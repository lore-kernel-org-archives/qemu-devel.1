Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7094BC3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 00:48:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A3342084E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 00:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nonterra01.onmicrosoft.com header.i=@nonterra01.onmicrosoft.com header.b="pGsePj9i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A3342084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nonterra.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9eh7-0005lv-Fh
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 19:48:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36618)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tobias.koch@nonterra.com>) id 1j9egS-0005KR-SL
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 19:48:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tobias.koch@nonterra.com>) id 1j9egR-0002KN-Nd
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 19:48:16 -0500
Received: from mail-eopbgr150081.outbound.protection.outlook.com
 ([40.107.15.81]:9394 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tobias.koch@nonterra.com>)
 id 1j9egR-0002Ie-Dr
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 19:48:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KSY3EJJY3bDIIWLyyrDUaPviYDLEk3iQ3+YpyvWnUlPIaKgPRcc4wIOegJgxMKQrCdtHLHjgXtFMwjHcfz4YlD+zJkQLylz1wgk/BUvrWBoHSQWxBp426RlMmaPuxLhHyyHCE6ibcUc3GGoDbNscTnqE+W9ha2W08lusJHSy8dv8j46ra/ST2LHFbTJNwtFTVY5M3r293JWcGutFkBC9bO/8ijqOV32vAQlN761jUsnzr4OsW0qCjnRXmPgWSCIjvqffs/M/nzE39mUyRtnKuBeGvu7Tuok0bhxbJtIxL5RVIzwWlYm4Bz8JycwGS3LFz2AaCTjccmtdAZMeZ8S8dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LaCFAUA2g4iVk31YglLfVViQc3HAtGn2jkjtbZ36Cho=;
 b=gNZXWZBH2QNqbdJs3ETQmGVUomk7AD8Lx7vxHUVf1lnMQSJLFNBrXc72ZsqTKMI5Gr4EKJChWtPoo/OaooXWmf0QpUWafUCwQAhWKWSg/eQTlzgTT3I8s2FE4oFUSBzWdtplLmo6KqM+wAeNtQEn47QdPSaswH0Hte73e3uRH6qtD+8ukE2Q24aKoCuy8M1pRAG86w7uaCr1jMevzJnFP2kuJNkTlyEQ1VqBcMOoZ7DiFsl1q1Q1m5RiVOW9AjhafSY0Gz+mWlV9Ny/spqoEh5GOU4QUE+BgK5TEugG2FRrPKm54dJVv188OvW0SGwt8zs7UfhzGAhl1dGItKLC1cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nonterra.com; dmarc=pass action=none header.from=nonterra.com;
 dkim=pass header.d=nonterra.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nonterra01.onmicrosoft.com; s=selector2-nonterra01-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LaCFAUA2g4iVk31YglLfVViQc3HAtGn2jkjtbZ36Cho=;
 b=pGsePj9iO3y1kpJlwSMXD1CalaDwLpJ360glQY8YK5z8EqA+uU8wzzF23/F4Ao6rUsvMbvF6HdlyWak3ZJn1CqXWTgBWGbYbtjBBgQ4CiH3m0c0bfBeHGchigTDNv+GNeAFCsiOfWCuV5yG1hLnWZUkYWVBDInJFsJhkF+629CM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=tobias.koch@nonterra.com; 
Received: from AM0PR08MB4273.eurprd08.prod.outlook.com (20.179.35.80) by
 AM0PR08MB4161.eurprd08.prod.outlook.com (20.178.203.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Thu, 5 Mar 2020 00:48:12 +0000
Received: from AM0PR08MB4273.eurprd08.prod.outlook.com
 ([fe80::7163:372d:fd4c:812a]) by AM0PR08MB4273.eurprd08.prod.outlook.com
 ([fe80::7163:372d:fd4c:812a%5]) with mapi id 15.20.2772.019; Thu, 5 Mar 2020
 00:48:12 +0000
To: qemu-devel@nongnu.org
From: Tobias Koch <tobias.koch@nonterra.com>
Subject: [PATCH] linux-user: do prlimit selectively
Message-ID: <6d93d213-894b-8fc7-a008-62084c5c1a01@nonterra.com>
Date: Thu, 5 Mar 2020 03:48:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::20) To AM0PR08MB4273.eurprd08.prod.outlook.com
 (2603:10a6:208:144::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.132.123.168] (88.128.88.112) by
 FR2P281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.19 via Frontend Transport; Thu, 5 Mar 2020 00:48:10 +0000
