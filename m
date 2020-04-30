Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22371C8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:49:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF8FE2074A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bJjd37qj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF8FE2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU8cm-0007HC-0N
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 08:49:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40564)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU8bK-0004L8-Ba
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 08:47:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU8bJ-0005lY-8J
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 08:47:38 -0400
Received: from mail-vi1eur05on2137.outbound.protection.outlook.com
 ([40.107.21.137]:53184 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jU8bH-0005iG-At; Thu, 30 Apr 2020 08:47:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xd1gmbQNUyPak4PtFxaKvvhApCznmI8SogptV5pTGodn1W0Ul0/VlHOO2TDFCpDSTmK7Ei3hCPo5CJVkR40c+i2AXc9lVu1q3QWRkRACeZ0nz/oDPG6IOML3cr+A9F2A5AcUfk3LyEddUUuM83IaUDs2EiKrYRASfuDF9e/GIya1WdBrcrJ0Ug0eFAbxYAfYmUi7Jidbeq2TqvsPzztg671bC6jOqV5OO4y/h5rmVRupsOQQGBaNykGLZiPbaWbDB7mAi+qJZ3sFJrlypiAMsbOEz3NsI0nCUsenxusXP5WdSMtro7hlAof9uroquG1EZlhrr2tY3diDusor+uPGyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQeDoIljBSEuz6kudeTyXXzzXYTa7DbJJ11tHAlcnOs=;
 b=clOySBrvTN6hxicV32Kz7JYP65nrPjIhxRn89/8wJtya7WCvpH/CHx1JSDQ1t8jQxYA+c2ugJ2WJZQ3d1sUKet1f0O6pMhQRRzkoBsxJRALmYUsgQPfRK3FbZIv1R/KQEuDMohE0M8fVQIQOZ4tE9uZwe1kZEP0qNdbNMSne6hc57lCFX1k0fY5WuwVCzUPqkwk3lrKWwPHOIIUBfaT0TxlsoBJfKPnu0ah6ZVL9hObprM8yfPV55NFdKlZW1QoNTSaQjmb0SOIJRWjVNdMbfoakAh4dN0tQtcyZiVsqvDu1q23qMh9RRaUKkHK1YRmosyLLQl1RS0cm/AyFG44X3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQeDoIljBSEuz6kudeTyXXzzXYTa7DbJJ11tHAlcnOs=;
 b=bJjd37qjs7zUN/PDNbUwBUF3u8YjHIM/xqoZM0zxAMPPs9CIh+tBoLVKsyliAa09DryfyIIOpVyBMDujsTnmZEpgE5k3RCU+zhYQE/w6B9QRcfdhIaMiQTkFfOJeJSzrhC6SxVzOrla042J99V+T3eRMSOxJpnTgVFpPECyvW2k=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5478.eurprd08.prod.outlook.com (2603:10a6:20b:107::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 30 Apr
 2020 12:47:31 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 12:47:31 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 3/8] iotests/148: use skip_if_unsupported
Date: Thu, 30 Apr 2020 15:47:08 +0300
Message-Id: <20200430124713.3067-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200430124713.3067-1-vsementsov@virtuozzo.com>
References: <20200430124713.3067-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0001.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::11)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.138) by
 FRYP281CA0001.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.20 via Frontend Transport; Thu, 30 Apr 2020 12:47:31 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.138]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70cac734-a9c2-4d4d-cdef-08d7ed04a5e3
