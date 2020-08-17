Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577F2C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:53:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15348204FD
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Odeq9dSi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15348204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gVv-0008Kf-85
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 10:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gH0-0004Gr-OJ
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:07 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33798)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGz-00068m-Bg
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:06 -0400
Received: by mail-wr1-x444.google.com with SMTP id f7so15275587wrw.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jyMNUDYyORpdvrQXMR4LxpvvMPAAn/lulO8jr9STstU=;
 b=Odeq9dSiSL/hZ0XnXXrheUP+Jeg6xvKk8LwKBzEiPrPHzLn6tpZYZw6gmv2hwBEo3K
 5Uak3+b5yjGp3521e1I9VLvYJn9RuLnRcujJT5VeKZgizAzN2dDA8IMh8Qpdbu1jeVJO
 RQWxQgruGZLRQt0lH8qyV2u+gsOFCgL5VCHQ6v3ApxGgkpuXDdZRDGpVd/Q83bBS4Ep4
 g1/rh/sCKMXWSA21O6jN6PLcifzLy9cO3lMwHqrkWDfkjRuLW6KAH2+79qlhTupHuhqK
 H5FJV6ApAtkK6aAcxtJULDoIicOsNAPIgyRaVITbWCdOiSBRiN6LqvKym2ugAZA5uHDd
 zbGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=jyMNUDYyORpdvrQXMR4LxpvvMPAAn/lulO8jr9STstU=;
 b=Rnk/LTchmdlwdCQxcQPeCNCC06zcn5D9uG0ENviI5mZPk/w65rdD8AnPb6FRtWvfoX
 OhNn/AL1BdllthcnKIz4T7rwTQ6JI7Hh7eUJ0HmSOXq5aaveVxG6o2vzJc9ZuiTD9rKR
 2QCXx6iaaEXSDDVRLs+P/MZn46sY1zXFMsqXtQE7zGyTEV7lgEH/uOl0oTJPpySu53jd
 5Edig1ihkSU9nqR+9GG1oErIkpUm2ZwSochT4QXswNYo1O0yiB8YgBVVvQCrGdtWJwrM
 dzjOMORyEal5QFRqBb9EX+vp/ty8AJ/8HPzkWK5iZvVAU/lWsmzFYF3hMuR3ml2KsD4L
 MWxQ==
X-Gm-Message-State: AOAM530xe2lAqc4MvDNxVP3EVHcnExCkkGQ8Wha1xz6/EK1PLqeVP2c1
 I3N+3sKXZ0ZeQ3x74weQl1bqRHD43I8=
X-Google-Smtp-Source: ABdhPJxW0sHrDch5nJ6B8FPnfqEyvRXvjxpjmrDcBrOjpvPGZ0LlYwzgP/icjK49PZbagdp/v+TX5Q==
X-Received: by 2002:adf:b353:: with SMTP id k19mr15504667wrd.159.1597675083891; 
 Mon, 17 Aug 2020 07:38:03 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.38.03 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:38:03 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 038/150] meson: add solaris and Haiku libraries
Date: Mon, 17 Aug 2020 16:35:31 +0200
Message-Id: <20200817143723.343284-39-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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

There is no probing in configure, so no need to pass them as
variables to meson.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/meson.build b/meson.build
index 34e2a7a3f5..08bda49778 100644
--- a/meson.build
+++ b/meson.build
@@ -62,6 +62,14 @@ elif host_machine.system() == 'darwin'
   iokit = dependency('appleframeworks', modules: 'IOKit')
   cocoa = dependency('appleframeworks', modules: 'Cocoa')
   hvf = dependency('appleframeworks', modules: 'Hypervisor')
+elif host_machine.system() == 'sunos'
+  socket = [cc.find_library('socket'),
+            cc.find_library('nsl'),
+            cc.find_library('resolv')]
+elif host_machine.system() == 'haiku'
+  socket = [cc.find_library('posix_error_mapper'),
+            cc.find_library('network'),
+            cc.find_library('bsd')]
 endif
 glib = declare_dependency(compile_args: config_host['GLIB_CFLAGS'].split(),
                           link_args: config_host['GLIB_LIBS'].split())
-- 
2.26.2



