Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5FEC10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 11:11:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A234420863
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 11:11:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A234420863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51208 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDSB4-0001rL-Po
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 07:11:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hDS9Z-0000w9-Ke
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 07:09:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hDS9X-0001lg-MU
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 07:09:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hDS9W-0001ke-TK
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 07:09:27 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3CE3531676A7;
	Mon,  8 Apr 2019 11:09:25 +0000 (UTC)
Received: from thuth.com (ovpn-116-50.ams2.redhat.com [10.36.116.50])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DB900177B6;
	Mon,  8 Apr 2019 11:09:23 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Date: Mon,  8 Apr 2019 13:09:17 +0200
Message-Id: <20190408110920.30119-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Mon, 08 Apr 2019 11:09:25 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 0/3] Fixes for libqos
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Jafar Abdi <cafer.abdi@gmail.com>, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190408110917.C502K88sw6p-sSJrAm5NOf85ldv9DOHoYR_5tFOwxmU@z>

 Hi Peter,

the following changes since commit f55a585d1037e5de6088f25e75443c2776786e=
29:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into stagi=
ng (2019-04-07 14:54:55 +0100)

are available in the Git repository at:

  https://gitlab.com/huth/qemu.git pull-request-2019-04-08

for you to fetch changes up to c19f2b711e15dac4c2cdbace2f8fb3a45fbed0d2:

  test qgraph.c: Fix segs due to out of scope default (2019-04-08 12:38:0=
7 +0200)

----------------------------------------------------------------
- Fix a crash in libqos with GCC 9
- Fix usage of wrong boolean types in libqos
----------------------------------------------------------------

Dr. David Alan Gilbert (1):
      test qgraph.c: Fix segs due to out of scope default

Jafar Abdi (2):
      tests/libqos: fix usage of bool in pci-pc.c
      tests/libqos: fix usage of bool in pci-spapr.c

 tests/libqos/pci-pc.c    | 2 +-
 tests/libqos/pci-spapr.c | 2 +-
 tests/libqos/qgraph.c    | 6 ++++--
 3 files changed, 6 insertions(+), 4 deletions(-)

