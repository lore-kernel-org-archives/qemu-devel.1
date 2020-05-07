Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD730C38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 16:12:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5CE92083B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 16:12:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5CE92083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWj8d-0001By-PF
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 12:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1jWj7Z-00007T-Kv; Thu, 07 May 2020 12:11:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14032
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1jWj7X-0001VU-UN; Thu, 07 May 2020 12:11:37 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 047F8geP119768; Thu, 7 May 2020 12:11:29 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 30vmqaj1w5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 07 May 2020 12:11:29 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 047Fv6j0117907;
 Thu, 7 May 2020 12:11:28 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.70])
 by mx0b-001b2d01.pphosted.com with ESMTP id 30vmqaj1uv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 07 May 2020 12:11:28 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
 by ppma01fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 047G9oeU019081;
 Thu, 7 May 2020 16:11:26 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com
 (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
 by ppma01fra.de.ibm.com with ESMTP id 30s0g5csa4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 07 May 2020 16:11:26 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 047GAEGo63766876
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 7 May 2020 16:10:14 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2C3A75204E;
 Thu,  7 May 2020 16:11:24 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.160.63])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id E68B652050;
 Thu,  7 May 2020 16:11:23 +0000 (GMT)
Subject: [PATCH] target/ppc: Untabify excp_helper.c
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 07 May 2020 18:11:23 +0200
Message-ID: <158886788307.1560068.14096740175576278978.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-07_09:2020-05-07,
 2020-05-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1034
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0
 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=884 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070123
Received-SPF: softfail client-ip=148.163.158.5; envelope-from=groug@kaod.org;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 12:11:34
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_SOFTFAIL=0.665,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some tabs crept in with a recent change.

Fixes: 6dc6b557913f "target/ppc: Improve syscall exception logging"
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/excp_helper.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 639cac38f9c3..4db3d9ed9af5 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -70,16 +70,16 @@ static inline void dump_syscall(CPUPPCState *env)
 static inline void dump_hcall(CPUPPCState *env)
 {
     qemu_log_mask(CPU_LOG_INT, "hypercall r3=%016" PRIx64
-		  " r4=%016" PRIx64 " r5=%016" PRIx64 " r6=%016" PRIx64
-		  " r7=%016" PRIx64 " r8=%016" PRIx64 " r9=%016" PRIx64
-		  " r10=%016" PRIx64 " r11=%016" PRIx64 " r12=%016" PRIx64
+                  " r4=%016" PRIx64 " r5=%016" PRIx64 " r6=%016" PRIx64
+                  " r7=%016" PRIx64 " r8=%016" PRIx64 " r9=%016" PRIx64
+                  " r10=%016" PRIx64 " r11=%016" PRIx64 " r12=%016" PRIx64
                   " nip=" TARGET_FMT_lx "\n",
                   ppc_dump_gpr(env, 3), ppc_dump_gpr(env, 4),
-		  ppc_dump_gpr(env, 5), ppc_dump_gpr(env, 6),
-		  ppc_dump_gpr(env, 7), ppc_dump_gpr(env, 8),
-		  ppc_dump_gpr(env, 9), ppc_dump_gpr(env, 10),
-		  ppc_dump_gpr(env, 11), ppc_dump_gpr(env, 12),
-		  env->nip);
+                  ppc_dump_gpr(env, 5), ppc_dump_gpr(env, 6),
+                  ppc_dump_gpr(env, 7), ppc_dump_gpr(env, 8),
+                  ppc_dump_gpr(env, 9), ppc_dump_gpr(env, 10),
+                  ppc_dump_gpr(env, 11), ppc_dump_gpr(env, 12),
+                  env->nip);
 }
 
 static int powerpc_reset_wakeup(CPUState *cs, CPUPPCState *env, int excp,


