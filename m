Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE659C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 15:16:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98D8A20728
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 15:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OEUKNH5D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98D8A20728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZc4k-0005VU-OP
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 11:16:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jZc3d-0003tq-0X
 for qemu-devel@nongnu.org; Fri, 15 May 2020 11:15:29 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32733
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jZc3c-0005wr-1Y
 for qemu-devel@nongnu.org; Fri, 15 May 2020 11:15:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589555726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DxpwPQ+za994t64Er474RJNIL+31FCT1/qWvAtAuH3M=;
 b=OEUKNH5DXpJ8rwuqC4mmpm4MNs5vWrvebtz0JXjTJPr3U2GRCTU+5R/QXLH1Ucv3kP/sDU
 X1iIyn3cISouewv5GL2ARe3gBtWm6FLtnUT2//sUiRzH07shyB7ODHYwTyIoQ2wIsKAGql
 HwJrIQxyOS1RX2WhHQumIrv8rj4EJi4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-s1xMYdq5Nm-StiVRFEWLyQ-1; Fri, 15 May 2020 11:15:25 -0400
X-MC-Unique: s1xMYdq5Nm-StiVRFEWLyQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24572474;
 Fri, 15 May 2020 15:15:24 +0000 (UTC)
Received: from localhost (ovpn-112-229.ams2.redhat.com [10.36.112.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BB87E60C84;
 Fri, 15 May 2020 15:15:23 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-s390x@nongnu.org
Subject: [PATCH v2 0/3] s390x: improve documentation
Date: Fri, 15 May 2020 17:15:15 +0200
Message-Id: <20200515151518.83950-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The documentation for the s390x system emulation target still has quite
a bit of room for improvement, so I started adding some device documentation.

v1->v2:
- css.rst: added example for cssid == 0 (Thomas)
- css.rst: mention what the properties look like (Thomas)
- css.rst: it's "channel subsystem image" (me)
- 3270.rst: make introduction less confusing (Thomas)
- 3270.rst: fix device name (Thomas)
- 3270.rst: use unprivileged port (Thomas)
- vfio-ccw.rst: add mdevctl example (Thomas)
- vfio-ccw.rst: formatting tweaks (Thomas)

Cornelia Huck (3):
  docs/s390x: document the virtual css
  docs/s390x: document 3270
  docs/s390x: document vfio-ccw

 docs/system/s390x/3270.rst     | 32 +++++++++++++
 docs/system/s390x/css.rst      | 86 ++++++++++++++++++++++++++++++++++
 docs/system/s390x/vfio-ccw.rst | 72 ++++++++++++++++++++++++++++
 docs/system/target-s390x.rst   |  3 ++
 4 files changed, 193 insertions(+)
 create mode 100644 docs/system/s390x/3270.rst
 create mode 100644 docs/system/s390x/css.rst
 create mode 100644 docs/system/s390x/vfio-ccw.rst

-- 
2.25.4


