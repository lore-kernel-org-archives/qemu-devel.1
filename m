Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873F1C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:16:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9FF320829
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ns1DCL3s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9FF320829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIEZ8-00023V-N1
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 13:16:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIEWp-0008Og-UR; Tue, 15 Sep 2020 13:14:03 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:42068)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIEWo-0002iA-7P; Tue, 15 Sep 2020 13:14:03 -0400
Received: by mail-pl1-x642.google.com with SMTP id y6so1682803plt.9;
 Tue, 15 Sep 2020 10:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Bgt27bCdhURdGhLo2M0oeI2N1IaaI1SbICE67RRbSus=;
 b=ns1DCL3snoCB4DzRBmVOwdO67SNZVpT+nnZkRwC/2HQs4IxZE7+rhzbTKGZRCz484k
 wa7zySjj5wifnSvMZXEPmUJ1/u3wLCjhLQI77TPp8jTD+C2JcktepYNDj6ncaeVlvGLO
 cezLx5rhyiblQLhJxZU/lNavoS4Oez2b1GtjTk5goNd6cjAVbjqsDoNkLAZL79GMnq+I
 nbjuM6Bt8ZY6hz8R0JDCUxVTcg39lZZa9UWwrNXAxSbKQDzMR35eW7pL4DMuGkR3mRnH
 IrkYCMu69KHszu+34NRIIBwlAx7Tcy9r/dKFSQfr6U9ZMvDJv8WJP8atEY4Exc1lR+pK
 4sHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Bgt27bCdhURdGhLo2M0oeI2N1IaaI1SbICE67RRbSus=;
 b=WeR7XNRRzOIIRnIUnxGu7lus4qunEouNreVgOGdtCfGDKGIyzturaNlzGPAHw+z2eJ
 2gmuHhLtxYDCbJSMOVIiAvyPBZrcqPcbMbjSCYY54KQovWDvdk6DcwO5rsO4FTsJEJXm
 daxoDGZBRSo5r0j/iXLMsJLVIgwcXvqz75VN1+wQpWyiHKtNypsc3mzj+v1UkAe25hVj
 qWLXBX4gekRayQW6DNywey1EE8M2ORtQRdl4toOGWIbOdmk+CIu8PpeoiWV5GgK4fY/O
 MATR/cXrAgXGSNsms7VqjY3B6Tpwsf/vSqKQdZ8FIPaWrjx4aOF+m7ES3UQgSwYjjri9
 nrPg==
X-Gm-Message-State: AOAM532f/LGm1qTdKig4eIF+OES+fR8b7lKuDI/QwVecN0YdvF0I2rdT
 M39epiAQOEkr+HYnDsvqVeiu2ZdChK6jPaw0MTA=
X-Google-Smtp-Source: ABdhPJzcTGdoj0cL3HGbdEdXo52AaJS7RKOpcLESEsjmgceVuAWzKxI16Jrg+1FAkb+nXHtp5fFe3Q==
X-Received: by 2002:a17:90a:d512:: with SMTP id
 t18mr336923pju.106.1600190040245; 
 Tue, 15 Sep 2020 10:14:00 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id j14sm124046pjz.21.2020.09.15.10.13.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 10:13:59 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 15/26] cirrus: Building freebsd in a single short
Date: Wed, 16 Sep 2020 01:12:23 +0800
Message-Id: <20200915171234.236-16-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200915171234.236-1-luoyonggang@gmail.com>
References: <20200915171234.236-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=luoyonggang@gmail.com; helo=mail-pl1-x642.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@FreeBSD.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Peter Lieven <pl@kamp.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This reverts commit 45f7b7b9f38f5c4d1529a37c93dedfc26a231bba
("cirrus.yml: Split FreeBSD job into two parts").

freebsd 1 hour limit not hit anymore

I think we going to a wrong direction, I think there is some tests a stall the test runner,
please look at
https://cirrus-ci.com/task/5110577531977728
When its running properly, the consumed time are little, but when tests running too long,
look at the cpu usage, the cpu usage are nearly zero. doesn't consuming time.

And look at
https://cirrus-ci.com/task/6119341601062912

If the tests running properly, the time consuming are little
We should not hide the error by split them

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Ed Maste <emaste@FreeBSD.org>
---
 .cirrus.yml | 35 ++++++++---------------------------
 1 file changed, 8 insertions(+), 27 deletions(-)

diff --git a/.cirrus.yml b/.cirrus.yml
index 3dd9fcff7f..25fb4add9b 100644
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


