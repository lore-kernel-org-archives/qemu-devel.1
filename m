Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17C5C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 08:24:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 775C420643
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 08:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nz+Ddz0X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 775C420643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZVdZ-0001Ek-MW
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 04:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jZVbQ-0002iv-3F
 for qemu-devel@nongnu.org; Fri, 15 May 2020 04:21:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36579
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jZVbO-000734-5A
 for qemu-devel@nongnu.org; Fri, 15 May 2020 04:21:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589530912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=CRK3kFblrclA9bE0+LXesRKzwb0lmaOnmmjSkF9awjo=;
 b=Nz+Ddz0XRR2geaZlijlic+GCyDs060hfbYVCziuQ8lEMbBbAjjtmNitqXJpxawScB1QQMo
 7g75cblN02pKDhc+mugx1C1cI9G0bQzOUETXCQYE8F1HDOIsBHtHZ1sHOnJWlyCGDOLK/8
 H3Y+sO+785Rd6Q06EAdRjGLJGCNkDO0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-hvhZYGGiOWGqJpvop4IMkg-1; Fri, 15 May 2020 04:21:50 -0400
X-MC-Unique: hvhZYGGiOWGqJpvop4IMkg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2485107BEF7
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 08:21:49 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-115-145.ams2.redhat.com
 [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D03D960C05;
 Fri, 15 May 2020 08:21:46 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id B87C217477; Fri, 15 May 2020 10:21:45 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/2] ui: improve -show-cursor deprecation message
Date: Fri, 15 May 2020 10:21:44 +0200
Message-Id: <20200515082145.4732-2-kraxel@redhat.com>
In-Reply-To: <20200515082145.4732-1-kraxel@redhat.com>
References: <20200515082145.4732-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 22:56:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Specifically explain what users should do in case they don't use
-display yet and depend on the qemu picking the ui for them.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20200407093617.10058-1-kraxel@redhat.com
---
 softmmu/vl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index afd2615fb325..63eeb6ae1bdb 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -3531,8 +3531,10 @@ void qemu_init(int argc, char **argv, char **envp)
                 no_shutdown = 1;
                 break;
             case QEMU_OPTION_show_cursor:
-                warn_report("The -show-cursor option is deprecated, "
-                            "use -display {sdl,gtk},show-cursor=on instead");
+                warn_report("The -show-cursor option is deprecated. Please "
+                            "add show-cursor=on to your -display options.");
+                warn_report("When using the default display you can use "
+                            "-display default,show-cursor=on");
                 dpy.has_show_cursor = true;
                 dpy.show_cursor = true;
                 break;
-- 
2.18.4


