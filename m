Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53284C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 09:50:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E58DD22225
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 09:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b8pLXJ/b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E58DD22225
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIU4g-0002L1-28
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 05:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kIU20-0006CA-5f
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 05:47:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20684)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kIU1y-0008HQ-IU
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 05:47:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600249633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AdXCn2yJN8lsJ2ibutLA94Kpmd3ICvEcech46YtRkMA=;
 b=b8pLXJ/bzzKnOLoQZcmB313swyEHLZ8k88C3bPioasOhSzjbC1npSuO5Fqu6kqJixLhIeg
 8cI0sLWSWv5d72LBC30ku86bbVwM+t/zB3cSqYyC93RUsm34yzDJ2t44Iu/RNQ+vgs0O2A
 mRT3knYQNjs2vuVVifafVXvKJHMW2/Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-mPiTahVUNg-4bO98m6sU5w-1; Wed, 16 Sep 2020 05:47:10 -0400
X-MC-Unique: mPiTahVUNg-4bO98m6sU5w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7E6010BBEC8;
 Wed, 16 Sep 2020 09:47:08 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 68CED75123;
 Wed, 16 Sep 2020 09:47:06 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/8] Block odirect patches
Date: Wed, 16 Sep 2020 10:46:57 +0100
Message-Id: <20200916094705.2625331-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit de39a045bd8d2b49e4f3d07976622c29d58e0bac=
:=0D
=0D
  Merge remote-tracking branch 'remotes/kraxel/tags/vga-20200915-pull-reque=
st=3D=0D
' into staging (2020-09-15 14:25:05 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  https://github.com/berrange/qemu tags/block-odirect-pull-request=0D
=0D
for you to fetch changes up to b18a24a9f889bcf722754046130507d744a1b0b9:=0D
=0D
  block/file: switch to use qemu_open/qemu_create for improved errors (2020=
-0=3D=0D
9-16 10:33:48 +0100)=0D
=0D
----------------------------------------------------------------=0D
block: improve error reporting for unsupported O_DIRECT=0D
=0D
----------------------------------------------------------------=0D
=0D
Daniel P. Berrang=3DC3=3DA9 (8):=0D
  monitor: simplify functions for getting a dup'd fdset entry=0D
  util: split off a helper for dealing with O_CLOEXEC flag=0D
  util: rename qemu_open() to qemu_open_old()=0D
  util: refactor qemu_open_old to split off variadic args handling=0D
  util: add Error object for qemu_open_internal error reporting=0D
  util: introduce qemu_open and qemu_create with error reporting=0D
  util: give a specific error message when O_DIRECT doesn't work=0D
  block/file: switch to use qemu_open/qemu_create for improved errors=0D
=0D
 accel/kvm/kvm-all.c            |   2 +-=0D
 backends/rng-random.c          |   2 +-=0D
 backends/tpm/tpm_passthrough.c |   8 +--=0D
 block/file-posix.c             |  16 ++---=0D
 block/file-win32.c             |   5 +-=0D
 block/vvfat.c                  |   5 +-=0D
 chardev/char-fd.c              |   2 +-=0D
 chardev/char-pipe.c            |   6 +-=0D
 chardev/char.c                 |   2 +-=0D
 dump/dump.c                    |   2 +-=0D
 hw/s390x/s390-skeys.c          |   2 +-=0D
 hw/usb/host-libusb.c           |   2 +-=0D
 hw/usb/u2f-passthru.c          |   4 +-=0D
 hw/vfio/common.c               |   4 +-=0D
 include/monitor/monitor.h      |   3 +-=0D
 include/qemu/osdep.h           |   9 ++-=0D
 io/channel-file.c              |   2 +-=0D
 monitor/misc.c                 |  58 ++++++++----------=0D
 net/vhost-vdpa.c               |   2 +-=0D
 os-posix.c                     |   2 +-=0D
 qga/channel-posix.c            |   4 +-=0D
 qga/commands-posix.c           |   6 +-=0D
 stubs/fdset.c                  |   8 +--=0D
 target/arm/kvm.c               |   2 +-=0D
 ui/console.c                   |   2 +-=0D
 util/osdep.c                   | 104 +++++++++++++++++++++++----------=0D
 util/oslib-posix.c             |   2 +-=0D
 27 files changed, 150 insertions(+), 116 deletions(-)=0D
=0D
--=3D20=0D
2.26.2=0D
=0D