X-MS-TrafficTypeDiagnostic: AM7PR08MB5478:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54786CC77554F47558904EB6C1AA0@AM7PR08MB5478.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xF8v8WE01kUovcDm0rtsvJuZe5AO8p51wgENIJ8Kn0Pi+9hz5a95Fbq9WjsjiEGuYlOpUB85faO1neXNUlAzc2nrvKUkJaeFryW+egMv4uS3R4/i2GLRwGieqqxulb+yS0wolidud+3uDihhtM1h+VFdSUbBYvNihYGba7gSoIJAk/T9G6WVnI47WMgPcLxtIsPUv66CJieSvv0hNZPKHDj/Zn5HjTDPGFs5WqeApmA+XPlHs7lleNI0h7mCP9hO6S/ZvKhs5szUYAOecksDbjg16O6pR5cOfueowkdWWDoKQVFyID830K39r8pnergKR4CEMSuNIqMv5KSRDf1N06t1iUYiG5aIl+Fv6c5u5PpdHbXDG7BZr5qrgf/cwzK1efhjPX2RPhcR4b/IHEjvTcALaRgJRsPkjW52vFsMRRLmVOQEHqWiYu1ogkh5RAoE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39850400004)(376002)(366004)(136003)(346002)(316002)(2616005)(6666004)(956004)(2906002)(478600001)(107886003)(4326008)(6486002)(66476007)(66556008)(66946007)(86362001)(36756003)(6512007)(16526019)(186003)(26005)(8936002)(52116002)(8676002)(6506007)(1076003)(4744005)(6916009)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: SrbDylQfiiG7SMA5B6fTEhnTc2OhHIoI0RJtQdD3xJkib+9JU58va8E62bvi2Y5kJwQopVdr8X/tRzqXm+7F3Me/6TpGlBunQ1OOUn7+6M1XN7YysiBvk3MOyhyYHC4gGoRZSrWP98G5h4p1Q9W5ZzG5yIeZ6R9csTAdUkb4HMRHmExMpsWGyRWD82WOroCjQSLRaLNARJi2oBr7QF8JRul5ZQGQXNjdMuZEz0+tGp4Xi1mlu2fRrZ69mRv0bRfMuqtoND30WQuw0fJOnGraWlIIH7wNAsMi6KWoVQU0UGVeNL9DQDl9/ejpkvp0I5gNJh5jcLabmxoyvnkprf30cOdfVGihD9m5uFeMtozrD4eugqL4AjWSWuljbNaozr0u/apTHQxt6J/5pxFJJ7/clmITsLqhD5zWI8xU4VhR8XNvc1dFdcNkl3ds0NBnzPkHKQGpLWQtCRCZxIF6d9jTQgpoQ7bMeNUcRGIrQ8PKeVKaDvONeAu5EfqKRaE+xrX9iQ3zn72w4WyJPX9n7+37poQQq/10DarakPka9m5BKqc4NUyrUBG33JbjPpjiXsvP1OlhOOr2BSaYdqBW3lgwI/zw40f9UWEdM61kX0nKnQCXPX1iBCF8AYE+AjfYTJHDGXgenpjIE0A1ZzphrdYft+mR66FvCBa+jNmiOKxL66EiAV7ANAIicpcUToZdtYSMXRTRJCZUsswdS1qgRybs5Ufgn8kuPJ09MjdWK1WqI9wvR5GMbmXNgwhThE5VIzRj9qo0NNoS1dlGE2fubudoxy4eKEfcP6NIw8eOiq+XBDA=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70cac734-a9c2-4d4d-cdef-08d7ed04a5e3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 12:47:31.6918 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fSixBF3wVkbIe9YI9ByGDQ+s2BrucsnrO/ycZKsBsDnjEMdm8Cu7/8dQXLqaQ3W8ok/5GH+/HNMMab4Hj7jpPUXta9oL9r3TDpFa5WOxsHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5478
Received-SPF: pass client-ip=40.107.21.137;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 08:47:30
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.21.137
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Skip test-case with quorum if quorum is not whitelisted.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/148 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qemu-iotests/148 b/tests/qemu-iotests/148
index 90931948e3..5e14a455b1 100755
--- a/tests/qemu-iotests/148
+++ b/tests/qemu-iotests/148
@@ -47,6 +47,7 @@ sector = "%d"
 ''' % bad_sector)
         file.close()
 
+    @iotests.skip_if_unsupported(['quorum'])
     def setUp(self):
         driveopts = ['driver=quorum', 'vote-threshold=2']
         driveopts.append('read-pattern=%s' % self.read_pattern)
-- 
2.21.0


