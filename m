Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3258C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 19:22:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F59620578
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 19:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="AdZUvyJ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F59620578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAI3R-0007Dp-Or
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 15:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1kAI2Q-0005w7-Th
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 15:21:50 -0400
Received: from mail-eopbgr70128.outbound.protection.outlook.com
 ([40.107.7.128]:6919 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1kAI2O-0006qi-Nc
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 15:21:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0JEmzJfb0xMi/vRStssN4UJ59i6csxhZ1FruBqGIobOJwh4HTEH0DVeMkC0oK2b9hEpSlR5WgffdXy2taBHpT/XhWj2aWHW3gS93sNe3zOEJcX4x7QspLEWt6lpKuRfMHrDOwEsc4I7XBFyKh7CEeMDlfF99obWqbblYTxBVgfyKyEYDI1Fq9+IilJNHUKlEL25Se79eLfqWV9Ig+dlNH7of0bIDwSrTllN5S/sBUyAek6xFimMbyja+JgI5aN5QgPrx2Q1x/jZMG7Ez4krlTl1SyTMpKe1UjbZYxO3Uw36M8KPJC05BvUx33h4jdWxuibFWFcPaEaTZLKhyimdjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7nBWuTR5c7BYDKK426It8dwWF6GornGuzvQ3D/NuvI=;
 b=heQ5Sjfr8j/yCFnhPPderawDVMLk7LQwuKas+sL/4nxmB2c1c2IJ3NZNuvJh7EuXW95ElwUpJAXEe/tfVz21hgazH/8p1a510216yQ9SuUvol1SqIu+NFh9RizCivCkW0bkcpc0OWfcPMx/rc9YGSTuL4ChmuNegg++d+NH8WGaUFuBqkYqRboyiR19s3avJjV1dpgK5dk59WhsZoH7ZIGT3C8Uwr/gbycC4Jhgh6g7ItZec/dTRQKkGYVgDz52DcljJIUkljR0xz/AdChDOh2S6AkWNwXCiNu7anbrgtlSpHM83rdOWEyuUjolnoKn9H+wtoAJDKTYJ4oXoJTbG+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7nBWuTR5c7BYDKK426It8dwWF6GornGuzvQ3D/NuvI=;
 b=AdZUvyJ2VXyRdI2cdifCl+MPAVvgwwKs4zikkCe23s9sHRgFdMtTA3ty/pGA+3QoAzXWDPdCQ1TLjEnk2SUMvJlyDuI78uB3c+TujT42Nhkut3zy1tPGdcdHf3lYSUFKA+rvJ6J8f8ceR5XAiH5D1aR8omQY/hp5+47etC3rYRk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com (2603:10a6:802:a1::22)
 by VI1PR0301MB2254.eurprd03.prod.outlook.com (2603:10a6:800:29::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Mon, 24 Aug
 2020 19:21:32 +0000
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362]) by VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362%6]) with mapi id 15.20.3261.026; Mon, 24 Aug 2020
 19:21:31 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/2] linux-user: Add support for 'clock_nanosleep_time64()'
 and 'clock_adjtime64()'
Date: Mon, 24 Aug 2020 21:21:15 +0200
Message-Id: <20200824192116.65562-2-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824192116.65562-1-Filip.Bozuta@syrmia.com>
References: <20200824192116.65562-1-Filip.Bozuta@syrmia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0017.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::27) To VE1PR03MB5246.eurprd03.prod.outlook.com
 (2603:10a6:802:a1::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.238) by
 ZR0P278CA0017.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:16::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Mon, 24 Aug 2020 19:21:30 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.238]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1527809d-c0b6-4da9-26ca-08d84862e7e6
