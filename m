Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEB2C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 17:22:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEE8320729
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 17:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=leostella.onmicrosoft.com header.i=@leostella.onmicrosoft.com header.b="pvB56Wjo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEE8320729
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=leostella.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k06pS-0001p8-58
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 13:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthieu.bucchianeri@leostella.com>)
 id 1k06oo-0001HF-N6; Mon, 27 Jul 2020 13:21:42 -0400
Received: from mail-bn3usg02on0096.outbound.protection.office365.us
 ([23.103.208.96]:6123 helo=USG02-BN3-obe.outbound.protection.office365.us)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthieu.bucchianeri@leostella.com>)
 id 1k06ol-000386-Rt; Mon, 27 Jul 2020 13:21:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=UUEwkb025S7c3me37iZu4B9JBjBAYIqzasstZwH/yhnLlF6l1X22wJArmljSsninvlVHCHMHD1SU107xGZYtWTKqEypMNdZimGLimDSAv6do1P7xLoxM/2+vzzuVPaMXeS78D4Ae3rwRnd39OV/Ct4H0KeTH8y8Hr8uYTEHnUlqBZrgyrl5MeRno++IJwPXUc/SC1AI4krvAitBc3lFYYPPn89oVu1PMUDAKrYxPv6SIeSr95CQDufNTOoghOwJNFh4Zl6EEGCEM0LrEcdFu363aIs4zjWYyhQ/8iBIuxcpjxMnnUrfKWGZyNYASFHO5Sl+QeXZl0BJ1oN0lWLR3Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AyYcZeJhffJgimBV7FM3XZGQE4rq4cFhk14/tBV2Mk=;
 b=aDRray4QxlzHDERdmHSL0C8Ey5uJNeHiom3ZzYtY4vcg+flI1aAvrbjvo1dzRvYuplvCKWA4/InpqaA5Zn0sZiw/h7mZAuaDq2qzQiqxmiNLPVg5jY9WXjBvN+vJiucE8S4G7KzbEoTzeUM0mhoCM+NnkKYNK6luCgCoudyR8EbFeOKPRrGd5QHuc7CEppTtn/V6zninpmoiQQNFGZZe/hfSyJUMQfHk3W2rkIukEVnhbSXr1xikgz2fy/ZfIItxq7tc+Ic+bQVextsJmE3KVW4cHBa764MJV+mFH++rHXfWZqd7aSLmNY9WMjXIM4rcYuPFaV2wi6JtG6SWQ54zmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leostella.com; dmarc=pass action=none
 header.from=leostella.com; dkim=pass header.d=leostella.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leostella.onmicrosoft.com; s=selector1-leostella-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AyYcZeJhffJgimBV7FM3XZGQE4rq4cFhk14/tBV2Mk=;
 b=pvB56WjomJ5AGKbDDDNc7KUKyTbS93O48mWGLf7hQ9F6da3luQpu5yfKA3tgw55RLdTJijwuB62NK4C9yAFcBmmFh30ky0KqoEjcty/5PeUsk6WqiNPyUkm/e02TQwIYxXlUP+7vOmWiHbfsl0gAsu2hYzqjVfFFUjKJXpEF1J8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=leostella.com;
Received: from SN5P110MB0543.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:41c::10)
 by SN5P110MB0480.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:41b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.28; Mon, 27 Jul
 2020 17:21:33 +0000
Received: from SN5P110MB0543.NAMP110.PROD.OUTLOOK.COM
 ([fe80::d0e1:84ad:f42:f6f2]) by SN5P110MB0543.NAMP110.PROD.OUTLOOK.COM
 ([fe80::d0e1:84ad:f42:f6f2%5]) with mapi id 15.20.3216.031; Mon, 27 Jul 2020
 17:21:33 +0000
From: Matthieu Bucchianeri <matthieu.bucchianeri@leostella.com>
To: qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org,
	qemu-trivial@nongnu.org
