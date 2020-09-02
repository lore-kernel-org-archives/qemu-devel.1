Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89C8C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 23:12:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A49E20767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 23:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A0uL0A+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A49E20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDbvI-0006xP-Jn
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 19:12:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbVl-000603-Ma
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:45:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34768)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbVj-0000Gq-Vi
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:45:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599086747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ErQL7BgBnsy9YBAAKNOdUGZsMoynPW01pc2T06kSOGI=;
 b=A0uL0A+R1hoppAThTit6apNG5X/CIWdPIuVgPN1c3GkkaJHdYPKpkS8L776HhRntkF9vWs
 YitBZEX6Ze2vgo1NOFJBfgmrBRHzFk5PnHir9M5tBWNyqIWRSlIaIMXLsZX3WIALhDam+I
 SiN/QkSAx7ZRVThSRC2OxB1hjqNakGQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294--NQDohIxO-CJG1k_Xi3YjQ-1; Wed, 02 Sep 2020 18:45:43 -0400
X-MC-Unique: -NQDohIxO-CJG1k_Xi3YjQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3AB3E1005E65;
 Wed,  2 Sep 2020 22:45:42 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CD32619C59;
 Wed,  2 Sep 2020 22:45:41 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 57/63] xen: Rename XENBACKEND_DEVICE to XENBACKEND
Date: Wed,  2 Sep 2020 18:43:05 -0400
Message-Id: <20200902224311.1321159-58-ehabkost@redhat.com>
In-Reply-To: <20200902224311.1321159-1-ehabkost@redhat.com>
References: <20200902224311.1321159-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:42:29
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
Cc: Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>, berrange@redhat.com,
 Paul Durrant <paul@xen.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make the type checking macro name consistent with the TYPE_*
constant.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Paul Durrant <paul@xen.org>
Cc: xen-devel@lists.xenproject.org
Cc: qemu-devel@nongnu.org
---
 include/hw/xen/xen-legacy-backend.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/xen/xen-legacy-backend.h b/include/hw/xen/xen-legacy-backend.h
index ba7a3c59bb..be281e1f38 100644
--- a/include/hw/xen/xen-legacy-backend.h
+++ b/include/hw/xen/xen-legacy-backend.h
@@ -11,7 +11,7 @@
 #define TYPE_XENBACKEND "xen-backend"
 
 typedef struct XenLegacyDevice XenLegacyDevice;
-DECLARE_INSTANCE_CHECKER(XenLegacyDevice, XENBACKEND_DEVICE,
+DECLARE_INSTANCE_CHECKER(XenLegacyDevice, XENBACKEND,
                          TYPE_XENBACKEND)
 
 /* variables */
-- 
2.26.2


