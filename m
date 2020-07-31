Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A9DC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 19:09:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8987721744
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 19:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="tZQ5Fk8T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8987721744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1aPR-0001mB-TI
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 15:09:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k1aN2-0006Ym-78
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 15:07:08 -0400
Received: from mail-am6eur05on2132.outbound.protection.outlook.com
 ([40.107.22.132]:59583 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k1aMy-0002Mw-HR
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 15:07:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gpqeVh6u3Ff+BY0slhSDDYi/uo5E4SR9uXTghOnQbUPjZyMYCrGaMGuf7QK9TFayGlF3bFb7UpI+Avs3SDeQjht0cU4Fjw+0Dn8ntUFt07SP78kw0H9KlPrc94xGJ3UsvDVS+hKdr/zMlZSEVq+dijBFgae1fUUfpMX779DdU0ZRc2/rXMLTUvOeDbjKjAReqVCMlCoPvsDshM5gV2edz3wcwh3QDt68j/s5IwSI/x+atOolnaqMiPAIND0poSsl1NMs50s4Dk6bqVbIc46uZIuqrGZJZXIf+d2e8Oxug4mk5Qmo+UQRN4I9OSUIswA5xu5h/0IWtv8iT9RlsNpA6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKclw02c0T6RMOCR7gCOHfKzbJb4MchvU5i+3wNOd/0=;
 b=OE0d6fDln28cOK++KfQ7RKQFc3j7/QOizQhQ7VDAsLwaadf0p1ctj5pDUoMaa2d7dL0aUCMinDwpha2nGS/NVk5rTCKKzFg02Uu73+EjCvJ4gZQPRwTyFWH6iedY/5QBQx7t+VNitpDmoLZipoQd/qRtbnncNLQZuY+9FEQ45uU9g/4DhV4Ee7Yeq5/1NNSJVMrcDyZlLWk96OWtLFEMDOILgHasE0lPb8FGwPEFk5H0MtRCUWsd0NE7+Zv1q1GlZ7eeLGZidaujt5sdzexfSx14vSlO9TdJonsG9pgCOMSb46gXXTqLH3JvAwSBkmpKWbDoRdJGE4a+O+LVaS9kUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKclw02c0T6RMOCR7gCOHfKzbJb4MchvU5i+3wNOd/0=;
 b=tZQ5Fk8Tu2n926jpaZ/+j6SPQNQVkyGGU7W1roJLSgWlBE9ofK+W0LHxc0K/FcOhbGz6CuVBsq4B9e2Zrsu6t2eyCvRHaXjJlUgxUpq9x6CkNRf7+zoD2t4/Th8AutptpLFXTeuNF6+jc8otW9iWmddJaJIFu8NQNc0E1zDca3E=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM5PR03MB2884.eurprd03.prod.outlook.com (2603:10a6:206:1a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.26; Fri, 31 Jul
 2020 19:06:53 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3239.020; Fri, 31 Jul 2020
 19:06:53 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] linux-user: Fix 'recvmmsg()' implementation
Date: Fri, 31 Jul 2020 21:06:36 +0200
Message-Id: <20200731190637.66698-3-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200731190637.66698-1-Filip.Bozuta@syrmia.com>
References: <20200731190637.66698-1-Filip.Bozuta@syrmia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0002.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::12) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.235) by
 ZR0P278CA0002.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:16::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.17 via Frontend Transport; Fri, 31 Jul 2020 19:06:52 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.235]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39f6a098-11cf-4227-890c-08d83584e2ed
