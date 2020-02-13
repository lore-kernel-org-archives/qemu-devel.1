Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B48C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 09:07:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7B4C20848
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 09:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JllGjwSP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7B4C20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2ASz-0003zV-5x
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 04:07:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41121)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1j2ASD-00035l-DQ
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:06:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1j2ASB-0005nY-Nw
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:06:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40588
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1j2ASB-0005lp-Kj
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:06:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581584794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YB+NcfV4WhegA1HG+O1HopRCJPUTCKrhSWSrGXkAg3A=;
 b=JllGjwSPJ16TpFzfCk0B5aBW7wMqGZ46jJcxmPneth4ssq8HCqWPmGjg2YWpqyve/5gTPV
 5xcDTEAOm7MBs5xEp6bssfkANQV1MIsot9SfJloXw6V1aDmXfp7mA7C6VISigyl2aSfyKK
 zs74RTPfvIPqFRVog8UVJ/m+/kA9WBY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-gBgLzuVLM06IZorHLo72Gw-1; Thu, 13 Feb 2020 04:06:32 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 741BD13E4;
 Thu, 13 Feb 2020 09:06:31 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-39.ams2.redhat.com
 [10.36.117.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9197E5C131;
 Thu, 13 Feb 2020 09:06:28 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id C9F6245B4; Thu, 13 Feb 2020 10:06:27 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/1] Vga 20200213 patches
Date: Thu, 13 Feb 2020 10:06:26 +0100
Message-Id: <20200213090627.2181-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: gBgLzuVLM06IZorHLo72Gw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit e18e5501d8ac692d32657a3e1ef545b14e72b730=
:

  Merge remote-tracking branch 'remotes/dgilbert-gitlab/tags/pull-virtiofs-=
20200210' into staging (2020-02-10 18:09:14 +0000)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/vga-20200213-pull-request

for you to fetch changes up to ed71c09ffd6fbd01c2a487d47291ae57b08671ea:

  qxl: introduce hardware revision 5 (2020-02-13 08:31:40 +0100)

----------------------------------------------------------------
qxl: introduce hardware revision 5

----------------------------------------------------------------

Gerd Hoffmann (1):
  qxl: introduce hardware revision 5

 hw/display/qxl.h  | 2 +-
 hw/core/machine.c | 2 ++
 hw/display/qxl.c  | 7 ++++++-
 3 files changed, 9 insertions(+), 2 deletions(-)

--=20
2.18.2


