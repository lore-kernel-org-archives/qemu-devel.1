Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE04C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 10:17:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D360221D7A
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 10:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XlbSjQfx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D360221D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFxAo-0005CH-JS
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 06:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kFx9q-0004V1-VR
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 06:16:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59606
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kFx9p-000371-9p
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 06:16:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599646612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4mjyB/Qhcu2ZF9KbS3Ceuw559glnFytsEbsOvHTmqG8=;
 b=XlbSjQfxCZDxwbKpoH9Dwxj9u+GAuRwH+IBbY+ICIz/NrxwfTAcWa0ont+lq7VTN800s3p
 x8TQ5pATppD3yV8Mz/Fwo8vmwiYE/TMsCHyuu0EK6bQDnl1v3PBuxEsrDjXxISRfNPKqgQ
 lAhEmaGccOVs+IQjRbnU+uKGtHRyXvY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-AcpsgpF8POOl5XcLxi2D6g-1; Wed, 09 Sep 2020 06:16:48 -0400
X-MC-Unique: AcpsgpF8POOl5XcLxi2D6g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8412F6408A
 for <qemu-devel@nongnu.org>; Wed,  9 Sep 2020 10:16:47 +0000 (UTC)
Received: from localhost (ovpn-114-244.ams2.redhat.com [10.36.114.244])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0535C83564;
 Wed,  9 Sep 2020 10:16:43 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] gitmodules: add qboot, meson, and vbootrom mirrors
Date: Wed,  9 Sep 2020 11:16:39 +0100
Message-Id: <20200909101642.17698-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:05:47
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhpcyBwYXRjaCBzZXJpZXMgYWRkcyBxZW11Lm9yZyBtaXJyb3JzIGZvciBxYm9vdCwgbWVzb24s
IGFuZCB2Ym9vdHJvbS4NCg0KdmJvb3Ryb20gaXMgbm90IHlldCB1c2VkIGJ5IHFlbXUuZ2l0L21h
c3RlciBzbyB5b3UgbWF5IHdpc2ggdG8gaG9sZCBvZmYgb24NCmFwcGx5aW5nIHRoZSBmaW5hbCBw
YXRjaC4NCg0KU3RlZmFuIEhham5vY3ppICgzKToNCiAgZ2l0bW9kdWxlczogc3dpdGNoIHRvIHFl
bXUub3JnIHFib290IG1pcnJvcg0KICBnaXRtb2R1bGVzOiBzd2l0Y2ggdG8gcWVtdS5vcmcgbWVz
b24gbWlycm9yDQogIGdpdG1vZHVsZXM6IGFkZCBxZW11Lm9yZyB2Ym9vdHJvbSBzdWJtb2R1bGUN
Cg0KIC5naXRtb2R1bGVzIHwgNyArKysrKy0tDQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkNCg0KLS0gDQoyLjI2LjINCg0K


