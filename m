Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954E8C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 11:36:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63EFF2084D
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 11:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fdNWJlLz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63EFF2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo3he-0005vH-Lp
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 07:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jo3cA-0004Dy-Ug
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 07:30:50 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30993
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jo3c2-0007yD-Aq
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 07:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592998241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=e90sVaiY0y2bJO1wUVMH2JGLJEwOGOs++Ldelaxq98E=;
 b=fdNWJlLzJ6qZQc1QxE3KxxkU8us5OZv9YHy3mX4CnBeX2kgmUhdYaKrsLSXXVIyDppwufn
 vcbgTQTP8n5Vzc0kRMImXLX/e5FUCVl6ndvfQBbbQeBhFNiOJUM3qjhfKqFC6RglW0Xx72
 1XkbGM9dJ/vryrimlDsnArjjF8/60bA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-XQabyk_ANq-W1PDWjKz6jA-1; Wed, 24 Jun 2020 07:30:39 -0400
X-MC-Unique: XQabyk_ANq-W1PDWjKz6jA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7BB31107ACF7;
 Wed, 24 Jun 2020 11:30:38 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-67.ams2.redhat.com
 [10.36.112.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 35ED55C660;
 Wed, 24 Jun 2020 11:30:38 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 68C7A31E61; Wed, 24 Jun 2020 13:30:27 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 19/20] pcspk: update docs/system/target-i386-desc.rst.inc
Date: Wed, 24 Jun 2020 13:30:25 +0200
Message-Id: <20200624113026.13343-20-kraxel@redhat.com>
In-Reply-To: <20200624113026.13343-1-kraxel@redhat.com>
References: <20200624113026.13343-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 00:34:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-ppc@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 libvir-list@redhat.com,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add PC speaker with config hints.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 docs/system/target-i386-desc.rst.inc | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/docs/system/target-i386-desc.rst.inc b/docs/system/target-i386-desc.rst.inc
index 47a169e0ae2a..7d1fffacbea3 100644
--- a/docs/system/target-i386-desc.rst.inc
+++ b/docs/system/target-i386-desc.rst.inc
@@ -31,6 +31,8 @@ The QEMU PC System emulator simulates the following peripherals:
 
 -  CS4231A compatible sound card
 
+-  PC speaker
+
 -  PCI UHCI, OHCI, EHCI or XHCI USB controller and a virtual USB-1.1
    hub.
 
@@ -49,7 +51,7 @@ must be told to not have parallel ports to have working GUS.
 
 .. parsed-literal::
 
-   |qemu_system_x86| dos.img -soundhw gus -parallel none
+   |qemu_system_x86| dos.img -device gus -parallel none
 
 Alternatively:
 
@@ -60,3 +62,12 @@ Alternatively:
 Or some other unclaimed IRQ.
 
 CS4231A is the chip used in Windows Sound System and GUSMAX products
+
+The PC speaker audio device can be configured using the pcspk-audiodev
+machine property, i.e.
+
+.. parsed-literal::
+
+   |qemu_system_x86| some.img \
+   -audiodev <backend>,id=<name> \
+   -machine pcspk-audiodev=<name>
-- 
2.18.4


