Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE100C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 14:38:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88DDC2075F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 14:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="L7SXSBxL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88DDC2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjOLM-0005kO-JC
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 10:38:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jjOKL-0004j8-08; Thu, 11 Jun 2020 10:37:09 -0400
Received: from mail-eopbgr70121.outbound.protection.outlook.com
 ([40.107.7.121]:11590 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jjOKI-0001w4-Od; Thu, 11 Jun 2020 10:37:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZSA+eDZOIWXl1EClRTknof1vW1r1lcv6fbN+OC6YNckG6hpUTZXzynZ5JDkbyBcqIsssz1NksOqJg1oBAApkCHMz8MRmHfYVu4FINKGXSoH6c6sdhj98Y6S+YXeJcwnHH7n3sfR8Yhrm+H/kvwwvLrgeSMbOnID3iYmTftUoZCqX/5XVuRM1Uixc9KBd0ZLviM8d3oHUaxJNkgkKa4t2qjan2PRyNVmczxpBEGr4692qFrnHw4izyydNpN6FfrHrYjJ6vlc88wjbHLafDEZSJhkS5s7RO6dXoxcduYWMslSgxtR0x6LXzkAzjFHcW9NnoRWVG+1h1It0mwHFg1k7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvT8cmqH004fMvnWFpUwzdQX3em1j5adDL1wcNxoPoE=;
 b=dU/R7YGF8FjuSXchGO1jPSMiccslISrfNl+FdUAQGvY+WD48wQsTNlqB5jHUAaxtO2AwIJMxpBQLO4R9GkaR2pXesSlW5Coxig0VUSzg05EnmthdeG3L8/10BevaeWqu48vmY6WpSNgvHnXZnMyK9/c+wi7c1qoyQurPz2wL856N3KWGYyz6Jm9dskW5Yng7WWHQqxeqmOjiL8d7CDEugHletyTv17gKLe4M4dEYVhYAUGnIlVuj7u5ssA6v74R0ZacbGJziIesU5tx7UwmTlBDZjEpZXBumfMyeAumXhGd1YJ1RTK3mLyRElLQUNlC4zP5lauwUhkpkxV76p4uQyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvT8cmqH004fMvnWFpUwzdQX3em1j5adDL1wcNxoPoE=;
 b=L7SXSBxL5QYwWjhoxPgg9VcNF+LVnk1GLBM6LEaqDbFeh5r3ZuwmkWpkv0PyF3NnjfSTggfkjBDd0TgsGGeg+zig/15V353EJ0L1DfAh260ER0CJkXbcrXhVqG761pARcN9tDO2OkQFBwLBF/VsFwyju88B5pizn3c1v9KCq9hE=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5301.eurprd08.prod.outlook.com (2603:10a6:20b:dd::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21; Thu, 11 Jun
 2020 14:37:03 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3088.022; Thu, 11 Jun 2020
 14:37:03 +0000
Subject: Re: [PATCH v3 1/4] spapr: Simplify some warning printing paths in
 spapr_caps.c
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <159188280345.70166.14940592691021389043.stgit@bahia.lan>
 <159188281098.70166.18387926536399257573.stgit@bahia.lan>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <6d81d0ab-5993-83ff-0344-23dd079f9e15@virtuozzo.com>
Date: Thu, 11 Jun 2020 17:37:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <159188281098.70166.18387926536399257573.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0P190CA0024.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::34) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.159) by
 AM0P190CA0024.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.19 via Frontend Transport; Thu, 11 Jun 2020 14:37:03 +0000
X-Originating-IP: [185.215.60.159]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4bcaa285-7185-4b71-a3a9-08d80e14e86b
X-MS-TrafficTypeDiagnostic: AM7PR08MB5301:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5301796168F5B3EA36D44598C1800@AM7PR08MB5301.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lzMPdZPjryYg9xNGC4KYOJuovLAS01ZJGO3SzK4oOYw/AI4dwAUt3OFlUNQaEltf8j/ljqnDTd1FwC5PR/0LhBAnImBnL+UlM3NqWfvbEf8NfzFBI2SwAFoLby0zrX2vxY078ByaIq+/wMsptEVruR7gCa7dh3z4QXG5H/Y3f4KKl/wgpp0knYvO0WGZLyc0h1up5VbrbK2ChiPneAyS3w9ocDD3J+6nCssbques0Zw+qDNo4f/XMppO49t3S9UpgBijU6D6ktrBxbneilcA5NNKJ3lF/Lbb+nR8SxH167AVj6CUOtFx/v/CgRGY12/K5BAJwuB3t7B7HEPWMOvnb4xcG1bY3z4WA5qFPuSUxzd4iZh6OuRfgk+oqCbjuSoc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(39840400004)(136003)(396003)(366004)(478600001)(26005)(186003)(8676002)(66476007)(66556008)(31686004)(36756003)(2906002)(2616005)(956004)(5660300002)(66946007)(52116002)(8936002)(16576012)(6486002)(110136005)(31696002)(4326008)(16526019)(316002)(4744005)(86362001)(83380400001)(54906003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: xv0na6cwUBno9oUbnVIEwj1X4JhRAvM+OdR+06VDs3j4Y64tuNtw8Hg4OydOhXvw51KbcUEm7IR0rEBErxgbm6A/ot+3jd8KFhXA2c1AIDalRHhjXuRT9o44iGLF55SapmIWbBk3MQN48V72aJFKR//O329I1lxmF4lYwUPbcy4zd/c/UKBrNyQRfb5AzkWNbJPOL194dJLl+TQmSox0DmA9VthvJ+53DV19cKqbtppPm71YM0s6rDscAzBsmE1dz1xnsB8YQDjAAUdtAjJnemJrYBN7PMsbpp+PvVP0yZayPqjQwRxiDXe5k4evuLU2RBJvmuFIOAWA7YpfYV0oqijrwnYWRtPSxSXDbS1SrAjWoRYTRBhZeN61/dupgvf4jT5UY0ijvqZHlKEcIWRpJ39vLVBBy2vM+GWo2puM9I+0iYhF1cuBd4SZYVVC+I32/U9jrCjKdnozWPGtwqPQqWJPZi14R7i925heTBpafBpkc6RcAA3pREBSfum3y3cZ
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bcaa285-7185-4b71-a3a9-08d80e14e86b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 14:37:03.6210 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MItQ/3ITWoTRa+F6Cka44vefgc6SKb0zO9kU9gt11oUOC/v955Qm94vFEZA3i5etrTIuBOFe0449PDM9G0lEHnde23yORW17Dtw24Kt/cnc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5301
Received-SPF: pass client-ip=40.107.7.121;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 10:37:04
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
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
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

11.06.2020 16:40, Greg Kurz wrote:
> We obviously only want to print a warning in these cases, but this is done
> in a rather convoluted manner. Just use warn_report() instead.
> 
> Signed-off-by: Greg Kurz<groug@kaod.org>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

