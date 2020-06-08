Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97374C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:48:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FC0A206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="KlZVmVrh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FC0A206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiKx1-00088f-GD
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 12:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jiKsn-00036z-0d
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:44:21 -0400
Received: from mail-eopbgr80091.outbound.protection.outlook.com
 ([40.107.8.91]:62103 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jiKsl-0007Fd-9s
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:44:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXM8pHz+0rYtJYDberp6+2wOSFETHsvR0bA+eGeTY4vcZpn6Sqb/4Vp7lZI3g5VeSY4OBfMArMjoRzj5MAOPQZPKS0bumU4KxuJPrp5HJW5TXDEx1WCO/36zCHr4tsYKuQN0po8XJwtVUIyychljDfYrTtNLYSMrTwvI6a3OqcnTzEGLGZBESv0zMLmceaJUTSjP7DyoiL9cm7TMEW0f5JUk07nfGJ307zaIrwyyhZtscBdaPe36Vn0IsQ51yNIj16s8J196DZocbDoJzCYfe7tEe51a6C3ZCnnGXIJtWQ5RAh5kY3Z9rEVGzXcQgKWnYaVNOY2EmC1p0DZt1B0yNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bJUNo3V/2/CnSclCnsosB4WCMATua32ydXnuSKw9Es=;
 b=USJXMAhfRrAMET3VTb4V11qEraV4+e4nCGUbYEmC3o6pxtdaTQhxi1UqsStKZHkvX6EZ7/dDSryEj29r+04GbDgAmiGRlnOxKd4X23zNyuZxe/t1EPIl6HCX1C9yP7BxWs3fup1NDwmTIfM0D1mdMqatF7Lvf9b6rjldYZYeEWCCU0iyb77b1OD/v3qnVO62fMe98SZAv5SCo+z8Co+AwraBOpTRxUUtLbZxAONBXMuALMJ+59/Ko5DW5NjhzTQxhO80mbEOLA1bucDK0sw0b55yCfC0rIbHGUtBV28pR06UF60qCfNYYopZLPoiPIC2SBHdWnCRb+7NpX08GFFAdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bJUNo3V/2/CnSclCnsosB4WCMATua32ydXnuSKw9Es=;
 b=KlZVmVrhnMLoesvM0dAgmoEWioKa+a1G2M2G/NRrvr6fx7m8NdM+QPtAMfJzIhTbii7aQ3YBB4my14tmxkVpCwdEv/F1DvXznmvOJwi7jF8gnVsIxTJLxX9b0dRrSULVr8jgVjQL7pl6+3eCi82d1Rqo17bFfg6AOgU1Jp2I8Tk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB3798.eurprd03.prod.outlook.com (2603:10a6:20b:1f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19; Mon, 8 Jun
 2020 16:44:11 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 16:44:11 +0000
From: Filip Bozuta <filip.bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/6] linux-user: Extend strace support to enable argument
 printing after syscall execution
Date: Mon,  8 Jun 2020 18:43:52 +0200
Message-Id: <20200608164357.25065-2-filip.bozuta@syrmia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608164357.25065-1-filip.bozuta@syrmia.com>
References: <20200608164357.25065-1-filip.bozuta@syrmia.com>
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0016.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::26) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bozuta-ubuntu-18.syrmia.com (46.240.135.226) by
 ZR0P278CA0016.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:16::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 16:44:10 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [46.240.135.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ae5f8b6-8195-43f2-0191-08d80bcb2b60
X-MS-TrafficTypeDiagnostic: AM6PR03MB3798:
X-Microsoft-Antispam-PRVS: <AM6PR03MB37980FCDC7E18BFAC004319AEB850@AM6PR03MB3798.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e6E09thjq32e1K8Mf6Kc/A4NYGQdHGWxs8NHqUGnHVVNDiE0be2o5XxHfMStOWHPbrwFUQdnVa65Bu6vFwGTmuKbX15JnV8+NguXfxERHZj7TccI1deYSoJqtcafAz8Es9+b3retO2DNvJG8dBMwz5EMVc0XhXf50yPidCotHBwYBCtV3tCbxN/3hxSYfazio0i+tNhuZyqZyPkpwe7BBhAQEFbdnuxxPTOzLuJ9eUIgl+rQwM5mQTHLd2meuTKoCUzhUm8rxlPmBr7u1aNb+OSbpeXDnrAvmS32/f5JzY0o9Nhg2G3dSscpnFuFrHAN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(39830400003)(376002)(396003)(346002)(136003)(366004)(508600001)(4326008)(8676002)(8936002)(1076003)(66556008)(6916009)(66476007)(5660300002)(66946007)(86362001)(316002)(36756003)(16526019)(26005)(2906002)(52116002)(83380400001)(2616005)(956004)(44832011)(6486002)(7696005)(186003)(6666004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: mLx5vrDPfNCCPh/WAM/Uk7P3E7WDs/hE175jQJYL2EtZ9bd3jY++ivGuqx9F/Kp+7JzMFpNFjPZD64oZcocVwFRpTeohVWF0FMWXtwKoDUsevL7sOMADZVFOyEhrgRSi9g0FaheCzFkKzaJP3Po1f3nNNpg2F8BPxL1jroggjXomz74exTM7JOTnwoWWUozl8EMyTKz2w4fpzpvKyorjMmsNYjh0j8iGAdVHxrAkNWwZQiYYHg39BaeSK+MTue8dfw05jhsz4OdY2tI4DSqp1sq0CpHcYwatMUAdNEkg4uK6jDgH0llPjk6L+Mj4oQTC+jbIeB1CmlzLhbS+0pL52NZdAOZgrIqOU/1LYSyDxjagfloFOO9jxf6cFV9uYyPy/AxlwZX1687BA2sWQ8SmknwQHJJN+zS4/Ty+sDV0zDhH5g3YhJzhALG+JC9acvXecesKpmlEo//F7fUE2YMzWhh6IMByhnoPsshvq/9s0G0=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae5f8b6-8195-43f2-0191-08d80bcb2b60
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 16:44:10.9062 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fni+/SOhP3ec5WOq4yWS3dHSTHQ1xoTyoHZNkn1fqXJLPYtMBlIBz5ZMABKyga2rkS2fAugsK7sPCUd6vghoqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB3798
Received-SPF: pass client-ip=40.107.8.91; envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 12:44:17
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Filip Bozuta <Filip.Bozuta@syrmia.com>

    Structure "struct syscallname" in file "strace.c" is used for "-strace"
    to print arguments and return values of syscalls. The last field of
    this structure "result" represents the calling function that prints the
    return values. This field was extended in this patch so that this functions
    takes all syscalls arguments beside the return value. In this way, it enables
    "-strace" to print arguments of syscalls that have changed after the syscall
    execution. This extension will be useful as there are many syscalls that
    return values inside their arguments (i.e. listxattr() that returns the list
    of extended attributes inside the "list" argument).

Implementation notes:

    Since there are already three existing "print_syscall_ret*" functions inside
    "strace.c" ("print_syscall_ret_addr()", "print_syscall_ret_adjtimex()",
    "print_syscall_ret_newselect()"), they were changed to have all syscall arguments
    beside the return value. This was done so that these functions don't cause build
    errors (even though syscall arguments are not used in these functions).

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 linux-user/qemu.h    |  4 +++-
 linux-user/strace.c  | 24 ++++++++++++++++++------
 linux-user/syscall.c |  2 +-
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index ce902f5132..8f938b8105 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -383,7 +383,9 @@ int host_to_target_waitstatus(int status);
 void print_syscall(int num,
                    abi_long arg1, abi_long arg2, abi_long arg3,
                    abi_long arg4, abi_long arg5, abi_long arg6);
-void print_syscall_ret(int num, abi_long arg1);
+void print_syscall_ret(int num, abi_long ret,
+                       abi_long arg1, abi_long arg2, abi_long arg3,
+                       abi_long arg4, abi_long arg5, abi_long arg6);
 /**
  * print_taken_signal:
  * @target_signum: target signal being taken
diff --git a/linux-user/strace.c b/linux-user/strace.c
index 0d9095c674..23f7c386b5 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -19,7 +19,9 @@ struct syscallname {
     void (*call)(const struct syscallname *,
                  abi_long, abi_long, abi_long,
                  abi_long, abi_long, abi_long);
-    void (*result)(const struct syscallname *, abi_long);
+    void (*result)(const struct syscallname *, abi_long,
+                   abi_long, abi_long, abi_long,
+                   abi_long, abi_long, abi_long);
 };
 
 #ifdef __GNUC__
@@ -736,7 +738,9 @@ print_ipc(const struct syscallname *name,
  */
 
 static void
-print_syscall_ret_addr(const struct syscallname *name, abi_long ret)
+print_syscall_ret_addr(const struct syscallname *name, abi_long ret,
+                       abi_long arg0, abi_long arg1, abi_long arg2,
+                       abi_long arg3, abi_long arg4, abi_long arg5)
 {
     const char *errstr = NULL;
 
@@ -760,7 +764,9 @@ print_syscall_ret_raw(struct syscallname *name, abi_long ret)
 
 #ifdef TARGET_NR__newselect
 static void
-print_syscall_ret_newselect(const struct syscallname *name, abi_long ret)
+print_syscall_ret_newselect(const struct syscallname *name, abi_long ret,
+                            abi_long arg0, abi_long arg1, abi_long arg2,
+                            abi_long arg3, abi_long arg4, abi_long arg5)
 {
     qemu_log(" = 0x" TARGET_ABI_FMT_lx " (", ret);
     print_fdset(newselect_arg1,newselect_arg2);
@@ -783,7 +789,9 @@ print_syscall_ret_newselect(const struct syscallname *name, abi_long ret)
 #define TARGET_TIME_ERROR    5   /* clock not synchronized */
 #ifdef TARGET_NR_adjtimex
 static void
-print_syscall_ret_adjtimex(const struct syscallname *name, abi_long ret)
+print_syscall_ret_adjtimex(const struct syscallname *name, abi_long ret,
+                           abi_long arg0, abi_long arg1, abi_long arg2,
+                           abi_long arg3, abi_long arg4, abi_long arg5)
 {
     const char *errstr = NULL;
 
@@ -2847,7 +2855,9 @@ print_syscall(int num,
 
 
 void
-print_syscall_ret(int num, abi_long ret)
+print_syscall_ret(int num, abi_long ret,
+                  abi_long arg1, abi_long arg2, abi_long arg3,
+                  abi_long arg4, abi_long arg5, abi_long arg6)
 {
     int i;
     const char *errstr = NULL;
@@ -2855,7 +2865,9 @@ print_syscall_ret(int num, abi_long ret)
     for(i=0;i<nsyscalls;i++)
         if( scnames[i].nr == num ) {
             if( scnames[i].result != NULL ) {
-                scnames[i].result(&scnames[i], ret);
+                scnames[i].result(&scnames[i], ret,
+                                  arg1, arg2, arg3,
+                                  arg4, arg5, arg6);
             } else {
                 if (ret < 0) {
                     errstr = target_strerror(-ret);
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 05f03919ff..009bb67422 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -12441,7 +12441,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
                       arg5, arg6, arg7, arg8);
 
     if (unlikely(qemu_loglevel_mask(LOG_STRACE))) {
-        print_syscall_ret(num, ret);
+        print_syscall_ret(num, ret, arg1, arg2, arg3, arg4, arg5, arg6);
     }
 
     record_syscall_return(cpu, num, ret);
-- 
2.17.1


