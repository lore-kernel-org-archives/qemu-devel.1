Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B3CC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 12:56:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CE1520658
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 12:56:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CE1520658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8k7U-0003c1-Di
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 08:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freddy77@gmail.com>)
 id 1k8iOJ-0000ri-KS
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 07:05:55 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54840
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <freddy77@gmail.com>)
 id 1k8iOI-0007yZ-Aj
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 07:05:55 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-sGbotB74NQWbThYF1NlOfQ-1; Thu, 20 Aug 2020 07:05:51 -0400
X-MC-Unique: sGbotB74NQWbThYF1NlOfQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 507BB80EDAE;
 Thu, 20 Aug 2020 11:05:42 +0000 (UTC)
Received: from fziglio.remote.csb (unknown [10.40.195.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1ABD05DA76;
 Thu, 20 Aug 2020 11:05:37 +0000 (UTC)
From: Frediano Ziglio <freddy77@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] ui: Add more mouse buttons to SPICE
Date: Thu, 20 Aug 2020 12:05:30 +0100
Message-Id: <20200820110530.27965-1-freddy77@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=freddy77@gmail.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: gmail.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=205.139.110.61;
 envelope-from=freddy77@gmail.com; helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 03:03:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_ADSP_CUSTOM_MED=0.001,
 FORGED_GMAIL_RCVD=1, FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 NML_ADSP_CUSTOM_MED=0.9, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665,
 SPOOFED_FREEMAIL=1 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 20 Aug 2020 08:54:49 -0400
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
Cc: qemu-devel@nongnu.org, Frediano Ziglio <freddy77@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add support for SIDE and EXTRA buttons.

Signed-off-by: Frediano Ziglio <freddy77@gmail.com>
---
 ui/spice-input.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ui/spice-input.c b/ui/spice-input.c
index cd4bb0043f..d5bba231c9 100644
--- a/ui/spice-input.c
+++ b/ui/spice-input.c
@@ -123,6 +123,8 @@ static void spice_update_buttons(QemuSpicePointer *poin=
ter,
         [INPUT_BUTTON_RIGHT]       =3D 0x02,
         [INPUT_BUTTON_WHEEL_UP]    =3D 0x10,
         [INPUT_BUTTON_WHEEL_DOWN]  =3D 0x20,
+        [INPUT_BUTTON_SIDE]        =3D 0x40,
+        [INPUT_BUTTON_EXTRA]       =3D 0x80,
     };
=20
     if (wheel < 0) {
--=20
2.25.4


