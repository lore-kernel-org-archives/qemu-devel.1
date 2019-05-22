Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09954C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 22:36:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90BF02089E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 22:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oRkrI5C4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90BF02089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52613 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTZqe-0000i1-UQ
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 18:36:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTZj4-00039x-JS
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:28:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTZj3-0007RS-Gx
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:28:46 -0400
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31]:39104)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTZj1-0007MV-Ol
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:28:45 -0400
Received: by mail-yb1-xb31.google.com with SMTP id a3so1497777ybr.6
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 15:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=cyPCzZg9DUKeW2pqf+eu++K5/1I4IivLKFA9dQuPgvg=;
	b=oRkrI5C4KGkvNs/oqPbgoM9XFy+VDahGjMZCQDmIFo9jYrXEl1mZkelkmMVlrjh5ns
	a53I0lC1ebsp8juhQWg26bt6EJL0nClavDqUt8DHI2ZPcNp3IeuOVz2MkIqYx2psoXq6
	PnrRqKxq3DWlCMU17cZoEgRF5l6baMw8vA1GmqvaoKODr5qaIq+AgR2O+0MxwGBcfJu1
	ptPtMCebT0eTFQNJAgvMvGYQJaA9a4iCmUJ0B6TEByxsnGIT77TtcLwPSWCmTjuPL+JN
	i3kL5at0OZy/VHz6W4dgAu+OP0oCYPhCplr6L5UCG3iC3H04daJcVDmgYxjSJS9B8/Ah
	Tvfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=cyPCzZg9DUKeW2pqf+eu++K5/1I4IivLKFA9dQuPgvg=;
	b=UApYc9uw3JHbg8yDY42q5n2qiNeOPm2okivd/6WOI9bdfqvmErA/gLyO/l//1XkyEU
	WBmfzjPdyhzhWx5QqWmSaihEsnAmZp1trPLTCD5BBLWlvHqdtQPfvS9ea9u2VbUrQPmY
	LHdFNfRC7VCLSob49wTbnJ+XPQjnhmEDJvbAgN8ovNZOf+IcutXZq7mJhHPynE70hE/T
	OANIfQr9Vl4nz1C9C3HCJUj4S3Ug7Exg63rTVDq6iXx4m/pfj2IxoJNB8/1P/6oOLTV9
	mEgWcVPVNtqOUBHJ7GPSNEf6hvfSDw6wjT1t5GmxME1aoZCEguzWpTLkEyv1nUne7DDo
	bhBg==
X-Gm-Message-State: APjAAAVQV0E8AP2Qms0c8NK9QougZ06MK58qhCV7TlBRSJxkgBPolPPe
	5kU1s+2jSZucOgV8btYZ0d1xHUYnk/4=
X-Google-Smtp-Source: APXvYqy2AlpWHnO73CO5ZDw2917cOavzO9knlQCNA4k1E0BJg6xsKG1/6QeLuvukDJXLBzDWI2N7sg==
X-Received: by 2002:a5b:bcf:: with SMTP id c15mr14094056ybr.13.1558564113817; 
	Wed, 22 May 2019 15:28:33 -0700 (PDT)
Received: from localhost.localdomain ([71.46.56.17])
	by smtp.gmail.com with ESMTPSA id q11sm2276453ywg.7.2019.05.22.15.28.32
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 15:28:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 18:28:14 -0400
Message-Id: <20190522222821.23850-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190522222821.23850-1-richard.henderson@linaro.org>
References: <20190522222821.23850-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::b31
Subject: [Qemu-devel] [PULL 09/16] tcg/i386: Remove expansion for missing
 minmax
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

This is now handled by code within tcg-op-vec.c.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.inc.c | 37 -------------------------------------
 1 file changed, 37 deletions(-)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index ffcafb1e14..569a2c2120 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -3297,7 +3297,6 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_smax_vec:
     case INDEX_op_umin_vec:
     case INDEX_op_umax_vec:
-        return vece <= MO_32 ? 1 : -1;
     case INDEX_op_abs_vec:
         return vece <= MO_32;
 
@@ -3551,25 +3550,6 @@ static void expand_vec_cmpsel(TCGType type, unsigned vece, TCGv_vec v0,
     tcg_temp_free_vec(t);
 }
 
-static void expand_vec_minmax(TCGType type, unsigned vece,
-                              TCGCond cond, bool min,
-                              TCGv_vec v0, TCGv_vec v1, TCGv_vec v2)
-{
-    TCGv_vec t1 = tcg_temp_new_vec(type);
-
-    tcg_debug_assert(vece == MO_64);
-
-    tcg_gen_cmp_vec(cond, vece, t1, v1, v2);
-    if (min) {
-        TCGv_vec t2;
-        t2 = v1, v1 = v2, v2 = t2;
-    }
-    vec_gen_4(INDEX_op_x86_vpblendvb_vec, type, vece,
-              tcgv_vec_arg(v0), tcgv_vec_arg(v1),
-              tcgv_vec_arg(v2), tcgv_vec_arg(t1));
-    tcg_temp_free_vec(t1);
-}
-
 void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
                        TCGArg a0, ...)
 {
@@ -3609,23 +3589,6 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
         expand_vec_cmpsel(type, vece, v0, v1, v2, v3, v4, va_arg(va, TCGArg));
         break;
 
-    case INDEX_op_smin_vec:
-        v2 = temp_tcgv_vec(arg_temp(a2));
-        expand_vec_minmax(type, vece, TCG_COND_GT, true, v0, v1, v2);
-        break;
-    case INDEX_op_smax_vec:
-        v2 = temp_tcgv_vec(arg_temp(a2));
-        expand_vec_minmax(type, vece, TCG_COND_GT, false, v0, v1, v2);
-        break;
-    case INDEX_op_umin_vec:
-        v2 = temp_tcgv_vec(arg_temp(a2));
-        expand_vec_minmax(type, vece, TCG_COND_GTU, true, v0, v1, v2);
-        break;
-    case INDEX_op_umax_vec:
-        v2 = temp_tcgv_vec(arg_temp(a2));
-        expand_vec_minmax(type, vece, TCG_COND_GTU, false, v0, v1, v2);
-        break;
-
     default:
         break;
     }
-- 
2.17.1


