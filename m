Received: from eggs.gnu.org ([2001:4830:134:3::10]:49164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mr.katebzadeh@gmail.com>) id 1d1aTk-0000i1-FY
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 11:28:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mr.katebzadeh@gmail.com>) id 1d1aTf-0007C7-FH
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 11:28:12 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:36865)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mr.katebzadeh@gmail.com>)
	id 1d1aTf-0007Bx-58
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 11:28:07 -0400
Received: by mail-wm0-x231.google.com with SMTP id m123so20097202wma.0
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 08:28:07 -0700 (PDT)
From: Siavash Katebzadeh <mr.katebzadeh@gmail.com>
Message-Id: <0854947D-A949-4218-B3F4-89EB1143BCA3@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Date: Fri, 21 Apr 2017 19:58:02 +0430
In-Reply-To: <e538350e-e710-ea4d-ba69-8bc54c5af6a2@ilande.co.uk>
References: <AA896828-A1B7-4060-9537-F738C1E2012C@gmail.com>
	<e538350e-e710-ea4d-ba69-8bc54c5af6a2@ilande.co.uk>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Help needed: Sparc 64, kernel panic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel <qemu-devel@nongnu.org>

My mistake.
Yes I Already tried qemu-2.9.0.rc5. Same error happens.

Regards,
Siavash.=20

> On Apr 21, 2017, at 19:36, Mark Cave-Ayland =
<mark.cave-ayland@ilande.co.uk> wrote:
>=20
> On 21/04/17 15:56, Siavash Katebzadeh wrote:
>=20
>> My command line is:
>>=20
>> ./qemu-system-sparc64 \
>> -L pc-bios -m 720 \
>> -kernel ${KERNEL_PATH}/${KERNEL} \
>> -initrd ${KERNEL_PATH}/${INITRD} \
>> -drive file=3D${QCOW2_PATH}/${QCOW2},if=3Dvirtio,index=3D0 \
>> -rtc base=3D'2006-06-17T16:01:21',clock=3Dvm \
>> -net none -append 'modprobe.blacklist=3Dpata_cmd64x root=3D/dev/vda1' =
\
>> -d in_asm -D ./out_file_timing \
>> -nographic
>>=20
>> And here is my environment:
>>=20
>> Guest OS: Debian-7.8.0
>> Guest Kernel: 3.2.0-4-sparc64 (Virtio modules are added manually)
>> Host OS: Ubuntu 14.04
>> CPU: Intel(R) Xeon(R) CPU E5-2650 0 @ 2.00GHz
>>=20
>> This error happens when I=E2=80=99m using qemu-2.8.0-rc0 or later.
>=20
> Please make sure that you CC the qemu-devel list, particularly as I
> won't be around for several days. There have been several fixes in 2.9
> that could be related to this - do you still see the same issue with =
the
> latest 2.9 release?
>=20
>=20
> ATB,
>=20
> Mark.
