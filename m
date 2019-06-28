Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB95C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 10:50:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 375C920656
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 10:50:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 375C920656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgoSf-0004od-Dx
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 06:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60787)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kraxel@redhat.com>) id 1hgoJ0-0002jD-25
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 06:40:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hgoIw-0006H8-E6
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 06:40:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36980)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>)
 id 1hgoIm-00062A-Lm; Fri, 28 Jun 2019 06:40:20 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4A3053082212;
 Fri, 28 Jun 2019 10:40:10 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-96.ams2.redhat.com
 [10.36.116.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4A51160C4E;
 Fri, 28 Jun 2019 10:40:08 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 282E917512; Fri, 28 Jun 2019 12:39:58 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 28 Jun 2019 12:39:56 +0200
Message-Id: <20190628103957.9504-6-kraxel@redhat.com>
In-Reply-To: <20190628103957.9504-1-kraxel@redhat.com>
References: <20190628103957.9504-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Fri, 28 Jun 2019 10:40:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 5/6] seabios: add ati vgabios binary
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
Cc: Corey Minyard <cminyard@mvista.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Built from master (commit 6e56ed129c9782ba050a5fbfbf4ac12335b230f7),
which has ati vgabios support merged (checkout master branch in
roms/seabios submodule, then run "make -C roms seavgabios-ati").

Temporary exception until the next seabios major version is
released (probably 1.13, fall 2019).

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-id: 20190620151104.2678-3-kraxel@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 pc-bios/vgabios-ati.bin | Bin 0 -> 38912 bytes
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 pc-bios/vgabios-ati.bin

diff --git a/pc-bios/vgabios-ati.bin b/pc-bios/vgabios-ati.bin
new file mode 100644
index 0000000000000000000000000000000000000000..79644708ff88014f127aad29b707bfc8e26aee06
GIT binary patch
literal 38912
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
G1OFTT`I+wk

literal 0
HcmV?d00001

-- 
2.18.1


