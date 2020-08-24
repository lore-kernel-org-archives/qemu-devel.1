Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8C8C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 17:04:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46E3D206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 17:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CETrA1SI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46E3D206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAFtx-0001wk-Ip
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 13:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kAFrb-0007Rk-Ck
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 13:02:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44561)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kAFrZ-0003MD-Ls
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 13:02:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598288548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FCTt98t3u6zrfdm0T/Hn/QgrW0ZHZuuF4kwsBEziFv0=;
 b=CETrA1SIPdI9tioIK1loyrPRB8uGSUKYeHc+kLo6BB7H5zZDjxZsH+CmOakG1DfXkgt+iG
 J+D0SATr423pxGne6dyV9laoxMl1O5LYBDLiYjoIuyldnGy3j3/HMXpnxUOE54g/owSBC1
 XL+zHFaaZId3PJdWYFT11h8GbWUkfyM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-QPvhVExhMC6_8SfM-qtXDQ-1; Mon, 24 Aug 2020 13:02:22 -0400
X-MC-Unique: QPvhVExhMC6_8SfM-qtXDQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 714ED51B1;
 Mon, 24 Aug 2020 17:02:21 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-114-223.ams2.redhat.com
 [10.36.114.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F0CA45C1BB;
 Mon, 24 Aug 2020 17:02:19 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] nbd: build qemu-nbd on Windows
Date: Mon, 24 Aug 2020 18:02:16 +0100
Message-Id: <20200824170218.106255-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 04:38:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are already building the NBD client and server on Windows when it is=0D
used via the main system emulator binaries. This demonstrates there is=0D
no fundamental blocker to buildig the qemu-nbd binary too.=0D
=0D
=0D
In testing this I used:=0D
=0D
   wine qemu-nbd.exe -t -p 9000 demo.img=20=0D
=0D
and=0D
=0D
   wine qemu-img.exe info nbd:localhost:9000=0D
=0D
In fact I tested the full matrix of native vs windows client and native=0D
vs windows server.=0D
=0D
I did notice that native qemu-img will sometimes hang when talking to=0D
the windows qemu-nbd.exe binary, and the windows qemu-img will almost=0D
always hang.=0D
=0D
The hang happens in the "blk_unref" call in collect_image_info_list().=0D
This suggests something related to the socket teardown / cleanup in=0D
the NBD code.=0D
=0D
While we should obviously investigate and fix that, I didn't consider=0D
it a blocker for enabling build of qemu-nbd.exe, since we're already=0D
building the same (buggy) NBD code in the system emulators on Windows.=0D
=0D
Daniel P. Berrang=C3=A9 (2):=0D
  block: add missing socket_init() calls to tools=0D
  nbd: disable signals and forking on Windows builds=0D
=0D
 meson.build |  7 ++-----=0D
 qemu-img.c  |  2 ++=0D
 qemu-io.c   |  2 ++=0D
 qemu-nbd.c  | 11 ++++++++++-=0D
 4 files changed, 16 insertions(+), 6 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


