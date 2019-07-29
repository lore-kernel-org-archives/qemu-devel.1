Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2D0C7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 08:34:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E775E206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 08:34:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E775E206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs17D-0005XR-8S
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 04:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47991)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jasowang@redhat.com>) id 1hs16N-0004QH-RM
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 04:33:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1hs16M-0003Cv-RG
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 04:33:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43448)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1hs16M-0003CP-MA
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 04:33:50 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BE085308FB93;
 Mon, 29 Jul 2019 08:33:49 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-203.pek2.redhat.com
 [10.72.12.203])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6003C10190AA;
 Mon, 29 Jul 2019 08:33:48 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Date: Mon, 29 Jul 2019 16:33:41 +0800
Message-Id: <1564389226-4489-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Mon, 29 Jul 2019 08:33:49 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 0/5] Net patches
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

The following changes since commit fff3159900d2b95613a9cb75fc3703e67a6747=
29:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
90726' into staging (2019-07-26 16:23:07 +0100)

are available in the git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to f77bed14f01557596727c4eea042e9818c242049:

  net/colo-compare.c: Fix memory leak and code style issue. (2019-07-29 1=
6:29:30 +0800)

----------------------------------------------------------------

----------------------------------------------------------------
Jason Wang (1):
      e1000: don't raise interrupt in pre_save()

Prasad J Pandit (3):
      qemu-bridge-helper: restrict interface name to IFNAMSIZ
      qemu-bridge-helper: move repeating code in parse_acl_file
      net: tap: replace snprintf with g_strdup_printf calls

Zhang Chen (1):
      net/colo-compare.c: Fix memory leak and code style issue.

 hw/net/e1000.c       |  8 ++------
 net/colo-compare.c   | 27 ++++++++++++++++++++-------
 net/tap.c            | 19 +++++++++++--------
 qemu-bridge-helper.c | 24 +++++++++++++++++-------
 4 files changed, 50 insertions(+), 28 deletions(-)


