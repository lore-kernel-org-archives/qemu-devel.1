Received: from eggs.gnu.org ([2001:4830:134:3::10]:35249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e6xeS-0004Jz-U7
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 07:45:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e6xeN-0001b1-Go
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 07:45:44 -0400
Received: from mail.ispras.ru ([83.149.199.45]:48202)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e6xeN-0001ac-9V
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 07:45:39 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Tue, 24 Oct 2017 14:45:38 +0300
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
In-Reply-To: <CABdb736D975ai2N_o9Df5UCn5de6ohrxtajTmtT-B8smbDDvKw@mail.gmail.com>
References: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
	<150642388560.3900.1889412060549174598.stgit@Misha-PC.lan02.inno>
	<CABdb736D975ai2N_o9Df5UCn5de6ohrxtajTmtT-B8smbDDvKw@mail.gmail.com>
Message-ID: <c251d8e3e773117b44c62213e9d5c2c0@ispras.ru>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 07/43] windbg: added chardev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, sw@weilnetz.de, Pavel Dovgalyuk <dovgaluk@ispras.ru>, Roman Kagan <rkagan@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>

Ladi Prosek =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2017-10-03 14:49:
>>=20
>> +    chr =3D qemu_chr_new_noreplay(WINDBG, device);
>> +    if (!chr) {
>=20
> This should generate error output. Passing "-windbg bogus" makes QEMU
> exit silently.
> -gdb seems to have the same problem.
>=20

I added additional checking on chardev. At the moment, supporting only=20
pipe.

Thanks,
Mihail Abakumov

>> +        return -1;
>> +    }
>> +