Subject: [PATCH] target/ppc: Fix TCG leak with the evmwsmiaa instruction
Date: Mon, 27 Jul 2020 10:21:14 -0700
Message-Id: <20200727172114.31415-1-matthieu.bucchianeri@leostella.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: CY1P110CA0062.NAMP110.PROD.OUTLOOK.COM
 (2001:489a:200:400::32) To SN5P110MB0543.NAMP110.PROD.OUTLOOK.COM
 (2001:489a:200:41c::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bd1.leostella.local (2601:601:f01:e820:349c:f32e:2333:ec4c) by
 CY1P110CA0062.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:400::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.28 via Frontend Transport; Mon, 27 Jul 2020 17:21:32 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [2601:601:f01:e820:349c:f32e:2333:ec4c]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86702bd1-c70f-4ce5-2552-08d832518257
X-MS-TrafficTypeDiagnostic: SN5P110MB0480:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN5P110MB0480313F52CE83330063D15D84720@SN5P110MB0480.NAMP110.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN5P110MB0543.NAMP110.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(508600001)(8936002)(6486002)(5660300002)(44832011)(107886003)(86362001)(186003)(4326008)(16526019)(36756003)(2906002)(6512007)(1076003)(2616005)(83380400001)(52116002)(8676002)(66946007)(6666004)(66556008)(6506007)(66476007);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: leostella.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86702bd1-c70f-4ce5-2552-08d832518257
X-MS-Exchange-CrossTenant-AuthSource: SN5P110MB0543.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 17:21:33.5923 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: dbc51146-ab26-404b-9c4b-cce4f3331cc5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN5P110MB0480
Received-SPF: pass client-ip=23.103.208.96;
 envelope-from=matthieu.bucchianeri@leostella.com;
 helo=USG02-BN3-obe.outbound.protection.office365.us
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 13:21:37
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Matthieu Bucchianeri <matthieu.bucchianeri@leostella.com>,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix double-call to tcg_temp_new_i64(), where a temp is allocated both at
declaration time and further down the implementation of gen_evmwsmiaa().

Note that gen_evmwsmia() and gen_evmwsmiaa() are still not implemented
correctly, as they invoke gen_evmwsmi() which may return early, but the
return is not propagated. This will be fixed in my patch for bug #1888918.

Signed-off-by: Matthieu Bucchianeri <matthieu.bucchianeri@leostella.com>
---
 target/ppc/translate/spe-impl.inc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/translate/spe-impl.inc.c b/target/ppc/translate/spe=
-impl.inc.c
index 36b4d5654d..42a0d1cffb 100644
--- a/target/ppc/translate/spe-impl.inc.c
+++ b/target/ppc/translate/spe-impl.inc.c
@@ -528,14 +528,14 @@ static inline void gen_evmwsmia(DisasContext *ctx)

     tcg_temp_free_i64(tmp);
 }

 static inline void gen_evmwsmiaa(DisasContext *ctx)
 {
-    TCGv_i64 acc =3D tcg_temp_new_i64();
-    TCGv_i64 tmp =3D tcg_temp_new_i64();
+    TCGv_i64 acc;
+    TCGv_i64 tmp;

     gen_evmwsmi(ctx);           /* rD :=3D rA * rB */

     acc =3D tcg_temp_new_i64();
     tmp =3D tcg_temp_new_i64();

--
2.17.1

LeoStella, LLC
A joint venture of Thales Alenia Space and Spaceflight Industries

12501 E Marginal Way S =E2=80=A2 Tukwila, WA 98168

Proprietary Document: This document may contain trade secrets or otherwise =
proprietary and confidential information owned by LeoStella LLC. It is inte=
nded only for the individual addressee and may not be copied, distributed, =
or otherwise disclosed without LeoStella LLC express prior written authoriz=
ation.
Export Controlled: This document may contain technical data whose export is=
 restricted by the Arms Export Control Act (Title 22, U.S.C., Sec 2751 et s=
eq.) or the Export Administration Act of 1979, as amended, Title 50,U.S.C.,=
 app 2401 et seq. Violation of these export laws are subject to severe crim=
inal penalties. Recipient shall not export, re-export, or otherwise transfe=
r or share this document to any foreign person (as defined by U.S. export l=
aws) without advance written authorization from LeoStella LLC.

