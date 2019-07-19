Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E1DC7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 20:21:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ACEA21849
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 20:21:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ACEA21849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoZO2-0001jo-Np
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 16:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33134)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hoZNn-00019d-RQ
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 16:21:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hoZNm-0004Vf-58
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 16:21:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40208)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hoZNk-0004SZ-IP
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 16:21:33 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2BFE8335D0
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 20:21:27 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-46.phx2.redhat.com [10.3.116.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E198719C68
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 20:21:26 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 15:21:18 -0500
Message-Id: <20190719202119.24792-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Fri, 19 Jul 2019 20:21:27 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 0/1] NBD patches for -rc2
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

The following changes since commit e2b47666fe1544959c89bd3ed159e9e37cc9fc=
73:

  Merge remote-tracking branch 'remotes/berrange/tags/misc-next-pull-requ=
est' into staging (2019-07-19 14:29:13 +0100)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2019-07-19

for you to fetch changes up to 5cf42b1c1f75499b467701926d3c9691d27712e1:

  nbd: Initialize reply on failure (2019-07-19 13:19:18 -0500)

----------------------------------------------------------------
nbd patches for 2019-07-19

- silence harmless compiler/valgrind warning

----------------------------------------------------------------
Eric Blake (1):
      nbd: Initialize reply on failure

 block/nbd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--=20
2.20.1


