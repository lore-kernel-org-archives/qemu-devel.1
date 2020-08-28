Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8ACC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 17:33:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 951D02074A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 17:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzXe3gn4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 951D02074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBiFj-0007oj-OW
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 13:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kBiF4-0007KB-8R; Fri, 28 Aug 2020 13:32:46 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:37420)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kBiF2-0006T2-Jo; Fri, 28 Aug 2020 13:32:45 -0400
Received: by mail-ej1-x641.google.com with SMTP id e23so192596ejb.4;
 Fri, 28 Aug 2020 10:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UAV2VxiPeh/k1imQq8wDb2V7tbs05yxU2LPT+Ks9Xbc=;
 b=kzXe3gn404XKyNMCE5fChTdiWYauCsZkbrlAhrU+dikQVUR8Qm0ujAZ5ccGVURgIGg
 yO0tPCb3Ke2gOkUzUEf79JxneT1r5+rJS8sj+HFYP5oL+7DozuDnL+qNUjcvISF6/a05
 Ofkf9MpGO8/F/Gp2Spy/FVGeiHHnhhsjJuFmMswzx+8o6GMHFE+BVZ90ESTR7CRBFnvC
 dRn2ysXdB6AFMslzDn4IyvvYF2dBBqopnbBeZT6XaJNtg5lbv832DLKfS6K5vrPe6dFO
 E2LoX0bvCQRcYuaDTrYwYAiP0XqRy6kbQCzZqK+fR6rWN5yLTVZOi0xJAOmrbhdoBagl
 Nqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=UAV2VxiPeh/k1imQq8wDb2V7tbs05yxU2LPT+Ks9Xbc=;
 b=kdk8ZY6tWKoSwkPnrzuIXy05RZ/d2xNLVEQ4InoLEv7s4pY+DdvimgZMaBCcXmUtIB
 9hp79HbRswzhF9wkHZQdaf9sUiiw2LD1Q+RgRdwbC4yeqDMWWENsdU0H9Vr9u5fANs6L
 HeMzRH4Lwx4h9isY+AHiN3gRjvBxvEgsEH5ryqtYcEH/9mXf7wyMiYqxeUoSz9IwB1RG
 bP45oGuf1gUiObnqSOfof2WhwlSGBb3k5ej8HQvIW8XS0dcAvKhUy0n16oiqqsvOgkKs
 k3ZA+sW9QAdXZFUv96p22ua1fUgfTTbEH7jvAxFavbzPErMwnB43+ln5m2JKbq9bDGjS
 mMVA==
X-Gm-Message-State: AOAM531YhUvGILJtgfE6e0wrnWC+4vULifkwQrkw/RHE0NeAOhONPoH+
 SicZwt3Gn3/n9nENyhggF+rSp/o4JDg=
X-Google-Smtp-Source: ABdhPJx/UAnH+mKAvSRKOZjCCpLvUBsqpkRP764bqp1m+paCXbs2h0L985lfIA/YR855qE2pD7+pFA==
X-Received: by 2002:a17:906:6c8b:: with SMTP id
 s11mr2959036ejr.310.1598635961728; 
 Fri, 28 Aug 2020 10:32:41 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:287e:2203:f280:c08])
 by smtp.gmail.com with ESMTPSA id
 do6sm1590865ejc.35.2020.08.28.10.32.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 10:32:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] block: always link with zlib
Date: Fri, 28 Aug 2020 19:32:48 +0200
Message-Id: <20200828173248.24556-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The qcow2 driver needs the zlib dependency.  While emulators
provided it through the migration code, this is not true of
the tools.  Move the dependency from the qcow1 rule directly
into block_ss so that it is included unconditionally.

Fixes build with --disable-qcow1.

Reported-by: Thomas Huth <thuth@redhat.com>
Cc: qemu-block@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/meson.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/meson.build b/block/meson.build
index 4dbbfe60b4..a3e56b7cd1 100644
--- a/block/meson.build
+++ b/block/meson.build
@@ -40,9 +40,9 @@ block_ss.add(files(
   'vmdk.c',
   'vpc.c',
   'write-threshold.c',
-), zstd)
+), zstd, zlib)
 
-block_ss.add(when: [zlib, 'CONFIG_QCOW1'], if_true: files('qcow.c'))
+block_ss.add(when: 'CONFIG_QCOW1', if_true: files('qcow.c'))
 block_ss.add(when: 'CONFIG_VDI', if_true: files('vdi.c'))
 block_ss.add(when: 'CONFIG_CLOOP', if_true: files('cloop.c'))
 block_ss.add(when: 'CONFIG_BOCHS', if_true: files('bochs.c'))
-- 
2.26.2


