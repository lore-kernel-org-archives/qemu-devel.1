Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDC1C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:19:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B23E2137B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HAyrc7Dh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B23E2137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL0w8-0003Xf-E5
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 05:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kL0oZ-0001Dj-Fi
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:11:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44837)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kL0oR-0002Mt-Vj
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:11:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600852297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I6zjfb7zTAVAZEhd3+8dg8NOErW64r6KoxREtM366l8=;
 b=HAyrc7DhDronk4TaVMVn2UqQlbXgmV+FjfRoMU3yq84489qDocE6QvzINRBfoxaTJj7pQE
 5RAu0thMT85s/62BoRih2lzK2hrKcaS6eKliPTnDyde6m3QhqUypH4zSdffsycmguiMwAo
 qEgB5ReCN6dM8+LQYiJV8EKFChuqyuE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-ZOBUWsh7MAGuzeV9ucEPLg-1; Wed, 23 Sep 2020 05:11:36 -0400
X-MC-Unique: ZOBUWsh7MAGuzeV9ucEPLg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 171061005E66;
 Wed, 23 Sep 2020 09:11:35 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B14B65D9CC;
 Wed, 23 Sep 2020 09:11:34 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/12] configure: remove dead variable
Date: Wed, 23 Sep 2020 05:11:24 -0400
Message-Id: <20200923091131.1591563-6-pbonzini@redhat.com>
In-Reply-To: <20200923091131.1591563-1-pbonzini@redhat.com>
References: <20200923091131.1591563-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/configure b/configure
index 5df58c4b89..903bbcbc46 100755
--- a/configure
+++ b/configure
@@ -815,9 +815,6 @@ fi
 
 # OS specific
 
-# host *BSD for user mode
-HOST_VARIANT_DIR=""
-
 case $targetos in
 MINGW32*)
   mingw32="yes"
@@ -843,14 +840,12 @@ FreeBSD)
   audio_possible_drivers="oss sdl pa"
   # needed for kinfo_getvmmap(3) in libutil.h
   netmap=""  # enable netmap autodetect
-  HOST_VARIANT_DIR="freebsd"
 ;;
 DragonFly)
   bsd="yes"
   make="${MAKE-gmake}"
   audio_drv_list="oss try-sdl"
   audio_possible_drivers="oss sdl pa"
-  HOST_VARIANT_DIR="dragonfly"
 ;;
 NetBSD)
   bsd="yes"
@@ -858,14 +853,12 @@ NetBSD)
   audio_drv_list="oss try-sdl"
   audio_possible_drivers="oss sdl"
   oss_lib="-lossaudio"
-  HOST_VARIANT_DIR="netbsd"
 ;;
 OpenBSD)
   bsd="yes"
   make="${MAKE-gmake}"
   audio_drv_list="try-sdl"
   audio_possible_drivers="sdl"
-  HOST_VARIANT_DIR="openbsd"
 ;;
 Darwin)
   bsd="yes"
@@ -881,7 +874,6 @@ Darwin)
   # Disable attempts to use ObjectiveC features in os/object.h since they
   # won't work when we're compiling with gcc as a C compiler.
   QEMU_CFLAGS="-DOS_OBJECT_USE_OBJC=0 $QEMU_CFLAGS"
-  HOST_VARIANT_DIR="darwin"
 ;;
 SunOS)
   solaris="yes"
@@ -7636,9 +7628,6 @@ if [ "$TARGET_ABI_DIR" = "" ]; then
   TARGET_ABI_DIR=$TARGET_ARCH
 fi
 echo "TARGET_ABI_DIR=$TARGET_ABI_DIR" >> $config_target_mak
-if [ "$HOST_VARIANT_DIR" != "" ]; then
-    echo "HOST_VARIANT_DIR=$HOST_VARIANT_DIR" >> $config_target_mak
-fi
 if [ "$TARGET_SYSTBL_ABI" != "" ]; then
     echo "TARGET_SYSTBL_ABI=$TARGET_SYSTBL_ABI" >> $config_target_mak
     echo "TARGET_SYSTBL=$TARGET_SYSTBL" >> $config_target_mak
-- 
2.26.2



