Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A4CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:16:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9527E206C3
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P5VLek3N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9527E206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqeTD-0004y5-Qx
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 11:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jqeHy-0003Ly-RS
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:04:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24108
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jqeHu-0001CI-Hr
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:04:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593615877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=y/j30VHTl0CF5dqgwph+ZKKs3tG5+j6/uOJFNKACUHs=;
 b=P5VLek3NpbK66pFwwkY4NFJlTSnnN6ji6Jos3bVvml9aeUjCzxSRrz09zuVfZZ2sgJ12HA
 FWgiWmkdmmuPNt6CGGC6xwy7rgbWwExDdAdnT1e9hFIO4NvOjrbNf8kYMqsx9nrEQYvHV3
 bsDlClUbkhVwPxjDEjdPY3bZARvksFo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-mGaouRL6OFy4Yn1SOQY5kg-1; Wed, 01 Jul 2020 11:04:33 -0400
X-MC-Unique: mGaouRL6OFy4Yn1SOQY5kg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B35A71937FE4;
 Wed,  1 Jul 2020 15:04:29 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-62.ams2.redhat.com
 [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7B7E519C58;
 Wed,  1 Jul 2020 15:04:26 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 583379A9A; Wed,  1 Jul 2020 17:04:25 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/13] sm501: Drop unneded variable
Date: Wed,  1 Jul 2020 17:04:14 +0200
Message-Id: <20200701150425.13739-3-kraxel@redhat.com>
In-Reply-To: <20200701150425.13739-1-kraxel@redhat.com>
References: <20200701150425.13739-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 01:29:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: BALATON Zoltan <balaton@eik.bme.hu>

We don't need a separate variable to keep track if we allocated memory
that needs to be freed as we can test the pointer itself.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: ff9136c3151a15cdfa1d9b7a68acf11cffb8efa4.1592686588.git.balaton@eik.bme.hu
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/sm501.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 5ceee4166f6b..5d2e0195753a 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -796,13 +796,12 @@ static void sm501_2d_operation(SM501State *s)
             de = db + width + height * (width + dst_pitch);
             if (rtl && ((db >= sb && db <= se) || (de >= sb && de <= se))) {
                 /* regions may overlap: copy via temporary */
-                int free_buf = 0, llb = width * (1 << format);
+                int llb = width * (1 << format);
                 int tmp_stride = DIV_ROUND_UP(llb, sizeof(uint32_t));
                 uint32_t *tmp = tmp_buf;
 
                 if (tmp_stride * sizeof(uint32_t) * height > sizeof(tmp_buf)) {
                     tmp = g_malloc(tmp_stride * sizeof(uint32_t) * height);
-                    free_buf = 1;
                 }
                 pixman_blt((uint32_t *)&s->local_mem[src_base], tmp,
                            src_pitch * (1 << format) / sizeof(uint32_t),
@@ -813,7 +812,7 @@ static void sm501_2d_operation(SM501State *s)
                            dst_pitch * (1 << format) / sizeof(uint32_t),
                            8 * (1 << format), 8 * (1 << format),
                            0, 0, dst_x, dst_y, width, height);
-                if (free_buf) {
+                if (tmp != tmp_buf) {
                     g_free(tmp);
                 }
             } else {
-- 
2.18.4


