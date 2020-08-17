Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8522C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:08:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4C67204EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRFPMaCN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4C67204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gk4-000687-ST
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHa-0005Gi-CB
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:42 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:34041)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHY-0006FG-DB
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:41 -0400
Received: by mail-wr1-x433.google.com with SMTP id f7so15277502wrw.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2m9BLaRc2vYcN4AzbMEg1k1RBUEJSYEg5EY4KfBueFg=;
 b=WRFPMaCNdVXthCpZyQJrCLCKQLwppToc9gDtCQTOVvoBDHHgD4H4BIOZTuMiszpY+T
 ONDMwcaR0ub3eAear9oebFe9TZMTEWxpCOgPNBhnKmPSgeJZJgHz98Z2k0FwZVeJEim8
 pCICcC8MdKFryrf/vmjI3x2m5lfuaweVabZoenBzz6mo+MjeIDdcf/9sFPqXAEmtJLA2
 stSK4iAC0TXKE2QnnmWr2qcuHMJ4qdiZDM/+PbaGAfeYbJcp4VnZD8SI8PcAnoWxYGHK
 Miit+pnnMCZlMqrEE0yEaJoJZK1/C2YGFD7XrPfdZyyF741LHc9pmGV2qxEptRI3kSDW
 vgmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=2m9BLaRc2vYcN4AzbMEg1k1RBUEJSYEg5EY4KfBueFg=;
 b=TPw5OOZsY/DQw21puQ3c+Nxqzcb5GKpULEMER9ZQqCPQsAYX/LNrd55vMWBu4i0Gsu
 9wFOdluNON7+I1A63tF0u6h+Mu7NdZIm/czUryAoaB8VoosZPO2hl2pkJBaphqScnjJJ
 SMVis0tBXylWKpHSQP6R/kj/l7+lco2U2VTGgNLymL5ebi+i2zeN69RomkLUV1qIAkLs
 MQ8fGzpa8au8h3s/BAoeY+lV18WOsItzconTjBFxWyT1MIMANL4vbRPVNt0K5DMKvQ1h
 Av1SbCuaAMw+nlGS4p6MK+742Y8DqBe32EJg3HSrEEPzSmI+2E57DaLPuf072fjN0E8l
 Bbcw==
X-Gm-Message-State: AOAM530II33MlYr0SJonlpdou3zxJMUPurZ8MJ6IYq6mCEE5jBSTpCdH
 CmvjXYD7frYruh28x2fJhGvUsBfPbX4=
X-Google-Smtp-Source: ABdhPJz1K2/uJ6oUYsYk8zTaW939TXAmxnBGicwvcRGM/2hJ0u4iwSDEZ7siwuh2XmKByRw4On7+KQ==
X-Received: by 2002:adf:ef4d:: with SMTP id c13mr17074204wrp.198.1597675118327; 
 Mon, 17 Aug 2020 07:38:38 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.38.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:38:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 073/150] meson: convert trace/
Date: Mon, 17 Aug 2020 16:36:06 +0200
Message-Id: <20200817143723.343284-74-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x433.google.com
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
 trace/Makefile.objs | 8 --------
 trace/meson.build   | 5 ++++-
 2 files changed, 4 insertions(+), 9 deletions(-)
 delete mode 100644 trace/Makefile.objs

diff --git a/trace/Makefile.objs b/trace/Makefile.objs
deleted file mode 100644
index a429474618..0000000000
--- a/trace/Makefile.objs
+++ /dev/null
@@ -1,8 +0,0 @@
-# -*- mode: makefile -*-
-
-
-##################################################
-# Translation level
-
-obj-y += generated-helpers.o
-obj-y += control-target.o
diff --git a/trace/meson.build b/trace/meson.build
index cab36a248b..9c3c128164 100644
--- a/trace/meson.build
+++ b/trace/meson.build
@@ -1,3 +1,5 @@
+specific_ss.add(files('control-target.c'))
+
 trace_events_files = []
 foreach dir : [ '.' ] + trace_events_subdirs
   trace_events_file = meson.source_root() / dir / 'trace-events'
@@ -61,12 +63,13 @@ foreach d : [
   ['generated-helpers.h', 'tcg-helper-h'],
   ['generated-helpers-wrappers.h', 'tcg-helper-wrapper-h'],
 ]
-  custom_target(d[0],
+  gen = custom_target(d[0],
                 output: d[0],
                 input: meson.source_root() / 'trace-events',
                 command: [ tracetool, '--group=root', '--format=@0@'.format(d[1]), '@INPUT@' ],
                 build_by_default: true, # to be removed when added to a target
                 capture: true)
+  specific_ss.add(gen)
 endforeach
 
 if 'CONFIG_TRACE_UST' in config_host
-- 
2.26.2



