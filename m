Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F06C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 06:10:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D82620716
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 06:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ONDW0wnC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D82620716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiBU9-0004qX-7h
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 01:10:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44285)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iiBSO-0002ht-PA
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 01:08:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iiBSN-0000ZT-Jp
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 01:08:12 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33698
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iiBSN-0000Wv-Fu
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 01:08:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576822090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=57mmJdnPxDt0v4VDLtuZ1dom29KjWKfgfVh6VdGPcYk=;
 b=ONDW0wnCK8UiqTWl93fuJnc+mTVJQZR97uxX1AcnmmZXg/NpmYClnUw4rfHrLzPcYTjktZ
 hG/e9srAeotcxI2oMjOYr5Aw05vitsud8mrNpnb0xWYL9fB6tl//SzurDflSmomj3ntbdO
 5MlL3z/zFNTOU69Mu8ax9Ng0BOeumbM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-qc1CsPV7PP28vR1yAdSxOw-1; Fri, 20 Dec 2019 01:08:09 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 679B71005513
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 06:08:08 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-98.ams2.redhat.com
 [10.36.116.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BBE3C5C548;
 Fri, 20 Dec 2019 06:08:05 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 184729ADD; Fri, 20 Dec 2019 07:08:05 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/1] Seabios 20191220 patches
Date: Fri, 20 Dec 2019 07:08:04 +0100
Message-Id: <20191220060805.1741-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: qc1CsPV7PP28vR1yAdSxOw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit aceeaa69d28e6f08a24395d0aa6915b687d0a681=
:

  Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2019-=
12-17' into staging (2019-12-17 15:55:20 +0000)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/seabios-20191220-pull-request

for you to fetch changes up to db211f245b76193f7ce2cf7ebed8a0b3cb321c37:

  seabios: update to 1.13.0 final (2019-12-20 07:06:39 +0100)

----------------------------------------------------------------
seabios: update to 1.13.0 final

----------------------------------------------------------------

Gerd Hoffmann (1):
  seabios: update to 1.13.0 final

 pc-bios/bios-256k.bin             | Bin 262144 -> 262144 bytes
 pc-bios/bios.bin                  | Bin 131072 -> 131072 bytes
 pc-bios/vgabios-ati.bin           | Bin 39424 -> 39424 bytes
 pc-bios/vgabios-bochs-display.bin | Bin 28672 -> 28672 bytes
 pc-bios/vgabios-cirrus.bin        | Bin 38912 -> 38912 bytes
 pc-bios/vgabios-qxl.bin           | Bin 39424 -> 39424 bytes
 pc-bios/vgabios-ramfb.bin         | Bin 28672 -> 28672 bytes
 pc-bios/vgabios-stdvga.bin        | Bin 39424 -> 39424 bytes
 pc-bios/vgabios-virtio.bin        | Bin 39424 -> 39424 bytes
 pc-bios/vgabios-vmware.bin        | Bin 39424 -> 39424 bytes
 pc-bios/vgabios.bin               | Bin 38912 -> 38912 bytes
 roms/config.seabios-128k          |   1 +
 roms/seabios                      |   2 +-
 13 files changed, 2 insertions(+), 1 deletion(-)

--=20
2.18.1