X-MS-TrafficTypeDiagnostic: AM5PR03MB2884:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR03MB2884EB484C49F456A4F56FB5EB4E0@AM5PR03MB2884.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NiBMvEszE3EDyLwNWsG5NO36FrHqdpKetpQyjD3JRlgRYLuiLHjzQmJkQHZBRKc8VYvFBqLeVgo+QFsVVnYfkmPGCLoqV5KKj77jhCPycR/2kQot9CZyTCI4FmguPpMhuOUwYNh1XDvM058RWPh8K/Uh7auL0OsMduEHQTS/ET4noJp3XHsw7seAAcAkpfKI+UU6VPfz0vloeU1uFPXzRs4EVKU6vWY6/LMUA/VYmRofSo4ufb/JO8EYMNePb/QeXKwH6+aMInm/I0TPvKRBpLiS/h/eGrVLcH7t8ZDyf9rKg1UGol0S+4R5DlmonwBualFNwpeJGGdYmzWEpOhXs5izWVYTL1i5A2GkAubd7uEBenPL1JW5/jZ09EScAj5C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(396003)(39830400003)(376002)(346002)(366004)(136003)(6506007)(26005)(66556008)(186003)(6486002)(107886003)(66946007)(69590400007)(2616005)(66476007)(54906003)(6512007)(8676002)(2906002)(36756003)(4326008)(16526019)(5660300002)(52116002)(316002)(6666004)(83380400001)(86362001)(508600001)(956004)(6916009)(8936002)(1076003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: vefNGuoCb36TZTAGNcnZVzDsnYrbVoaaMR8MOxQvBqmJGgGmInQ9DUKTS/y6rAmv/3V/XxSlDY5U7M9kS2YyOzA4YibekZqMjpHELXEZAoQqh0ynU20TgH6kX1DehHDFJOoncnYnYavxxH1xnryxl41PObjAupfNK00V6wBgvsLRUjuOhMBjriL11dZUJBDuQ9DZM/+KAFbiTOh95hLuwcoXqPq+UXkRe+aFBVE2SvUnt3htmKlSZPSBczPpMn18xDoQ+g7ik87Xwt2ViX3Mhp1H7tv9+4yM0/1ls1Rh8P+4yNTGmGFjET9V/C55ts+TGKITggmWNo1urkS6vDrDEYflG//fWNwGbVIw+yC4DHLPwQPtG3NwutSVWU1hginNCemkjbiONGbv8l7yJaEwdHGR/ItdwDEyL1Nnzl1WVz4dISmda50egRnAdT7db2O8HjFQIcsDtfkCGL+3/l5c73WiDrJ4llDA4G61Y6CEzds=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f6a098-11cf-4227-890c-08d83584e2ed
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 19:06:53.3977 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LQu+qing3Z8Pe1nm3ad7Zi5x6ct7rBuF01BOtPTWV7ZM0cJsNNAPuRkzSOZLeehuguTJvPIioXgRvepFySbyEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR03MB2884
Received-SPF: pass client-ip=40.107.22.132;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 15:06:59
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

Syscall 'recvmmsg()' takes an argument which is of type 'struct timespec'
that represents a timeout for the receive operation. Before changes from
this patch, the timeout argument was ignored. This was probably due to
the way 'recvmmsg()' was implemented with looping over 'recvmsg()' which
doesn't have the timeout argument. This was changed with the previous
patch in this series and which is why the timeout argument should be
added accordingly.

Implementation notes:

    Function 'do_sendrecvmmsg()' was changed with the addition of a new
    argument which represents the timeout. This argument is only passed
    in case of 'TARGET_NR_recvmmsg' and for 'TARGENT_NR_sendmmsg' 0 is
    passed. Function 'do_sendrecvmmsg()' was also updated accordingly in
    'do_socketcall()' for 'TARGET_SYS_recvmmsg' and 'TARGET_SYS_sendmmsg'.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 linux-user/syscall.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 8cbefdb561..420d7e7334 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -3217,10 +3217,11 @@ static abi_long do_sendrecvmsg(int fd, abi_ulong target_msg,
 
 static abi_long do_sendrecvmmsg(int fd, abi_ulong target_msgvec_addr,
                                 unsigned int vlen, unsigned int flags,
-                                int send)
+                                abi_long timeout, int send)
 {
     struct mmsghdr *host_msgvec;
     struct target_mmsghdr *target_msgvec;
+    struct timespec ts;
     abi_long ret = 0;
     int num_sentrecv = 0;
     int num_iovec = 0;
@@ -3275,7 +3276,14 @@ static abi_long do_sendrecvmmsg(int fd, abi_ulong target_msgvec_addr,
         if (send) {
             ret = get_errno(safe_sendmmsg(fd, host_msgvec, i, flags));
         } else {
-            ret = get_errno(safe_recvmmsg(fd, host_msgvec, i, flags, NULL));
+            if (timeout) {
+                if (target_to_host_timespec(&ts, timeout)) {
+                    return -TARGET_EFAULT;
+                }
+                ret = get_errno(safe_recvmmsg(fd, host_msgvec, i, flags, &ts));
+            } else {
+                ret = get_errno(safe_recvmmsg(fd, host_msgvec, i, flags, NULL));
+            }
         }
     }
 
@@ -3611,10 +3619,10 @@ static abi_long do_socketcall(int num, abi_ulong vptr)
         return do_sendrecvmsg(a[0], a[1], a[2], 0);
     case TARGET_SYS_ACCEPT4: /* sockfd, addr, addrlen, flags */
         return do_accept4(a[0], a[1], a[2], a[3]);
-    case TARGET_SYS_RECVMMSG: /* sockfd, msgvec, vlen, flags */
-        return do_sendrecvmmsg(a[0], a[1], a[2], a[3], 0);
+    case TARGET_SYS_RECVMMSG: /* sockfd, msgvec, vlen, timeout, flags */
+        return do_sendrecvmmsg(a[0], a[1], a[2], a[3], a[4], 0);
     case TARGET_SYS_SENDMMSG: /* sockfd, msgvec, vlen, flags */
-        return do_sendrecvmmsg(a[0], a[1], a[2], a[3], 1);
+        return do_sendrecvmmsg(a[0], a[1], a[2], a[3], 0, 1);
     default:
         qemu_log_mask(LOG_UNIMP, "Unsupported socketcall: %d\n", num);
         return -TARGET_EINVAL;
@@ -9418,11 +9426,11 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR_sendmmsg
     case TARGET_NR_sendmmsg:
-        return do_sendrecvmmsg(arg1, arg2, arg3, arg4, 1);
+        return do_sendrecvmmsg(arg1, arg2, arg3, arg4, 0, 1);
 #endif
 #ifdef TARGET_NR_recvmmsg
     case TARGET_NR_recvmmsg:
-        return do_sendrecvmmsg(arg1, arg2, arg3, arg4, 0);
+        return do_sendrecvmmsg(arg1, arg2, arg3, arg4, arg5, 0);
 #endif
 #ifdef TARGET_NR_sendto
     case TARGET_NR_sendto:
-- 
2.25.1


