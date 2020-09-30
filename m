Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CE9C4727F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 11:31:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C95F820708
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 11:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cB4pOCKf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C95F820708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNaKP-0004RG-S4
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 07:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kNaIS-0002gm-VD
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 07:29:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45535)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kNaIO-0003sC-UD
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 07:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601465356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KZDvwu6aODUJ1KxrLmS6Mb7akFAQsgS+WoI3m7nzsEw=;
 b=cB4pOCKf1ivECYUQfUIGVexk/OoeiqWFmu3SZhfrbizgb7duZStNB4ZkwS8Z6Fb9j6augn
 iUZ6FxbQKXf+zZKJgFQBUwepPJfHuSNZs3iWD1syWjCqE/p45089/V+aL/jm4EcHsEpJLk
 orPT7MzTia9ERgvsgPSndfXY0iOwN0k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-SlLWav82MYyzsYwORPVy4g-1; Wed, 30 Sep 2020 07:29:12 -0400
X-MC-Unique: SlLWav82MYyzsYwORPVy4g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B3901015CB4
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 11:29:11 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0AE4A78807;
 Wed, 30 Sep 2020 11:29:05 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 5A1E943BFB0; Wed, 30 Sep 2020 13:29:04 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 4/6] meson: add spice_headers dependency.
Date: Wed, 30 Sep 2020 13:29:02 +0200
Message-Id: <20200930112904.24397-5-kraxel@redhat.com>
In-Reply-To: <20200930112904.24397-1-kraxel@redhat.com>
References: <20200930112904.24397-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Used for files which (with CONFIG_SPICE=y) depend on spice header files
to pick up some enum, but which do not depend on on the actual spice
shared library.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/meson.build   | 2 +-
 meson.build         | 2 ++
 monitor/meson.build | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/audio/meson.build b/audio/meson.build
index 18a831129ed0..7d53b0f920ff 100644
--- a/audio/meson.build
+++ b/audio/meson.build
@@ -1,5 +1,5 @@
+softmmu_ss.add([spice_headers, files('audio.c')])
 softmmu_ss.add(files(
-  'audio.c',
   'audio_legacy.c',
   'mixeng.c',
   'noaudio.c',
diff --git a/meson.build b/meson.build
index d36dd085b5fc..76f51b9ab323 100644
--- a/meson.build
+++ b/meson.build
@@ -213,9 +213,11 @@ if 'CONFIG_LIBJACK' in config_host
   jack = declare_dependency(link_args: config_host['JACK_LIBS'].split())
 endif
 spice = not_found
+spice_headers = not_found
 if 'CONFIG_SPICE' in config_host
   spice = declare_dependency(compile_args: config_host['SPICE_CFLAGS'].split(),
                              link_args: config_host['SPICE_LIBS'].split())
+  spice_headers = declare_dependency(compile_args: config_host['SPICE_CFLAGS'].split())
 endif
 rt = cc.find_library('rt', required: false)
 libmpathpersist = not_found
diff --git a/monitor/meson.build b/monitor/meson.build
index eb2a534fdc88..6d00985ace7a 100644
--- a/monitor/meson.build
+++ b/monitor/meson.build
@@ -3,7 +3,7 @@ qmp_ss.add(files('monitor.c', 'qmp.c', 'qmp-cmds-control.c'))
 softmmu_ss.add(files(
   'hmp-cmds.c',
   'hmp.c',
-  'qmp-cmds.c',
 ))
+softmmu_ss.add([spice_headers, files('qmp-cmds.c')])
 
 specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: [files('misc.c'), spice])
-- 
2.27.0


