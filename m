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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B552C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 10:09:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D76DF215A4
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 10:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IS4ctOfi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D76DF215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFx2p-0002CL-PI
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 06:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFx2F-0001gO-Fi; Wed, 09 Sep 2020 06:09:03 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:45255)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFx2D-00026A-OE; Wed, 09 Sep 2020 06:09:03 -0400
Received: by mail-pg1-x543.google.com with SMTP id 67so1700209pgd.12;
 Wed, 09 Sep 2020 03:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jZkHxOcJ5Q39hYOQUMkAjTg0hOyiBYw2ffyYzFdgrfI=;
 b=IS4ctOfixSyz9cjBbHYNUIh2rOPpKrSkIgB+1jcmFhXGCzFyNdpqs1L/YMVK8D66x9
 cdWMLuE9bOweSMIXDEmX1VYe7p5ov4TeriwZgujOmKHWbQDkIhAw+xyDEvMtbl1ypQse
 qi3lGlb0en76YYyWhazA4lEO5cr77cmS9GfrgUY9dgQeDa0GRi2DiJL0H0lv1r62c+tG
 yw7b7z2TVftdsqQWXoCnOFUqS+Hi0C/ONDegX+zlFKjxo+O3ysdeVlFIdwQgnTmTWwmE
 /O/DV6IvmkQokMOmAZUCpcTPLmf6LtzhELKg7HCjG3xD8svjJ6lm3z342iCOqD/2hs6t
 BA4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jZkHxOcJ5Q39hYOQUMkAjTg0hOyiBYw2ffyYzFdgrfI=;
 b=CKXEUDi15s9DLlgQxLD5QbQjAJO7PbTDgaM1f4mhH5a0p67feajL5SHIVtle1C9h8s
 EoSss+ASfZaZGJ4EhrRA00ILV4W26KgcotlK2xQhVIp1lpA2agsycl8Jn62XnhNiN3Vn
 m8Ncjrs0Kg7OtY//Ot3AAvLnI6PBTCgUlaVrgMatJySIxHQ2hjiR+IXY0/fXU+WkVIHG
 BQmlD3j89oMrjkrdgteugd58TDeQEhehuTZEJ3PNe0uXi9D/bo0WFP6knIef2GW57/Fj
 6ftdd2Xn1R8KIWSxoToriJxVolE2IaVcVxUYxh/lFSzkjBkIruHuz/VxH5szQ971tgoI
 tEtg==
X-Gm-Message-State: AOAM532L14EdSjzFZWDEQ6sFCg6w1HSq6S29Ahfd276F7e8b1Jzm1ZLX
 Yg9TX2hpvZYi+z1hh5aQUb0NTXltAVAN2X3H
X-Google-Smtp-Source: ABdhPJxDZ2yXmRzDg/0SkRFrAx8vRhZfofcfSnRRJ986zQ7BJigEBoymZvG/ycqYrkXuSUllmPTtdg==
X-Received: by 2002:a63:651:: with SMTP id 78mr83098pgg.344.1599646139264;
 Wed, 09 Sep 2020 03:08:59 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id d5sm2035502pfq.72.2020.09.09.03.08.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 03:08:58 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 14/21] cirrus: Building freebsd in a single short
Date: Wed,  9 Sep 2020 18:08:42 +0800
Message-Id: <20200909100842.1442-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
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
 Wen Congyang <wencongyang2@huawei.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Lieven <pl@kamp.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

freebsd 1 hour limit not hit anymore

I think we going to a wrong direction, I think there is some tests a stall the test runner,
please look at
https://cirrus-ci.com/task/5110577531977728
When its running properly, the consumed time are little, but when tests running too long,
look at the cpu  usage, the cpu usage are nearly zero. does't consuming time.

And look at
https://cirrus-ci.com/task/6119341601062912

If the tests running properly, the time consuming are little
We should not hide the error by split them

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


