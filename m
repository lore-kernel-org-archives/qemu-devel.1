Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1251FC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:20:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D33AC20879
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aFbsH48F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D33AC20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49989 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTWmk-0005E6-3Q
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 15:20:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTWOo-0008P8-Oe
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:55:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTWCN-00089P-Uy
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:42:49 -0400
Received: from mail-yw1-xc2f.google.com ([2607:f8b0:4864:20::c2f]:35734)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTWCN-00088A-PY
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:42:47 -0400
Received: by mail-yw1-xc2f.google.com with SMTP id k128so1248154ywf.2
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 11:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=cAffAFBxa4y/VVbarNUiRFSP9To260Z9zDP/Ls36OfI=;
	b=aFbsH48F39Xybci721A/f/XujFCOPwXRHQJY0y83RsgL3CsRY7y4Bx5W3NWKKmdiVE
	7JaMgeXYGtwj1ue/MlqLlofh/eyF7gyc6z2jnPl2mtzHJB0Z4DQh98S9iqRHM/dYcINP
	JZVXM+YykQwCEap5W59L4mlv3bHTP7Lh8WbfVir/o+nGvNyIRFMJulCbS1wba9DUFJVZ
	EB3uryMoGvrUmUGarf7Kec+z8V86Z65zkc3/rmplPZyI3o0LGEoo+bK7P91hvwk13Pjj
	RnQ7D9SB94vC2arWx0AiOjKHMH3G/W0M+vzDEYhf+y7y6bbj1GMMDDcM4UCG9UhoCedk
	lp5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=cAffAFBxa4y/VVbarNUiRFSP9To260Z9zDP/Ls36OfI=;
	b=HvZ/UmBcRyp95HvExuGZpTu48HuCBRfUZS0Psf5WYziJ1njrvLA60Tj67IR6VWbSMh
	c+Rkn8M8p/7xZuhcwtYch0qNbzpBs5/VydeTrNTkcRDt+JP5/gRJsvnOY95VIB0UeAqS
	KvdhLHv5QPo7A24DoELIeL7HvAkUxPrhmnc5udVbAtGOzTt2GoLuYxvGob3+Kto3xjmc
	5yXiy5Pf+3sVhVtXmuQ6lvvO5mt914t7hUYN14eTwFWyEUC+6BbubnstpkhseLr0LkvG
	mHGtQdM6M5xeyOVoNuRoSUcxNyh0zaQespAAXV1pFRUdzIS+TL1euymrSY6JH8+kMW21
	SCOg==
X-Gm-Message-State: APjAAAX+A+dXpuHlOn1IFNwbfFyiH2+m0mvhGKGwrKnmHKPWy/QkwwqF
	f3uHvtnZddTwFsQM9SvIVEZz1Bsbnxk=
X-Google-Smtp-Source: APXvYqzQCWwDX0yPSCgUV5E9l+Pn+Xh1qf4kyDMumN5NHKKnWpq+2BioX7KhuSnVV8oNzLltSMTCWg==
X-Received: by 2002:a0d:dbc1:: with SMTP id d184mr18034660ywe.18.1558550565413;
	Wed, 22 May 2019 11:42:45 -0700 (PDT)
Received: from localhost.localdomain ([71.46.56.17])
	by smtp.gmail.com with ESMTPSA id
	206sm1299445ywq.74.2019.05.22.11.42.44
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 11:42:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 14:42:17 -0400
Message-Id: <20190522184226.17871-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190522184226.17871-1-richard.henderson@linaro.org>
References: <20190522184226.17871-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::c2f
Subject: [Qemu-devel] [PULL 16/25] linux-user: Remove srand call
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We no longer use rand() within linux-user.

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/main.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 66c909a1a6..689bcf436d 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -623,8 +623,6 @@ int main(int argc, char **argv, char **envp)
 
     cpu_model = NULL;
 
-    srand(time(NULL));
-
     qemu_add_opts(&qemu_trace_opts);
 
     optind = parse_args(argc, argv);
@@ -692,15 +690,6 @@ int main(int argc, char **argv, char **envp)
     {
         Error *err = NULL;
         if (seed_optarg != NULL) {
-            unsigned long long seed;
-
-            /* This will go away with the last user of rand(). */
-            if (parse_uint_full(seed_optarg, &seed, 0) != 0) {
-                fprintf(stderr, "Invalid seed number: %s\n", seed_optarg);
-                exit(EXIT_FAILURE);
-            }
-            srand(seed);
-
             qemu_guest_random_seed_main(seed_optarg, &err);
         } else {
             qcrypto_init(&err);
-- 
2.17.1


