Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C604C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 06:28:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61F612225A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 06:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TbxlwCOe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61F612225A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUOet-000191-EV
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 02:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kUOeF-0000ib-Dj
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 02:27:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49885)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kUOeC-0003Yo-02
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 02:27:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603088872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ciWHBC7rkevReYldcSdEHqzDaeWWAP/3K3FEQ6xyFbI=;
 b=TbxlwCOe2zFCYAZrBI8DOkZRKW8Vq+y4A8+eaXmp0ZLBzfOuP6xWHBQCfjLsQ3h1HoPA1R
 g2oK/15DmvEp+EuW5FcOpbz7Aa3fuXY7mI2W79jUtZ7OaInfW7encJ1Kv9mI+T8VqvKdLe
 ukduJ6GyHVX5o+e+7JaMMzEC1AitFSI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-WB93xu9rMQev3G7TAGwFqg-1; Mon, 19 Oct 2020 02:27:48 -0400
X-MC-Unique: WB93xu9rMQev3G7TAGwFqg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5394C835B47;
 Mon, 19 Oct 2020 06:27:46 +0000 (UTC)
Received: from kaapi (ovpn-116-139.sin2.redhat.com [10.67.116.139])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DB1B25C225;
 Mon, 19 Oct 2020 06:27:39 +0000 (UTC)
Date: Mon, 19 Oct 2020 11:57:37 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH] ati: mask x y display parameter values
In-Reply-To: <607d183b-8885-583f-de2a-ee693e641a50@eik.bme.hu>
Message-ID: <nycvar.YSQ.7.78.906.2010191056550.1472930@xnncv>
References: <20201018120852.1415440-1-ppandit@redhat.com>
 <607d183b-8885-583f-de2a-ee693e641a50@eik.bme.hu>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 01:44:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Gaoning Pan <pgn@zju.edu.cn>, Gerd Hoffmann <kraxel@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+-- On Sun, 18 Oct 2020, BALATON Zoltan wrote --+
| The s->regs.[src|dst]_[xy] values should not be over 0x3fff because we mask 
| them on register write in ati.c

  Yes, those register values are set to zero(0).

| and here [src|dst]_[x|y] local variables are declared unsigned so negative 
| values come out as large integers that should be caught by the checks below 
| as being over VRAM end

  As above register values are zero(0), following expression(s)

    dst_x = ... (s->regs.dst_x(=0) + 1 - s->regs.dst_width(=16383))
    dst_y = ... (s->regs.dst_y(=0) + 1 - s->regs.dst_height(=16383))

result in large unsigned values: 

  ati_2d_blt
    pixman_blt(0x7f03cbe00000, 0x7f03cbe00000, 131064, 131064, 32, 32,
       src_x=0, src_y=-16382, dst_x=0, dst_y=-16382, 16383, 16383)

Shown as negative values due to signed '%d' conversion.

| but those checks may have an off by one error or some other mistake.

    uint8_t *end = s->vga.vram_ptr + s->vga.vram_size;
    if (dst_bits >= end || dst_bits + dst_x + (dst_y + s->regs.dst_height) * dst_stride >= end) {
        qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
        return;
    }

* Above check does not seem to catch it.

* Does a check below look okay?
===
diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 524bc03a83..b75acc7fda 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -54,9 +54,13 @@ void ati_2d_blt(ATIVGAState *s)
...
+    if (dst_x > 0x3fff || dst_y > 0x3fff) {
+        qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
+        return;
+    }
...
+        if (src_x > 0x3fff || src_y > 0x3fff) {
+            qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
+            return;
+        }
===

* ati_2d_blt() routine looks complex. Maybe it can be divided in two halves.


Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D


