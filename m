Received: from eggs.gnu.org ([2001:4830:134:3::10]:44199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dhgr3-0007dQ-GG
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 14:46:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dhgqy-000792-L2
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 14:46:17 -0400
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:37930)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dhgqy-00078c-FH
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 14:46:12 -0400
Received: by mail-it0-x241.google.com with SMTP id f16so1135953itb.5
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 11:46:12 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <ff49cfa1-5a00-c329-1647-3ad8367cc804@redhat.com>
Date: Tue, 15 Aug 2017 14:46:09 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <5D42D1E3-A946-4E2C-BDC4-BB785D0B880D@gmail.com>
References: <C2D23A89-6DB7-445C-BC25-71E9E49C288D@gmail.com>
	<ff49cfa1-5a00-c329-1647-3ad8367cc804@redhat.com>
Subject: Re: [Qemu-devel] Help with Windows NT 4.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, =?utf-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>


> On Aug 14, 2017, at 2:51 AM, Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>=20
> On 13/08/2017 21:13, Programmingkid wrote:
>> Lately I found out that Windows NT 4.0 seems to work well with the
>> 486 and pentium processors. Using "-cpu 486" made installing it
>> actually work. Now I am seeing another issue. When I boot Windows NT
>> 4.0 I see this error message:
>>=20
>> *** STOP: 0x0000007B (0x807A8610,0x00000000,0x00000000,0x00000000)=20
>> INACESSIBLE_BOOT_DEVICE
>>=20
>> Would anyone know a way to solve this issue?
>=20
> Herv=C3=A9 is probably the best person to answer this question.  Maybe =
try
> installing it with SCSI disks ("-drive if=3Dscsi,id=3Dhd,file=3D... =
-drive
> if=3Dscsi,id=3Dcd,file=3D... -device lsi -device scsi-hd,drive=3Dhd =
-device
> scsi-cd,drive=3Dcd").
>=20
> Thanks,
>=20
> Paolo

Thanks for the help. Unfortunately trying to boot from the install CD =
leads to the INACCESSIBLE_BOOT_DEVICE error when using SCSI.=20=
