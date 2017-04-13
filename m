Received: from eggs.gnu.org ([2001:4830:134:3::10]:35359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1cyayc-0004Nu-6m
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 05:23:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1cyayX-00033v-99
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 05:23:42 -0400
Received: from mail.ispras.ru ([83.149.199.45]:55420)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1cyayX-00033j-1l
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 05:23:37 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Thu, 13 Apr 2017 12:23:35 +0300
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
In-Reply-To: <CABdb734AjdU7kQOUzmmnhEdd0wmJWM4-2Fop=8jZ588uZX3M-w@mail.gmail.com>
References: <8a7bf9dbac4c6db5b7e8dd5c968cacae@ispras.ru>
	<CABdb734AjdU7kQOUzmmnhEdd0wmJWM4-2Fop=8jZ588uZX3M-w@mail.gmail.com>
Message-ID: <6b41df8d91c856eaf459ccd1b29105ed@ispras.ru>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] WinDbg module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, sw@weilnetz.de, Pavel Dovgalyuk <dovgaluk@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>

Ladi Prosek =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2017-04-13 10:02:
>=20
> The linked v2.7.50-windbg seems to be a Windows release. Does it also
> work on Linux hosts with KVM?
>=20

I haven't tested it yet, but it should work.

>=20
> Also,
>=20
>   #ifdef TARGET_X86_64 // Unimplemented yet
>   #error Unsupported Architecture
>   #endif
>=20
> can you estimate the amount of work to support 64-bit?
>=20

At the moment I can't implement support for x86_64 arch. At least due to=20
the fact that any OS Windows that I tried crashes on this architecture.

Thanks,
Mihail Abakumov
