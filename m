Return-Path: <SRS0=wjfX=SQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F551C10F13
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Apr 2019 23:34:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F029206B6
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Apr 2019 23:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyqyM0/X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F029206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42073 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFodW-0004XV-TL
	for qemu-devel@archiver.kernel.org; Sun, 14 Apr 2019 19:34:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1hFocm-0004Dp-Sx
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 19:33:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1hFocm-0000dl-0z
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 19:33:24 -0400
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33]:41652)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1hFocl-0000cu-Li
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 19:33:23 -0400
Received: by mail-io1-xd33.google.com with SMTP id v10so13098553iom.8
	for <qemu-devel@nongnu.org>; Sun, 14 Apr 2019 16:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:content-transfer-encoding:mime-version:subject:message-id:date
	:to; bh=MqIE2BX64LNLQmd4spp1WsefkGPRWkKqqnC73L/dJP4=;
	b=hyqyM0/XHILEshKDaLDZCfJvr709USa4AUGJ+SlrfRiiUfixjne0PlVga8jWpIKNva
	FXubMO/jH7PwbGj08tptcB2wjNRmH24ypczbASTWa7H3dfLu1rmRKls+FnV4Tz8puErx
	x4hUWeftS2YVbu4we/xo9H/pTQewmDeE30chSUZ15A9UIoGt1Cxp1y+bB9uKLJQPFfHG
	v8K34S+UK9bV+0Ry+xJOBFJpYZ7doqus2LgFdHJjpQM8b8Cua91UNaF4l4Xy+c67PxO1
	WW49V4E1tqPfkmWxBsTPsbdIGZfgob6pxJEQUuo0ZrFC7Tnrjl2QmJQEXdno/2uSO3yl
	4pEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:content-transfer-encoding:mime-version
	:subject:message-id:date:to;
	bh=MqIE2BX64LNLQmd4spp1WsefkGPRWkKqqnC73L/dJP4=;
	b=MiBs9A2zUBBngiPbQc2EEq5u8Hv6/mVu4V4XlmnssIK37GAxyAfEQxyL2ZTaR4bX4H
	gh4/he+6F1rOPjfECNpAXcycphsHvejMiQ5W8pweJpYJJmJFkUH8/kJ9aIAgz2PQ77WG
	AI2PP2X3Qgcp+etoGLLkHGBeeuX187kpdLQT+vwnysTnnk+NKLcB+J7SIQyLRprVJfn8
	yVZ16LwV+6LpM2ZC7jV0PEWFBPlB0nYyhKPbkITwBvD2QoJplT0i10I1Nv69ZMAuy8cO
	a9U8RiMR3NkYIxcSugTlVyuTgJh49DvrTOREIDtTExyPFOjuej8lNcdF0TET0LP3AwBD
	FFTA==
X-Gm-Message-State: APjAAAWp+Sgm8Vamqqn/6PbL23eNqLs5YcUPjTBeeY6Otk+EHToWANP2
	uwfYN3leeieZGXebxK9dSe2UjEUS
X-Google-Smtp-Source: APXvYqz7A85IG4BgC4jxuUDsdf7EDWY1NdUKHEAaU8zBPwaYp1e7XwrxCCjb3U8WbWzu6mlvgLfimw==
X-Received: by 2002:a6b:e009:: with SMTP id z9mr46035474iog.127.1555284801217; 
	Sun, 14 Apr 2019 16:33:21 -0700 (PDT)
Received: from [192.168.0.2] (d14-69-20-184.try.wideopenwest.com.
	[69.14.184.20]) by smtp.gmail.com with ESMTPSA id
	n21sm17820147ioo.3.2019.04.14.16.33.20 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 14 Apr 2019 16:33:20 -0700 (PDT)
From: Programmingkid <programmingkidx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Message-Id: <839EC771-5973-4B05-BC76-D6CC5EE63A43@gmail.com>
Date: Sun, 14 Apr 2019 19:33:17 -0400
To: QEMU Developers <qemu-devel@nongnu.org>
X-Mailer: Apple Mail (2.3273)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::d33
Subject: [Qemu-devel] Booting from a Bootcamp partition
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190414233317.TWKob4YyHLartBmB8C7I6iNiPSnPvuw7AFPjac-7sFI@z>

Hi I was wondering if anyone has been able to boot from a bootcamp =
partition inside of QEMU. I know this partition can be used in QEMU but =
my own attempts at booting Windows 7 on my bootcamp partition did not =
work. I always see "A disk read error occurred". Has anyone else been =
successful at this?=20=

