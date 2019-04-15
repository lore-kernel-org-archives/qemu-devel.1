Received: from eggs.gnu.org ([209.51.188.92]:37001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1hFymJ-0003K6-SY
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:23:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1hFymI-0000Y9-Ui
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:23:55 -0400
Received: from mail-io1-xd31.google.com ([2607:f8b0:4864:20::d31]:39071)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1hFymI-0000XS-M5
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:23:54 -0400
Received: by mail-io1-xd31.google.com with SMTP id e13so14090916ioq.6
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 03:23:54 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <20190415095400.GD29134@stefanha-x1.localdomain>
Date: Mon, 15 Apr 2019 06:23:51 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <97D57A26-6DB4-45AA-BC68-27BBEDEEBE74@gmail.com>
References: <839EC771-5973-4B05-BC76-D6CC5EE63A43@gmail.com>
	<20190415095400.GD29134@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] Booting from a Bootcamp partition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, John Snow <jsnow@redhat.com>


> On Apr 15, 2019, at 5:54 AM, Stefan Hajnoczi <stefanha@gmail.com> =
wrote:
>=20
> On Sun, Apr 14, 2019 at 07:33:17PM -0400, Programmingkid wrote:
>> Hi I was wondering if anyone has been able to boot from a bootcamp =
partition inside of QEMU. I know this partition can be used in QEMU but =
my own attempts at booting Windows 7 on my bootcamp partition did not =
work. I always see "A disk read error occurred". Has anyone else been =
successful at this?=20
>=20
> Hi,
> It's difficult to help without more information:
> 1. What is your QEMU command-line?

sudo qemu-system-x86_64 -name "Windows 7" -hda "/dev/disk0s4" -boot "c" =
-m 3000=20

> 2. What is the partition table on the disk?

The bootcamp partition is this: /dev/disk0s4

> General problems with booting Windows are usually caused by a guest
> configuration that doesn't match the hardware configuration that =
Windows
> was installed under.  Can you check that the AHCI bus address of the
> disk and partition numbering matches what Windows expected?

How would someone do this?

> It may also be useful to enable tracing (see docs/devel/tracing.txt) =
to
> see what the ahci_* trace event log says.  I have CCed John Snow, one =
of
> the few people who can read this log :).

I'm guessing you believe the problem is the partition can't be read in =
QEMU. I know for sure it can. I attached this partition to another QEMU =
VM and was able to see it on the Desktop.=20

My guess is the computer is using an EFI firmware and QEMU uses the =
traditional BIOS firmware (SeaBIOS).  So I think trying UEFI in QEMU =
might work.=
