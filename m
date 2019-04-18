Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DBBC10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 21:15:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5CB7214C6
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 21:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oberlin-edu.20150623.gappssmtp.com header.i=@oberlin-edu.20150623.gappssmtp.com header.b="i4uJvMJ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5CB7214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oberlin.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47470 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHENr-0007Lp-1Z
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 17:15:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hHE9G-0004H2-3W
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 17:00:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hHE9E-0003Bt-9I
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 17:00:46 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:47098)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1hHE9C-0003AO-Me
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 17:00:44 -0400
Received: by mail-io1-xd42.google.com with SMTP id p23so2964589iol.13
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 14:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oberlin-edu.20150623.gappssmtp.com; s=20150623;
	h=mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=+M7zE+5ZWrcnyFpVllv1wmGDDGSb6vX0KTCEj2AghkE=;
	b=i4uJvMJ88cczdQW9PBcZa32ILWU0xpG0K9AeCuKS/9h0CcAE7pX+IKJq13QRksaLqd
	n9FPxaCDi3/LL7pqOK65o7rAIwG+OJ/MgmVNrsHuKULHAHDDKjaqxS6lOTyTfOy5Lehw
	xLehnmQd3931XbvqTCpY3wx+34uiYvg/PVb8jmZCnL4jXy3X1DuCeujyI7If2npLhcux
	lkcp0cxb481P49nLGaEXRGFwF4OSwrEbmhLVl1wi81uZs3uI4GYfE5b56DygFCTHB/ZC
	RNiJ1/NvSzwGl3QHxWPF90+nmVBj4xnie1ZTbcghClgRaaKuCuZxC+FI0IKMYvko1ks4
	/IDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=+M7zE+5ZWrcnyFpVllv1wmGDDGSb6vX0KTCEj2AghkE=;
	b=pMckd+Y6+7jpdZq+NMBNqUx0x6PFeNISM7rapHm/5IlNz+itZ/6bcUt+UTnOUlNiYY
	FoiaFv+CiFS6fvbw8SH6kqpe822R6QFLE5EQZbV9Vzhk649PNGXH6//zMJlFKve/whTC
	C9apRiyRoPOZWsCxAT2HRT3hAId8ixIXvwzqirwh63o9Mr5lfFpCAByci6F0IJ10nbBC
	0KZ2CLy1vGJfOW+yZyRaPfZ1ychGwxozLhoKgdffoN9QHWctqxrGR7xDJyN/EKZ01tPF
	Uao+EBv+peHPfIvjRhd5L6Rp6HQ5+dth2LFH/i2Htk/mAfJdm6PF5ojk09LLJXllhvnp
	uS0Q==
X-Gm-Message-State: APjAAAUNEk0sEDaJUB9Zp1snG3EHlGnMIv9oSBoVrrXMZUSStFCUPAuB
	BvUI/HQLd/Oe4V13yHoISxHWPQ==
X-Google-Smtp-Source: APXvYqzV+42tE2QCZnddG8ykHscasuywm+mI6OPOyUwJTRbkEJG1ArDHAgLpnTsrjpgk5HdTqgyJYw==
X-Received: by 2002:a5d:8b41:: with SMTP id c1mr219795iot.173.1555621241743;
	Thu, 18 Apr 2019 14:00:41 -0700 (PDT)
Received: from worksec.oberlin.net (ip-210-181.oberlin.net. [208.66.210.181])
	by smtp.gmail.com with ESMTPSA id
	f204sm1501243itc.26.2019.04.18.14.00.40
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 18 Apr 2019 14:00:41 -0700 (PDT)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
In-Reply-To: <0437475a-10ff-b8e0-3914-536a78f99b6e@redhat.com>
Date: Thu, 18 Apr 2019 17:00:40 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <59245359-ECA9-430C-A634-50ED8E9C6875@oberlin.edu>
References: <cover.1554755001.git.stephen.checkoway@oberlin.edu>
	<6cf20899-f643-950b-37b9-dcc47df0d72e@redhat.com>
	<5C484463-F00B-4EC0-9272-DC23CEE8F376@oberlin.edu>
	<0437475a-10ff-b8e0-3914-536a78f99b6e@redhat.com>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>
X-Mailer: Apple Mail (2.3445.102.3)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::d42
Subject: Re: [Qemu-devel] [PATCH 00/10] block/pflash_cfi02: Implement
 missing AMD pflash functionality
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
	Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
	Max Reitz <mreitz@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418210040.r-TXBrxFNAsB7txIGk6HMfqm4K3mA12LRJUHpRGjkBc@z>



On Apr 9, 2019, at 12:15, Philippe Mathieu-Daud=C3=A9 =
<philmd@redhat.com> wrote:

> Since you did changes in the CFI table, I think we should add a tests
> verifying the table is correctly generated for all you FlashConfig =
entries.

In v3 of the patch, I added tests for the CFI table values
- device length
- sector length and number of sectors
- erase suspend supported

--=20
Stephen Checkoway






