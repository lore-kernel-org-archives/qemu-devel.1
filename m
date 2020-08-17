Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757BAC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:57:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4096B205CB
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6QlqBL5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4096B205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gZQ-00086u-CY
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 10:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gH7-0004Pp-Ap
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:13 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33797)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gH5-0006A1-PC
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:12 -0400
Received: by mail-wr1-x441.google.com with SMTP id f7so15275966wrw.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ser9XLljIbOuFxuhLFNRibnCpNpEfksvUVVck7gs7/c=;
 b=D6QlqBL5a//rMSEI29QrPsZdZ+Mp+Xl06etYhL5O0knxgsI0N7GD0H+x7NBYtJeTe/
 O7y4UARP7fab4rOblsLg5/vlgrJpCqjrezKAPKj9A3fztenpqc1Tx1NcWsLur7laaKZu
 Ihb502GVcMwbeGUt6uXasXgPxmuyZd8KwZkUn1Bp8FxyN6ixyiiwqcrMS3EXSSt3HoGj
 4VXPa9gsYwtBqIyCNO5OKGuwpIN80ttgrxagqb/VpywjmrPBdthKgsAEXJXt5oPc2S5X
 ufkSQIkxlOQLGES5ZmngdLknHjv/dYGJRVvu9Ea/gGsKAq5eMxcjrgsh0P492ZBrB3Ko
 5FMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Ser9XLljIbOuFxuhLFNRibnCpNpEfksvUVVck7gs7/c=;
 b=dgqt2Z0N0FUXPUuut5q3uKiKD8AlgtzHLvlNgX72knQgGgN9aIUV2zKvL5JO8Qhq3e
 IZo5Ews5qygkJCrkcu3nIeEMv1h9imcXjIxKPqI4sbWGNNwUBbRd34xlJHyURd6EsATB
 nRlyT6mZZd5BDxUw8fCcqmt82a1yTq152UqqzTUaLp0D9QfP8Exaki/uGQPP0PffyEaU
 Xeebtn4nhFNCPGddnfmEOE1VIkOZwU4FyWZreYrxA6exgcCn/lIbp73KFGWl7g1KXa8q
 uK8fpEfHhsgIKWpjgNglDfKTuj8ek0A2JPXy762SI2a2OYy6oNn/6x5ZdjsAOTnEfyZW
 XVJg==
X-Gm-Message-State: AOAM533JGP3UHsVOakWS5Oh9meHlYSowt4w7qZXyc63nX49KfSeOlgYi
 ifiicDYq00QEpxUVyOrBdc6mEWSQ6c0=
X-Google-Smtp-Source: ABdhPJxXtRucoMer8HPOq5oA/CYvBYhToAepkzx15sUmsQpGPpfuuOzMZ45DaIWuLEFo0B729pZgsA==
X-Received: by 2002:adf:bc54:: with SMTP id a20mr15636564wrh.227.1597675090249; 
 Mon, 17 Aug 2020 07:38:10 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.38.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:38:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 045/150] meson: add qemu-edid
Date: Mon, 17 Aug 2020 16:35:38 +0200
Message-Id: <20200817143723.343284-46-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x441.google.com
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile    | 2 --
 configure   | 2 +-
 meson.build | 4 ++++
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 60dec5d0ff..35ea574503 100644
--- a/Makefile
+++ b/Makefile
@@ -418,8 +418,6 @@ qemu-nbd$(EXESUF): qemu-nbd.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io
 qemu-io$(EXESUF): qemu-io.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 qemu-storage-daemon$(EXESUF): qemu-storage-daemon.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(chardev-obj-y) $(io-obj-y) $(qom-obj-y) $(storage-daemon-obj-y) $(COMMON_LDADDS)
 
-qemu-edid$(EXESUF): qemu-edid.o hw/display/edid-generate.o $(COMMON_LDADDS)
-
 fsdev/virtfs-proxy-helper$(EXESUF): fsdev/virtfs-proxy-helper.o fsdev/9p-marshal.o fsdev/9p-iov-marshal.o $(COMMON_LDADDS)
 
 scsi/qemu-pr-helper$(EXESUF): scsi/qemu-pr-helper.o scsi/utils.o $(authz-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
diff --git a/configure b/configure
index 919f0413fa..2b55fba922 100755
--- a/configure
+++ b/configure
@@ -6668,7 +6668,7 @@ fi
 
 tools=""
 if test "$want_tools" = "yes" ; then
-  tools="qemu-img\$(EXESUF) qemu-io\$(EXESUF) qemu-edid\$(EXESUF) $tools"
+  tools="qemu-img\$(EXESUF) qemu-io\$(EXESUF) $tools"
   if [ "$linux" = "yes" -o "$bsd" = "yes" -o "$solaris" = "yes" ] ; then
     tools="qemu-nbd\$(EXESUF) qemu-storage-daemon\$(EXESUF) $tools"
   fi
diff --git a/meson.build b/meson.build
index fc65f01b6f..d336812c2a 100644
--- a/meson.build
+++ b/meson.build
@@ -311,6 +311,10 @@ if have_tools
                dependencies: [qemuutil, xkbcommon], install: true)
   endif
 
+  executable('qemu-edid', files('qemu-edid.c', 'hw/display/edid-generate.c'),
+             dependencies: qemuutil,
+             install: true)
+
   if 'CONFIG_VHOST_USER' in config_host
     subdir('contrib/libvhost-user')
     subdir('contrib/vhost-user-blk')
-- 
2.26.2



