Return-Path: <SRS0=E2zY=TZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A01C282E1
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 02:23:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF1C72081C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 02:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CC9btvjr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF1C72081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34824 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUMLh-0001ft-25
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 22:23:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1hUMJt-0000UP-9z
	for qemu-devel@nongnu.org; Fri, 24 May 2019 22:22:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1hUMIN-0003WZ-99
	for qemu-devel@nongnu.org; Fri, 24 May 2019 22:20:28 -0400
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143]:50785)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1hUMIN-0003WG-1e
	for qemu-devel@nongnu.org; Fri, 24 May 2019 22:20:27 -0400
Received: by mail-it1-x143.google.com with SMTP id a186so8975864itg.0
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 19:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=C8S3L1SKV3Hi1BBB4SYBzTmmGw8D7/NaQdI+QyJpEEE=;
	b=CC9btvjrB+LbM6b6rYZtHnecxyxKVxTkqMbd0/U+2rH4oho1lD7y+2CjZtZWEgz65E
	4oYuNLf25+7gzVCyu1iJArvye+usXuwJFAYNvrzZUV/vvbtMXu7hxmMjfFiYHSqrdg92
	A97vRYenQR/1Z/vXNijek20C3S+U5An8z4YJLtqQ2mICHruUmHLaWmVgNSKrCPXmkuU+
	rEodwcwF0Mo2CsfLDg40GdA49pdEj05R/Ek8ZrJxWG9LqZTBV5JXt+HJYdsV7BaeCOB+
	49/sBUh7PXKuM3AtfebFvcZ6eZODWdF96SZusw+08bFCKQiQcN/gSPzeOXroz2G50GVU
	nAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=C8S3L1SKV3Hi1BBB4SYBzTmmGw8D7/NaQdI+QyJpEEE=;
	b=e8mqGQJxFkvEXOFyGXh6VB+6YlYqkaOylonEIocTCZJNZTwdj7bXE9sCAGigA9FAk1
	EqQkgBLRorP21a8geqfMNVfMAwxxKhpx6NojXlPa99ldutoRvsc1wamevAj0ES/fTO+0
	sUhd9kHWqcctG9UEj8Lo3v93r212eP0OKwTLRCW4v3OEACfQGBM6qgTkajlSQiVxMb6g
	f2d6jrtYOXBIw2otUjcRitKmFZolg7OPIH6NarID4AXoojrlwlTUsnuEj2SbJFrGv9kS
	RfZKzHbIt399TFLqXymBPkICVGBo0vsHEojIFf+dUH6sBuKtqX6kJ6RoS6jQ1hkcN45g
	SqAg==
X-Gm-Message-State: APjAAAWHMKJ5DJYVbyopy7p+VcjG+j6hXSCiP742ZIcVbQC5bX5yJf3e
	fg6gTUem3lbyE1zAMQZ51fU=
X-Google-Smtp-Source: APXvYqzqoYT2bBpl5fj5RAADwvTKwC/n6V2jME/okA8cPVf88yE+qhYip5iBh+vAZSuLjCOBLUiHyw==
X-Received: by 2002:a24:fd41:: with SMTP id m62mr20617621ith.67.1558750826073; 
	Fri, 24 May 2019 19:20:26 -0700 (PDT)
Received: from localhost.localdomain (d14-69-20-184.try.wideopenwest.com.
	[69.14.184.20]) by smtp.gmail.com with ESMTPSA id
	p20sm1575524ioj.63.2019.05.24.19.20.24
	(version=TLS1 cipher=AES128-SHA bits=128/128);
	Fri, 24 May 2019 19:20:25 -0700 (PDT)
From: John Arbuckle <programmingkidx@gmail.com>
To: richard.henderson@linaro.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.orgd,
	david@gibson.dropbear.id.au, mark.cave-ayland@ilande.co.uk
Date: Fri, 24 May 2019 22:20:06 -0400
Message-Id: <20190525022008.24788-1-programmingkidx@gmail.com>
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::143
Subject: [Qemu-devel] [PATCH 0/2] Implement PowerPC FPSCR flag Fraction
 Rounded
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
Cc: John Arbuckle <programmingkidx@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In IEEE 754 math, the arithmetic, rounding, and conversion instructions produce an intermediate result that can be regarded as having infinite precision and unbounded exponent range. When the final result has its fraction part incremented is when the Fraction Rounded bit is set.

This patch implements the PowerPC FPSCR flag Fraction Rounded.

Note: there are still functions in softfloat that need to be adjusted so that float_flag_rounded is fully supported. These include round_to_int(), and all legacy roundAndPack* functions. So basically anywhere that sets the float_flag_inexact.

John Arbuckle (2):
  Implement Floating Point flag Fraction Rounded
  Implement the PowerPC Floating Point Status and Control Register
    Fraction Rounded bit

 fpu/softfloat.c               | 15 ++++++++++++---
 include/fpu/softfloat-types.h |  1 +
 target/ppc/fpu_helper.c       |  4 ++++
 3 files changed, 17 insertions(+), 3 deletions(-)

-- 
2.14.3 (Apple Git-98)


