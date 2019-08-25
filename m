Return-Path: <SRS0=aJdJ=WV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77750C3A5A1
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 19:03:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 446EA206E0
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 19:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lozeoGSI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 446EA206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1xna-0003DO-0b
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 15:03:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57935)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i1xXY-0001Vh-Od
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 14:47:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i1xXX-0004yE-OZ
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 14:47:00 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:34191)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i1xXX-0004y2-KS
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 14:46:59 -0400
Received: by mail-qt1-x841.google.com with SMTP id q4so15966656qtp.1
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2019 11:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mVyvepJpofMiXJQ4yUXovAwU9I26tBxVFmMOIPeTZIQ=;
 b=lozeoGSIDTtpQdB81Z0mR2O98atrq8kVqAWbtYmcbQCnetzp3P4u5y04RaEKjOZ9Lj
 4dyUxepmK6O2H2+nzxU8Pr3T9Tr5SFuikmInCX19TOL2AIdO1m8v9lCPrWogCb2YqPWI
 gai08Jff3Kx9nbVkYULdZ1UaJdCELP8NsPjvoVktyzvmyaSU8oKjf91mgiVVwhpoAMVe
 bM0vwZhspBUj7moR3TjUEYsGltfJga/1a95npEXOnpErt0gnSPt2ZhcldMphBSVOqKvE
 NxUmXuja4sFmSoQpAZPkBwIod7A3iRaeeSxFAKaJSZ2EPrl1FQlFRG8yel5k1mDnxVTd
 xa3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mVyvepJpofMiXJQ4yUXovAwU9I26tBxVFmMOIPeTZIQ=;
 b=fwKc3ORZDy50d2JjS4Y0Mxp8Lp1Fdg4sN9WHfcl3j4Am+xmGbi4IRN4CwiUlp7kSCl
 m64lo/W9YnmeGqhxpp8XiGhDJDxMChAl9sg8TFpA5HKz99IFXSsWgWBA/e6soXfoLcwc
 +RzUpTNraTMTMjQToq9jj699W/ujQufaq8S8jijrof1C3BiOR5LiDFexxmZOGd78BJjO
 9cNWaU7M9snWUm1NaJPZRIeh0602dauOFDV2pTMdIooMXT64n1dQQc233uYJOsbhQ+A1
 tNi0tSlqzSHqjPDBYQoisxQxH9gTULO7hh9f90x4WIjWazJW7t6sYPx7WqkiD7NJoDec
 mErA==
X-Gm-Message-State: APjAAAUyAC21Kr3HDRvDKLETS2hS6Q7MwNdu1CRGgDRwf5TUBc8khGfF
 AZUN/BaddUnO0X7+wj846oqKcpAezJQ=
X-Google-Smtp-Source: APXvYqyQWBGQZZrHBFwQEexwJRDKgzrlqQR1og4RQp/xJncVYnhsZOp3SNMzI8JY7jvAtkvlG8CnEw==
X-Received: by 2002:a0c:b192:: with SMTP id v18mr12820001qvd.163.1566758819092; 
 Sun, 25 Aug 2019 11:46:59 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-61b1-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:61b1::5])
 by smtp.gmail.com with ESMTPSA id d3sm5348870qtq.32.2019.08.25.11.46.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 25 Aug 2019 11:46:58 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Sun, 25 Aug 2019 20:46:27 +0200
Message-Id: <e977b11c8259297cd38ada4d564c9ec31b2e4b35.1566755452.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566755452.git.DirtY.iCE.hu@gmail.com>
References: <cover.1566755452.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
Subject: [Qemu-devel] [PATCH 25/25] usbaudio: change playback counters to 64
 bit
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With stereo playback, they need about 375 minutes of continuous audio
playback to overflow, which is usually not a problem (as stopping and
later resuming playback resets the counters).  But with 7.1 audio, they
only need about 95 minutes to overflow.

After the overflow, the buf->prod % USBAUDIO_PACKET_SIZE(channels)
assertion no longer holds true, which will result in overflowing the
buffer.  With 64 bit variables, it would take about 762000 years to
overflow.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 hw/usb/dev-audio.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/usb/dev-audio.c b/hw/usb/dev-audio.c
index e42bdfbdc1..ea604bbb8e 100644
--- a/hw/usb/dev-audio.c
+++ b/hw/usb/dev-audio.c
@@ -578,9 +578,9 @@ static const USBDesc desc_audio_multi = {
 
 struct streambuf {
     uint8_t *data;
-    uint32_t size;
-    uint32_t prod;
-    uint32_t cons;
+    size_t size;
+    uint64_t prod;
+    uint64_t cons;
 };
 
 static void streambuf_init(struct streambuf *buf, uint32_t size,
@@ -601,7 +601,7 @@ static void streambuf_fini(struct streambuf *buf)
 
 static int streambuf_put(struct streambuf *buf, USBPacket *p, uint32_t channels)
 {
-    uint32_t free = buf->size - (buf->prod - buf->cons);
+    int64_t free = buf->size - (buf->prod - buf->cons);
 
     if (free < USBAUDIO_PACKET_SIZE(channels)) {
         return 0;
@@ -610,6 +610,8 @@ static int streambuf_put(struct streambuf *buf, USBPacket *p, uint32_t channels)
         return 0;
     }
 
+    /* can happen if prod overflows */
+    assert(buf->prod % USBAUDIO_PACKET_SIZE(channels) == 0);
     usb_packet_copy(p, buf->data + (buf->prod % buf->size),
                     USBAUDIO_PACKET_SIZE(channels));
     buf->prod += USBAUDIO_PACKET_SIZE(channels);
@@ -618,10 +620,10 @@ static int streambuf_put(struct streambuf *buf, USBPacket *p, uint32_t channels)
 
 static uint8_t *streambuf_get(struct streambuf *buf, size_t *len)
 {
-    uint32_t used = buf->prod - buf->cons;
+    int64_t used = buf->prod - buf->cons;
     uint8_t *data;
 
-    if (!used) {
+    if (used <= 0) {
         *len = 0;
         return NULL;
     }
-- 
2.22.0


