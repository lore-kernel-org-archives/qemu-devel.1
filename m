Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEEBC43215
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 06:06:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B6802071E
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 06:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MANZo7VI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B6802071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZ7VZ-0004rG-Hl
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 01:06:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36525)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iZ7UK-00040O-MO
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 01:04:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iZ7UG-0006Dv-5f
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 01:04:43 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26073
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iZ7UF-0006DW-Rv
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 01:04:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574661878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=atz2ZKWY6/1Z4ss8AX492U8knlT66Mc8rxtVGPuIM3Y=;
 b=MANZo7VI71qTsIVHBDtA8qyIX517erEzbLOEP9oyBXJXy6Ak+fEcollGYxdtDtnZfMYkoz
 HYvxwwpntYGcj5dDmXpXNC/AzbHAbbcpnBF2GYtinXcXnOW/oY/dmcxtQlRw/9j/DyXNej
 OUMp1heWzKyOZMw5JhBQP9+gDXTAy2c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-qmINDB2YPlG2QIz2-mM5Mw-1; Mon, 25 Nov 2019 01:04:37 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5217480058B
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 06:04:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 226AD19C69
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 06:04:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8078E1138606; Mon, 25 Nov 2019 07:04:34 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/1] Miscellaneous patches for 2019-11-25
Date: Mon, 25 Nov 2019 07:04:33 +0100
Message-Id: <20191125060434.22997-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: qmINDB2YPlG2QIz2-mM5Mw-1
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 2061735ff09f9d5e67c501a96227b470e7de69b1=
:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into sta=
ging (2019-11-21 17:18:40 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-misc-2019-11-25

for you to fetch changes up to 25f74087c695364dfaa87443b1040a3aa5c29008:

  util/cutils: Fix incorrect integer->float conversion caught by clang (201=
9-11-25 06:00:05 +0100)

----------------------------------------------------------------
Miscellaneous patches for 2019-11-25

----------------------------------------------------------------
Fangrui Song (1):
      util/cutils: Fix incorrect integer->float conversion caught by clang

 util/cutils.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--=20
2.21.0


