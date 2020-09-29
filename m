Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28D1C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:28:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C0EF207F7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FMxozRnQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C0EF207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNA3v-0003dJ-DM
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 03:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9xF-0003Ci-V7
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:21:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33561)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9xC-0001d5-G7
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:21:41 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601364097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=av5Mz4G8ahNNHHbj7k0mQcB8mlsr0+IKdPzJNJRtlnM=;
 b=FMxozRnQeN1LqSwPkhQw3fLShlW6IZTGXP7ZVazR5KJ/NxOeOGIlfloenrjn3w9uUivosb
 JfZABbdP8tIrH3i+T8WAnMv5+NONiTpX4gtHUTrNRlaDC2VN8DtJVjG7OchZWQb8RYCclv
 wscyNuLEn3zc9NEbQnoIb7ysKlkEkVA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-w7nKC3FLNRKBaBw4Dkl1fg-1; Tue, 29 Sep 2020 03:21:35 -0400
X-MC-Unique: w7nKC3FLNRKBaBw4Dkl1fg-1
Received: by mail-wm1-f71.google.com with SMTP id m19so1453909wmg.6
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 00:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=av5Mz4G8ahNNHHbj7k0mQcB8mlsr0+IKdPzJNJRtlnM=;
 b=KDzL+kdKjES1+dZcxf4mIIW9/sohZ5lCfIVyHPrfKgLOdkFPhPclkJRAbhmkiKk7J4
 aW1pJlu6a9kIq+nnUc/NxBhNsmlS/rN2j8ots2jw0Q4kDg1LWIeksKs+vyhEHKevjfn/
 m6/HgWnN0hFOj4KLYhroIdhiFxuCqkOyLYDeIQjz+99FILcUDycHfHCNcVpC6+Zm8aZ1
 X3q42fvBiGwDXb8fUB/YeFITRanuzRZp4IcJW3i4R2SAOuzdGvJSbzLMplGcWkOraRGY
 cJoZkT9DjouYTCaFlvvIHYyfpzk184cAYAj+euQ1plAJT6QJeCHdoXbKjpFrZtJQxy6g
 YqHg==
X-Gm-Message-State: AOAM5300CPmzrZCRwkMNWfr2Q7XOZhw54QOTo0OuM1/UJ39CJMW5thHG
 Jn/5bxbLcQp5bpMsAlCpwaq/IkN4amSO8Ob+DY0DeZlMLx+OdhFPe5Gwp+I/xsN1CIenGkz5NF7
 mZRyMFVCUGA3gN50=
X-Received: by 2002:a05:600c:20c8:: with SMTP id
 y8mr2851809wmm.108.1601364094080; 
 Tue, 29 Sep 2020 00:21:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLO7v9LkFUBiHkyulaCupUIQ6+rAK+A5F3fM66wtauUwrb5YnJwmZ4cec/ptBWhozc9Ujr8g==
X-Received: by 2002:a05:600c:20c8:: with SMTP id
 y8mr2851792wmm.108.1601364093921; 
 Tue, 29 Sep 2020 00:21:33 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id h17sm4967259wro.27.2020.09.29.00.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 00:21:33 -0700 (PDT)
Date: Tue, 29 Sep 2020 03:21:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v4 15/48] configure: Fix build dependencies with vhost-vdpa.
Message-ID: <20200929071948.281157-16-mst@redhat.com>
References: <20200929071948.281157-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200929071948.281157-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, lulu@redhat.com,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, pbonzini@redhat.com,
 marcandre.lureau@redhat.com,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Laurent Vivier <lvivier@redhat.com>

Following the same logic as for vhost-net-user and vhost-kernel,
enable vhost-net if vhost-net-vdpa is enabled and vhost-net is not
explicitly disabled.
See 299e6f19b3e2 ("vhost-net: revamp configure logic")

Autoselect VHOST if VHOST_VDPA is set
See 21c6b0c87e85 ("configure: simplify vhost condition with Kconfig")
See 2becc36a3e53 ("meson: infrastructure for building emulators"

Problems can be triggered using;
... --enable-vhost-vdpa --disable-vhost-user --disable-vhost-kernel ...

Fixes: 108a64818e69 ("vhost-vdpa: introduce vhost-vdpa backend")
Cc: lulu@redhat.com
Cc: pbonzini@redhat.com
Cc: marcandre.lureau@redhat.com
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Message-Id: <20200924210023.160679-1-lvivier@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 configure    | 3 ++-
 Kconfig.host | 4 ++++
 meson.build  | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index e8e8e984f2..8ee15810c8 100755
--- a/configure
+++ b/configure
@@ -2494,9 +2494,10 @@ if test "$vhost_net_vdpa" = "yes" && test "$vhost_vdpa" = "no"; then
   error_exit "--enable-vhost-net-vdpa requires --enable-vhost-vdpa"
 fi
 
-# OR the vhost-kernel and vhost-user values for simplicity
+# OR the vhost-kernel, vhost-vdpa and vhost-user values for simplicity
 if test "$vhost_net" = ""; then
   test "$vhost_net_user" = "yes" && vhost_net=yes
+  test "$vhost_net_vdpa" = "yes" && vhost_net=yes
   test "$vhost_kernel" = "yes" && vhost_net=yes
 fi
 
diff --git a/Kconfig.host b/Kconfig.host
index 4af19bf70e..a9a55a9c31 100644
--- a/Kconfig.host
+++ b/Kconfig.host
@@ -24,6 +24,10 @@ config VHOST_USER
     bool
     select VHOST
 
+config VHOST_VDPA
+    bool
+    select VHOST
+
 config VHOST_KERNEL
     bool
     select VHOST
diff --git a/meson.build b/meson.build
index b26c8bffc6..d36dd085b5 100644
--- a/meson.build
+++ b/meson.build
@@ -521,6 +521,7 @@ kconfig_external_symbols = [
   'CONFIG_OPENGL',
   'CONFIG_X11',
   'CONFIG_VHOST_USER',
+  'CONFIG_VHOST_VDPA',
   'CONFIG_VHOST_KERNEL',
   'CONFIG_VIRTFS',
   'CONFIG_LINUX',
-- 
MST


