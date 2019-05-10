Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F2FC04AB1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 01:39:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD083217F9
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 01:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QTSz4jph"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD083217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35182 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOuVw-0002Ti-Vs
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 21:39:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOuHq-0006LA-FJ
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOuHp-0001G1-HM
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:22 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:44626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOuHp-0001En-BN
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:21 -0400
Received: by mail-pf1-x42b.google.com with SMTP id g9so2244589pfo.11
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 18:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=m8x2+ISq8VDA34RGun8yoxuib+WCd51kzqEMsPfii4Q=;
	b=QTSz4jph9S4OEHX0O5EabZ5iXAOs0H+CP+JG+4vlE6qvDaDaYukMygwb5yWkxD3Sax
	FJi9MaYsQV9JwwOvNWLtSPayMkZVVhwNTf8khaebgPdJlsVX5F0L8r9ofTib/ppupl1D
	DKZDdVwqi/zGHdZ3TWpmhoZ3BiWNeMFQPHjAw4iGbDrrXHWzdBBF2Aca0xQtmnwJN5ry
	HNwqYQpqqnH6OV8jGEJCHE4m2Mg6xUf679MlFzlkyZAn6/r+6tog+oQpY4OZOHRiP36J
	NcfUAB5jMyfs/6ct014j2Ac9u8hCIhhSlUfX6wVSvIhlbX5SzBp3TPm1eMa72pH+DCT6
	BmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=m8x2+ISq8VDA34RGun8yoxuib+WCd51kzqEMsPfii4Q=;
	b=iHY4DwWiMfuE2a0hPnHmhUQ1l7IuWmh++/jFW3QaIaPqQR00Q04i2rIu2X0pBNnUyf
	qnCYXSHNMXM+vjNlSjYhdumzI/ohTL+BlSvtvtjACbRhPTxW6wHtYi4lvsAYWZDLZZQv
	eo1OQ9Xbw9w6V1/x1f6jpkQTNI26bt/omfdW/Dgbusupi5sechxQu28tGxbGYpR1gYSh
	8/lE0TrlaYMJg6hT27u+CGDCvaLWXdSOpLKLLOmJ3jcbAdrYtybzhuC2PlirgPEiFbKN
	3YmWOEe11/jFanrj/u1/VzKELos6rdZ3ASnHide+8NF3WJSd7Xggb+gQ1CYbzKiRo2WP
	UwSQ==
X-Gm-Message-State: APjAAAWiTJoEgkgjY6Ds/gMOJhpvuS8UO/9fIWPwnXRkegK8HzpdApLw
	oglJLd5M6BjvsDYE6duAR4khsXD/kb8=
X-Google-Smtp-Source: APXvYqz4NLUnEPt8j+yyR+ay7Tf+C8GFvOWXAxzAuypmOekmrHspRlq0rGQ7QAlT0RLAuQcZKkrATA==
X-Received: by 2002:a62:579b:: with SMTP id i27mr10077584pfj.205.1557451519977;
	Thu, 09 May 2019 18:25:19 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	n18sm8252700pfi.48.2019.05.09.18.25.18
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 18:25:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 18:24:50 -0700
Message-Id: <20190510012458.22706-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510012458.22706-1-richard.henderson@linaro.org>
References: <20190510012458.22706-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::42b
Subject: [Qemu-devel] [PATCH v5 16/24] linux-user: Remove srand call
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
Cc: Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We no longer use rand() within linux-user.

Cc: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/main.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index e455bff1b7..5d1c6a115b 100644
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
             /* ??? Assumes qcrypto is only used by qemu_guest_getrandom.  */
-- 
2.17.1


