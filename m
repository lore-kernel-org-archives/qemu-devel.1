Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA12C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 18:49:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D149C2080A
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 18:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sb6Xu5Kp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D149C2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54270 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbrGS-0006wL-Vc
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 14:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34208)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hbq0T-0007A9-MY
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:28:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hbq0P-0004Ca-Dg
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:28:51 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33066)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hbq0N-0003wR-Bo
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:28:48 -0400
Received: by mail-wr1-x444.google.com with SMTP id n9so3386221wru.0
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 10:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=l+F+1JN97gKyw7kKNWTOxFjpETDNYB39JWHiUo3QTVA=;
 b=sb6Xu5Kp41Z06TykOvhElWOnU/IGs1hZmd23GE+R+8eET7wGXVqS4I/T6oA76AIkSK
 0b+dxWBpr7NOJZ79VVLP8ambmypEN8uW6/WSDPdE3KPdvFTc0d5tT/fDQHljertzxPL0
 mRK+wijtp353zjBR18hWt9fd8LGNTMKYl2pcD2/pjAaz2BXaH5NiyzuTIlwFNqw2EMtF
 lbxQtxBSSfmALXKphpaA2mMbhjkv/WzmSc17qAu9J/HeqAqOsikpbRnGjRLcby40I/im
 z61WDhl3HyReuCU2dWkOEgZG0bLlzs57RLA3Nv6GaAPSld32ffb0DwL8W2LjNz3/7i6R
 FryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=l+F+1JN97gKyw7kKNWTOxFjpETDNYB39JWHiUo3QTVA=;
 b=E88vv6nLS++QKbsNovbk3LncZVEtMJjNzVOIkI/DplHTE3ZbzlwCOyAFtX334xUMOo
 uqoHpiqnEpcs+TchclWX5+Zo/XRG4VC9YcndmB7DE5tZyVGhIXwgDkdsF5uMrTt2uMAj
 3Bdwd4qLshq3BPwk+Z63+SthJI4nUc7OBfMr3WG+SeRJ+gVoyA78doc7tPhLtYZkdT5p
 589BeVQiaempM/wsKd/2fBhzGbV3bzuD8+hHYFyIA+soOpmTNmggEauo1cdSb6M+oImy
 k0CYOXMugtZm/AykM28cUPqWclpanzQL/7KP8mABFsUYoJ/+vMa1Letlp138FgxmlvXf
 MVfA==
X-Gm-Message-State: APjAAAW3nf5LBK3lsZp2yklzsXASlDKVCVhi0DpZXtz/gWS1p2ysPtg6
 yUnt2hrXbzxyN4jQhIuhO1FbYw==
X-Google-Smtp-Source: APXvYqzMLSK7+SkT+doycWqokAFfRgXvilXEqEabHPNK31DKuQzeai/z248Q1ZETdDcZvs/q+IljJA==
X-Received: by 2002:a5d:6709:: with SMTP id o9mr52157881wru.301.1560533317777; 
 Fri, 14 Jun 2019 10:28:37 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id s188sm4205143wmf.40.2019.06.14.10.28.30
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 10:28:36 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E50C71FFCB;
 Fri, 14 Jun 2019 18:12:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 14 Jun 2019 18:12:00 +0100
Message-Id: <20190614171200.21078-51-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614171200.21078-1-alex.bennee@linaro.org>
References: <20190614171200.21078-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH  v3 50/50] TODO: API changes to make?
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

---
 include/qemu/qemu-plugin.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 21f056d4ab..655640fe54 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -169,6 +169,7 @@ enum qemu_plugin_mem_rw {
  * callbacks to be triggered when the block or individual instruction
  * executes.
  */
+/* ??? - should we expose vcpu_index here? */
 typedef void (*qemu_plugin_vcpu_tb_trans_cb_t)(qemu_plugin_id_t id,
                                                unsigned int vcpu_index,
                                                struct qemu_plugin_tb *tb);
-- 
2.20.1


