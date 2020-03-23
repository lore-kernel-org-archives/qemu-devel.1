Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545A2C4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 12:50:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15E372072E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 12:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VER+ucL2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15E372072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGMXX-0004zw-62
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 08:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53327)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jGMWN-0003lf-Vp
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 08:49:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jGMWM-0000qM-Do
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 08:49:35 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:38208)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jGMWM-0000qE-An
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 08:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584967773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xM2bAyKorR0TMkdqh+pJyQnW09P2kvT+m0sO3J23gZs=;
 b=VER+ucL2jp7EbGGgG8k4D4vzUQpDBkozoe5X8sYXhAW1xSwV8ojQUA7EcUDalewG5Bv2xu
 Qq8ZzFMJkqW0B9+nzSuEKKS+sgtztiFzlfGyqYF8b8Zh9MMD0jBQpgAvrSzPm3k5IxJ30v
 7oxA/vSOnx6pWz2svfsCFZqMPkXbMZE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-GShvz5pBNQq1Q5IFuTGSvA-1; Mon, 23 Mar 2020 08:49:30 -0400
X-MC-Unique: GShvz5pBNQq1Q5IFuTGSvA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD3058017CE;
 Mon, 23 Mar 2020 12:49:29 +0000 (UTC)
Received: from localhost (ovpn-113-18.ams2.redhat.com [10.36.113.18])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 248A61001F43;
 Mon, 23 Mar 2020 12:49:26 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL for-5.0 0/2] s390x fixes and documentation
Date: Mon, 23 Mar 2020 13:49:21 +0100
Message-Id: <20200323124923.24014-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 29e0855c5af62bbb0b0b6fed792e004dad92ba95=
:

  Merge remote-tracking branch 'remotes/elmarco/tags/slirp-pull-request' in=
to staging (2020-03-22 21:00:38 +0000)

are available in the Git repository at:

  https://github.com/cohuck/qemu tags/s390x-20200323

for you to fetch changes up to 7722837369eb1c7e808021d79da68afa0c01c26f:

  s390/ipl: fix off-by-one in update_machine_ipl_properties() (2020-03-23 1=
2:36:27 +0100)

----------------------------------------------------------------
- fix an off-by-one in the ipl code
- s390x documentation reordering

----------------------------------------------------------------

Cornelia Huck (1):
  Documentation: create/move s390x documentation

Halil Pasic (1):
  s390/ipl: fix off-by-one in update_machine_ipl_properties()

 MAINTAINERS                         |  5 +++--
 docs/system/index.rst               |  1 -
 docs/system/{ =3D> s390x}/vfio-ap.rst |  0
 docs/system/target-s390x.rst        | 26 ++++++++++++++++++++++++++
 docs/system/targets.rst             |  1 +
 hw/s390x/ipl.c                      |  2 +-
 6 files changed, 31 insertions(+), 4 deletions(-)
 rename docs/system/{ =3D> s390x}/vfio-ap.rst (100%)
 create mode 100644 docs/system/target-s390x.rst

--=20
2.21.1


