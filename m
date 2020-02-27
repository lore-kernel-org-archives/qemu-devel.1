Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BCAC4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 01:56:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54EEF20838
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 01:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aPEiaYKn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54EEF20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j78Pd-0006P6-Da
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 20:56:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36416)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j78OB-0004cC-TR
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 20:55:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j78OA-0002eY-Ob
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 20:54:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58446
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j78OA-0002bl-Jp
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 20:54:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582768497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LT6+cr0JcAPD/ccTwfLNwAf217rBmjvPPgjG/htawBI=;
 b=aPEiaYKnVOhEm/WjZp42ZH3XO5PNdnehBl2omdAoqspmstvEU9IG4BYdYlyL2eW90sBGxw
 CSpNEyb4LIRco44/fi8y21ikt7V4JO+7/RI4FC7l3YC/TQ0079sT1R9guSzxPND58ZMlxc
 G7I73XnU4zlaG6kY1rkttpA5c1gXNu8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-YQchkr02MUmbgdSCN4ZRPg-1; Wed, 26 Feb 2020 20:54:51 -0500
X-MC-Unique: YQchkr02MUmbgdSCN4ZRPg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD0F98017CC
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 01:54:50 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-57.phx2.redhat.com [10.3.116.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 895B85C21B
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 01:54:50 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/4] NBD patches for 2020-02-26
Date: Wed, 26 Feb 2020 19:54:44 -0600
Message-Id: <20200227015448.960538-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

The following changes since commit db736e0437aa6fd7c1b7e4599c17f9619ab6b837=
:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into sta=
ging (2020-02-25 13:31:16 +0000)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2020-02-26

for you to fetch changes up to 8198cf5ef0ef98118b4176970d1cd998d93ec849:

  block/nbd: fix memory leak in nbd_open() (2020-02-26 17:29:00 -0600)

----------------------------------------------------------------
nbd patches for 2020-02-26

- ensure multiple meta contexts work
- allow leading / in export names
- fix a failure path memory leak

----------------------------------------------------------------
Eric Blake (2):
      nbd: Fix regression with multiple meta contexts
      nbd-client: Support leading / in NBD URI

Pan Nengyuan (2):
      block/nbd: extract the common cleanup code
      block/nbd: fix memory leak in nbd_open()

 block/nbd.c  | 33 ++++++++++++++++++++-------------
 nbd/server.c | 12 ++++++++++--
 2 files changed, 30 insertions(+), 15 deletions(-)

--=20
2.24.1


