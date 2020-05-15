Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEAFC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 14:38:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78A76207BB
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 14:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N5J81MR9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78A76207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZbTc-0001IZ-NP
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 10:38:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jZbRG-0004JS-Jt
 for qemu-devel@nongnu.org; Fri, 15 May 2020 10:35:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44362
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jZbRF-0007xP-AC
 for qemu-devel@nongnu.org; Fri, 15 May 2020 10:35:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589553348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=GZCiQ1XMKOML6r1OifdKYZRO7gqQ/zx4tGmS8eEVSj4=;
 b=N5J81MR9eLQV5Gz4cKMBoK102KnEH1CWmYETKnHbYn/GP9BVUnH3uG0wAKqnMIAZVtQZqe
 rwBbZxySOHae9NXU6WYCbFXviEXU/jk1GU03vX3lfJe2raD8GWXImkHVQTiheEm5KOhkvV
 jmxMU9cmZU4hrnUc2hivOKaDo3zwafQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-YMV64LQyMhGPTQlu8VEwRg-1; Fri, 15 May 2020 10:35:46 -0400
X-MC-Unique: YMV64LQyMhGPTQlu8VEwRg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11C03EC1C1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 14:35:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-115-145.ams2.redhat.com
 [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D4A5378379;
 Fri, 15 May 2020 14:35:40 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 3983A9D58; Fri, 15 May 2020 16:35:29 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 12/13] audio: add soundhw deprecation notice
Date: Fri, 15 May 2020 16:35:27 +0200
Message-Id: <20200515143528.13591-13-kraxel@redhat.com>
In-Reply-To: <20200515143528.13591-1-kraxel@redhat.com>
References: <20200515143528.13591-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
Cc: libvir-list@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 docs/system/deprecated.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index 3142fac38658..7de1045b7e27 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -88,6 +88,15 @@ should specify an ``audiodev=`` property.  Additionally, when using
 vnc, you should specify an ``audiodev=`` propery if you plan to
 transmit audio through the VNC protocol.
 
+Creating sound card devices using ``-soundhw`` (since 5.1)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+Sound card devices should be created using ``-device`` instead.  The
+names are the same for most devices.  The exceptions are ``hda`` which
+needs two devices (``-device intel-hda --device hda-duplex``) and
+``pcspk`` which can be activated using ``-global
+pcspk.audiodev=<name>``.
+
 ``-mon ...,control=readline,pretty=on|off`` (since 4.1)
 '''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
-- 
2.18.4


