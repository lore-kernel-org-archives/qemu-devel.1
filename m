Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0803C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 15:26:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7810A2067D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 15:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vx/VZuma"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7810A2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwSFr-0001ag-QE
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 11:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39134)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jwSEc-0008TD-Hs
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 11:25:14 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:32951)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jwSEa-0005nU-Ni
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 11:25:14 -0400
Received: by mail-wr1-x442.google.com with SMTP id f18so11625166wrs.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 08:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+ZwHV1TY0j+MTqvjQNw1IJRg8wBizhyo8ltO1jMhlE8=;
 b=vx/VZumavB9dH7lOJ7yE9QaBuBd/Ytryk1KE79ztkuzG1LjBYlD8qE18cv2+Jif5Au
 Vgov8xy1UBJh5pIWc3BakXnSRmMK68k/f4YhmEEY/fuvvXHruUCitNyPWHklO+VmdgdS
 2hmGZ9LYAlxR4Xwfp/Wyt00Uw60Fm5ImUp9QFLmYFt+Ho3/lAtn+nPDJPu2eX04zQoY+
 dvWBbl0Mxp4n5RQ1JhU30RKCxpSfZ2BlDm2OH629OMDKARxBlP+LAg22nTAsoUoPtdhn
 T/k7WGRdLUt/+760M+8jr++rxlhOfcg6S0Ta29ArgCci+/bCUq+7062fTg0OG0u9oyAh
 wHSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+ZwHV1TY0j+MTqvjQNw1IJRg8wBizhyo8ltO1jMhlE8=;
 b=cr/hLgfW2F673HAjoh+nqYllNnmrEFEtFyB1DJSkDinRH08zJCv+iCKenE+An9wlFq
 qHeIb8uTzwGJpE8Qv2O4VhLVROBBTf/hiaTCBqPvEOFqP8D/UUJfQa3KTsHH/1ycV7z3
 SeODXJLTnHds8plibTnbBqaZHsErA07a2mOWMrk/w+XM4Yl+mSN7zxTZYDDxn/G+ZCOl
 cTuz1q9MCstXIljtQEqu7//Z/+DvgrxqbMqLQGSVhvVi3YdRdIN3QXc4UXd0GaNnYn1g
 5b9yr2OGHWpbrzbfxuJFRlvOY7tk3c1gkkezOxg1HSpvqRYQKHZt9YSCpRR6Cjz4czSK
 TZDg==
X-Gm-Message-State: AOAM531y5Ykh+hVjwosRYOuhz951dIc9rDnPmp7duWxuUviwE1vCDe8D
 fD6IGNWKh1fT+cqqKjqybznzcRliq5SBfA==
X-Google-Smtp-Source: ABdhPJzneYSuo2O69f1gQAKkzxd+HTJiwrcy5+CtUKvhZjz6ST250Ncwa/IvDooErWyO+iH8nYjTDg==
X-Received: by 2002:adf:c185:: with SMTP id x5mr11746649wre.403.1594999510922; 
 Fri, 17 Jul 2020 08:25:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 1sm13724248wmf.0.2020.07.17.08.25.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2020 08:25:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.1] Makefile: Remove config-devices.mak on "make clean"
Date: Fri, 17 Jul 2020 16:25:08 +0100
Message-Id: <20200717152508.10272-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x442.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The config-devices.mak files are generated by "make", and so they
should be deleted by "make clean".

(This is different from config-host.mak and config-all-disas.mak,
which are created by "configure" and so only deleted by
"make distclen".)

If we don't delete these files on "make clean", then the build
tree is left in a state where it has the config-devices.mak
file but not the config-devices.mak.d file, and make will not
realize that it needs to rebuild config-devices.mak if, for
instance, hw/sd/Kconfig changes.

NB: config-all-devices.mak is also generated by "make", but we
already remove it on "make clean".

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I didn't remove the existing 'rm -f $(SUBDIR_DEVICES_MAK)'
from the 'distclean' rules on the basis that config-all-devices.mak
is explicitly removed in both 'distclean' and 'clean', despite
'distclean' depending on 'clean'...
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 32345c610ee..c2120d8d48d 100644
--- a/Makefile
+++ b/Makefile
@@ -775,6 +775,7 @@ clean: recurse-clean
 	rm -f storage-daemon/qapi/qapi-gen-timestamp
 	rm -rf qga/qapi-generated
 	rm -f config-all-devices.mak
+	rm -f $(SUBDIR_DEVICES_MAK)
 
 VERSION ?= $(shell cat VERSION)
 
-- 
2.20.1


