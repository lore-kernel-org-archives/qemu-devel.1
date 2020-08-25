Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E45C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 06:21:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7464E2075F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 06:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LJh1LyHC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7464E2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kASLD-0003i8-Oy
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 02:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kASJj-0002Mc-0n
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 02:20:23 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21655
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kASJe-0002a7-EH
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 02:20:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598336417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kpphaskQWrYI+TodXTkjAYOmWfYI2YftHxISCa3D2dw=;
 b=LJh1LyHCxqRHUG0OXMFfWC7Un4SW1MNuBuLByD0POVTdbxYozzOyAd5ATNoDu3zWfpVzk5
 mg1uUdwgQxy0WiUk9LFOhjzqPVzeFKzxDyPUCMGWp+UzkOtfTlxCl1q7V99lGGCMFYzxW3
 MweR0ibG35JUvm4ogwvHXIHOwziO0Fs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-ZHD1IrziOJm-X4f5cffAXw-1; Tue, 25 Aug 2020 02:20:13 -0400
X-MC-Unique: ZHD1IrziOJm-X4f5cffAXw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2EBE6425D1;
 Tue, 25 Aug 2020 06:20:12 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-54.ams2.redhat.com
 [10.36.112.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 37C5010098A5;
 Tue, 25 Aug 2020 06:20:09 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 4F0201753B; Tue, 25 Aug 2020 08:20:08 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] Fixes 20200825 patches
Date: Tue, 25 Aug 2020 08:20:05 +0200
Message-Id: <20200825062008.6502-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 01:35:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: laurent@vivier.eu, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 30aa19446d82358a30eac3b556b4d6641e00b7c1=
:=0D
=0D
  Merge remote-tracking branch 'remotes/cschoenebeck/tags/pull-9p-20200812'=
 into staging (2020-08-24 16:39:53 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://git.kraxel.org/qemu tags/fixes-20200825-pull-request=0D
=0D
for you to fetch changes up to 9755c94a50c8b845ad133a6e660f55ca131b9c7a:=0D
=0D
  meson: avoid compiling qemu-keymap by default (2020-08-25 08:12:19 +0200)=
=0D
=0D
----------------------------------------------------------------=0D
meson: keymap fixes=0D
=0D
----------------------------------------------------------------=0D
=0D
Gerd Hoffmann (1):=0D
  meson: drop keymaps symlink=0D
=0D
Laurent Vivier (2):=0D
  meson: move xkbcommon to meson=0D
  meson: avoid compiling qemu-keymap by default=0D
=0D
 configure         | 31 +++++--------------------------=0D
 meson_options.txt |  1 +=0D
 meson.build       | 16 +++++++++++-----=0D
 ui/meson.build    |  2 +-=0D
 4 files changed, 18 insertions(+), 32 deletions(-)=0D
=0D
--=20=0D
2.27.0=0D
=0D


