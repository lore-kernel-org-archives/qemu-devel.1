Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7CBC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:47:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD28420789
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqlad71I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD28420789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gQ7-0003tD-Vh
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 10:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGs-000459-St
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:37:58 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:51536)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGr-00065Q-3d
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:37:58 -0400
Received: by mail-wm1-x330.google.com with SMTP id p14so13423663wmg.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QVZIG0mdwsjMiMofc5+oO2XHExj/PcaxRAVhdIUfPEM=;
 b=lqlad71IfRVmKkFnWGwli0kMNIgMqnnIuc5LzLF4JdAt9frvLeqY2oRjFKBk+CgRa6
 uzSr4QIZrMuBo9WdwNN2QWoUNTtl49IlpvOB8BwY4nAXjnEhd4vOKltZoBmy6B7QnPXT
 Q1sgCEuBG7oVLCLHtDexjHMPgSxdS6kpBVVBI2GTmvNZzZ6l/JhOhrflcXf0dGyJRg0w
 bzFdUaX11lFgVqBd1wzjNHAbSAiAX67U4rRK1PmfnL22z6IDll/lWg+q+r+TzTb2I64L
 JC1+6Lj75jo6D6kJVbZGPHM2efPIiG/nNHHEggsfjpoZ7sX1KOTVWBfCw5SB8PrbFBzW
 yoCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=QVZIG0mdwsjMiMofc5+oO2XHExj/PcaxRAVhdIUfPEM=;
 b=ZfqYoaThCyNFLfNr4JHup+yKXA52UR5g7j0OMuBoSrch0EmRkFd3dZyJFfhRV3zPXg
 nWVKAe0TFH2zrt1Nl5kNfEMbOVt/tEuDfprpd0jYiQgFpXCRpdGHg4UJwTyy7RCpxp0A
 vW4C27HRaDZGJSlPrxKSpL5ognpMRbyaRB/rJ3a0HnsyoSu0vvQfsNfhx+DTAvIGwAxf
 AVaqpaex2TjkwGZo5PwabllaPqR3TCSzVDEnG3PGIUE2LB/+cxBhDQQuzJQD6Ks/BaPr
 oDbN5ANvf5IeEHuwUvL28tceGpPDt1hjnSWw/r2L93m0DTf9bkihc1r/DcK9BzZB7hCR
 7DTA==
X-Gm-Message-State: AOAM531xDdh8z+sheCkd7PG3HOmgCYplq18Q8NhVnxEicsyt0piCIbmL
 MCs4G3BvoDY7xEtk69oDhHXuY43oTF8=
X-Google-Smtp-Source: ABdhPJzwtGwVBVqdnBa0lZXjkq3h5v2hMSQOYoT3eXitibBXqc21ieag0yUTsHSNDW5LyBXxaJVK2w==
X-Received: by 2002:a1c:1b41:: with SMTP id b62mr14972683wmb.89.1597675073357; 
 Mon, 17 Aug 2020 07:37:53 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.37.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:37:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 026/150] meson: add version.o
Date: Mon, 17 Aug 2020 16:35:19 +0200
Message-Id: <20200817143723.343284-27-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x330.google.com
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 16f92c4c60..d70c98bd9c 100644
--- a/meson.build
+++ b/meson.build
@@ -45,8 +45,14 @@ targetos = host_machine.system()
 m = cc.find_library('m', required: false)
 util = cc.find_library('util', required: false)
 socket = []
+version_res = []
 if host_machine.system() == 'windows'
   socket = cc.find_library('ws2_32')
+
+  win = import('windows')
+  version_res = win.compile_resources('version.rc',
+                                      depend_files: files('pc-bios/qemu-nsis.ico'),
+                                      include_directories: include_directories('.'))
 endif
 glib = declare_dependency(compile_args: config_host['GLIB_CFLAGS'].split(),
                           link_args: config_host['GLIB_LIBS'].split())
@@ -231,7 +237,7 @@ libqemuutil = static_library('qemuutil',
                              sources: util_ss.sources() + stub_ss.sources() + genh,
                              dependencies: [util_ss.dependencies(), m, glib, socket])
 qemuutil = declare_dependency(link_with: libqemuutil,
-                              sources: genh)
+                              sources: genh + version_res)
 
 summary_info = {}
 summary_info += {'Install prefix':    config_host['prefix']}
-- 
2.26.2



