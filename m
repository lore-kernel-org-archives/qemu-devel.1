Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEA0C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 12:52:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3676E2087C
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 12:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PW8Sne9n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3676E2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1UWG-0005Pn-CK
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 08:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k1UVZ-0004a3-Md
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 08:51:33 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:43501)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k1UVV-0003Ww-G1
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 08:51:33 -0400
Received: by mail-pl1-x642.google.com with SMTP id t10so11960519plz.10
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2020 05:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=tOFYqw6kA0tuZpo4KlMuTovIvhRpkKWTDyY3ER7Gskg=;
 b=PW8Sne9nzd5sxS+HeSvJwOmUB2qdHbLs0JTSElYEvAbBcI5BafA2xEnvVyPra6bjWr
 V4u6FgruGLS5ZrRoRoYtqaecDxKWRNDydsaJ3U6Ibk2s9p65XbU8KGWoYAyRPt7eJJuv
 uTvew/f5iBZw166Uzi8zVHJj0YhiUN/7UrSZkBYVHluPeWnJm61Ux6w3hlfIk7yEWtK4
 brRxwIBWoX3UiWVmVklXrq/Gz0wX5gq5ciqwMvUQeOty93IYfeeYsTYER+DgWj5bi/wA
 N4MW8tH6NMoExVLJfrS1zo1DyLkmnOdjrvyHuN2fXZFVc4rEo1WVYgH0Z6+cKr1QRjGH
 CbSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=tOFYqw6kA0tuZpo4KlMuTovIvhRpkKWTDyY3ER7Gskg=;
 b=UnMqe1mpTFuxD3Mz+HlXo4bX6t4Odjj1gD31S/4HV4+qhHOr4el93EyTAN+8I3L7Pd
 CpyQ1SlS2uqdq4D7tvike1qJgOFQae7Sp5mYMqASc/13Jp5Zz5LnFrL7cz7Ph9lFC9SE
 cGC6wceHsSIVolCblZsVLfvAAqy6y1LJ4AqsOA9CPGoTP6mkqrCoHjCDEEVF7fKzGn0m
 2O+GFagG9vTzs0kIpGViDrH+S7jZbgEKxVUlIEJZLZ0bb3/h95HAZX7aCFJPHU0TOQ8G
 QDZRFl0xLJaF40f1tFk92wfkmlKpvMIpWR5mmDYqjh2P3yy+nBpsFJA2McN/aOHZxJ2L
 Aeew==
X-Gm-Message-State: AOAM533gayk4vDoQUX83KyNsSRhTf0sYoSJEGhLX/PEbE+vXIPXYfIpg
 C8Ow+/ubQdq9OKTVlgk/WjI7oeW5U9w=
X-Google-Smtp-Source: ABdhPJygqQupovImnZ2uNa5F0d+lNfKq9UlO+NQYE7x2R+5adybEcWQLaSmCgc6a36MJnqJOX81pzQ==
X-Received: by 2002:a17:90a:bc45:: with SMTP id
 t5mr3898770pjv.139.1596199886511; 
 Fri, 31 Jul 2020 05:51:26 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 (c-73-47-162-176.hsd1.ma.comcast.net. [73.47.162.176])
 by smtp.gmail.com with ESMTPSA id v11sm9733646pgs.22.2020.07.31.05.51.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2020 05:51:25 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] accel/tcg: remove implied BQL from
 cpu_handle_interrupt/exception path
Date: Fri, 31 Jul 2020 08:51:25 -0400
Message-Id: <20200731125127.30866-1-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=robert.foley@linaro.org; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: robert.foley@linaro.org, cota@braap.org, pbonzini@redhat.com,
 peter.puhov@linaro.org, alex.bennee@linaro.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The purpose of this change is to set the groundwork
so that an arch could move towards removing
the BQL from the cpu_handle_interrupt/exception paths.

The BQL is a bottlneck in scaling to more cores.
And this cpu_handle_interrupt/exception path is one of
the key BQL users as measured by the QEMU sync profiling (qsp).

We have chosen to break up the process of removing
BQL from this path into two pieces:

1) Changes to the core/common functions
   of cpu_handle_interrupt/exception
   allowing a per-arch decision to hold BQL.
   The common case and the default is for the core code
   to hold the BQL (bql=true).
   This set of changes is handled in this patch.

2) Removing the BQL from the per-arch functions.
   1) makes it possible for an arch to set bql=false
   so that the common code does not hold the BQL
   across the cpu_handle_interrupt/exception call.
   This allows the arch to handle locking in this path
   We leave it up to the arch to make the change
   at the time that makes sense.

It is worth mentioning that we are working on per-arch changes
in line with 2), and plan to submit these.
In other words, we plan to set the groundwork with this
patch series and then will take advantage of it in later series.

This patch series is based on the per-CPU locks patch:
https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg05314.html

Robert Foley (2):
  hw/core: Add bql_interrupt flag to CPUClass
  accel/tcg:  interrupt/exception handling uses bql_interrupt flag

 accel/tcg/cpu-exec.c  | 34 ++++++++++++++++++++++++++--------
 hw/core/cpu.c         |  1 +
 include/hw/core/cpu.h |  8 ++++++++
 3 files changed, 35 insertions(+), 8 deletions(-)

-- 
2.17.1


