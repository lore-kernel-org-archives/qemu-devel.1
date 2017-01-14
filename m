Received: from eggs.gnu.org ([2001:4830:134:3::10]:51722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1cSO7y-0004S5-Qu
	for qemu-devel@nongnu.org; Sat, 14 Jan 2017 08:12:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1cSO7x-0000s7-VT
	for qemu-devel@nongnu.org; Sat, 14 Jan 2017 08:12:14 -0500
References: <1483049536-21548-1-git-send-email-hpoussin@reactos.org>
	<CACXAS8AGTGJ-3yEzf9gzOmfRfppL2REmTyB2SAkb3Nd8eyVYig@mail.gmail.com>
	<733cba29-58b7-e43f-0d50-3774ee8bf3b2@reactos.org>
	<8b07aa89-92fe-1f2d-d392-e1a7e63d75ca@ilande.co.uk>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <24009368-afce-92dd-2cd7-cd4b6629fc05@reactos.org>
Date: Sat, 14 Jan 2017 14:11:50 +0100
MIME-Version: 1.0
In-Reply-To: <8b07aa89-92fe-1f2d-d392-e1a7e63d75ca@ilande.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/6] ppc: add a IBM 40p machine (RS/6000,
 PReP)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>
Cc: Giancarlo Teodori <gteodori@gmail.com>, Thomas Huth <thuth@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

Le 13/01/2017 =C3=A0 13:23, Mark Cave-Ayland a =C3=A9crit :
>>
>> OpenBIOS doesn't support PReP boot partitions (type 0x41) nor PReP
>> kernels so this is a no-go yet.
>
> Just out of interest, is it just the PReP boot partition support that i=
s
> missing from OpenBIOS? If so, that should be fairly easy to implement i=
f
> there's a spec lying around somewhere.

2 things are missing to boot from hard disk/cdrom:
- support for LSI SCSI adapter
- support for PReP boot partition support

However, if you want to boot with -kernel, you only need to have support =
for PReP boot partition.
Partial specification is available at:
ftp://ftp.software.ibm.com/rs6000/technology/spec/srp1_1.exe
section 5.3 (Loading the Load Image)
and
section 5.4 (Transferring System Control to Load Image)


> It would be great if we could finally remove OHW from QEMU :)

I fully agree on that!

Herv=C3=A9
