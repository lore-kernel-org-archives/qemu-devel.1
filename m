Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8D3C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 12:25:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 374F620720
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 12:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FD3HZ0Mj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 374F620720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j02hi-00084q-Ca
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 07:25:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45459)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1j02gh-0006YH-Ff
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:24:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1j02gg-0002un-FH
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:24:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51857
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1j02gg-0002uD-CB
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:24:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581078285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kSwyJLt0pIhmpqCuj7paHMqte/QEP0BcScw1XaiA3ZQ=;
 b=FD3HZ0Mj4o4JkhAu0ZVT4VSCAwy8Aq9xAz/FLn9F7Igv83KW7Ua/3GJ9jDXJP7Yiu/cdeD
 c7V3oPnGjuTCX9tDn3tkQ8Iww7rlj9gZqHFGvlPLcH0w4rOUEHZSANbALjhta39GpkIGsY
 uBsPwqH6Ga7oJ1ElrLhb4g+bMDVNksE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-hRTv_pSpM2uxUCT6PrgyDQ-1; Fri, 07 Feb 2020 07:24:43 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6645C108442C
 for <qemu-devel@nongnu.org>; Fri,  7 Feb 2020 12:24:42 +0000 (UTC)
Received: from dhcp-16-105.lcy.redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D608E7FB60;
 Fri,  7 Feb 2020 12:24:41 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] Misc patches
Date: Fri,  7 Feb 2020 12:24:37 +0000
Message-Id: <20200207122440.2650229-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: hRTv_pSpM2uxUCT6PrgyDQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 5b7686f3fa2092d2b3be92df67b5966ee1b0142a=
:

  Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2020-02-06' int=
o staging (2020-02-06 18:59:12 +0000)

are available in the Git repository at:

  https://github.com/berrange/qemu tags/misc-fixes-pull-request

for you to fetch changes up to 416b71906edfcf280ef31d0e5e607898330b6271:

  docs: stop documenting the e1000 NIC model as the default (2020-02-07 12:=
22:19 +0000)

----------------------------------------------------------------

* Use correct constants for 'bool' type
* Fix compatibility with noVNC in websocket impl
* Remove inaccurate docs aout default NIC model

----------------------------------------------------------------

Daniel P. Berrang=C3=A9 (1):
  docs: stop documenting the e1000 NIC model as the default

Jafar Abdi (1):
  authz: fix usage of bool in listfile.c

yuchenlin (1):
  io/channel-websock: treat 'binary' and no sub-protocol as the same

 authz/listfile.c     |  2 +-
 io/channel-websock.c | 36 ++++++++++++++++++++++++------------
 qemu-options.hx      | 12 +++++++-----
 3 files changed, 32 insertions(+), 18 deletions(-)

--=20
2.24.1


