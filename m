Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D578BC3A5A1
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 00:32:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9923722D37
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 00:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMVLUOAY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9923722D37
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i22w5-0004sY-Lh
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 20:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48772)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i22sl-0002Tx-HE
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 20:29:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i22sk-0001zy-My
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 20:29:15 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36229)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i22sk-0001zW-HZ
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 20:29:14 -0400
Received: by mail-wr1-x443.google.com with SMTP id r3so13610770wrt.3
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2019 17:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nlX7+gWJb2MeKaswtkvAtP/+mrv1fy++rHT+GxAY3UY=;
 b=XMVLUOAYp62/AYRsga04gl1thR68AdNRN6m2cDnk8G6Ve2IlM85OUfAxKPluMd4exP
 WWkC7PDMTlIfmaSlTmGbbQfm7SskEiopE9EuEsQU5dIPLCDuqd4+yaefLFzW37uaUHwB
 KWCSqMLnPP8ukNuZqb4yhOFn3oE1X9A6iLR3UO+Ul2Eb3jNHeQ2codI1qEOdOS4F0GYO
 1Dy/kKsvPm9u1ri5WsHI7d2v6XtyMnjmpdZlJjzW4QpwvRXT+kYXC/QGAidYDHJNuDTP
 vodk+b4+rw7rDC27ysc6dK3Atfd/rwBwrilARJddY3s65reqtmFW3aqLhyOV9fUQxtxm
 zUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nlX7+gWJb2MeKaswtkvAtP/+mrv1fy++rHT+GxAY3UY=;
 b=Jc/OhYLMbcqA3gEyQWef1U6hM7QsA+xRUiMYK8IAgIywpltZ7L0C7jDuk4qt3r3wQF
 J0LSuwYvYLQQ8Evumhuj4oglOWIv89zFij0haTd3FRcoejqgoCRbBKP+T0SvlJJP0oIq
 vK0e3bAAXXcDpm/PCIPX/2bhSh/r9UMcqB4F4r0cWup5ZoGMOVPyh00yPQo8HXl5EXIX
 F/tF+x2dHtYwQ4pRA1W8LW1gkA68PI2X2EfyAHTNr+uZVtKwYloS/VRXmuds4edYDSmJ
 B75YBs3SjHycuVSckfmkjzkvsFprljR+vU2bxpOHoci0Ftyi0GciFZq807Kyq70+6Clu
 z4Mw==
X-Gm-Message-State: APjAAAXQQsERMlnEx+0adregkIrXT4Qzc5QO75x4Cc15LcldcIClR+Ir
 k2Sjym06sf5qik1iW9gCWWMe5XFV/Pw=
X-Google-Smtp-Source: APXvYqyRp4czrHdINCoTm+BaSXKP0KqZ4mvwT54stAjqeIbbTVDlQHWL0NwTNp11GXCKGucgH1qtGg==
X-Received: by 2002:adf:8364:: with SMTP id 91mr18615855wrd.13.1566779353446; 
 Sun, 25 Aug 2019 17:29:13 -0700 (PDT)
Received: from decltype.home.dirty-ice.org
 (2a01-036c-0113-61b1-0001-0000-0000-00d3.pool6.digikabel.hu.
 [2a01:36c:113:61b1:1::d3])
 by smtp.gmail.com with ESMTPSA id c19sm8662339wml.13.2019.08.25.17.29.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 25 Aug 2019 17:29:13 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 26 Aug 2019 02:29:08 +0200
Message-Id: <9db7233c490836c221bab463305d08e34db9f037.1566779143.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566779143.git.DirtY.iCE.hu@gmail.com>
References: <cover.1566779143.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH 2/3] audio: paaudio: fix client name
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

pa_context_new expects a client name, not a server socket path.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 audio/paaudio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/audio/paaudio.c b/audio/paaudio.c
index bfef9acaad..777b8e4718 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -866,7 +866,7 @@ static void *qpa_conn_init(const char *server)
     }
 
     c->context = pa_context_new(pa_threaded_mainloop_get_api(c->mainloop),
-                                server);
+                                "qemu");
     if (!c->context) {
         goto fail;
     }
-- 
2.22.0


