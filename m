Received: from eggs.gnu.org ([2001:4830:134:3::10]:47146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ccB0Z-0006GZ-4d
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 08:13:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ccB0Y-0000XS-0t
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 08:13:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44726)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ccB0X-0000XI-Qu
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 08:13:01 -0500
References: <20170210014519.12413-1-bobby.prani@gmail.com>
	<871sv6xmzk.fsf@linaro.org>
	<0ec07664-fa06-8f09-33ce-ca15448c7851@redhat.com>
	<87y3xew7hn.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3f702266-1ac2-57c5-e0f8-3dec07b450d2@redhat.com>
Date: Fri, 10 Feb 2017 14:12:58 +0100
MIME-Version: 1.0
In-Reply-To: <87y3xew7hn.fsf@linaro.org>
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



On 10/02/2017 13:33, Alex Benn=C3=A9e wrote:
> That said for TCG system emulation EXCP_ATOMIC is currently broken with
> respect to debugging. However for the initial guests/host combination o=
f
> ARMv7/8 on x86_64 we don't need the fallback with pretty much 99% of
> deployed hosts. How about the following:
>=20
>   - drop Pranith's patch for the current MTTCG series
>   - replace with an error/abort on EXCP_ATOMIC

Don't even replace it? :)

Paolo

>   - proceed with merge as plan
>   - tackle the BQL lock next (along with more MTTCG guest/targets enabl=
ement)
