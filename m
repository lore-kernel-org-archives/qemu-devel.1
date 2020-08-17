Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884FAC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:45:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51AF4205CB
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s21N8Ng7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51AF4205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gO5-0000Sb-Du
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 10:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGc-0003KZ-BR
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:37:42 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:36391)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGa-00062k-RZ
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:37:42 -0400
Received: by mail-wr1-x42f.google.com with SMTP id 88so15280672wrh.3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mQFyJVdpVjaE0U+2hL8BlOmtacuv/C9XnPeWiNd02zw=;
 b=s21N8Ng71iQSh2RJwjvDHgkUUQHFOlS+j4pw+826LodvnUGoDnNYAl7dutEZhjmDQQ
 u8kFvhwlMMHpl2cR/QOD3Vu356IQrql1/EmtFaLNZLzKwe8SnTto6h52qX47wsUY0lyc
 fgDW3F2+Krz7tPfWl8Mmf81Ddu/yR/OhuLnspx0BIiHxO90rLdlxIZQXq6fQjUrWyI/a
 dkobRooohz3Y4LNETaqh9MBAFFsq63l2t3Z5bOT3nVa82z2zCIZqZX4jR3sB7gO/WmK8
 bg21H9wCR0DVa7czrfxpv9acXaYIWM7Q/D53Q4d3yjmSPza/IHQ12mbSQ7pJKzivUN0s
 4U2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=mQFyJVdpVjaE0U+2hL8BlOmtacuv/C9XnPeWiNd02zw=;
 b=m2Wb8sAszY5ftlbxAR23k1yQPYRbimI86DEIkbEclEu/273xcOxXHh6SzY5GRrEGZ9
 b4Valgg2lbrgV7ws96x89rZNssZaxPJHKpnfMVDj6OL00CSPNY74v8+AMC+4awjisx3H
 McMNprXvRQUt2d9ivSvh1JOgzlz6SRQYgsi+fEbH4AMc3qYUyi/vWTk5F5ZRBz8Qcdjb
 xbU525r8ZI59Cj3OdB3ORLDr8FmS0Y33j6nrgqAkcfNmevns2FNA/n6XDcUfxU1jzII0
 PLwyeDPL34K5FZ9gQGXFYqfN5arAn+oQ6gEJncZdFZlQR3rxzmhrD+IDgLIO4av2NLpm
 sFHg==
X-Gm-Message-State: AOAM532c/bJOP2kMGVAacYxUUsCNq9LRaEvv+WxhfjN1Bfs8TwOuVXge
 0hgTTI94W6VGUxG1XGvXo7kWaf9XHKw=
X-Google-Smtp-Source: ABdhPJxzfK3Oe6i/7d2iiB1y91jdJr+vGrUIa+wSUP96msVx/qg90/gDAQ1nE43VjJ9rueYfWh9D/A==
X-Received: by 2002:adf:92a1:: with SMTP id 30mr17126918wrn.56.1597675059100; 
 Mon, 17 Aug 2020 07:37:39 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.37.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:37:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 012/150] configure: expand path variables for meson configure
Date: Mon, 17 Aug 2020 16:35:05 +0200
Message-Id: <20200817143723.343284-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x42f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 configure | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/configure b/configure
index 606c327cca..373bb22287 100755
--- a/configure
+++ b/configure
@@ -415,16 +415,7 @@ LDFLAGS_SHARED="-shared"
 modules="no"
 module_upgrades="no"
 prefix="/usr/local"
-mandir="\${prefix}/share/man"
-datadir="\${prefix}/share"
 firmwarepath="\${prefix}/share/qemu-firmware"
-qemu_docdir="\${prefix}/share/doc/qemu"
-bindir="\${prefix}/bin"
-libdir="\${prefix}/lib"
-libexecdir="\${prefix}/libexec"
-includedir="\${prefix}/include"
-sysconfdir="\${prefix}/etc"
-local_statedir="\${prefix}/var"
 confsuffix="/qemu"
 slirp=""
 oss_lib=""
@@ -979,12 +970,6 @@ if test "$mingw32" = "yes" ; then
     LIBS="-liberty $LIBS"
   fi
   prefix="c:/Program Files/QEMU"
-  mandir="\${prefix}"
-  datadir="\${prefix}"
-  qemu_docdir="\${prefix}"
-  bindir="\${prefix}"
-  sysconfdir="\${prefix}"
-  local_statedir=
   confsuffix=""
   libs_qga="-lws2_32 -lwinmm -lpowrprof -lwtsapi32 -lwininet -liphlpapi -lnetapi32 $libs_qga"
 fi
@@ -1638,6 +1623,26 @@ for opt do
   esac
 done
 
+libdir="${libdir:-$prefix/lib}"
+libexecdir="${libexecdir:-$prefix/libexec}"
+includedir="${includedir:-$prefix/include}"
+
+if test "$mingw32" = "yes" ; then
+    mandir="$prefix"
+    datadir="$prefix"
+    qemu_docdir="$prefix"
+    bindir="$prefix"
+    sysconfdir="$prefix"
+    local_statedir=
+else
+    mandir="${mandir:-$prefix/share/man}"
+    datadir="${datadir:-$prefix/share}"
+    qemu_docdir="${qemu_docdir:-$prefix/share/doc/qemu}"
+    bindir="${bindir:-$prefix/bin}"
+    sysconfdir="${sysconfdir:-$prefix/etc}"
+    local_statedir="${local_statedir:-$prefix/var}"
+fi
+
 case "$cpu" in
     ppc)
            CPU_CFLAGS="-m32"
-- 
2.26.2