X-MS-TrafficTypeDiagnostic: VI1PR0301MB2254:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0301MB2254ED0632D298AFB08C3B3EEB560@VI1PR0301MB2254.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QpkIB+9KDnXp3d4xKUmj2+Qhg/56OzyRUnWVKdWqDEGQVzHp0Nb2vUoXVefwuG1xbFKGjQL994K7buXhJ9VC4R0ehNuGSBoKOLlB1ugNCvixlmr8XBGN97wVR/1eWalxZvZKtE6p9m4dAIktZQiZrrKPphXmLuVN+MSioVodlcXclb6jhWBJEoxLvUYf7pbeHn5w9kMHux2j7zr/+r3RCp0RJ3dTD/W50kLPhy62M73TomiA9OxT4SSyv1pXMldagAug02q1oYUiUdSMHiUiriVN0yxq03ip8Kw1Kk1qo5mJCNAHMdieMEFniPnRtQCM/Y/YhvXwgFyMzCYy4Mo8BN3BPB4vVF5EFFHLtatYTBfCnMqYaOyQLB+vPA7eOveVlRdHuJC0Koj/idwUB5lyy4EQ0a7nAnvd7WhjFZppb2455iDZGsUgSbKlwDQpmroTFhVtb75KolXbw0sKTvYDhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR03MB5246.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(376002)(39830400003)(136003)(396003)(366004)(6666004)(956004)(2616005)(5660300002)(66556008)(66476007)(66946007)(2906002)(1076003)(478600001)(4326008)(107886003)(83380400001)(6916009)(6512007)(8936002)(6486002)(966005)(186003)(6506007)(69590400007)(16526019)(86362001)(316002)(52116002)(8676002)(36756003)(54906003)(26005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: jeiflx+IHrl0DgX2UJuf5NOEEahjxh8AWbKBtMksfCMNhH1NAeQBHb63/lvDmK3T0AcpFSBe4B6/ZO+jXELc5lxYzLrsfAoCVhzzy5/UE9998qaIy//KrozV+O1+ixNasZ9jyrNOmadbA5OLQZ8hFQmjrZxsctFPN8j4NjhTM1njkCBaNSS5EMHFk+RfpNDxJKADlkUTmNxkUuSu19lslr7VMEErpLXEwZrxrQ3+wLEs+wPxTM/l0KqQe1vOAEcImMgGUTklc9lhVEwzCpvDZ2DoN8vZF+1n4QAeDRYQl3rQJ31w3K17oP2Auxk90spHlo71o4pc1zodjQvBSX4I+0n+QYjBM3bNUFvcZaniI5wOmnqdB4ewxJc5vlACv77wUX7mw6RbnhOx3zIcOC/9aThUk3k2ZqS9dbWvtkFWw7Ld3jdeT0Ys1JLx4B3hw2U9lTOu9IMLv6CnmaIoIkSduXxXBhn3/+kzc0C9xZDU+R6goz0RP9ZCq40Ry59LwDJ3vx/lGQ1P0k9h8hxehLA5wpp0VAsZO2rMhOu5qv6aCDLeIXSMAS0NzMahA+T8b6f2JBSHO+0wR87chHDWFX41nSn9S5UUMN/gEIknR8ZfpNRleXtPOc5jGbE1TBuDQAYFUDBg5ONWc0uqAioQiSsSyA==
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1527809d-c0b6-4da9-26ca-08d84862e7e6
X-MS-Exchange-CrossTenant-AuthSource: VE1PR03MB5246.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 19:21:31.0368 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B0YgEuTHwci24sP9pM2ePADGawVud1VvYl4SlANfkbgse7idCe0vDv8Hk5MuMv+yxbIHGtzn6V0DQfXK95PxZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0301MB2254
Received-SPF: pass client-ip=40.107.7.128;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 15:21:42
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch implements functionality for following time64 syscall:

*clock_nanosleep_time64()

    This is a year 2038 safe vairant of syscall:
    int clock_nanosleep(clockid_t clockid, int flags,
                        const struct timespec *request,
                        struct timespec *remain)
    --high-resolution sleep with specifiable clock--
    man page: https://man7.org/linux/man-pages/man2/clock_nanosleep.2.html

*clock_adjtime64()

    This is a year 2038 safe variant of syscall:
    int clock_adjtime(clockid_t clk_id, struct timex *buf)
    --tune kernel clock--
    man page: https://man7.org/linux/man-pages/man2/clock_adjtime.2.html

Implementation notes:

    Syscall 'clock_nanosleep_time64()' was implemented similarly
    to syscall 'clock_nanosleep()' except that 'host_to_target_timespec64()'
    and 'target_to_host_timespec64()' were used instead of the regular
    'host_to_target_timespec()' and 'target_to_host_timespec()'.

    For 'clock_adjtime64()' a 64-bit target kernel version of 'struct timex'
    was defined in 'syscall_defs.h': 'struct target__kernel_timex'.
    This type was used to convert the values of 64-bit timex type between
    host and target. For this purpose a 64-bit timex converting functions
    'target_to_host_timex64()' and 'host_to_target_timex64()'. An existing
    function 'copy_to_user_timeval64()' was used to convert the field
    'time' which if of type 'struct timeval' from host to target.
    Function 'copy_from_user_timveal64()' was added in this patch and
    used to convert the 'time' field from target to host.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 linux-user/syscall.c      | 137 +++++++++++++++++++++++++++++++++++++-
 linux-user/syscall_defs.h |  31 +++++++++
 2 files changed, 166 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 05f03919ff..a359bd8620 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -809,7 +809,8 @@ safe_syscall4(int, accept4, int, fd, struct sockaddr *, addr, socklen_t *, len,
 safe_syscall2(int, nanosleep, const struct timespec *, req,
               struct timespec *, rem)
 #endif
-#ifdef TARGET_NR_clock_nanosleep
+#if defined(TARGET_NR_clock_nanosleep) || \
+    defined(TARGET_NR_clock_nanosleep_time64)
 safe_syscall4(int, clock_nanosleep, const clockid_t, clock, int, flags,
               const struct timespec *, req, struct timespec *, rem)
 #endif
@@ -1205,8 +1206,25 @@ static inline abi_long copy_to_user_timeval(abi_ulong target_tv_addr,
     return 0;
 }
 
+static inline abi_long copy_from_user_timeval64(struct timeval *tv,
+                                                abi_ulong target_tv_addr)
+{
+    struct target__kernel_sock_timeval *target_tv;
+
+    if (!lock_user_struct(VERIFY_READ, target_tv, target_tv_addr, 1)) {
+        return -TARGET_EFAULT;
+    }
+
+    __get_user(tv->tv_sec, &target_tv->tv_sec);
+    __get_user(tv->tv_usec, &target_tv->tv_usec);
+
+    unlock_user_struct(target_tv, target_tv_addr, 0);
+
+    return 0;
+}
+
 static inline abi_long copy_to_user_timeval64(abi_ulong target_tv_addr,
-                                             const struct timeval *tv)
+                                              const struct timeval *tv)
 {
     struct target__kernel_sock_timeval *target_tv;
 
@@ -6771,6 +6789,87 @@ static inline abi_long host_to_target_timex(abi_long target_addr,
 }
 #endif
 
+
+#if defined(TARGET_NR_clock_adjtime64) && defined(CONFIG_CLOCK_ADJTIME)
+static inline abi_long target_to_host_timex64(struct timex *host_tx,
+                                              abi_long target_addr)
+{
+    struct target__kernel_timex *target_tx;
+
+    if (copy_from_user_timeval64(&host_tx->time, target_addr +
+                                 offsetof(struct target__kernel_timex,
+                                          time))) {
+        return -TARGET_EFAULT;
+    }
+
+    if (!lock_user_struct(VERIFY_READ, target_tx, target_addr, 1)) {
+        return -TARGET_EFAULT;
+    }
+
+    __get_user(host_tx->modes, &target_tx->modes);
+    __get_user(host_tx->offset, &target_tx->offset);
+    __get_user(host_tx->freq, &target_tx->freq);
+    __get_user(host_tx->maxerror, &target_tx->maxerror);
+    __get_user(host_tx->esterror, &target_tx->esterror);
+    __get_user(host_tx->status, &target_tx->status);
+    __get_user(host_tx->constant, &target_tx->constant);
+    __get_user(host_tx->precision, &target_tx->precision);
+    __get_user(host_tx->tolerance, &target_tx->tolerance);
+    __get_user(host_tx->tick, &target_tx->tick);
+    __get_user(host_tx->ppsfreq, &target_tx->ppsfreq);
+    __get_user(host_tx->jitter, &target_tx->jitter);
+    __get_user(host_tx->shift, &target_tx->shift);
+    __get_user(host_tx->stabil, &target_tx->stabil);
+    __get_user(host_tx->jitcnt, &target_tx->jitcnt);
+    __get_user(host_tx->calcnt, &target_tx->calcnt);
+    __get_user(host_tx->errcnt, &target_tx->errcnt);
+    __get_user(host_tx->stbcnt, &target_tx->stbcnt);
+    __get_user(host_tx->tai, &target_tx->tai);
+
+    unlock_user_struct(target_tx, target_addr, 0);
+    return 0;
+}
+
+static inline abi_long host_to_target_timex64(abi_long target_addr,
+                                              struct timex *host_tx)
+{
+    struct target__kernel_timex *target_tx;
+
+   if (copy_to_user_timeval64(target_addr +
+                              offsetof(struct target__kernel_timex, time),
+                              &host_tx->time)) {
+        return -TARGET_EFAULT;
+    }
+
+    if (!lock_user_struct(VERIFY_WRITE, target_tx, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+
+    __put_user(host_tx->modes, &target_tx->modes);
+    __put_user(host_tx->offset, &target_tx->offset);
+    __put_user(host_tx->freq, &target_tx->freq);
+    __put_user(host_tx->maxerror, &target_tx->maxerror);
+    __put_user(host_tx->esterror, &target_tx->esterror);
+    __put_user(host_tx->status, &target_tx->status);
+    __put_user(host_tx->constant, &target_tx->constant);
+    __put_user(host_tx->precision, &target_tx->precision);
+    __put_user(host_tx->tolerance, &target_tx->tolerance);
+    __put_user(host_tx->tick, &target_tx->tick);
+    __put_user(host_tx->ppsfreq, &target_tx->ppsfreq);
+    __put_user(host_tx->jitter, &target_tx->jitter);
+    __put_user(host_tx->shift, &target_tx->shift);
+    __put_user(host_tx->stabil, &target_tx->stabil);
+    __put_user(host_tx->jitcnt, &target_tx->jitcnt);
+    __put_user(host_tx->calcnt, &target_tx->calcnt);
+    __put_user(host_tx->errcnt, &target_tx->errcnt);
+    __put_user(host_tx->stbcnt, &target_tx->stbcnt);
+    __put_user(host_tx->tai, &target_tx->tai);
+
+    unlock_user_struct(target_tx, target_addr, 1);
+    return 0;
+}
+#endif
+
 static inline abi_long target_to_host_sigevent(struct sigevent *host_sevp,
                                                abi_ulong target_addr)
 {
@@ -9726,6 +9825,21 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
         }
         return ret;
+#endif
+#if defined(TARGET_NR_clock_adjtime64) && defined(CONFIG_CLOCK_ADJTIME)
+    case TARGET_NR_clock_adjtime64:
+        {
+            struct timex htx;
+
+            if (target_to_host_timex64(&htx, arg2) != 0) {
+                return -TARGET_EFAULT;
+            }
+            ret = get_errno(clock_adjtime(arg1, &htx));
+            if (!is_error(ret) && host_to_target_timex64(arg2, &htx)) {
+                    return -TARGET_EFAULT;
+            }
+        }
+        return ret;
 #endif
     case TARGET_NR_getpgid:
         return get_errno(getpgid(arg1));
@@ -11684,6 +11798,25 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return ret;
     }
 #endif
+#ifdef TARGET_NR_clock_nanosleep_time64
+    case TARGET_NR_clock_nanosleep_time64:
+    {
+        struct timespec ts;
+
+        if (target_to_host_timespec64(&ts, arg3)) {
+            return -TARGET_EFAULT;
+        }
+
+        ret = get_errno(safe_clock_nanosleep(arg1, arg2,
+                                             &ts, arg4 ? &ts : NULL));
+
+        if (ret == -TARGET_EINTR && arg4 && arg2 != TIMER_ABSTIME &&
+            host_to_target_timespec64(arg4, &ts)) {
+            return -TARGET_EFAULT;
+        }
+        return ret;
+    }
+#endif
 
 #if defined(TARGET_NR_set_tid_address) && defined(__NR_set_tid_address)
     case TARGET_NR_set_tid_address:
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 152ec637cb..3783c5a07e 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -287,6 +287,37 @@ struct target_timex {
     abi_int:32; abi_int:32; abi_int:32;
 };
 
+struct target__kernel_timex {
+    abi_uint modes;               /* Mode selector */
+    abi_int: 32;                  /* pad */
+    abi_llong offset;             /* Time offset */
+    abi_llong freq;               /* Frequency offset */
+    abi_llong maxerror;           /* Maximum error (microseconds) */
+    abi_llong esterror;           /* Estimated error (microseconds) */
+    abi_int status;               /* Clock command/status */
+    abi_int: 32;                  /* pad */
+    abi_llong constant;           /* PLL (phase-locked loop) time constant */
+    abi_llong precision;          /* Clock precision (microseconds, ro) */
+    abi_llong tolerance;          /* Clock freq. tolerance (ppm, ro) */
+    struct target__kernel_sock_timeval time;  /* Current time */
+    abi_llong tick;               /* Microseconds between clock ticks */
+    abi_llong ppsfreq;            /* PPS (pulse per second) frequency */
+    abi_llong jitter;             /* PPS jitter (ro); nanoseconds */
+    abi_int shift;                /* PPS interval duration (seconds) */
+    abi_int: 32;                  /* pad */
+    abi_llong stabil;             /* PPS stability */
+    abi_llong jitcnt;             /* PPS jitter limit exceeded (ro) */
+    abi_llong calcnt;             /* PPS calibration intervals */
+    abi_llong errcnt;             /* PPS calibration errors */
+    abi_llong stbcnt;             /* PPS stability limit exceeded */
+    abi_int tai;                  /* TAI offset */
+
+    /* Further padding bytes to allow for future expansion */
+    abi_int:32; abi_int:32; abi_int:32; abi_int:32;
+    abi_int:32; abi_int:32; abi_int:32; abi_int:32;
+    abi_int:32; abi_int:32; abi_int:32;
+};
+
 typedef abi_long target_clock_t;
 
 #define TARGET_HZ 100
-- 
2.25.1


