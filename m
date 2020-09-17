Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F457C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 06:24:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A98722137B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 06:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L109pYTs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A98722137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kInLQ-0006Bx-Fx
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 02:24:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kInJs-0004fI-4q
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 02:23:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41339)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kInJq-0002jP-El
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 02:22:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600323776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nqi2no+720uKexcOmtsTvg2x2b+ijYW4Uq6U7nVU3sI=;
 b=L109pYTsZ7Y/vcpw6McaqRtvgeaILMhs4Bz9SA6vOY0IVbVnoBxwKSdrQbYCwTTv8hu1bf
 KUI11QLpNUqRRLhUBQBHlN85SjGofm7teFgF9Mn/1KyBJcl4yCurdKKV47Haw/apZaOEZ6
 9pcXRRCRFwlnY34oypHZw72akOamJdM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-iPEy6fFYPfa2pO_HR7c4-w-1; Thu, 17 Sep 2020 02:22:55 -0400
X-MC-Unique: iPEy6fFYPfa2pO_HR7c4-w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47574186DD2A
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 06:22:54 +0000 (UTC)
Received: from localhost (unknown [10.36.110.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B65DF1C4;
 Thu, 17 Sep 2020 06:22:46 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH 0/5] Add physical display dimensions to spice/virtio-gpu
Date: Thu, 17 Sep 2020 10:22:37 +0400
Message-Id: <20200917062242.1877925-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 20:51:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>=0D

Hi,=0D
=0D
This series improves the support for HiDPI displays with Spice.=0D
The related spice series have already been merged.=0D
=0D
Marc-Andr=C3=A9 Lureau (5):=0D
  edid: fix physical display size computation=0D
  edid: use physical dimensions if available=0D
  ui: add getter for UIInfo=0D
  spice: get monitors physical dimension=0D
  virtio-gpu: set physical dimensions for EDID=0D
=0D
 hw/display/edid-generate.c     | 36 +++++++++++++++++++++++-----------=0D
 hw/display/virtio-gpu-base.c   |  2 ++=0D
 hw/display/virtio-gpu.c        |  2 ++=0D
 include/hw/display/edid.h      |  5 ++++-=0D
 include/hw/virtio/virtio-gpu.h |  1 +=0D
 include/ui/console.h           |  4 ++++=0D
 qemu-edid.c                    | 11 +++++++++--=0D
 ui/console.c                   |  7 +++++++=0D
 ui/spice-display.c             | 19 +++++++++++++++++-=0D
 9 files changed, 72 insertions(+), 15 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


