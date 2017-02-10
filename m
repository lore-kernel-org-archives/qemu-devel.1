Received: from eggs.gnu.org ([2001:4830:134:3::10]:33924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ccA6n-00061b-7a
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 07:15:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ccA6i-0005G4-M2
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 07:15:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ccA6i-0005Fu-Fr
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 07:15:20 -0500
References: <20170210014519.12413-1-bobby.prani@gmail.com>
	<871sv6xmzk.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0ec07664-fa06-8f09-33ce-ca15448c7851@redhat.com>
Date: Fri, 10 Feb 2017 13:15:19 +0100
MIME-Version: 1.0
In-Reply-To: <871sv6xmzk.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tcg: handle EXCP_ATOMIC exception properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Pranith Kumar <bobby.prani@gmail.com>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "open list:Overall" <qemu-devel@nongnu.org>



On 10/02/2017 13:13, Alex Benn=C3=A9e wrote:
>> +        if (atomic_read(&other_cpu->running) &&
>> !qemu_cpu_is_self(other_cpu)) {
> The comment above reads:
>=20
>   Must only be called from outside cpu_exec.
>=20
> So we need to revise this comment. Is this really a limitation or was i=
t
> originally the design goal?

If you want to call it within cpu_exec, you can always use
cpu_exec_end/start around it.

I think we should first of all get rid of the iothread lock within
cpu_exec, and then look at this patch again.

Paolo
