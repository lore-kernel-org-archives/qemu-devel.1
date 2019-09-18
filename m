Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51309C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 09:09:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C427206C2
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 09:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0GrL65r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C427206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAVxW-0000md-2Q
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 05:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46311)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <i.maratos@gmail.com>) id 1iAVBL-0001zw-NK
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 04:19:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <i.maratos@gmail.com>) id 1iAVBK-0005f7-ML
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 04:19:23 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f]:42352)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <i.maratos@gmail.com>) id 1iAVBK-0005e0-FG
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 04:19:22 -0400
Received: by mail-lf1-x12f.google.com with SMTP id c195so4990023lfg.9
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 01:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=f+/mTsEKdtvDNH0uPjSuI9MN5hmFW2IdVLVORRmJWfk=;
 b=K0GrL65rO2jc9zF3RMIfzs3yIlsB9PH6ahEhheMSOEalZnzHTH9qTX68SOsi4mwEXj
 14bI+6Bk4qSCnCY+rfj8fmHtGvMotrJfS8HP840IRl46wszble/Bi1899EB2qui9fe/8
 /Js1XyQwIT6T+5Dtt4upuSct5SYPYbWroRJgdLBdM4U0w3NtHWiVr17VHDhuZ5trjv33
 AoIlZx7EmQVdQC0Mfyf6e+HRBbB5rnp/Uc7o2Nr73eIJCdf8i93RtziqqjKK4bmbTSNj
 g7ECbzOWAoESEZAo+i64c8pNCkfczvGWZh1AOyP77mTB79tmdy5npKLJvobna1I5rJ6p
 ZkRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=f+/mTsEKdtvDNH0uPjSuI9MN5hmFW2IdVLVORRmJWfk=;
 b=SDy/ZELmbxZqVf41eSgEvPGlt/1+P0gO4yv/pJC04e6K8zVRI4DeB9QF4CkhYcXE1b
 jazqIRWegFBlLyeB6yveF3LbF5WaxW5AQ/KEDOvU9bB/JdvTJG3p4xqNemPIzqq27hYM
 JYD12aWN/cAX3J8exH4JDUrONPI2M3AfU3ezmBh9XQrn/9oLqCdql+LLdIe99M9n8yoM
 103uWA/8GBUyynNmdnGXIcZlNLkuJS3HZehgc4FHpjYB3fE5aKpbJ8ubDTkxz7Bt9wuZ
 eslQux8ae3f5+1Ct0x8UNsV0dWoX7tHhoUnYGjUjfU266WDMcMidM+rBbAwItFGbEbHQ
 vFHA==
X-Gm-Message-State: APjAAAWas5VM1Y2DZ+0NHpYi6scj+AUK3bfB3KktwnZFL0sBy57SC6U6
 8sB5+bbaop4i9TTzl6J3IUOVvgaPgwwCdo8/UzK1mA9C
X-Google-Smtp-Source: APXvYqxHBqJSsp1aWgCNznKuLmZ9/qSa4wq2tW2VOOj1zcx+5IpZJihjvn6e4zyUXXPvD9q9k/xwcejDuubxdi2lTmY=
X-Received: by 2002:a19:c191:: with SMTP id r139mr1400298lff.23.1568794760382; 
 Wed, 18 Sep 2019 01:19:20 -0700 (PDT)
MIME-Version: 1.0
From: Ilias <i.maratos@gmail.com>
Date: Wed, 18 Sep 2019 09:19:10 +0100
Message-ID: <CANP-_LDVvnbXnk1GpNRbQ3zKBsh-z6_w1qn-t9LKbtGEEKUV-A@mail.gmail.com>
To: qemu-devel@nongnu.org
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::12f
X-Mailman-Approved-At: Wed, 18 Sep 2019 05:08:03 -0400
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: [Qemu-devel] qemu patches
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Your recent patch

https://github.com/qemu/qemu/commit/12e9493df9242a2051701e7eb64175d4e904acba#diff-d98f9b48cc332d226892f0db74a86b87

to the file

target/i386/whpx-all.c
<https://github.com/qemu/qemu/blob/master/target/i386/whpx-all.c>

breaks compilation when WHPX is enabled.

Please add

#include "hw/boards.h"

to the #include section of the above file again to fix it.
