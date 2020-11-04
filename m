Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD83CC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:53:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1084920780
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZOCT0nip"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1084920780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaNuA-0002Mc-VI
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 13:53:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaNk9-0001yH-6I
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 13:42:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41525)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaNk6-00028J-7P
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 13:42:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604515365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FOR/bv25dGPFB9FnzIFOxW/ObDgDZns8YprwAzRry/Y=;
 b=ZOCT0nipxcarR/PkJXPu4zNwZOVnjdoQTGZVrg0nC36mEW45ZYhZmM6D04IPfscZHMpK1o
 U4cfg9kO/aj7rWZRdLVX6cYSTTm//oeXw8ll+y3wb4x39L+nfGBqR4jHj00M9TECYwazhO
 X6m+AxXm8iOgnGooOrdAq6Nst2MByzg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-U_0yv88tNZCx7G7sLSfluQ-1; Wed, 04 Nov 2020 13:42:41 -0500
X-MC-Unique: U_0yv88tNZCx7G7sLSfluQ-1
Received: by mail-wr1-f70.google.com with SMTP id i1so9580565wrb.18
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 10:42:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FOR/bv25dGPFB9FnzIFOxW/ObDgDZns8YprwAzRry/Y=;
 b=sReZE2pWqD9xBuC8pZ9pYJ3tFQxZ6CRpO/SYFhf5zizADuaLhPSXf1F2exgMIbXxKK
 FUZbUTgkxySueYxmXT0DdVfP19TdPn0tP7rRdSVClYKPLTOPtFmCnrWX4RXmlD85H8V/
 dsVGkUoBULqJNmVHsd1Z/erbHJbyhhWTrgTRPWKacJwGEkrlXyM/N0bcVPW7NW9WwZBp
 vDfSrjvNueDSvLJd9eRjSIxgOZTKF9ld5z8A4QPkGsg+3LluFFXYdN/s0Br9PI80tk5J
 KGU3sc9JhuN1mQJF0CG7VWiWt9T+4JKTODohvLJZiVAlABvMqPioSBh+UWyqbyCizRLF
 G61g==
X-Gm-Message-State: AOAM530LhHOR5AK0HYvjmv9ukoW+blr/PPAtx7+mIyDe3FJDadDAe+Rt
 KqENnRtyIOSV1ocLt5sAVnKekNQlxnQoijIabSo7Cf2J/KUgrO6MKqT5zN40GzH5/6+cc8J1Fhl
 UIw9JPfwyOBG1qJY=
X-Received: by 2002:a7b:c394:: with SMTP id s20mr5924198wmj.40.1604515358943; 
 Wed, 04 Nov 2020 10:42:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwqQ9cPQnZn21RyObjiv/0mWqWgbarV9I5sq1Oty/uN54G/keqXwFoQvvPtrJ5zwc6ZabtS8w==
X-Received: by 2002:a7b:c394:: with SMTP id s20mr5924184wmj.40.1604515358792; 
 Wed, 04 Nov 2020 10:42:38 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id y20sm3285147wma.15.2020.11.04.10.42.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 10:42:38 -0800 (PST)
Date: Wed, 4 Nov 2020 13:42:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 28/31] configure: introduce --enable-vhost-user-blk-server
Message-ID: <20201104184040.285057-29-mst@redhat.com>
References: <20201104184040.285057-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201104184040.285057-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

Make it possible to compile out the vhost-user-blk server. It is enabled
by default on Linux.

Note that vhost-user-server.c depends on libvhost-user, which requires
CONFIG_LINUX. The CONFIG_VHOST_USER dependency was erroneous since that
option controls vhost-user frontends (previously known as "master") and
not device backends (previously known as "slave").

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20201027173528.213464-3-stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 configure                | 15 +++++++++++++++
 block/export/export.c    |  4 ++--
 block/export/meson.build |  2 +-
 util/meson.build         |  2 +-
 4 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/configure b/configure
index 2c3c69f118..b5e8f5f72c 100755
--- a/configure
+++ b/configure
@@ -329,6 +329,7 @@ vhost_crypto=""
 vhost_scsi=""
 vhost_vsock=""
 vhost_user=""
