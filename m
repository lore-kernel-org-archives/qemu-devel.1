Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E668EC2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 14:14:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADFFE20661
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 14:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="EmocC3N2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADFFE20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyyyI-0000Gl-Mv
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 09:14:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45730)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iyywK-0005bW-UQ
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 09:12:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iyywJ-0006q5-V3
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 09:12:32 -0500
Received: from mail-eopbgr10093.outbound.protection.outlook.com
 ([40.107.1.93]:59717 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iyywH-0006Pw-M8; Tue, 04 Feb 2020 09:12:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FP/iyxRwOP3FxzmdgxUtQcygpJrR3GBI37DlHw1dLSGi6k8lFPQo79jawTp/31ho3h/X6y8gISthNRQt/8ALymje9p3UUjH0LQLbKzCSkXNt/glPMTdwqNkt9tmRjl+tRB80eQPE+QTt7DIKhl4NvSVh9850vUvF60/St7CVYO59/1lw615GSJrD888wmD0/KgODUZLep3iUb0kE2QdIHbzqOC4Zz2OxduzepowWgKlMCzIAr4B6UTANXSH7SEmiNafTMElpJZ717oK5vEjliZe5UUf4zl23nJ9MfC3+cKeKpYaoJigbb/s87h9jhHGuOc3vdDfDpLgkI2OQyr9UHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0pZh5sVDqRUpTT5FYywEq8vU0/2kkBdK43fPfJ7yvs=;
 b=fv12kDbYw8vHNTqKmKl3E62LSVsGkHNV+FeQOUh3epJRXGvVmYS8b55fnyAtYAiPBD1RQMpkI8PlCIQ5XWAX2aytRCsAfCGLtwKjKAk9Aw39a8BnyRcHlIekhO+yzelUbdLYtlRkrtj0JSB9q6Q2QC8GP/x5ie/CW7xdqVnArF/+C/JqbCzT1iuUFZ6EARdtSewt2HQz3gkOEWAiGq3o+Jy19iSG5hyYjHUtv54bbPJXDrFg8FThJzU6Du5c6Pw2gz4UH/uirShPrXVjqpcgJ71ypsxTG0aVYCpTiWFjW8ZcMpxk8/FFOXLEq2sInkdZesXfN36zPUDnUy3ytFs0hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0pZh5sVDqRUpTT5FYywEq8vU0/2kkBdK43fPfJ7yvs=;
 b=EmocC3N2yNxPXbkTcjE0LnZ3kwQ1ZJ0P3n5dO+2CSC6DYuYbO3nLuN/nQ1ATtl9stBm86u67/zGHgzNq/twh4rO0c7cOU6vA/bJOgEZ+xVQ6EU8ns7H+aBuN+z9aTCGjew/GJC6dFUVqu6bKTCekIwtLfba1b25pAIbDkFxCaJY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3189.eurprd08.prod.outlook.com (52.135.163.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.30; Tue, 4 Feb 2020 14:12:26 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2686.034; Tue, 4 Feb 2020
 14:12:25 +0000
Subject: Re: [PATCH 01/17] qcow2: Comment typo fixes
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200131174436.2961874-1-eblake@redhat.com>
 <20200131174436.2961874-2-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200204171223511
Message-ID: <73563682-9ced-accd-9b61-01f446d870cd@virtuozzo.com>
Date: Tue, 4 Feb 2020 17:12:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200131174436.2961874-2-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR07CA0002.eurprd07.prod.outlook.com
 (2603:10a6:7:67::12) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR07CA0002.eurprd07.prod.outlook.com (2603:10a6:7:67::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.15 via Frontend Transport; Tue, 4 Feb 2020 14:12:25 +0000
X-Tagtoolbar-Keys: D20200204171223511
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a300ce9-4c7a-4efa-59ad-08d7a97c42c5
X-MS-TrafficTypeDiagnostic: AM6PR08MB3189:
X-Microsoft-Antispam-PRVS: <AM6PR08MB31891654C0145069A1F800A5C1030@AM6PR08MB3189.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-Forefront-PRVS: 03030B9493
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(376002)(39850400004)(136003)(346002)(396003)(366004)(189003)(199004)(26005)(5660300002)(6486002)(478600001)(86362001)(558084003)(81156014)(316002)(16576012)(36756003)(66476007)(66946007)(66556008)(186003)(16526019)(4326008)(8676002)(2616005)(956004)(52116002)(31696002)(31686004)(2906002)(8936002)(81166006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3189;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DOnRMJtaekujmo9o3dXrLqqcpytEgfRxEOdqe2GG0V22D44NPeainaf1AMWp+xv6YAYxBnZEa8pZBOOqYc11hTvyudFnP5buojnLu278zu7ZB8YmMdCaiqkqJshsTRNbrA+XA+3dExgvJg9qHU38Q61PCLHiInQbM4d3vbdvLk1ydY7CIoMeLMwcrfc9slY7iyocdJ6gGNaSHiE9rvlwr3LzXQYhJWkKjWEm++BceE3zeLbmUby0JjXUOfO/VQ+0p2sGZWb/iI3DFe5udtzK6VRi+lGjdR7Vcekuhpf4jbjfDLRWR5DLqjzr8JRo71P28AsFoRUrH5w+OpIckRVQKng+xCmHiltUAq54yLs6xsRIv+X4jpgUgQaKrzL7/n8W3Nt6EGNJMa7j4B9ybOEgG4DrWFmEtPTPEgQtFA3e6AA/JX1SG6vj/70Qj45ZIWkz
X-MS-Exchange-AntiSpam-MessageData: Q2vleR+sj4S5t1hlPJu0IiP8Mx2+E66ScdzQGO9eCWVKZ6cq2XJ8ZLNi5b/0XoajS+VLTn2JvDEesKUWyCKPmT7BuojIvNWhXPkIgolsRrXFAYNjxZtPRXBCoHX4DXKuS8czn7Il8DgehFVTDRcUkw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a300ce9-4c7a-4efa-59ad-08d7a97c42c5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2020 14:12:25.8982 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sywlwHTCFCjFwU8wffy4kL8QSszEyDhtnqdZkMlfHepNeZZazOERRAsF9Xuti7QpXakahqCBPyWvADkpr2Ckif5OYNakBD9BEPYTtGhcZuQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3189
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.93
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
Cc: david.edmondson@oracle.com, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

31.01.2020 20:44, Eric Blake wrote:
> Various trivial typos noticed while working on this file.
> 
> Signed-off-by: Eric Blake<eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

