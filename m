Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D7DC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 07:35:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5100F2068F
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 07:35:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5100F2068F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvFTL-00066J-H2
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 03:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jvFRA-0001ZR-33
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 03:33:12 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:43819)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jvFR5-00024P-Vx
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 03:33:11 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M734j-1jwac91SqV-008cPY; Tue, 14 Jul 2020 09:33:06 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 4/7] linux-user: add new netlink types
Date: Tue, 14 Jul 2020 09:32:56 +0200
Message-Id: <20200714073259.1464675-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200714073259.1464675-1-laurent@vivier.eu>
References: <20200714073259.1464675-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:AbIAij+Z3f0St+yHezyXFOZxIBusGhUoJNPuAphHcS4/dzNbV8O
 3lTx+skyChLXYcYMZmjv340Q+zxVlq0WJsfcg49qR6etqsPZfPoBhvsQfkmEkcaGXyqlesj
 mV66BIuWP8T3SqXAXyqqoExkcssxSx4Y2OkR7i3H35t0fAjo4ypJVre63+9xjvQpBX/74zz
 oPf0iH7AY6Y9s7TkoqWAw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VXI+FDNetjk=:8dKehAlsZa1jYs3FQn1wYF
 IBhVW9CVqSf0rUHJCNcd3t2SBO6PEfakIZJ1Mtt2rH25LQgmcaUIbdMceCalFiLWtV5TWVp9V
 gNJp+ccZdrHePJtkojZDsfK//Z56CC5caWDfHyMp3zZewAbAo9FwCWqbWWOqwK0QUmWkQVoJl
 +0tv1Q0eJlZU4yQcO+ny5hJV+cxYAfDoGDME8WR3nXphEj2C+bCvWGlcrmt8fLg4nfqwZ3UWB
 By+oB6/QpHNxEgz5O1nwWZr0wlW6jnXq9Fy1h0+snGlFPEo0HP768zrGGpehDjeswuwRBfTPP
 9p39dJANNmG/SVxt9VfqzR0qWThOknGXfHAwMHO6zPn0WqOWIpAKJJOm0WDGugcmlJsWDWvq7
 3JcUie5IHKhlBH5XuW+1gEPiHE4clQFje40uCrRAjzTwmxV8DZtHymnkofO3Fq/JAICcNMn3p
 6T7MMq2w2r/0YUbcXqRBrECcl8KYZ6c1P9tuSIwhvSfq+6myNFbnyX54AT7oNAE1mtoVSIQHE
 KRYOm30nWaVP1ZBstA2ckWejscz9Wgu2eZiRsu5s916k5dIBuhvm05dLYzgkKT99w9PUTfFXz
 S1QuEeaynHD/5GWOv2OnKG6g34tQ9ILehxL8m8QmGMkJoEWm4oUkv3rnE27Y8XsNUNGDrA8M3
 qz4Xu5HFXtv+9HnU5x1qXlsvlIzFT/tBYA9ymasg+TQGJ7ZqRsByKXPR+gQuJ/2o2IfXu8f9L
 ajRIkI0wTA36QcYX3M/iTD6rSqGFby4dxxhQ4IDj8TVMDY7Yn3aSBjXoUcp8SBLSYxmsMPYp5
 r87wGpnV41GdlpaVcNmTUXNtsNIok0YkjLPSUlL1fByUkr/K/5xCr8JnrmMMYyHbu8wCNZs
Received-SPF: none client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 03:33:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Only implement IFLA_PERM_ADDRESS to fix the following error:

  Unknown host QEMU_IFLA type: 54

The couple of other ones, IFLA_PROP_LIST and IFLA_ALT_IFNAME, have
been introduced to be used with RTM_NEWLINKPROP, RTM_DELLINKPROP and
RTM_GETLINKPROP that are not implemented by QEMU.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200709072332.890440-1-laurent@vivier.eu>
---
 linux-user/fd-trans.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/linux-user/fd-trans.c b/linux-user/fd-trans.c
index c0687c52e62b..5d49a53552b2 100644
--- a/linux-user/fd-trans.c
+++ b/linux-user/fd-trans.c
@@ -133,6 +133,9 @@ enum {
     QEMU_IFLA_NEW_IFINDEX,
     QEMU_IFLA_MIN_MTU,
     QEMU_IFLA_MAX_MTU,
+    QEMU_IFLA_PROP_LIST,
+    QEMU_IFLA_ALT_IFNAME,
+    QEMU_IFLA_PERM_ADDRESS,
     QEMU___IFLA_MAX
 };
 
@@ -807,6 +810,7 @@ static abi_long host_to_target_data_link_rtattr(struct rtattr *rtattr)
     /* binary stream */
     case QEMU_IFLA_ADDRESS:
     case QEMU_IFLA_BROADCAST:
+    case QEMU_IFLA_PERM_ADDRESS:
     /* string */
     case QEMU_IFLA_IFNAME:
     case QEMU_IFLA_QDISC:
-- 
2.26.2


