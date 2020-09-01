Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31587C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:25:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E48D0206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RHWDCt3Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E48D0206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD2XM-0001dv-29
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 05:25:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kD2KV-0003e1-NN
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 05:11:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26666
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kD2KU-0006s5-0n
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 05:11:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598951509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zFBQTBi25e5joBAp65GuMnsD8kwlFz5k6Gy++2C8kpU=;
 b=RHWDCt3QUawYm0o2r/Dqoq/VjLHHa8oZR+CnslOQ5tsltiIs54MsOP/rOzooo/qaXvB9ll
 8NCMI443LjVn/mJFjc0nbJs+mOUdE0mGe/wiPz7ra5gRXeDSoq5+qeh4nf7NVpErz40Ykh
 0A35kt0blGV22srgVJkVsRnC7q8dPsM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-HyHZRB3uMeKizJUTnkLHEg-1; Tue, 01 Sep 2020 05:11:47 -0400
X-MC-Unique: HyHZRB3uMeKizJUTnkLHEg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDB41800C60
 for <qemu-devel@nongnu.org>; Tue,  1 Sep 2020 09:11:46 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AB05378B45
 for <qemu-devel@nongnu.org>; Tue,  1 Sep 2020 09:11:46 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 24/24] meson: add description to options
Date: Tue,  1 Sep 2020 05:11:32 -0400
Message-Id: <20200901091132.29601-25-pbonzini@redhat.com>
In-Reply-To: <20200901091132.29601-1-pbonzini@redhat.com>
References: <20200901091132.29601-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 05:11:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index c3120fa359..3e772f55b3 100644
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
+       description: 'Localizationo of the GTK+ user interface')
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


