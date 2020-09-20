Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B42C43465
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 13:09:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 675B920EDD
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 13:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h4ZCTnCs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 675B920EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJz5Z-0007kc-DE
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 09:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJz3o-00067o-Dn
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 09:07:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49677)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJz3k-00017d-DG
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 09:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600607233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UHOXeaaNH7mO2Pxxop/1n3qru7dlsdRVvl4+1v0LLIU=;
 b=h4ZCTnCscv+bMuQStmWXq8KNAypanxcF1/bt7h+YtMhe2fTQK3SJELuXJHscGe+gKfrw6B
 ySL4LuMsd07TFhoeCdA1h5b9JDIOu+dHL6osvK01donyJL/qJVTfBnEMRvtNQX5bIG3/63
 eMirA7GEFQJmXJlFJZT+uLAAd1JmMAY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-YPqjf2sDMFW4SFBrxa5Lgw-1; Sun, 20 Sep 2020 09:07:11 -0400
X-MC-Unique: YPqjf2sDMFW4SFBrxa5Lgw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 053608030B8
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2020 13:07:11 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C620161983
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2020 13:07:10 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/9] configure: remove dead variable
Date: Sun, 20 Sep 2020 09:07:04 -0400
Message-Id: <20200920130708.1156310-6-pbonzini@redhat.com>
In-Reply-To: <20200920130708.1156310-1-pbonzini@redhat.com>
References: <20200920130708.1156310-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/20 07:54:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.501,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/configure b/configure
index ee5c4da54b..df3b031b1c 100755
--- a/configure
+++ b/configure
@@ -808,9 +808,6 @@ fi
 
 # OS specific
 
-# host *BSD for user mode
-HOST_VARIANT_DIR=""
-
 case $targetos in
 MINGW32*)
   mingw32="yes"
@@ -837,14 +834,12 @@ FreeBSD)
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
@@ -852,14 +847,12 @@ NetBSD)
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
@@ -876,7 +869,6 @@ Darwin)
   # Disable attempts to use ObjectiveC features in os/object.h since they
   # won't work when we're compiling with gcc as a C compiler.
   QEMU_CFLAGS="-DOS_OBJECT_USE_OBJC=0 $QEMU_CFLAGS"
-  HOST_VARIANT_DIR="darwin"
 ;;
 SunOS)
   solaris="yes"
@@ -7626,9 +7618,6 @@ if [ "$TARGET_ABI_DIR" = "" ]; then
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



