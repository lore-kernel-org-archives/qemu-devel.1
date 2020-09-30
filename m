Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80021C4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 20:00:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA04C20709
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 20:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vgG/ol6d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA04C20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNiHV-0007cx-Kc
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 16:00:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kNiFe-0006K3-Sc
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 15:58:58 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:35014)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kNiFc-00079O-J5
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 15:58:58 -0400
Received: by mail-wr1-x430.google.com with SMTP id e16so3146365wrm.2
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 12:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uFGgdCjH6RaiKdPtx+4yFhh4lvq4ISq/FvhVyKEO4tE=;
 b=vgG/ol6dTmL1/Xow9khCxoOVDH+t29i4NagAyZVbOkork3a5W7LJbUlZVHDN3MW8Jd
 oQqw7VmRyeK8K+3xjW/K1w+NZ5b+guFq6RcgSyVueAKaHtO0vBzbo6ePekR5Pt0jsA2/
 qFknH1Dlz4UuUNbLUYYqPou+yV/3LAlylYawTPM7lpZy+ei5Z0+x96KG78KkyNwecalB
 aPpdMeYCFTpW/xQxMB4htuMesaHDikiXt5cSu4gHo6firYeAlyITrZjvUyq3M/SiMja0
 gEbbIquEo/oWR+J2bNI436ovT/nZpDyZrgxeilSsHbohuZ61573lgibWxjFqQN6SFxt2
 v+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=uFGgdCjH6RaiKdPtx+4yFhh4lvq4ISq/FvhVyKEO4tE=;
 b=IeHBScAb7lauJ1KhqMvfA1QTedsbqNX8rrTOy6+eSNVz0Ww/szbDNI2OkxoJQ8oN9t
 +LZd4z04Vl5/J5fDYTCUwuDZAXO4IcNfRY3RIOCrFfZAqD06AonRWD2jZowWt2GIYQYM
 GlzAOe3NUODxwTVeqmj9BktKpgNbCCjvspHXhxrtxfZN6pH+h+tBP8xUVhQ4q+Hd+J7D
 Ej/WdVIqpOaEizDVKPjd3q1NCtGGmBrgxqQf0RFys4kF6/KUJpjXpjqjXicxpob+8gsd
 9II3w3VMhz7yg82Fq5sp5uFZei5o6K08oacxfID25azSqTb8TiHCk4Nqn+EU0pp986ri
 aG4A==
X-Gm-Message-State: AOAM531XWDGrsLv2A3i64bFtGWyZkt6DfUA+kZRTVjSl9/wpC7KEvpdE
 RqIW76QZrf3aWMFOy16C5hEQKxMm7Mk=
X-Google-Smtp-Source: ABdhPJwoK8PT+aQndCGAOiMWjMqRllG0MibzzQppa+AjaUmNF0IeMFislyZdMrpA1OQ7JQAITMshyw==
X-Received: by 2002:adf:db4d:: with SMTP id f13mr4880621wrj.155.1601495933964; 
 Wed, 30 Sep 2020 12:58:53 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:75e3:aaa7:77d6:f4e4])
 by smtp.gmail.com with ESMTPSA id
 b64sm4824204wmh.13.2020.09.30.12.58.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 12:58:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 31/86] meson: extend libmpathpersist test for static linking
Date: Wed, 30 Sep 2020 21:58:50 +0200
Message-Id: <20200930195850.278104-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200930195850.278104-1-pbonzini@redhat.com>
References: <20200930195850.278104-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x430.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

libmultipath has a dependency on libdevmapper, so
include it as well when static linking.  It seems that
the rabbit hole ends there.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/meson.build b/meson.build
index 8e9cd67235..5dd7728cc9 100644
--- a/meson.build
+++ b/meson.build
@@ -302,14 +302,25 @@ if targetos == 'linux' and have_tools and not get_option('mpath').disabled()
           mpath_lib_init(udev);
           return 0;
       }'''
-  libmultipath = cc.find_library('multipath',
-                                 required: get_option('mpath'),
-                                 static: enable_static)
-  libmpathpersist = cc.find_library('mpathpersist',
-                                    required: get_option('mpath'),
-                                    static: enable_static)
-  if libmultipath.found() and libmpathpersist.found() and libudev.found()
-    mpathlibs = [libmultipath, libmpathpersist, libudev]
+  mpathlibs = [libudev]
+  if enable_static
+    mpathlibs += cc.find_library('devmapper',
+                                   required: get_option('mpath'),
+                                   static: enable_static)
+  endif
+  mpathlibs += cc.find_library('multipath',
+                               required: get_option('mpath'),
+                               static: enable_static)
+  mpathlibs += cc.find_library('mpathpersist',
+                               required: get_option('mpath'),
+                               static: enable_static)
+  foreach lib: mpathlibs
+    if not lib.found()
+      mpathlibs = []
+      break
+    endif
+  endforeach
+  if mpathlibs.length() > 0
     if cc.links(mpath_test_source_new, dependencies: mpathlibs)
       mpathpersist = declare_dependency(dependencies: mpathlibs)
       mpathpersist_new_api = true
-- 
2.26.2

