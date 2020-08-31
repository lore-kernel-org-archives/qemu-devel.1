Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2503C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 08:32:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEC992073A
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 08:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gd3cMDES"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEC992073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCfEd-0007EL-U3
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 04:32:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kCfBZ-0002Ha-7w
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 04:29:05 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27130
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kCfBX-000615-Ap
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 04:29:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598862542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5+BCakrOKFcEAOoI1USC566br9qYiCMgtiiLkMLNqrQ=;
 b=Gd3cMDESvH9gAMOqbNERID5qxl3C4wLy++I2bUzp1RUNJG0nWg1D3+oqpapT2CC3KejRwe
 FQ2mnblPSj7w/maALid1b63bYtyRhyRtSQoHgnNFOiq5V68D9IThSbRywM8KOH5qpqX7q2
 vK6wbAxttzNN6t9Oji4ufCQOS4bh8a4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-L8prCKE3Nl6fCGFyC79R4w-1; Mon, 31 Aug 2020 04:28:59 -0400
X-MC-Unique: L8prCKE3Nl6fCGFyC79R4w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDDE910ABDA0
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 08:28:58 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com
 (ovpn-12-88.pek2.redhat.com [10.72.12.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 87D5D5D9D3;
 Mon, 31 Aug 2020 08:28:45 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: jasowang@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH 4/9] vhost-vdpa: refine info string
Date: Mon, 31 Aug 2020 16:27:32 +0800
Message-Id: <20200831082737.10983-5-jasowang@redhat.com>
In-Reply-To: <20200831082737.10983-1-jasowang@redhat.com>
References: <20200831082737.10983-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 03:06:35
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
Cc: lulu@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We use "vhost-vdpa" as nic info string which is not useful, let's add
the vhostdev path.

before:
info network
v0: index=0,type=vhost-vdpa,vhost-vdpa

after:
info network
v0: index=0,type=vhost-vdpa,vhostdev=/dev/vhost-vdpa-0

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/vhost-vdpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index c4568b885e..397d4d3082 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -181,7 +181,7 @@ static int net_vhost_vdpa_init(NetClientState *peer, const char *device,
     int ret = 0;
     assert(name);
     nc = qemu_new_net_client(&net_vhost_vdpa_info, peer, device, name);
-    snprintf(nc->info_str, sizeof(nc->info_str), TYPE_VHOST_VDPA);
+    snprintf(nc->info_str, sizeof(nc->info_str), "vhostdev=%s", vhostdev);
     nc->queue_index = 0;
     s = DO_UPCAST(VhostVDPAState, nc, nc);
     vdpa_device_fd = qemu_open(vhostdev, O_RDWR);
-- 
2.20.1


