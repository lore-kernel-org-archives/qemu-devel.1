Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5063FC5517A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 10:03:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 959A12076E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 10:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X2nTvwae"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 959A12076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY4mE-0000te-6M
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 06:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kY4kV-0007qt-FH
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 06:01:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26702)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kY4kM-0007xH-Lg
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 06:01:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603965688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BPlVQfEtYu9dToRr5tNKJooWKenat+csUd42dK1f7k4=;
 b=X2nTvwaeuokaocJr7ovk4jVNLj6Z07HrgmML411Y7bjuKWIBNNSshh92qepu4m7Q8iIfoX
 uJMC8S8LWAsIazf71ptwQAWb59VFfr3hNQsXnnKg0Qgwtp8s1eajLaS5o1lqLYTuIbwU8P
 m1hXbD/YXX2iNlXUhRKyzki1PDJuP7o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-nBqQ0uvlNgqW7stCyWx6hA-1; Thu, 29 Oct 2020 06:01:26 -0400
X-MC-Unique: nBqQ0uvlNgqW7stCyWx6hA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 320D218CBC43;
 Thu, 29 Oct 2020 10:01:25 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-115-62.ams2.redhat.com
 [10.36.115.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4F15B100238E;
 Thu, 29 Oct 2020 10:01:20 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/5] Misc next patches
Date: Thu, 29 Oct 2020 10:01:14 +0000
Message-Id: <20201029100119.30696-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:47:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit bbc48d2bcb9711614fbe751c2c5ae13e172fbca8=
:=0D
=0D
  Merge remote-tracking branch 'remotes/philmd-gitlab/tags/renesas-20201027=
' =3D=0D
into staging (2020-10-28 16:25:31 +0000)=0D
=0D
are available in the Git repository at:=0D
=0D
  https://gitlab.com/berrange/qemu tags/misc-next-pull-request=0D
=0D
for you to fetch changes up to dfc00eb7dea43bfb6d4a2ba38c4f6bc9745f3729:=0D
=0D
  util: include the target address in socket connect failures (2020-10-29 0=
9:=3D=0D
57:37 +0000)=0D
=0D
----------------------------------------------------------------=0D
Misc fixes=0D
=0D
 * Improve socket cnnection failure error reporting=0D
 * Fix LGPL version number=0D
=0D
----------------------------------------------------------------=0D
=0D
AlexChen (1):=0D
  io: Don't use '#' flag of printf format=0D
=0D
Chetan Pant (3):=0D
  io: Fix Lesser GPL version number=0D
  crypt: Fix Lesser GPL version number=0D
  authz: Fix Lesser GPL version number=0D
=0D
Daniel P. Berrang=3DC3=3DA9 (1):=0D
  util: include the target address in socket connect failures=0D
=0D
 authz/base.c                    |  2 +-=0D
 authz/list.c                    |  2 +-=0D
 authz/listfile.c                |  2 +-=0D
 authz/pamacct.c                 |  2 +-=0D
 authz/simple.c                  |  2 +-=0D
 include/authz/base.h            |  2 +-=0D
 include/authz/list.h            |  2 +-=0D
 include/authz/listfile.h        |  2 +-=0D
 include/authz/pamacct.h         |  2 +-=0D
 include/authz/simple.h          |  2 +-=0D
 include/io/channel-buffer.h     |  2 +-=0D
 include/io/channel-command.h    |  2 +-=0D
 include/io/channel-file.h       |  2 +-=0D
 include/io/channel-socket.h     |  2 +-=0D
 include/io/channel-tls.h        |  2 +-=0D
 include/io/channel-util.h       |  2 +-=0D
 include/io/channel-watch.h      |  2 +-=0D
 include/io/channel-websock.h    |  2 +-=0D
 include/io/channel.h            |  2 +-=0D
 include/io/dns-resolver.h       |  2 +-=0D
 include/io/task.h               |  2 +-=0D
 io/channel-buffer.c             |  2 +-=0D
 io/channel-command.c            |  2 +-=0D
 io/channel-file.c               |  2 +-=0D
 io/channel-socket.c             |  2 +-=0D
 io/channel-tls.c                |  2 +-=0D
 io/channel-util.c               |  2 +-=0D
 io/channel-watch.c              |  2 +-=0D
 io/channel-websock.c            |  4 ++--=0D
 io/channel.c                    |  2 +-=0D
 io/dns-resolver.c               |  2 +-=0D
 io/task.c                       |  2 +-=0D
 tests/qemu-iotests/162.out      |  4 ++--=0D
 tests/test-authz-list.c         |  2 +-=0D
 tests/test-authz-listfile.c     |  2 +-=0D
 tests/test-authz-pam.c          |  2 +-=0D
 tests/test-authz-simple.c       |  2 +-=0D
 tests/test-crypto-afsplit.c     |  2 +-=0D
 tests/test-crypto-block.c       |  2 +-=0D
 tests/test-crypto-cipher.c      |  2 +-=0D
 tests/test-crypto-hash.c        |  2 +-=0D
 tests/test-crypto-ivgen.c       |  2 +-=0D
 tests/test-crypto-secret.c      |  2 +-=0D
 tests/test-crypto-xts.c         |  2 +-=0D
 tests/test-io-channel-buffer.c  |  2 +-=0D
 tests/test-io-channel-command.c |  2 +-=0D
 tests/test-io-channel-file.c    |  2 +-=0D
 tests/test-io-channel-socket.c  |  2 +-=0D
 tests/test-io-task.c            |  2 +-=0D
 util/qemu-sockets.c             | 32 +++++++++++++++++++-------------=0D
 50 files changed, 70 insertions(+), 64 deletions(-)=0D
=0D
--=3D20=0D
2.28.0=0D
=0D


