Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279ACC43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 02:41:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51DD520796
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 02:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M37zuSRT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51DD520796
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kF75d-0002Bo-AO
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 22:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kF753-0001ZS-Hg
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 22:40:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26137
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kF751-0004X5-1S
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 22:40:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599446426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4OIj4jz8LXHEWJ5feeAlUTIZDKQ5O5S7lX7AHvNA6oc=;
 b=M37zuSRToklewB/6AjPsan9sFQXndeiy44xkOJpCmoa3aIGe/E4fhyOqoArFsB3Su7iWdA
 +WW6tmQqhctDr9C8Uadj+pYuJtO+ARkYD2JuM3S3vgAckgLfxywFnqb0dLAFdmD80L/K9R
 ev4X43Ip8/8oh7sPpflZMCJ4HP3QewU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-QJ6ftDz1No-R3vebK5ftQQ-1; Sun, 06 Sep 2020 22:40:24 -0400
X-MC-Unique: QJ6ftDz1No-R3vebK5ftQQ-1
Received: by mail-wr1-f69.google.com with SMTP id r15so5141775wrt.8
 for <qemu-devel@nongnu.org>; Sun, 06 Sep 2020 19:40:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4OIj4jz8LXHEWJ5feeAlUTIZDKQ5O5S7lX7AHvNA6oc=;
 b=XIUDdsT4oqrxlPbRqGcx49ZayOiEYgPZ7u6qBOnB02o99cHzokK5s0qZiOL1A13HHi
 pe+nY9pTOfl3XQ+RQrb2QF5yv6GEOjAzavA9ShxwvhGdKX8Cfe0W/FB50xD/Y9h09kWB
 kqkNFnzWk5b5EwDbF60i6tqRa/VAvuAPeRNro0wmnNCJVH6PWY+wrrAn34tVuBFXHMkW
 b2KNBRwDiW0bJIjoEwZw3oeZ8bN0Ca5W1zqE1ELRbVwudbHcpcZWF01LM15TebV1qDTX
 dNFvetcBAvhv38kSGQQqDJy0cmbgAB+qjsc14ERG3Y3EPiCCOs3OcoiSsXbZubXKzITJ
 R/9g==
X-Gm-Message-State: AOAM531v8okZ+6yfzVwSYWOdGij/TgJOZixtatrXWUFtHc6Du800xDtO
 qiJVFVXFaZ8OG8txp/P7njk0Pb/N4xKibvkLn+e3EedP8AmkcPysWuT4J4ouTbtuXGONa6rMdSN
 r3YEDzuQZixpkSio=
X-Received: by 2002:adf:c404:: with SMTP id v4mr18782084wrf.17.1599446423414; 
 Sun, 06 Sep 2020 19:40:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdhbmfejOQRnTYHq/FvUULXHKw2HSDGUiqQAlr9sUy9fovlhOU/lgA5l0QN8+7XEjg08lWRg==
X-Received: by 2002:adf:c404:: with SMTP id v4mr18782062wrf.17.1599446423182; 
 Sun, 06 Sep 2020 19:40:23 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id g2sm25686140wmg.32.2020.09.06.19.40.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2020 19:40:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/s390x/css: Remove double initialization
Date: Mon,  7 Sep 2020 04:40:20 +0200
Message-Id: <20200907024020.854465-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/06 21:15:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-trivial@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix eventual copy/paste mistake introduced in commit bc994b74ea
("s390x/css: Use static initialization for channel_subsys fields").

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/s390x/css.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 519dc91316d..9961cfe7bf6 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -353,7 +353,6 @@ static ChannelSubSys channel_subsys = {
     .pending_crws = QTAILQ_HEAD_INITIALIZER(channel_subsys.pending_crws),
     .do_crw_mchk = true,
     .sei_pending = false,
-    .do_crw_mchk = true,
     .crws_lost = false,
     .chnmon_active = false,
     .indicator_addresses =
-- 
2.26.2


