Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B10DC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 08:02:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5553C206F8
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 08:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="ZAzm5jbd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5553C206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKHHQ-0008DC-CH
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 04:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41638)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Aijaz.Baig@protonmail.com>) id 1jKHGl-0007m8-RQ
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:01:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Aijaz.Baig@protonmail.com>) id 1jKHGk-0003x7-5J
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:01:39 -0400
Received: from mail2.protonmail.ch ([185.70.40.22]:26188)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Aijaz.Baig@protonmail.com>)
 id 1jKHGj-0003vW-KV
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:01:38 -0400
Date: Fri, 03 Apr 2020 08:01:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=default; t=1585900895;
 bh=SL32QGKa0TR71g1Njnm8jR9PPVNkl2aQsJ20JjPfNtw=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=ZAzm5jbd1Vlc5FWQbvavJjr4Slq43KNqRa6Ou/pqS3rXZ9oFRQuhKGO521JnqILe4
 B4b90Xk8j8g7Cf/jKinGVDvKWQoh9vug3DOL+VpuV6/7P+c8gTlVnlxsEro3HljqGB
 vStlWimvrssx6Pik1DPOXn8tYun+jv8uHdTnA/S4=
To: 'Peter Maydell' <peter.maydell@linaro.org>
From: Aijaz.Baig@protonmail.com
Cc: qemu-devel@nongnu.org
Subject: RE: Qemu doesn't detect hard drive
Message-ID: <001201d6098e$0ef0b3b0$2cd21b10$@protonmail.com>
In-Reply-To: <CAFEAcA_-aRethWOmzaKqft8yMg6dGUUwvf1kX36R4+R=yWS2RA@mail.gmail.com>
References: <XSF-9CLAGYMG1ivdwoihQBZm3XT2vWdKVqHtMLExgA1LJwkSeISDoKKVEJ3E3qhZaNvki44j2CdXdQ81ljytvtS0MGmXL3gFhO2kQmWA2Kk=@protonmail.com>
 <CAFEAcA_-aRethWOmzaKqft8yMg6dGUUwvf1kX36R4+R=yWS2RA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 185.70.40.22
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Aijaz.Baig@protonmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks for the tip Pete. It is always tiny tidbits like these that can wast=
e hours of time for someone coming from x86 =F0=9F=98=89.=20

Ok I changed the command line and it looks like this now:
sudo qemu-system-arm -m 1024M -M vexpress-a9 -D qemu.log -sd armdisk.img -k=
ernel buildroot-2019.02.5/output/images/zImage -dtb buildroot-2019.02.5/out=
put/images/vexpress-v2p-ca9.dtb -append "root=3D/dev/ram console=3DttyAMA0,=
115200 kgdboc=3Dkbd,ttyAMA0,115200 ip=3Ddhcp nokaslr" -initrd buildroot-201=
9.02.5/output/images/rootfs.cpio -nographic -net nic -net bridge,br=3Dmybri=
dge -s

I am looking at 'dumping' a Debian like rootfs on the MMC and then use that=
 as the default rootfs instead of the busybox one. Is there an easy to foll=
ow guide that you can point me at?  Would save me a couple hours. Also, mer=
ely specifying that partition as the kernel 'root' parameter should suffice=
 right?

-----Original Message-----
From: Peter Maydell <peter.maydell@linaro.org>=20
Sent: Friday, April 3, 2020 1:10 PM
To: Aijaz.Baig <Aijaz.Baig@protonmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: Qemu doesn't detect hard drive


On Fri, 3 Apr 2020 at 06:18, Aijaz.Baig <Aijaz.Baig@protonmail.com> wrote:
> I would now like to add a hard disk for persistent storage and then=20
> transfer control from busybox initrd based rootfs over to the full=20
> fledged version offered with Linux. So I add it to the command line
>
> `sudo qemu-system-arm -m 1024M -M vexpress-a9 -D qemu.log -drive=20
> if=3Dnone,format=3Draw,file=3Ddisk.img -kernel=20
> buildroot-2019.02.5/output/images/zImage -dtb=20
> buildroot-2019.02.5/output/images/vexpress-v2p-ca9.dtb -append=20
> "console=3DttyAMA0,115200 kgdboc=3Dkbd,ttyAMA0,115200 ip=3Ddhcp nokaslr"=
=20
> -initrd buildroot-2019.02.5/output/images/rootfs.cpio -nographic -net=20
> nic -net bridge,br=3Dmybridge -s

This command line creates a "drive" object but doesn't plug it in to anythi=
ng (it's like asking QEMU to model a board, with a hard drive sat next to i=
t on the desk but no cable between them :-))

More generally, the vexpress-a9 board does not support hard disks.
This is because the real hardware we're modelling here has no disk drive in=
terfaces and no PCI or similar bus that you could plug a scsi controller in=
to. The best it can do for storage is an SD card emulation, which works but=
 the performance is not great.

thanks
-- PMM



