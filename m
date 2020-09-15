Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7B1C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:55:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBD8920872
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEerEEPu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBD8920872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIAUL-00014n-F2
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 08:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kI9s3-0002d0-1b; Tue, 15 Sep 2020 08:15:39 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:40497)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kI9s0-0008Uk-Tn; Tue, 15 Sep 2020 08:15:38 -0400
Received: by mail-pf1-x442.google.com with SMTP id x123so1821722pfc.7;
 Tue, 15 Sep 2020 05:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EwczR+sEF9hc4J2M80DE+JfDO1uP/AS3SpW7brF/43Q=;
 b=OEerEEPugLVy45XIZUZ6IA+XSo4X3Z7lWZ3CojKyEne2JjeARsTj3G4BVAv0+NeFKz
 1xICFDj4OUVRiFtBEnsEx3P9SiU7W0GCSbmaQBhMxNGTGwjnV/G7EmwQo8GlfdaQEOFg
 eNbaYeH4Dxmsya3fs7NEwsVkaQaKpTpVZyZSoYKqBoKJDUEIcoz4EEcaEjp7WPPriHhd
 m7m2xJII+8N2yDCYJqEmHNbHIQ4QIKmlNNifk+ZbI/Q9RBzJ7CQQR/l4Yxznrh9UVwJ7
 d+G2cuaqDB5NvXed9gS/2w7Ptnl/bxC9rEuAoFZ0B+xi1q0ESh54P4ITTzM+zhKnj4Yv
 l9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EwczR+sEF9hc4J2M80DE+JfDO1uP/AS3SpW7brF/43Q=;
 b=khU8Y2SvJIONdorSfMEI6aotCjZULdRJm0KKA8DrnX7/mazWddAnSUKqSiWqq/s4v1
 HbFPk+/SOalmM+mK75Q4n7vt4pLMEnLJnPP55HPyKxFS66+zvLTbGjAupwntc5oDq3Hb
 bCz84eq/TM/+8r+I94tpy77haL5SLIOC20dA+eZtPiTYdy2kwl0xHZ0tESM66YNM+LL1
 tUuVqhfk4AjQ9dy4O64JRXV/MzuAm8/lSRxLp4B8CPnUCk1rb8ISVai9MmCMc1Q62A9Q
 W70JmCdsdXQzDLqmJ0vO2WjjU1gs67ImmWyUd2noZr2iG80zT4h33qjHITEdp1pHCHnC
 PJ+w==
X-Gm-Message-State: AOAM531yj2bF42b19HjFdtiBX15QnLuydCA7v5VvC80orMS9eW2xb2nI
 BOS/s6RS870rSE/TCmhRBbaHRVmckLGNSOtGoGc=
X-Google-Smtp-Source: ABdhPJy+qru9aD+hjdGyjnaodv1UI9xYzSt4j4XDlKcpH2FgjnVTnV9JqceXizlFt0h6XGi5fLRzzA==
X-Received: by 2002:a63:485c:: with SMTP id x28mr14717568pgk.289.1600172133348; 
 Tue, 15 Sep 2020 05:15:33 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 k28sm13683061pfh.196.2020.09.15.05.15.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 05:15:32 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 26/26] block: enable libnfs on msys2/mingw in cirrus.yml
Date: Tue, 15 Sep 2020 20:13:18 +0800
Message-Id: <20200915121318.247-27-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200915121318.247-1-luoyonggang@gmail.com>
References: <20200915121318.247-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Peter Lieven <pl@kamp.de>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

At the begging libnfs are not enabled because of compiling error,
now it's fixed so enable it

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 .cirrus.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.cirrus.yml b/.cirrus.yml
index 176ccba76c..9566ec0439 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -93,6 +93,7 @@ windows_msys2_task:
         mingw-w64-x86_64-libusb
         mingw-w64-x86_64-usbredir
         mingw-w64-x86_64-libtasn1
+        mingw-w64-x86_64-libnfs
         mingw-w64-x86_64-nettle
         mingw-w64-x86_64-cyrus-sasl
         mingw-w64-x86_64-curl
-- 
2.28.0.windows.1


