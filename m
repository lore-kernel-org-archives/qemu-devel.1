Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B89C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 11:05:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D6ED20714
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 11:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hGb69tYY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D6ED20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH3qS-0000JN-Cr
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 07:05:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37947)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jH3kJ-0000JR-Vz
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:58:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jH3kI-0006hs-Uu
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:58:51 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:50308)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jH3kI-0006gn-Qn
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:58:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585133930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tDFrK3Be+RVpsk87Bbyr29Etbp5WYzkSg0bDmbhYfZw=;
 b=hGb69tYYKjyX2h4q0uCddKNTa9uUuqwhGv1VAUxWSLsZaIiC5197MarW12yNPEGqTpJil9
 17TuwIOmTDvnwDL8vSK8yRwCQQb9Ko8MxRmFPdC5N9lzh05lGdgzcV1SPTcekCYLQ3iZQr
 LAZtuYJtPpmYaT19ejrzJIEWRA/U+xc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-PBhpmCDOOCezAv0sI7sRcQ-1; Wed, 25 Mar 2020 06:58:48 -0400
X-MC-Unique: PBhpmCDOOCezAv0sI7sRcQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0290E189D6D3
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 10:58:48 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-49.ams2.redhat.com
 [10.36.112.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CE5991000322;
 Wed, 25 Mar 2020 10:58:44 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id D0C4817535; Wed, 25 Mar 2020 11:58:43 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/2] Fixes 20200325 patches
Date: Wed, 25 Mar 2020 11:58:41 +0100
Message-Id: <20200325105843.17387-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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

The following changes since commit 736cf607e40674776d752acc201f565723e86045=
:

  Update version for v5.0.0-rc0 release (2020-03-24 17:50:00 +0000)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/fixes-20200325-pull-request

for you to fetch changes up to 95fad99cb28e9970944b01fd7af452f6f9f37484:

  hw/audio/fmopl: fix segmentation fault (2020-03-25 09:55:40 +0100)

----------------------------------------------------------------
fixes: input error handling & audio segfault

----------------------------------------------------------------

Philippe Mathieu-Daud=C3=A9 (1):
  ui/input-linux: Do not ignore ioctl() return value

Volker R=C3=BCmelin (1):
  hw/audio/fmopl: fix segmentation fault

 hw/audio/fmopl.c |  4 ++--
 ui/input-linux.c | 29 +++++++++++++++++++++++++++--
 2 files changed, 29 insertions(+), 4 deletions(-)

--=20
2.18.2


