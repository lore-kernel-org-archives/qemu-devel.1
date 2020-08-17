Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B27AC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:10:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D44AC2054F
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+VTgHXC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D44AC2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gmH-00021S-3U
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:10:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHd-0005OH-6E
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:45 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:34761)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHb-0006G8-Gu
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:44 -0400
Received: by mail-wm1-x332.google.com with SMTP id c19so13338335wmd.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3REw3lOnIPKtBmuqPqRRs54RBlXKhwodvkw9HHvxT3U=;
 b=J+VTgHXCqlFGz/lBwvKpCSK+TX7pYUaxftRFrqEnL75151LRGN5zIpN5WS3M+fnqI+
 Fj2eTmOHGatRyA39xx69GUmLS0CLZ3mtOmqtogLPPUEp/UDn6V1t/Xm1iKW5n2wphdZv
 97q/DXjFB29oELBueA+XwyWMb9+pykYvrfBRiTyzQFOz5BXyXCT5sE2IJA7D5cGBkhff
 IZRQ3XPQsBgTlIqxpCrhvgyYfemLk/iOKFJnpLGBd17wCfNFM5fXaUK7H7flJkyuDDSD
 7B+XdslpxtzHZA82ohiFmlaco4S2HYVHRmTtKMwETCIcUlxyCiOap7j1D0FGr7qyEZVZ
 9xXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=3REw3lOnIPKtBmuqPqRRs54RBlXKhwodvkw9HHvxT3U=;
 b=ZpvDnXQfTLc0TEThvhv1BvRmRBRMjd55VpZi4iyBoq/65kwN9lWnkH7C2yjufeRGVp
 ap+mw7XRB1DLhtKxD+OCf0/5TKGt0iDf9N3J7BWaI5gnC6SYBt1N8xnqexqGKLUtB7Q/
 n8QMukHnTrUnf3Yh7Pe22RRGL7N9DLPv5j7lovpRSPQs8ZlxS55Nl993/FOCHPgPpmOy
 M8cli0kxvjX5++Z0MdZQQ6QPfL1fhJR5II9PG4CAjoxznIh50/fLh7z/myCp61rV6dCE
 qbgPQwyGpPSdB4Z4AZYMfdF23Hn2L1WzgJa7iaAGMPq6sDACTsJeyMgTM+RbyuqZRhSR
 tU6Q==
X-Gm-Message-State: AOAM533g5KaaylCP+UnXfS1uM8YfwYUKYBlC7gcJZoad5qwAq97AbWxI
 7ObVWuakATKqV0oKnINDXbfM2BhK4U8=
X-Google-Smtp-Source: ABdhPJz1UfhsZYeP4ExvaANWucedTfiGC7kHlQwanH5S+xkVA6ZqiCNBm00E5Ejhy+W1tbiP2DsszA==
X-Received: by 2002:a1c:e008:: with SMTP id x8mr14678766wmg.75.1597675121932; 
 Mon, 17 Aug 2020 07:38:41 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.38.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:38:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 077/150] meson: convert replay directory to Meson
Date: Mon, 17 Aug 2020 16:36:10 +0200
Message-Id: <20200817143723.343284-78-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x332.google.com
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
 Makefile.objs        |  1 -
 meson.build          |  1 +
 replay/Makefile.objs | 10 ----------
 replay/meson.build   | 12 ++++++++++++
 4 files changed, 13 insertions(+), 11 deletions(-)
 delete mode 100644 replay/Makefile.objs
 create mode 100644 replay/meson.build

diff --git a/Makefile.objs b/Makefile.objs
index e304d92954..cfb2cf2b49 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -68,7 +68,6 @@ common-obj-$(if $(and $(CONFIG_BZIP2),$(CONFIG_DMG)),m) += block-dmg-bz2$(DSOSUF
 common-obj-y += hw/
 common-obj-m += hw/
 
-common-obj-y += replay/
 common-obj-y += backends/
 
 common-obj-y += qapi/
diff --git a/meson.build b/meson.build
index cae4b2dce2..3c79d0cea3 100644
--- a/meson.build
+++ b/meson.build
@@ -652,6 +652,7 @@ common_ss.add(files('cpus-common.c'))
 
 subdir('softmmu')
 subdir('monitor')
+subdir('replay')
 
 # needed for fuzzing binaries
 subdir('tests/qtest/libqos')
diff --git a/replay/Makefile.objs b/replay/Makefile.objs
deleted file mode 100644
index 939be964a9..0000000000
--- a/replay/Makefile.objs
+++ /dev/null
@@ -1,10 +0,0 @@
-common-obj-y += replay.o
-common-obj-y += replay-internal.o
-common-obj-y += replay-events.o
-common-obj-y += replay-time.o
-common-obj-y += replay-input.o
-common-obj-y += replay-char.o
-common-obj-y += replay-snapshot.o
-common-obj-y += replay-net.o
-common-obj-y += replay-audio.o
-common-obj-y += replay-random.o
diff --git a/replay/meson.build b/replay/meson.build
new file mode 100644
index 0000000000..8783aea7c8
--- /dev/null
+++ b/replay/meson.build
@@ -0,0 +1,12 @@
+softmmu_ss.add(files(
+  'replay.c',
+  'replay-internal.c',
+  'replay-events.c',
+  'replay-time.c',
+  'replay-input.c',
+  'replay-char.c',
+  'replay-snapshot.c',
+  'replay-net.c',
+  'replay-audio.c',
+  'replay-random.c',
+))
-- 
2.26.2



