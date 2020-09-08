Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC82C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:57:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFCD62068D
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s09b1O8/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFCD62068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFio9-0000Zo-1z
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 14:57:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFihR-0003OX-0t; Tue, 08 Sep 2020 14:50:37 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:46162)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFihP-0002oU-8a; Tue, 08 Sep 2020 14:50:36 -0400
Received: by mail-pf1-x442.google.com with SMTP id b124so11693041pfg.13;
 Tue, 08 Sep 2020 11:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GCgbOADJo9SgTrFvdP0jEa9PoTonwhtwSH4+oqHE/pQ=;
 b=s09b1O8/qPl0Wx5E6dWGi3ro2nFGD/w50/L3c+0UPd2GxLWgGxgWs7C2I5MRrvwmom
 scgrnZR9lFURs4Pf05KGDJTJZy1tgHbhXgGVcPR2WPBp6CQnQ10GDMqabv/7C0BVcvAP
 TSrTeQ1Ru/pU5HhrQ1bJxgEi7822FJPsV36GERd1qcA0S90ed6NLm3+J0ReNBDtJqWrP
 GgNxr91TYKn9bkejac+vNs8dr8NB+2c+GvQB51e/1NGsihqd3BdNeWk14k14xgv+b+jL
 A9kwgN9cJEAIkKvp04v1JzMXhNSZroStSIy08lVyNApwTgTU6Ipd7px1JqZRdenm6Mz4
 ZHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GCgbOADJo9SgTrFvdP0jEa9PoTonwhtwSH4+oqHE/pQ=;
 b=jaicMdP3aRa6C9bFhCur80myPB6yxW3dp2WTCcE79XkHewuYoqnvMq1h5uBWeRPeOr
 QCEUF9mBvdN3+BTxbuRSO/lLhthijheVDWfmRdbtDQCUZ/gPSfwwUyJHGB1V3GKD6Pw8
 aI/nfvGEsWJJWfO13Mt3bWk8iSKcuHYpiPh8IHThtiRZg8n0wfJ2S0WKkv1lhPQpuSMJ
 jXFbUKPINmSZ6HmnFKaimrFi+d9+ulBpCfx6WGFOxYmFfbxIkc0n7f1F3vW8kUBJrC7U
 lZ5NDaZAuuG6DNlntfBej0f6o+6JpqtsOGntzEP3tyNNhWbeo8LkpPSM/3M2TdGyzVPz
 N94w==
X-Gm-Message-State: AOAM5314CRe+VCDqCmVQrYJsUlfh7ZW40F8ScK9xkD1fFKoaefNtNFoJ
 jRhmHf3l4m3d+V1D7FwM2H6jnTqp5mXJNjd8
X-Google-Smtp-Source: ABdhPJxss9DgG3QnNN+8erdww6zfCgfMadiAlPJPVXzGP3y6VV/DSjOvl45KgBSPW9jrbQvajAE+aQ==
X-Received: by 2002:a63:f70e:: with SMTP id x14mr83825pgh.407.1599591032872;
 Tue, 08 Sep 2020 11:50:32 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id 8sm43553pjx.14.2020.09.08.11.50.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 11:50:32 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/16] cirrus: Building freebsd in a single short
Date: Wed,  9 Sep 2020 02:49:16 +0800
Message-Id: <20200908184918.1085-15-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200908184918.1085-1-luoyonggang@gmail.com>
References: <20200908184918.1085-1-luoyonggang@gmail.com>
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
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

freebsd 1 hour limit not hit anymore

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 .cirrus.yml | 35 ++++++++---------------------------
 1 file changed, 8 insertions(+), 27 deletions(-)

diff --git a/.cirrus.yml b/.cirrus.yml
index 49335e68c9..b0004273bb 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -1,38 +1,19 @@
 env:
   CIRRUS_CLONE_DEPTH: 1
 
-freebsd_1st_task:
+freebsd_12_task:
   freebsd_instance:
     image_family: freebsd-12-1
-    cpu: 4
-    memory: 4G
-  install_script: ASSUME_ALWAYS_YES=yes pkg bootstrap -f ; pkg install -y
-    bash curl cyrus-sasl git glib gmake gnutls gsed
-    nettle perl5 pixman pkgconf png usbredir
+    cpu: 8
+    memory: 8G
+  install_script:
+    - ASSUME_ALWAYS_YES=yes pkg bootstrap -f ;
+    - pkg install -y bash curl cyrus-sasl git glib gmake gnutls gsed 
+          nettle perl5 pixman pkgconf png usbredir
   script:
     - mkdir build
     - cd build
-    - ../configure --disable-user --target-list-exclude='alpha-softmmu
-        ppc64-softmmu ppc-softmmu riscv32-softmmu riscv64-softmmu s390x-softmmu
-        sparc64-softmmu sparc-softmmu x86_64-softmmu i386-softmmu'
-        --enable-werror || { cat config.log; exit 1; }
-    - gmake -j$(sysctl -n hw.ncpu)
-    - gmake -j$(sysctl -n hw.ncpu) check
-
-freebsd_2nd_task:
-  freebsd_instance:
-    image_family: freebsd-12-1
-    cpu: 4
-    memory: 4G
-  install_script: ASSUME_ALWAYS_YES=yes pkg bootstrap -f ; pkg install -y
-    bash curl cyrus-sasl git glib gmake gnutls gtk3 gsed libepoxy mesa-libs
-    nettle perl5 pixman pkgconf png SDL2 usbredir
-  script:
-    - ./configure --enable-werror --target-list='alpha-softmmu ppc64-softmmu
-        ppc-softmmu riscv32-softmmu riscv64-softmmu s390x-softmmu
-        sparc64-softmmu sparc-softmmu x86_64-softmmu i386-softmmu
-        sparc-bsd-user sparc64-bsd-user x86_64-bsd-user i386-bsd-user'
-        || { cat config.log; exit 1; }
+    - ../configure --enable-werror || { cat config.log; exit 1; }
     - gmake -j$(sysctl -n hw.ncpu)
     - gmake -j$(sysctl -n hw.ncpu) check
 
-- 
2.28.0.windows.1


