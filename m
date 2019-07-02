Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5400C5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 04:06:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9DF621473
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 04:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9DF621473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiA3x-0008G9-TV
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 00:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50381)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jasowang@redhat.com>) id 1hi8aG-0004jK-OI
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 22:31:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1hi8aE-0003cp-RA
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 22:31:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45312)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1hi8aD-0003Uj-6k
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 22:31:50 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AB3F430872C5;
 Tue,  2 Jul 2019 02:31:33 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-232.pek2.redhat.com
 [10.72.12.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 57ED5BA4D;
 Tue,  2 Jul 2019 02:31:31 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Date: Tue,  2 Jul 2019 10:31:12 +0800
Message-Id: <1562034689-6539-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Tue, 02 Jul 2019 02:31:33 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 00/17] Net patches
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
Cc: Jason Wang <jasowang@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 7d0e02405fc02a181319b1ab8681d2f72246b7=
c6:

  Merge remote-tracking branch 'remotes/vivier2/tags/trivial-patches-pull=
-request' into staging (2019-07-01 17:40:32 +0100)

are available in the git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to 0e8818f023616677416840d6ddc880db8de3c967:

  migration/colo.c: Add missed filter notify for Xen COLO. (2019-07-02 10=
:21:07 +0800)

----------------------------------------------------------------

----------------------------------------------------------------
C=C3=A9dric Le Goater (1):
      ftgmac100: do not link to netdev

Dr. David Alan Gilbert (5):
      net/announce: Allow optional list of interfaces
      net/announce: Add HMP optional interface list
      net/announce: Add optional ID
      net/announce: Add HMP optional ID
      net/announce: Expand test for stopping self announce

Markus Armbruster (2):
      MAINTAINERS: Add qemu-bridge-helper.c to "Network device backends"
      qemu-bridge-helper: Document known shortcomings

Stefano Garzarella (4):
      net: fix assertion failure when ipv6-prefixlen is not a number
      net: avoid using variable length array in net_client_init()
      net: use g_strsplit() for parsing host address and port
      net: remove unused get_str_sep() function

Zhang Chen (5):
      COLO-compare: Add new parameter to communicate with remote colo-fra=
me
      COLO-compare: Add remote notification chardev handler frame
      COLO-compare: Make the compare_chr_send() can send notification mes=
sage.
      COLO-compare: Add colo-compare remote notify support
      migration/colo.c: Add missed filter notify for Xen COLO.

 MAINTAINERS             |   1 +
 hmp-commands.hx         |   7 ++-
 hw/net/ftgmac100.c      |   2 -
 hw/net/virtio-net.c     |   4 +-
 include/net/announce.h  |   8 ++-
 migration/colo.c        |   2 +
 monitor/hmp-cmds.c      |  41 ++++++++++++-
 net/announce.c          |  89 +++++++++++++++++++++++----
 net/colo-compare.c      | 155 ++++++++++++++++++++++++++++++++++++++++++=
------
 net/net.c               |  99 +++++++++++++++----------------
 net/trace-events        |   3 +-
 qapi/net.json           |  16 ++++-
 qemu-bridge-helper.c    |  12 +++-
 qemu-options.hx         |  33 ++++++++++-
 tests/virtio-net-test.c |  57 +++++++++++++++++-
 15 files changed, 430 insertions(+), 99 deletions(-)