+vhost_user_blk_server=""
 vhost_user_fs=""
 kvm="auto"
 hax="auto"
@@ -1246,6 +1247,10 @@ for opt do
   ;;
   --enable-vhost-vsock) vhost_vsock="yes"
   ;;
+  --disable-vhost-user-blk-server) vhost_user_blk_server="no"
+  ;;
+  --enable-vhost-user-blk-server) vhost_user_blk_server="yes"
+  ;;
   --disable-vhost-user-fs) vhost_user_fs="no"
   ;;
   --enable-vhost-user-fs) vhost_user_fs="yes"
@@ -1791,6 +1796,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   vhost-crypto    vhost-user-crypto backend support
   vhost-kernel    vhost kernel backend support
   vhost-user      vhost-user backend support
+  vhost-user-blk-server    vhost-user-blk server support
   vhost-vdpa      vhost-vdpa kernel backend support
   spice           spice
   rbd             rados block device (rbd)
@@ -2382,6 +2388,12 @@ if test "$vhost_net" = ""; then
   test "$vhost_kernel" = "yes" && vhost_net=yes
 fi
 
+# libvhost-user is Linux-only
+test "$vhost_user_blk_server" = "" && vhost_user_blk_server=$linux
+if test "$vhost_user_blk_server" = "yes" && test "$linux" = "no"; then
+  error_exit "--enable-vhost-user-blk-server is only available on Linux"
+fi
+
 ##########################################
 # pkg-config probe
 
@@ -6275,6 +6287,9 @@ fi
 if test "$vhost_vdpa" = "yes" ; then
   echo "CONFIG_VHOST_VDPA=y" >> $config_host_mak
 fi
+if test "$vhost_user_blk_server" = "yes" ; then
+  echo "CONFIG_VHOST_USER_BLK_SERVER=y" >> $config_host_mak
+fi
 if test "$vhost_user_fs" = "yes" ; then
   echo "CONFIG_VHOST_USER_FS=y" >> $config_host_mak
 fi
diff --git a/block/export/export.c b/block/export/export.c
index c3478c6c97..bad6f21b1c 100644
--- a/block/export/export.c
+++ b/block/export/export.c
@@ -22,13 +22,13 @@
 #include "qapi/qapi-commands-block-export.h"
 #include "qapi/qapi-events-block-export.h"
 #include "qemu/id.h"
-#if defined(CONFIG_LINUX) && defined(CONFIG_VHOST_USER)
+#ifdef CONFIG_VHOST_USER_BLK_SERVER
 #include "vhost-user-blk-server.h"
 #endif
 
 static const BlockExportDriver *blk_exp_drivers[] = {
     &blk_exp_nbd,
-#if defined(CONFIG_LINUX) && defined(CONFIG_VHOST_USER)
+#ifdef CONFIG_VHOST_USER_BLK_SERVER
     &blk_exp_vhost_user_blk,
 #endif
 };
diff --git a/block/export/meson.build b/block/export/meson.build
index 9fb4fbf81d..19526435d8 100644
--- a/block/export/meson.build
+++ b/block/export/meson.build
@@ -1,2 +1,2 @@
 blockdev_ss.add(files('export.c'))
-blockdev_ss.add(when: ['CONFIG_LINUX', 'CONFIG_VHOST_USER'], if_true: files('vhost-user-blk-server.c'))
+blockdev_ss.add(when: 'CONFIG_VHOST_USER_BLK_SERVER', if_true: files('vhost-user-blk-server.c'))
diff --git a/util/meson.build b/util/meson.build
index c5159ad79d..f359af0d46 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -66,7 +66,7 @@ if have_block
   util_ss.add(files('main-loop.c'))
   util_ss.add(files('nvdimm-utils.c'))
   util_ss.add(files('qemu-coroutine.c', 'qemu-coroutine-lock.c', 'qemu-coroutine-io.c'))
-  util_ss.add(when: ['CONFIG_LINUX', 'CONFIG_VHOST_USER'], if_true: [
+  util_ss.add(when: 'CONFIG_LINUX', if_true: [
     files('vhost-user-server.c'), vhost_user
   ])
   util_ss.add(files('block-helpers.c'))
-- 
MST


