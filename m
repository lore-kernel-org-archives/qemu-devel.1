Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754A0C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 06:11:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E400520732
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 06:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mb2GJXyb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E400520732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFWr2-0005VU-HU
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 02:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kFWqK-0004eQ-4d
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 02:11:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28524
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kFWqF-0003GT-G9
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 02:10:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599545453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1KJcOj7PFAeL5QZ23SdIBNgoJPQzLJshAsJ+u4HbUoE=;
 b=Mb2GJXybf53T/7O6dQvXiyWNQQdcsbpBfP8h4XsuX7+XKgltRbDeGnc4nCvKiDIcWLmdK5
 sniZvsQYQFqeCuiwLJF7UybhFED12QQJWo4b2kZsz0gIFqAlJUkOc/T8ZQXyWf5eX5elv7
 oqezL7jUFLONVcF6SBy7XmRrqm8yQLo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-EuNuflBtNr29TBE4pZy7Og-1; Tue, 08 Sep 2020 02:10:51 -0400
X-MC-Unique: EuNuflBtNr29TBE4pZy7Og-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1EE18014D8
 for <qemu-devel@nongnu.org>; Tue,  8 Sep 2020 06:10:50 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A84F3811BE;
 Tue,  8 Sep 2020 06:10:47 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 960C317538; Tue,  8 Sep 2020 08:10:46 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] Sirius/ipxe 20200908 patches
Date: Tue,  8 Sep 2020 08:10:43 +0200
Message-Id: <20200908061046.10871-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:10:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit e11bd71f89649da3cff439c030d2ccac0cc914e3=
:=0D
=0D
  Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2020-=
09-07' into staging (2020-09-07 16:51:00 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://git.kraxel.org/qemu tags/sirius/ipxe-20200908-pull-request=0D
=0D
for you to fetch changes up to 3e570a9ae9b966362596fd649f2cbcff0b2199c9:=0D
=0D
  ipxe: update binaries (2020-09-08 08:08:30 +0200)=0D
=0D
----------------------------------------------------------------=0D
ipxe: update to aug 2020 snapshot.=0D
=0D
----------------------------------------------------------------=0D
=0D
Gerd Hoffmann (3):=0D
  ipxe: update submodule=0D
  ipxe: drop ia32 efi roms=0D
  ipxe: update binaries=0D
=0D
 pc-bios/efi-e1000.rom    | Bin 240128 -> 159232 bytes=0D
 pc-bios/efi-e1000e.rom   | Bin 240128 -> 159232 bytes=0D
 pc-bios/efi-eepro100.rom | Bin 240128 -> 159232 bytes=0D
 pc-bios/efi-ne2k_pci.rom | Bin 238592 -> 157696 bytes=0D
 pc-bios/efi-pcnet.rom    | Bin 238592 -> 157696 bytes=0D
 pc-bios/efi-rtl8139.rom  | Bin 242688 -> 160768 bytes=0D
 pc-bios/efi-virtio.rom   | Bin 242688 -> 160768 bytes=0D
 pc-bios/efi-vmxnet3.rom  | Bin 236032 -> 156672 bytes=0D
 roms/Makefile            |   2 --=0D
 roms/ipxe                |   2 +-=0D
 10 files changed, 1 insertion(+), 3 deletions(-)=0D
=0D
--=20=0D
2.27.0=0D
=0D


