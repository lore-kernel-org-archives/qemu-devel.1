Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AD7C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 16:25:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15D4D206B8
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 16:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzDKsv96"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15D4D206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG2ui-000718-4s
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 12:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kG2kn-0000ts-5h; Wed, 09 Sep 2020 12:15:25 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:36273)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kG2ki-0006Z3-TP; Wed, 09 Sep 2020 12:15:24 -0400
Received: by mail-pg1-x543.google.com with SMTP id f2so391579pgd.3;
 Wed, 09 Sep 2020 09:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=70Ma0bsMS+N8kUAgscN+dsueAkfzxvTL6r3jLhB2wcc=;
 b=gzDKsv96W98DCLHiTa8wexBvyAf5dt8uIgT51iunKVNjFjhF0iN9tYEgEMe1WBwS6r
 Wrw7OqIW2cmL6miMqmOgC+I3Xo6Tqjo99J6CTw/PzBiAAtaN3yS1KkoquLXOGEbXKWtT
 xpu9wAoH3no+xQPQrE20PdSj32dogp1Q3VDN7knHiYVM5FsM5F58Ld5BKUTK1zo6ldgl
 zKzvxBn28KSsx9KVo8Yo6ZUn0L5ez5uVHP9GeA4ZLhuImTjI5RG8uawY45ZRPW8WIVbX
 YNvq5EkbH8x4lRrH5Z807n2fePs6juozBUsrw2HwjHTfVYnKvCQ8Jaby+ntIDxUMPtVN
 D/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=70Ma0bsMS+N8kUAgscN+dsueAkfzxvTL6r3jLhB2wcc=;
 b=BaoJbHnHhUa/jM0qqwFcPffVmKEiGqpYapEUt70sg8yqqNWBBmMbNotevfuSwO+2eI
 aufdmpdYFihwmKMribkWm90jBC64+3JlknXs7sxvYIq8fuK2mFgfaiI4jKnSdByG2Zgi
 GoYiIchHbab+10yZ9UwDlZdkEygvP8O2qsQdVMUWa9ANrFSsXBnIc94qDf2pe6F55oSC
 9KgjOjM9UfFuVSrTJvAsj+0JJRqnzwEr5JWS9xYR2B3OfZPodQ+Rf8u1wmZM88AxlXTb
 MnYdxXGCCaOv8H6lc7Ek6qKMqiFGoUddfCudfKg9+rJV8xlXDlbNTV4dvr89p1lRaojM
 FdRg==
X-Gm-Message-State: AOAM532LXvMOA+VZaYYa3FHQlyjKNDtXEeuDVJO9N/EqkDuJBU4kvAT4
 QcmQQeX2d2WJ9n384L/5v7+iFkCBlwkVtKre
X-Google-Smtp-Source: ABdhPJznUgOE0uOHj1YLR9RiZSgjzZnZfdG3Jcr2+ZdRoALr5r2xd0uLsP6C7aQCEWd1ZFEUWsTYGQ==
X-Received: by 2002:a62:1ec1:0:b029:13e:d13d:a102 with SMTP id
 e184-20020a621ec10000b029013ed13da102mr1546854pfe.30.1599668118699; 
 Wed, 09 Sep 2020 09:15:18 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id l123sm2506987pgl.24.2020.09.09.09.15.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 09:15:17 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 16/24] cirrus: Building freebsd in a single short
Date: Thu, 10 Sep 2020 00:14:27 +0800
Message-Id: <20200909161430.1789-8-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200909161430.1789-1-luoyonggang@gmail.com>
References: <20200909161430.1789-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x543.google.com
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
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
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
---
 .cirrus.yml | 37 +++++++++----------------------------
 1 file changed, 9 insertions(+), 28 deletions(-)

diff --git a/.cirrus.yml b/.cirrus.yml
index 3dd9fcff7f..a18971aac4 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -1,40 +1,21 @@
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
+    - ../configure --enable-werror || { cat config.log; exit 1; }
     - gmake -j$(sysctl -n hw.ncpu)
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
-    - gmake -j$(sysctl -n hw.ncpu)
-    - gmake -j$(sysctl -n hw.ncpu) check
+    - gmake check
 
 macos_task:
   osx_instance:
-- 
2.28.0.windows.1


