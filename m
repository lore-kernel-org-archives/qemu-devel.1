Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF082C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 16:36:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AD31214D8
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 16:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ShBZWWbn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AD31214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSklu-00023z-PT
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 11:36:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42135)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iSklE-0001WT-Iu
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:35:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iSklD-0004xP-Gw
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:35:52 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46123)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iSklD-0004x9-BL
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:35:51 -0500
Received: by mail-wr1-x444.google.com with SMTP id b3so3718498wrs.13
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 08:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=aSmb4NCLzT8DNYPjt+115CigbamYZVNmeNTY22WSO1A=;
 b=ShBZWWbnHSPUPYl314j3nk66L/fncKFv8OqjHe2UN5xtGpTA7TaCFojCWmFheElNA/
 RuoXYcayjaOX/rILnWt7tFc3n+UwL1kihtxjy6l7dxcQWCPlh5+pgWBSDYq8laKtRj4s
 8AF3AVu7t92VOyju6gHblwyFJWSNlvxQUC+sQ8vs/GkiUxyPIft/pt6SXhxZ6Fc0085/
 VjhWik8cIIT5ACjMvxZVGdPkm9bdCnQlJbFTFH7xiGWN5am7TSN09T9osZtVLTiG0TCO
 B+IN7/C3W0nRatMnUTEMJZbJ+0dL+svymq2vN24JcJU3q6pQtgMlQ96+CWaLUY4NR1fR
 glVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=aSmb4NCLzT8DNYPjt+115CigbamYZVNmeNTY22WSO1A=;
 b=QwpLiasLTf46VVs/2GJu/4OMU3MMy7wFYxHtYd+AQvuqJAEsz5rXnh9Lps8a9OfMin
 kxKMmPO+UjMSZ9oH4utpHLzueXvOJYrsphVPwocV9LjgdfzqqXFmtUoOOMWxX/nuV57U
 WwVL1kP+XYpmj8B/HTEK0xUab7xonX/cjeYxA9L5u8SQh55hoyvl6Dqp48sApizd3PCY
 byukS0M1rhrGtIvbTYGeeWRS2Axyf5n6jAH4zWEf+vcNKEA7GJEVpHU6/ScZ6coHV3M5
 zN6aa2APPXDRRJkTUzv3xUkKY5cKI1r7VKDxFdqN8AtMGvCks0q6JEvjrNG8p6FcA871
 o7xg==
X-Gm-Message-State: APjAAAW0sjsUM+LiDqPJndoMwwT3nnXY16xU0vxi2jOWMMsw5THG4H5T
 cwMKuMCe2N8WgYvecB8Nh13hYA==
X-Google-Smtp-Source: APXvYqz4CTX9StTYRjr2xHvCmbfL3kHOzeIqkO9m5emfCTmiKWPE9MbVeyMsmW6KoODmS+XCvzaKkA==
X-Received: by 2002:adf:f50e:: with SMTP id q14mr3440792wro.139.1573144549911; 
 Thu, 07 Nov 2019 08:35:49 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g133sm2439494wme.42.2019.11.07.08.35.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2019 08:35:48 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 621551FF87;
 Thu,  7 Nov 2019 16:35:48 +0000 (GMT)
References: <20191107142613.2379-1-robert.foley@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH 0/4] Make the qemu_logfile handle thread safe.
In-reply-to: <20191107142613.2379-1-robert.foley@linaro.org>
Date: Thu, 07 Nov 2019 16:35:48 +0000
Message-ID: <87r22jhcez.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: peter.puhov@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> This patch adds thread safety to the qemu_logfile handle.  This now
> allows changing the logfile while logging is active, and also solves
> the issue of a seg fault while changing the logfile.
>
> This patch adds use of RCU for handling the swap out of the
> old qemu_logfile file descriptor.

I've finished my pass. Looks pretty good - a few minor comments around
the persistence of the read lock and some minor stylistic nits.

>
> Robert Foley (4):
>   Add a mutex to guarantee single writer to qemu_logfile handle.
>   Add use of RCU for qemu_logfile.
>   qemu_log_lock/unlock now preserves the qemu_logfile handle.
>   Added tests for close and change of logfile.
>
>  accel/tcg/cpu-exec.c          |  4 +-
>  accel/tcg/translate-all.c     |  4 +-
>  accel/tcg/translator.c        |  4 +-
>  exec.c                        |  4 +-
>  hw/net/can/can_sja1000.c      |  4 +-
>  include/exec/log.h            | 33 ++++++++++--
>  include/qemu/log.h            | 51 +++++++++++++++---
>  net/can/can_socketcan.c       |  5 +-
>  target/cris/translate.c       |  4 +-
>  target/i386/translate.c       |  5 +-
>  target/lm32/translate.c       |  4 +-
>  target/microblaze/translate.c |  4 +-
>  target/nios2/translate.c      |  4 +-
>  target/tilegx/translate.c     |  7 +--
>  target/unicore32/translate.c  |  4 +-
>  tcg/tcg.c                     | 28 ++++++----
>  tests/test-logging.c          | 74 ++++++++++++++++++++++++++
>  util/log.c                    | 99 ++++++++++++++++++++++++++++-------
>  18 files changed, 273 insertions(+), 69 deletions(-)


--
Alex Benn=C3=A9e

