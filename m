Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE00C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 12:02:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB2502067C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 12:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jGKIIMLv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB2502067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7dq9-0006O3-2A
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 08:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1k7dpF-00059U-Rv
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 08:01:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23497)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1k7dpE-0003fY-0J
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 08:01:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597665675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pnJdpW+Vz+R/b7LxH4DU9OkPy3KD/Xqc3C7CNMbuDMY=;
 b=jGKIIMLvSPRYVtFxey0kRdSscmZzjYBAU0t8sbIZG/ppEUrS8UR+2tFxXca/Oln+ziw8T4
 Ql3cWpOBvjaX66D1Apx4t7kAVRH/ajRHAYHtlNpXkEhcX4gj/DIsvDesGWXxdU6WYbjkTI
 YMGVoVEky3uUQoVPwmh+qFHHj7jDDXI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-AON5aFx4OROH_cxq9rWqzg-1; Mon, 17 Aug 2020 08:01:03 -0400
X-MC-Unique: AON5aFx4OROH_cxq9rWqzg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B36581F012
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 12:01:00 +0000 (UTC)
Received: from localhost (unknown [10.36.110.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 41E32BABA;
 Mon, 17 Aug 2020 12:00:58 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] WIP: add physical display dimensions to spice/virtio-gpu
Date: Mon, 17 Aug 2020 16:00:52 +0400
Message-Id: <20200817120056.56751-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 01:24:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>=0D

Hi,=0D
=0D
In order to improve support for HiDPI, I proposed some new Spice messages t=
o=0D
inform the guest of the display physical dimensions.=0D
=0D
See spice-protocol proposal and related server & spice-gtk changes:=0D
https://gitlab.freedesktop.org/spice/spice-protocol/-/merge_requests/24=0D
https://gitlab.freedesktop.org/spice/spice/-/merge_requests/139=0D
https://gitlab.freedesktop.org/spice/spice-gtk/-/merge_requests/64=0D
=0D
Marc-Andr=C3=A9 Lureau (4):=0D
  edid: use physical dimensions if available=0D
  ui: add getter for UIInfo=0D
  spice: get monitors physical dimension=0D
  virtio-gpu: set physical dimensions for EDID=0D
=0D
 hw/display/edid-generate.c     | 21 ++++++++-----=0D
 hw/display/virtio-gpu-base.c   |  2 ++=0D
 hw/display/virtio-gpu.c        |  2 ++=0D
 include/hw/display/edid.h      |  2 ++=0D
 include/hw/virtio/virtio-gpu.h |  1 +=0D
 include/ui/console.h           |  4 +++=0D
 ui/console.c                   |  7 +++++=0D
 ui/spice-display.c             | 54 +++++++++++++++++++++++++++++++++-=0D
 8 files changed, 84 insertions(+), 9 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


