Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7ADC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 09:59:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95EF520897
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 09:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OohCFDHA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95EF520897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNCPX-0004Kb-9p
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 05:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kNCO4-0002ga-D5
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 05:57:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26542)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kNCO2-0000pO-61
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 05:57:32 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601373448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/hbNtG1O1KKe2o2EEtMsEGAHXCwp9g/8JIkRNaFEZIg=;
 b=OohCFDHAH8YeWFjb8S/brdb5BTJ6SKilhNqZgKuH3Ux0jvoFW12BJCA5VkFDzg1tPOKQ/Q
 mL+I6UzjScHFDjPxnO7UzLHdnEmBXsjQTRlt+exYSxWfHmGEfAowz61RljVsxp48K1uyzO
 5kXOCA/goktMyN+EvcznoO5uTEw9aAo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-hzlEDHbENl6A8R-YTHl8VA-1; Tue, 29 Sep 2020 05:57:26 -0400
X-MC-Unique: hzlEDHbENl6A8R-YTHl8VA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08A30107465A;
 Tue, 29 Sep 2020 09:57:25 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CA8987A431;
 Tue, 29 Sep 2020 09:57:18 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 812079D77; Tue, 29 Sep 2020 11:57:17 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/9] Vga 20200929 patches
Date: Tue, 29 Sep 2020 11:57:08 +0200
Message-Id: <20200929095717.26745-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 74504514b154ebebdff577d88e4bf5c13074e9ed=
:=0D
=0D
  Merge remote-tracking branch 'remotes/alistair/tags/pull-register-2020092=
7'=3D=0D
 into staging (2020-09-28 16:49:10 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://git.kraxel.org/qemu tags/vga-20200929-pull-request=0D
=0D
for you to fetch changes up to 97a0530bb71fb96468f218b622cd840e2c667bf6:=0D
=0D
  ppc/pseries: enable big-endian-framebuffer quirk for bochs-display and vi=
rt=3D=0D
io-vga (2020-09-29 10:08:25 +0200)=0D
=0D
----------------------------------------------------------------=0D
virtio-vga: reset fix, bigendian fix.=0D
virtio-vga+spice: set monitor dimension via edid.=0D
=0D
----------------------------------------------------------------=0D
=0D
Gerd Hoffmann (2):=0D
  virtio-vga: implement big-endian-framebuffer property=0D
  ppc/pseries: enable big-endian-framebuffer quirk for bochs-display and=0D
    virtio-vga=0D
=0D
Guoqing Zhang (1):=0D
  virtio-gpu-3d: fix abnormal display after a warm reboot=0D
=0D
Marc-Andr=3DC3=3DA9 Lureau (6):=0D
  edid: fix physical display size computation=0D
  edid: use physical dimensions if available=0D
  ui: add getter for UIInfo=0D
  spice: remove the single monitor config logic=0D
  spice: get monitors physical dimension=0D
  virtio-gpu: set physical dimensions for EDID=0D
=0D
 include/hw/display/edid.h      |  5 ++++-=0D
 include/hw/virtio/virtio-gpu.h |  1 +=0D
 include/ui/console.h           |  4 ++++=0D
 hw/display/edid-generate.c     | 36 +++++++++++++++++++++++-----------=0D
 hw/display/virtio-gpu-3d.c     |  2 +-=0D
 hw/display/virtio-gpu-base.c   |  2 ++=0D
 hw/display/virtio-gpu.c        |  2 ++=0D
 hw/display/virtio-vga.c        | 19 ++++++++++++++++++=0D
 hw/ppc/spapr_pci.c             |  4 +++-=0D
 qemu-edid.c                    | 11 +++++++++--=0D
 ui/console.c                   |  7 +++++++=0D
 ui/spice-display.c             | 33 +++++++++++--------------------=0D
 12 files changed, 88 insertions(+), 38 deletions(-)=0D
=0D
--=3D20=0D
2.27.0=0D
=0D


