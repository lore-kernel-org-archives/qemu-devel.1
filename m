Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220BDC433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 15:27:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC9E220812
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 15:27:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC9E220812
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=efs-auto.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jig9s-00032J-7E
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 11:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.brenken@efs-auto.org>)
 id 1jig8t-0002BR-G5
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 11:26:23 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:46205)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.brenken@efs-auto.org>)
 id 1jig8s-0004sD-HZ
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 11:26:23 -0400
Received: from localhost.localdomain ([178.239.76.114]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MIMT4-1jlxvk3USC-00EKHl; Tue, 09 Jun 2020 17:26:12 +0200
From: David Brenken <david.brenken@efs-auto.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/1] tricore: added AURIX TC277 D-Step TriBoard
Date: Tue,  9 Jun 2020 17:25:52 +0200
Message-Id: <20200609152553.4376-1-david.brenken@efs-auto.org>
X-Mailer: git-send-email 2.16.1.windows.4
X-Provags-ID: V03:K1:CPBf9EeZ1YsZX+PO1l+cPDhEP1XCT8l+4EWKnF3n1nfUxrFy9X7
 m7yDrNc9kC70Qwv1fH5RcAOXJ2h0hZbiP9GK8cmKVXqiNA3JSYSxM68y6sNlXVu5TOE0YGs
 wm3FW0AHxiLeK1RipXlkr44xWaIr1PhreLuNon1LIKsGLbfIk3JRsOkw0fc4Be4/nGP+rNU
 bYo+hEMjznpWeVt5DAK4Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DAeiJ+UWS6Y=:tmXNv6hZWjzBrfQcvjvYSY
 8laBBWnwz1HnZmTGeCVXvgyYtFxzkQWJLDTSRmlNXQGxXwuRKp6SQX6gv/HKp5CFR79a045qz
 qNoDtFSL8rMZL+TfpVDakknXOeyVekBbGGi67fLB3f9VcKpgX8Ax/7nsuiTEdVAS5nYsQTCbz
 deMpCkrUuc8WZruqDs4OU8aaU44adMBhBA7vuGWYAhysOB79QDDiUVBf6VpOr/aqUQOwIioOI
 RmYdDTjxXH+DmOGV98hkehW079tdReq4A4H2TIVxTl/ttDhn9H5xTKYgyOdKZ6BKg6/1eMRYo
 xFby2yE8970lU4tgDpyn6vqAGiuM9OcOEohTIVNAHs78OQRsiK1sQPhnPfutRlx6bvnZRCoiy
 iHz+lI8srkkLGjo6PZIWPj4+zsZYhHmZslDAKoqf+DPstWKxl1e7Tns5/YvrDSnb7iphaYp8G
 G5+tUyDosuVWmC/D1Rt3UHrOr7l5zZCuq0sCdQhLUSTJRsZSd8wMRB8nYu729bZGNLxmgG1wF
 fmzu3XofLJu81tBRnZgX/CE980U9Rz90nrniZSVeLl5g2j9Y56YgEW/+sqFtJ8rqRXMqpKImF
 QT3MegBvjDUwssu1JOwq4qMaumJlT4h7D49EkXCkJjKhr1JfCbyNxXwimoeQzyFDy/Sy2rmeF
 ZjDfuuhqwrjPd4VK6j3tIX+7nUvDkMvbmcpsKQ3kYIws95Gg8lOPbWKNatyInqXc7oQp4SiCu
 k3QhP94bevhEEIGQ78xMwTdxdEvnMbcmaIQFD1+wUNW3eQjaYrOwjLkmmdoK0JKX4IfBSK8cR
 vgjZREp07t72xS1NMquxrsO3t35LAUUAM1w/GLTdNYDzKBnhsG2qR41cyKdZOMf2rqj/sON
Received-SPF: none client-ip=217.72.192.73;
 envelope-from=david.brenken@efs-auto.org; helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 11:26:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kbastian@mail.uni-paderborn.de,
 Andreas Konopik <andreas.konopik@efs-auto.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andreas Konopik <andreas.konopik@efs-auto.de>

Hello everyone,

this patch adds the AURIX TC277 D-Step TriBoard as QEMU machine
(-M AURIX_TriBoard_TC277D). Memory maps are implemented according to the the
"AURIX TC27x D-Step User's Manual V2.2 2014-12". AURIX memory layouts
are specified by the processor, that is why this patch has been reworked as a
SoC-implementation.

Andreas Konopik (1):
  tricore: added triboard with tc27x_soc

 hw/tricore/Kconfig             |   8 ++
 hw/tricore/Makefile.objs       |   2 +
 hw/tricore/tc27x_soc.c         | 252 +++++++++++++++++++++++++++++++++
 hw/tricore/triboard.c          | 104 ++++++++++++++
 include/hw/tricore/tc27x_soc.h | 135 ++++++++++++++++++
 include/hw/tricore/triboard.h  |  53 +++++++
 6 files changed, 554 insertions(+)
 create mode 100644 hw/tricore/tc27x_soc.c
 create mode 100644 hw/tricore/triboard.c
 create mode 100644 include/hw/tricore/tc27x_soc.h
 create mode 100644 include/hw/tricore/triboard.h

-- 
2.27.0


