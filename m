Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786EAC43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 16:45:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A270208C7
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 16:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p5jJ3n+x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A270208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFKGR-0005m4-3E
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 12:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kFKFl-0004wz-IC
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 12:44:25 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631]:42737)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kFKFj-0000Z7-3J
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 12:44:25 -0400
Received: by mail-ej1-x631.google.com with SMTP id q13so18931444ejo.9
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 09:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gHA3rG1cX6vaNQ4xFlpgHaaH64od+23NbrxTtBveFE8=;
 b=p5jJ3n+xJkTCmsGQONXl8FFT3g92K86LCxnB8RzF8BsH1HNoi4n9KmcwlK7h2+OpuS
 ZAmvczID2A66jK6eOr2nHK1oxxlOLJkGcEhysU/Cxoph9S5DyHxKC3UCBZry40StHyat
 7GEpu8nACBN4PtGOTEprYkdCtdXYdzmN5AnaWvU+dw4dqQvl3ayNyKv7dc/agCXAdxP7
 y3XrPT/oHsPiYhW0cKVrcxIaBrKJq5Pt1NBvZngeHat/8+ryZw63KsHObVfWP9p1AT94
 aDHIvUfE2tq/uzxRRXbrzLG6sRHXsIwGUb34+dImUvtwoR3B4qVJeidXSHY6DhBmUlXU
 oxeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=gHA3rG1cX6vaNQ4xFlpgHaaH64od+23NbrxTtBveFE8=;
 b=Y+C6SR/p3L6rJemz43QxgrPbY50fI03YdqFP+n1HAdHTAEGTRVsQIEdsAP2Ekoi6nw
 +RUw4Ci0thjDG+Fme62KpWEpMJggHzxhZyZvQVDHpsZuS913qOFcnvHTWcBqHV0ckRE+
 knqctUpNqIl899P5dsesput6+jQJ1spWSQBFEipizPuniDCu4CSKWKUseSF6BN8IWJ9I
 CbDpAQ2OUMYnd8Ay/CU74uYERftky/madxBYzm52AfmlSGC2yTMUnDW9cdLSLLVf6EI1
 QpRR7N4ohJJ5pRBeBxHemsX0shPSxNPXdU1zAfll4qNlb/z8TdLHXHHQpBKeHM398YDE
 2gcA==
X-Gm-Message-State: AOAM532e40+ycJFKc6lBG9krxZCj+paIdN2Ip4TAbkfeA8FQvnKC6GYJ
 SXTmwnz1u4IDE1H72v0L3HGLRXwtufU=
X-Google-Smtp-Source: ABdhPJz3IGr562sYqi70Z//qJxb7AXhRRW8YLynEi0xflFqlsra7Oa2O6ebOfB4/GAq5CTUisf2Bpg==
X-Received: by 2002:a17:906:a207:: with SMTP id
 r7mr12237591ejy.32.1599497061382; 
 Mon, 07 Sep 2020 09:44:21 -0700 (PDT)
Received: from donizetti.lan ([2001:b07:6468:f312:6891:d6db:f6ec:d1df])
 by smtp.gmail.com with ESMTPSA id n20sm15760391ejg.65.2020.09.07.09.44.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 09:44:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 37/46] meson: get opengl compilation flags from OPENGL_CFLAGS
Date: Mon,  7 Sep 2020 18:44:20 +0200
Message-Id: <20200907164421.19886-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200907164421.19886-1-pbonzini@redhat.com>
References: <20200907164421.19886-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-ej1-x631.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The opengl compilation flags were added to QEMU_CFLAGS.  We do not
want them to be added to all compilation commands, so export them
also via OPENGL_CFLAGS rather than via QEMU_CFLAGS.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure   | 1 +
 meson.build | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index d21fb1e733..e18f3e2156 100755
--- a/configure
+++ b/configure
@@ -7051,6 +7051,7 @@ fi
 
 if test "$opengl" = "yes" ; then
   echo "CONFIG_OPENGL=y" >> $config_host_mak
+  echo "OPENGL_CFLAGS=$opengl_cflags" >> $config_host_mak
   echo "OPENGL_LIBS=$opengl_libs" >> $config_host_mak
   if test "$opengl_dmabuf" = "yes" ; then
     echo "CONFIG_OPENGL_DMABUF=y" >> $config_host_mak
diff --git a/meson.build b/meson.build
index eda2dc8b9e..6a0a645a9c 100644
--- a/meson.build
+++ b/meson.build
@@ -302,7 +302,8 @@ if 'CONFIG_AUDIO_COREAUDIO' in config_host
 endif
 opengl = not_found
 if 'CONFIG_OPENGL' in config_host
-  opengl = declare_dependency(link_args: config_host['OPENGL_LIBS'].split())
+  opengl = declare_dependency(compile_args: config_host['OPENGL_CFLAGS'].split(),
+                              link_args: config_host['OPENGL_LIBS'].split())
 else
 endif
 gtk = not_found
-- 
2.26.2



