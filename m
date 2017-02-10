Received: from eggs.gnu.org ([2001:4830:134:3::10]:45159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ccCR2-0001ly-AX
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 09:44:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ccCQz-0004fy-7Q
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 09:44:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59990)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ccCQz-0004fo-0e
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 09:44:25 -0500
References: <20170210014519.12413-1-bobby.prani@gmail.com>
	<871sv6xmzk.fsf@linaro.org>
	<0ec07664-fa06-8f09-33ce-ca15448c7851@redhat.com>
	<87y3xew7hn.fsf@linaro.org>
	<3f702266-1ac2-57c5-e0f8-3dec07b450d2@redhat.com>
	<87vasiw1ql.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ca69916b-d0d5-f3c7-5ece-bd7ac0c2a402@redhat.com>
Date: Fri, 10 Feb 2017 15:44:20 +0100
MIME-Version: 1.0
In-Reply-To: <87vasiw1ql.fsf@linaro.org>
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Pranith Kumar <bobby.prani@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "open list:Overall" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>



On 10/02/2017 15:37, Alex Benn=C3=A9e wrote:
>>>   - drop Pranith's patch for the current MTTCG series
>>>   - replace with an error/abort on EXCP_ATOMIC
>> Don't even replace it? :)
>=20
> I guess - the failure mode is only when we single step? Should we not
> try to emit a warning like we do for the mismatched MOs?

If we're confident we can fix it before 2.9, we can afford the small bug
for the time being.

Paolo
