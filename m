Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAE5C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 17:42:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D43182071B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 17:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fxru1+ZU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D43182071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDAIO-0007EE-2o
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 13:42:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDAFB-0003at-57
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 13:38:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50047)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDAF8-00017N-Uf
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 13:38:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598981929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0YflkMx3pzh8OWPDBNhUGOFfsmrxMK8bNqws+pl9viM=;
 b=fxru1+ZUjA95/Ou1VkUhVzrpsGXkTfg1odAwPiJ7sNPXaOHTqxr2ejbdceevQdN1VXJPOx
 +hMWaUY+j/cyNzJ3n3jZSpsHcvIz4Gn82TV6EbVhaDqjYTTxRFN0zeZs3/Rs1Mz1ClUKbC
 whXzuXkyoNqn4T7LMjPUW+fScwkmwF8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-250sX_8GPCKuHGU2cosVfw-1; Tue, 01 Sep 2020 13:38:47 -0400
X-MC-Unique: 250sX_8GPCKuHGU2cosVfw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 016DA18A2256
 for <qemu-devel@nongnu.org>; Tue,  1 Sep 2020 17:38:47 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C2A3661177
 for <qemu-devel@nongnu.org>; Tue,  1 Sep 2020 17:38:46 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 24/26] meson: add description to options
Date: Tue,  1 Sep 2020 13:38:40 -0400
Message-Id: <20200901173842.5882-3-pbonzini@redhat.com>
In-Reply-To: <20200901173842.5882-1-pbonzini@redhat.com>
References: <20200901173842.5882-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 01:27:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will be useful in the future to generate configure
command line parsing from meson_options.txt.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson_options.txt | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/meson_options.txt b/meson_options.txt
index c3120fa359..543cf70043 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -2,12 +2,23 @@ option('qemu_suffix', type : 'string', value: 'qemu',
        description: 'Suffix for QEMU data/modules/config directories (can be empty)')
 option('docdir', type : 'string', value : 'doc',
        description: 'Base directory for documentation installation (can be empty)')
-option('gettext', type : 'boolean', value : true)
-option('sdl', type : 'feature', value : 'auto')
-option('sdl_image', type : 'feature', value : 'auto')
-option('u2f', type : 'feature', value : 'auto')
-option('vnc', type : 'feature', value : 'enabled')
-option('vnc_jpeg', type : 'feature', value : 'auto')
-option('vnc_png', type : 'feature', value : 'auto')
-option('vnc_sasl', type : 'feature', value : 'auto')
-option('xkbcommon', type : 'feature', value : 'auto')
+
+option('gettext', type : 'boolean', value : true,
+       description: 'Localization of the GTK+ user interface')
+
+option('sdl', type : 'feature', value : 'auto',
+       description: 'SDL user interface')
+option('sdl_image', type : 'feature', value : 'auto',
+       description: 'SDL Image support for icons')
+option('u2f', type : 'feature', value : 'auto',
+       description: 'U2F emulation support')
+option('vnc', type : 'feature', value : 'enabled',
+       description: 'VNC server')
+option('vnc_jpeg', type : 'feature', value : 'auto',
+       description: 'JPEG lossy compression for VNC server')
+option('vnc_png', type : 'feature', value : 'auto',
+       description: 'PNG compression for VNC server')
+option('vnc_sasl', type : 'feature', value : 'auto',
+       description: 'SASL authentication for VNC server')
+option('xkbcommon', type : 'feature', value : 'auto',
+       description: 'xkbcommon support')
-- 
2.26.2



