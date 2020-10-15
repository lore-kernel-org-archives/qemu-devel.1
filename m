Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA741C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 09:54:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8764206D4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 09:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gK4crFcw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8764206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSzxc-0003x9-HB
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 05:54:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <e.emanuelegiuseppe@gmail.com>)
 id 1kSzvP-0002Ta-G1
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 05:51:55 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:43001)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <e.emanuelegiuseppe@gmail.com>)
 id 1kSzvN-0002k1-Vu
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 05:51:55 -0400
Received: by mail-ej1-x642.google.com with SMTP id h24so2666026ejg.9
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 02:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=CVL1Lk008m2jM9jWCmddFEDDIVap1LQpxh1UQ+7A9gg=;
 b=gK4crFcwANGsVJhPtNVzbTFSGa9NjrI6btATKo8sjFUeYZyiuexJbQDNsNhrYzCD/6
 uLctiKn9SYH4h0yaqi6shn4wmSaLxHFPyHclIE6k0gZH/7ojwaq9o3YnryZ+U0wh54K2
 32WXs5Dt7I+7M72LUb6L+EBJE2xLKipa+9eZ8BsoksXgRGlni5vuBxyoN9LAho6tLDzL
 KuDijQX7EF3Q9iDb5kCKQaB+h3S2hgAFWa3GmGz5uKZitU5NUQN+OdoAL3R4w1wUxe/z
 mnP/9YdLuPS/9xxkMc5iz8xoQUud+aerR0BUnHNel0MPEkPZj8S4mMHI4rGTqgFtR+4S
 PSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=CVL1Lk008m2jM9jWCmddFEDDIVap1LQpxh1UQ+7A9gg=;
 b=qQV+XbTnP/UEbI6CKX14YxZDPIGbkR1Xv3CdYb4r+ow86D4h500W2/ClEWaaw0/Rg0
 fqeOWZR0LedSakmVoZtty2qpJroGrMMBLkt4jJ2znA1l00LLsqw92J3vCZwNcWCFNmEJ
 72YVWwRO+p5vFw44RFSP44P0qmlKEzewlv9COynYPpGLa4nZsBftPmg3Ip7f7v2oyEmL
 MP09mssqcg2JrfnE9bdD3qA2CSWa64EN4ks9g+qBlsQZY17EURdGCV0SlBFehslHDazf
 reTQ4fVT1UYmx54A9I3Ea7qnhZ4bHjxceBlwaBUbMyDWrj6/uJpgvHTlho9w2C4v11Z9
 nbQQ==
X-Gm-Message-State: AOAM53265zHy+5GihyPuxlPbwu0sIpMzkoSz6WskPGq/XzjKWG7kJENj
 d/nj5VDo8XO0mayZHNySJ7SaYhLbvzFTLA==
X-Google-Smtp-Source: ABdhPJynDQ54TkcoquvWvLTTalAkzeaCsDXmOEkrjPJ6oBf5A5leItOFkK20NaclPMaPdSxDaezPbg==
X-Received: by 2002:a17:906:f11a:: with SMTP id
 gv26mr3402200ejb.13.1602755511240; 
 Thu, 15 Oct 2020 02:51:51 -0700 (PDT)
Received: from localhost.localdomain ([194.230.155.110])
 by smtp.gmail.com with ESMTPSA id ce15sm1249733ejc.39.2020.10.15.02.51.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2020 02:51:50 -0700 (PDT)
From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] loads-stores.rst: add footnote that clarifies GETPC usage
Date: Thu, 15 Oct 2020 11:51:47 +0200
Message-Id: <20201015095147.1691-1-e.emanuelegiuseppe@gmail.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=e.emanuelegiuseppe@gmail.com; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Current documentation is not too clear on the GETPC usage.
In particular, when used outside the top level helper function
it causes unexpected behavior.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
---
 docs/devel/loads-stores.rst | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
index 9a944ef1af..59c1225391 100644
--- a/docs/devel/loads-stores.rst
+++ b/docs/devel/loads-stores.rst
@@ -93,7 +93,13 @@ guest CPU state in case of a guest CPU exception.  This is passed
 to ``cpu_restore_state()``.  Therefore the value should either be 0,
 to indicate that the guest CPU state is already synchronized, or
 the result of ``GETPC()`` from the top level ``HELPER(foo)``
-function, which is a return address into the generated code.
+function, which is a return address into the generated code [#gpc]_.
+
+.. [#gpc] Note that ``GETPC()`` should be used with great care: calling
+          it in other functions that are *not* the top level
+          ``HELPER(foo)`` will cause unexpected behavior. Instead, the
+          value of ``GETPC()`` should be read from the helper and passed
+          if needed to the functions that the helper calls.
 
 Function names follow the pattern:
 
-- 
2.17.1


