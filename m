Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01788C10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 13:57:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C20C02077C
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 13:57:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C20C02077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49324 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEaD2-0002KT-2G
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 09:57:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hEaBZ-0001El-R0
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 09:56:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hEaBX-0005k2-P5
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 09:56:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hEaBR-0005fS-UJ; Thu, 11 Apr 2019 09:56:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 02C20C0AC378;
	Thu, 11 Apr 2019 13:56:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AD04045F35;
	Thu, 11 Apr 2019 13:56:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 448F41138648; Thu, 11 Apr 2019 15:56:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Apr 2019 15:56:00 +0200
Message-Id: <20190411135602.21725-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Thu, 11 Apr 2019 13:56:04 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/2] hw/arm/virt: Support firmware
 configuration with -blockdev
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-block@nongnu.org,
	mreitz@redhat.com, qemu-arm@nongnu.org, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411135600.F_K6BdQm6XMGYrQ1XVD8jq_bzjVqsxFKV6DaS-AKGDQ@z>

L=C3=A1szl=C3=B3 asked for feature parity with the PC machine types.

Markus Armbruster (2):
  pflash_cfi01: New pflash_cfi01_legacy_drive()
  hw/arm/virt: Support firmware configuration with -blockdev

 hw/arm/virt.c            | 192 +++++++++++++++++++++++++--------------
 hw/block/pflash_cfi01.c  |  30 ++++++
 hw/i386/pc_sysfw.c       |  19 +---
 include/hw/arm/virt.h    |   2 +
 include/hw/block/flash.h |   1 +
 5 files changed, 157 insertions(+), 87 deletions(-)

--=20
2.17.2


