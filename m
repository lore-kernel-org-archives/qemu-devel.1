Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_DR
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2569BC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 10:07:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F31B420851
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 10:07:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F31B420851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38190 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbMdo-0002yN-TY
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 06:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56261)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hbMW6-00079g-Pp
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 05:59:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hbMW5-0005uV-Su
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 05:59:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49544)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hbMW5-0005tz-MX
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 05:59:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C7F19A3B6B
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 09:59:32 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-220.ams2.redhat.com
 [10.36.117.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6372B541C8;
 Thu, 13 Jun 2019 09:59:26 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, jasowang@redhat.com, eblake@redhat.com,
 armbru@redhat.com, laine@redhat.com
Date: Thu, 13 Jun 2019 10:59:19 +0100
Message-Id: <20190613095924.21908-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Thu, 13 Jun 2019 09:59:32 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 0/5] network announce;
 interface selection & IDs
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

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Laine asked for some extra features on the network announce support;

The first allows the announce timer to announce on a subset of the
interfaces.

The second allows there to be multiple timers, each with their own
parameters (including the interface list).

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

v4
  Minor typo fixes
  Expanded the test to check we can stop a running announce

Dr. David Alan Gilbert (5):
  net/announce: Allow optional list of interfaces
  net/announce: Add HMP optional interface list
  net/announce: Add optional ID
  net/announce: Add HMP optional ID
  net/announce: Expand test for stopping self announce

 hmp-commands.hx         |  7 +++-
 hmp.c                   | 41 +++++++++++++++++++-
 hw/net/virtio-net.c     |  4 +-
 include/net/announce.h  |  8 +++-
 net/announce.c          | 83 ++++++++++++++++++++++++++++++++++-------
 net/trace-events        |  3 +-
 qapi/net.json           | 16 ++++++--
 tests/virtio-net-test.c | 57 ++++++++++++++++++++++++++--
 8 files changed, 192 insertions(+), 27 deletions(-)

--=20
2.21.0


