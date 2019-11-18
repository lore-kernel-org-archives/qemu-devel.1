Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB02C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 18:48:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00CA7222C2
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 18:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="By7Upaw4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00CA7222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWm4e-0001Im-R7
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 13:48:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40803)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1iWm2k-0000E9-1o
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 13:46:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1iWm2j-0002Vx-0x
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 13:46:33 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52566
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1iWm2i-0002VJ-TB
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 13:46:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574102790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=A9ydHaz5mfKGM4kaTSzRF83vMjgOGYhONlp8L4EOxLM=;
 b=By7Upaw4NfGnRx1/beGJjpYxUImYu9OolyZxUaVJHYFnrVhO5vedFbvqXRMAocZlT/WJ9b
 pAJAxUFUyAP9NiwALzX2PdRFCAiIH1/ITE80BHaNx5SHMXo0aX2j5ykNd7K2sD+lC3wN6z
 YaGRT8fPsTa4EeJahO/kELNbA6rh4fY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-7LrkY06hM2Oj9GNd-qlKCw-1; Mon, 18 Nov 2019 13:46:29 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E1D7477
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 18:46:28 +0000 (UTC)
Received: from gimli.home (ovpn-116-56.phx2.redhat.com [10.3.116.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0093C60BF4;
 Mon, 18 Nov 2019 18:46:25 +0000 (UTC)
Subject: [PULL 0/3] VFIO fixes 2019-11-18
From: Alex Williamson <alex.williamson@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 18 Nov 2019 11:46:25 -0700
Message-ID: <157410270703.24655.9333886493163056872.stgit@gimli.home>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 7LrkY06hM2Oj9GNd-qlKCw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 1bd0f1c9c149c2fb738f381099cec7ad0ee224a9=
:

  Merge remote-tracking branch
'remotes/kraxel/tags/seabios-20191118-pull-request' into staging (2019-11-1=
8
14:30:24 +0000)

are available in the Git repository at:

  git://github.com/awilliam/qemu-vfio.git tags/vfio-fixes-20191118.0

for you to fetch changes up to 29b95c992a569818294478b4616e44b45c67d34e:

  vfio: vfio-pci requires EDID (2019-11-18 10:41:49 -0700)

----------------------------------------------------------------
VFIO fixes 2019-11-18

 - Fix migration blocker double free (Michal Privoznik)

 - Use migration_add_blocker() return value (Jens Freimann)

 - Depend on EDID for display support (Paolo Bonzini)

----------------------------------------------------------------
Jens Freimann (1):
      vfio: don't ignore return value of migrate_add_blocker

Michal Privoznik (1):
      hw/vfio/pci: Fix double free of migration_blocker

Paolo Bonzini (1):
      vfio: vfio-pci requires EDID

 hw/vfio/Kconfig | 1 +
 hw/vfio/pci.c   | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)


