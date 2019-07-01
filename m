Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1514C5B578
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 01:35:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB0F7216C8
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 01:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB0F7216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi7hG-0005Vc-4S
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 21:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47557)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eric.auger@redhat.com>) id 1hi3z3-0001bF-LT
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:37:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1hi3yz-0002ue-L0
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:37:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35262)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1hi3yb-0002kR-AU; Mon, 01 Jul 2019 17:36:43 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4D77330860A0;
 Mon,  1 Jul 2019 19:08:39 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-95.ams2.redhat.com [10.36.116.95])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 23EA42CFC7;
 Mon,  1 Jul 2019 19:08:21 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org,
 shameerali.kolothum.thodi@huawei.com, imammedo@redhat.com
Date: Mon,  1 Jul 2019 21:08:19 +0200
Message-Id: <20190701190819.25388-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Mon, 01 Jul 2019 19:08:54 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] tests: Update DSDT ACPI table for arm/virt
 board with PCDIMM related changes
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

PCDIMM hotplug addition updated the DSDT. Update the reference table.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 tests/data/acpi/virt/DSDT | Bin 18476 -> 18493 bytes
 1 file changed, 0 insertions(+), 0 deletions(-)

diff --git a/tests/data/acpi/virt/DSDT b/tests/data/acpi/virt/DSDT
index 20e85c7f89f645c69935c615c07084e221419960..1a5c3e5243c78eb25345fdf7f=
fa442afec3c5c28 100644
GIT binary patch
delta 172
zcmZ28fpPByMlP3Nmk?VI1_q{Y6S<_BIvO{s=3DeSSi^^mWRZt~=3Da(Tfjuig$N)iRXy-
z@O0sIbPn(|FfcS`;D`?ea)A;+mUB?BARiZZCmRDZqb36bLnT9WgKLnhI|B~`0|zG;
zOLQYQi0kYc?CPT+ViNBf7Q$Ho;v_5(n_Qj1$iNt*&kVB1*CW8$H`v*4fdEjLhl`1U
Ni>WOjJjjWw0RY`tDw+TQ

delta 134
zcmdlxfpN_QMlP3Nmk=3DEf1_q{ziCof5?F}2%bKIpo*xdvC4LIUGJY9GlgM2*<49pA}
zIN}{$f+og`c`$P_2rw{ovN13+sxvS!RDxt&Jq4Ay6ndl?7@-g-A<n=3Dc$sh-0Ff)LR
Z11c2ZjdwLLW@rlt4|3vam^{&45den68LI#Q

--=20
2.20.1


