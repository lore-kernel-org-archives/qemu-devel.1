Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0554C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:41:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EBDA214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uu6K+QDl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EBDA214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iugTt-0001e5-29
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 12:41:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59508)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iudMQ-0004rq-8q
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 09:21:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iudMP-0003JE-6z
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 09:21:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47101
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iudMP-0003J9-3c
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 09:21:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579789288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Nfpr4H4sbGnPB2PuTC3DcPSoB6WSGYjKfzfoVJpf+QE=;
 b=Uu6K+QDluWk0wNqsvqyp6RRr0Ivd/So/ZZv50KpL/+oMpbLQ+Lz2pqSzh9k3gSBtKPgDWr
 8TAyy7sCs7BWChjgtHRSrgJ/+K6I0CdpCu6NcSrs55KRHtctsZkhKgegd6mPGSt8nETtTJ
 uEgC6ARzsmQh3ws01WyR3GDqo225yyg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-m_Lzo08xMSmB0NEFkQMgAA-1; Thu, 23 Jan 2020 09:21:26 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7C67DB65
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 14:21:25 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-106.ams2.redhat.com
 [10.36.116.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 350C285757;
 Thu, 23 Jan 2020 14:21:23 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 6638016E18; Thu, 23 Jan 2020 15:21:22 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] Ui 20200123 patches
Date: Thu, 23 Jan 2020 15:21:19 +0100
Message-Id: <20200123142122.13839-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: m_Lzo08xMSmB0NEFkQMgAA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 43d1455cf84283466e5c22a217db5ef4b8197b14=
:

  qapi: Fix code generation with Python 3.5 (2020-01-20 12:17:38 +0000)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/ui-20200123-pull-request

for you to fetch changes up to a1e8853ed2acbda29a52533abc91b035b723952e:

  ui/console: Display the 'none' backend in '-display help' (2020-01-21 07:=
29:40 +0100)

----------------------------------------------------------------
vnc: fix zlib compression artifacts.
ui: add "none" to -display help.

----------------------------------------------------------------

Cameron Esfahani (1):
  vnc: prioritize ZRLE compression over ZLIB

Gerd Hoffmann (1):
  Revert "vnc: allow fall back to RAW encoding"

Philippe Mathieu-Daud=C3=A9 (1):
  ui/console: Display the 'none' backend in '-display help'

 ui/console.c      |  1 +
 ui/vnc-enc-zrle.c |  4 ++--
 ui/vnc.c          | 31 +++++++++++--------------------
 3 files changed, 14 insertions(+), 22 deletions(-)

--=20
2.18.1