X-Originating-IP: [88.128.88.112]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b08832f8-0dd1-4e7a-4d92-08d7c09ee106
X-MS-TrafficTypeDiagnostic: AM0PR08MB4161:
X-Microsoft-Antispam-PRVS: <AM0PR08MB41617898A8A03E7271C64E1689E20@AM0PR08MB4161.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:269;
X-Forefront-PRVS: 03333C607F
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(136003)(366004)(39830400003)(396003)(376002)(346002)(189003)(199004)(2906002)(5660300002)(4326008)(6916009)(44832011)(2616005)(316002)(956004)(52116002)(86362001)(31696002)(16576012)(36756003)(31686004)(6486002)(508600001)(8936002)(16526019)(186003)(81156014)(26005)(81166006)(66556008)(66476007)(8676002)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR08MB4161;
 H:AM0PR08MB4273.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: nonterra.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SmuUfXME2nrZFzRmu6x0CopS2MmJqy2SjtZicvjUDs+OJj2XS4DUG6/QE2UITHp9ono3M/YfEB824OCXqNLZq8v8p4dvWTtr1WhU42yzcxWIV5Q27GaEghOtqr9CkGk+lrrD1WllzjaNbEH/my/4dbFcmweNOmNJ8sQXbYGDtrXlocrGJrpcjiQJOulPtAc/4h6eJXCxqWF7vLAAWv0zB5gqNlc9quaKeq2cHRIbqVEk4/q+iTy1Uw5uBcJ0v+T2ZSktKpCwH5w9lrQBNLjCL9AKDvkASrU1P1pPwoSLbpHI2K1m1HsuCGC/hTpIuypvG9lJdrHyA7UfCa+tWU+6JDAeGyN/bFnf7AyklAHXpnV7Ew1akL1p1T31qTybYhswccX2SeXdqiAWQjM3Tha2xlKr+1kYCLhHFwH211i3HkEU241509LgfCTWKz2DC51v
X-MS-Exchange-AntiSpam-MessageData: yamu27w7CYjnzrh14hGez0Z39L6AQG4FnkPTNOC75zX+aIO4m37xGszR/UwooIWE53drdjKKSwDGpSb2eQms0xE9j6Zr24W2QQdH4TeH0FOx58CPeO0S43YCqKgDKtb73JH9Xkb+cUtfR5PNSqYhAQ==
X-OriginatorOrg: nonterra.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b08832f8-0dd1-4e7a-4d92-08d7c09ee106
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2020 00:48:11.5643 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 76ec9478-ab84-4eac-917c-c1a3242376a3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IdGvE57t8psHR2Mp8JjpbqS1nvpCnKl5RIwEqLJ9PqJhW4Vjam+6Xy2hRXN3sq5gL/+Z88yE34phbD2SYUsShD6mK2JeYnscYwgxdjjCacw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4161
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.15.81
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
Cc: Riku Voipio <riku.voipio@iki.fi>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Analogous to what commit 5dfa88f7 did for setrlimit, this commit
selectively ignores limits for memory-related resources in prlimit64
calls. This is to prevent too restrictive limits from causing QEMU
itself to malfunction.

Signed-off-by: Tobias Koch <tobias.koch@nonterra.com>
---
=C2=A0linux-user/syscall.c | 16 ++++++++++------
=C2=A01 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 8d27d10807..8554c77a38 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11872,13 +11872,17 @@ static abi_long do_syscall1(void *cpu_env, int
num, abi_long arg1,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct host_rlimit64 rnew,=
 rold, *rnewp =3D 0;
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int resource =3D target_to=
_host_resource(arg2);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (arg3) {
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!lo=
ck_user_struct(VERIFY_READ, target_rnew, arg3, 1)) {
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return -TARGET_EFAULT;
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (res=
ource !=3D RLIMIT_AS &&
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 resource !=3D RLIMIT_DATA &&
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 resource !=3D RLIMIT_STACK) {
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (!lock_user_struct(VERIFY_READ, target_rnew, arg3, 1)=
) {
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -TARGET_EFAULT;
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 }
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 rnew.rlim_cur =3D tswap64(target_rnew->rlim_cur);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 rnew.rlim_max =3D tswap64(target_rnew->rlim_max);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 unlock_user_struct(target_rnew, arg3, 0);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 rnewp =3D &rnew;
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rnew.rl=
im_cur =3D tswap64(target_rnew->rlim_cur);
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rnew.rl=
im_max =3D tswap64(target_rnew->rlim_max);
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unlock_=
user_struct(target_rnew, arg3, 0);
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rnewp =
=3D &rnew;
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D get_errno(sys_prli=
mit64(arg1, resource, rnewp, arg4 ?
&rold : 0));
--=20
2.20.1


