Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C399EC10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 10:25:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A44C2075B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 10:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/lsn/ai"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A44C2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47815 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFyno-00046h-NL
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 06:25:28 -0400
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=so3z31DIMMDStPDkde9XJL6darEkDyzB1FPgOxg5dno=;
	b=s/lsn/aisBD8UkMxVnJoqQGtip9+QotmtFdvD0shqkN/8qzcEJHOCYj0ZazCR21A44
	Wx8l4DEJ1I43UkkAoxCztn2MahUeblICynKrdjzNxmHKtFHXIuzkgljHG93Hd0blcQtV
	yLOHVDRGqVPYwbUxT/OIpsqhg6qXm6ksz+WxiJl9F85Y+XDWihNnkMvVunt3l0QRJTJn
	tvCIThynyJ0aXGLSQ3864CNlHvUSANRhI2kbzgtDvB32HYZxGnqddwehZMahqpypu22B
	1ON8Q12Nrf3NiBVVva+gJl5pyKPGjsfEHEMvBGYanZCwWnMuWLeza2q55GIW+MOGVOEh
	SkTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=so3z31DIMMDStPDkde9XJL6darEkDyzB1FPgOxg5dno=;
	b=HSYBJJOQJ1mW26GjcIZIskUGXuBpaukVojPpGTwEDw+bJpoHcjwYpdcRmXMO8yKdx2
	xru5DYVCfiYcRr0ncX03waYfidDIrCyKeJ/82vx1S2WMxH7WXl4ZVYR09In5reIYzz2N
	EaonPNxt3HWMErrTp8m7nqBYm+iGIMzq5UPJFg+Wm2Y5f0cJa1mCAzpjjpZOXhAy1OLI
	7ItsHQZ3a7pbYsGXJIctM2PoTNmCYmTEgOunKChpEKpm11EdawMRGEfUd3W9ZjpWwuMA
	SBpWBMzcVQfEFvNRHv33pjDbMh8FkSsxCML0D+sP8cwWwYm+s14niZ5l9fLO+I8iZDUl
	sj/g==
X-Gm-Message-State: APjAAAXqVjx6NqfmIzZADc09Ibg17JKCN8ERaJ4UAYZ3oP5fLMda5Eus
	dHF/PEiOS11dXSRqmDqRJZ8=
X-Google-Smtp-Source: APXvYqzglMBuNldWz+nZUiYGn4ISX8QqCx4Lo9a50iGcx0F86iN7ilnkgyeumavSyf9vFurJEjiChw==
X-Received: by 2002:a5d:8d93:: with SMTP id b19mr9386391ioj.54.1555323833838; 
	Mon, 15 Apr 2019 03:23:53 -0700 (PDT)
Received: from [192.168.0.2] (d14-69-20-184.try.wideopenwest.com.
	[69.14.184.20])
	by smtp.gmail.com with ESMTPSA id 79sm7904667itw.18.2019.04.15.03.23.52
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 15 Apr 2019 03:23:53 -0700 (PDT)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <20190415095400.GD29134@stefanha-x1.localdomain>
Date: Mon, 15 Apr 2019 06:23:51 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <97D57A26-6DB4-45AA-BC68-27BBEDEEBE74@gmail.com>
References: <839EC771-5973-4B05-BC76-D6CC5EE63A43@gmail.com>
	<20190415095400.GD29134@stefanha-x1.localdomain>
To: Stefan Hajnoczi <stefanha@gmail.com>
X-Mailer: Apple Mail (2.3273)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::d31
Subject: Re: [Qemu-devel] Booting from a Bootcamp partition
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415102351.UeVy4OCBrw2YWU57vG05rAaCy__FrjIonC9YrOEC87Y@z>


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

