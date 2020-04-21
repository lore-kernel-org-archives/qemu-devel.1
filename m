Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB7DC54FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 11:20:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26902206D5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 11:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LAmj92Nh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26902206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQqwt-0001zO-8U
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 07:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51890)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQqvu-000169-NX
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 07:19:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQqvr-00053E-QN
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 07:19:17 -0400
Received: from mail-eopbgr60110.outbound.protection.outlook.com
 ([40.107.6.110]:9415 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jQqvr-000507-2M; Tue, 21 Apr 2020 07:19:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJ5MB9xCnWWUYFzt0XyVxophXSawlkqnGjdEW6BNVYF+h3v0EQ5FE2ECZAYFnZGgnVpIK+PQK21+035tJgA6grnhm9xzZPiyTYO87yEdT6CT7zaIWi1YjfWSh8FnDSrvCbTYRaHxg4Sjs+3KokdW9W4OOANcJWGBeofeDUS7Gk718ATrclHTJJ3aT7RpNaz3gcgZ3gOQYmMZabEms/dmNWIO7R2ydou92jNtQhzdcUZi2j1NTQzKyA7BeDKv0KoFaEDxxXJf4jjRjvJWlh1WMJ2KmxY3zgADoZk8LkFCAudDMmn4O1R3HS3M8UswVm3R1baK4jZ3zI7/MtAZZzdNsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqrxhbETZnqtwVSCN+3qSrLq8jMw8LagLBmxIcDWWlo=;
 b=HptEmt0cZjbE+wMYqVGmwmoxOTGE6x6/bZVT4rmgR1g9LQS3+IGzfvsbndi1lg5eO/zBh2mwPOK7Nnx7Ze4nuH0ypo6bDkBntwWy9Zk9+FU4ikBfZTTOt/HAPJqnemcBIMfI3isJu5ZAzJOiF/sKTM6yJ+7BVahSv46w+/mNx6GV2hBH2/a4wKRzvHWs06osjUB/5CEynFOBr/m7BkhpwEVx/uZYfjPGuh/leAisIUQcdtZ4jYAdy7IyTWpFj7Yn955gPZBFyWTFB40wQogy6Y79TuLeZihpGOdgs7Y9NzmHuUNDWPCA2zAJX6udDbrPmiFeKOMG6tpWMy9xGp6Mzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqrxhbETZnqtwVSCN+3qSrLq8jMw8LagLBmxIcDWWlo=;
 b=LAmj92NhRKIJzvqVA0oXdQ0nALoa5XUB7kojDEtPCEdteF4oY9LzkveKrQ9pNJdkgocJEhfWDRHmGCHaAKTEQCMODCriK+SaQMTTY+k3BtWhJKIzBEcmehj6Dalc26a7yv0fGlnyTp0f/SbnJyjrqBkErtNdIjaaxJMI8rYZF3Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5336.eurprd08.prod.outlook.com (2603:10a6:20b:105::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Tue, 21 Apr
 2020 11:19:11 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2921.027; Tue, 21 Apr 2020
 11:19:11 +0000
Subject: Re: [PATCH v4 4/9] qcow2: Support BDRV_REQ_ZERO_WRITE for truncate
To: Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org
References: <20200420133214.28921-1-kwolf@redhat.com>
 <20200420133214.28921-5-kwolf@redhat.com>
 <59085a98-338c-fb6c-db2b-0636a03d3190@virtuozzo.com>
 <w51wo699kpj.fsf@maestria.local.igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200421141909693
Message-ID: <a75a7331-9638-3453-9c0e-9cc337583103@virtuozzo.com>
Date: Tue, 21 Apr 2020 14:19:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <w51wo699kpj.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::10) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.142) by
 FR2P281CA0023.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.27 via Frontend Transport; Tue, 21 Apr 2020 11:19:10 +0000
X-Tagtoolbar-Keys: D20200421141909693
X-Originating-IP: [185.215.60.142]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e768fe3-4534-4b3c-ef8f-08d7e5e5d0e2
X-MS-TrafficTypeDiagnostic: AM7PR08MB5336:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5336458F8CD7D85C3D824CB4C1D50@AM7PR08MB5336.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-Forefront-PRVS: 038002787A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(366004)(4326008)(8936002)(81156014)(8676002)(36756003)(498600001)(2906002)(66946007)(66476007)(66556008)(26005)(31686004)(5660300002)(6486002)(4744005)(52116002)(31696002)(86362001)(956004)(2616005)(16576012)(110136005)(16526019)(186003);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U03eg4WG36EPR9Tgw7hd8nNsPdEwCSGL/ofbmSweI1GW1VwYJdckOfZfSXSnfgYtZwD69DyyBTwSWSgHswndUC2gi4uw/5yas+znL34bWVfSrAcpbt2KZPSoSo/ExULeaQZV7mr6TISvf5j6UVrvFitXYYVYRsioaic+HlrqBFVtkzyX71t2tPzfKZka7PxHBHEj19eeVtmavg1kakE9BR9mkE3NUaeEnptKoXjrus4Q1saDKR1pwW6MjbSY6MShT9uvX6B0W71GbCy541huNiHcqr/YFKhhnJPO1Lzmx8gwYUBuaOEJOqqDz3KQhCimvLRTWWVwoUNw5CoiRLBmXVpJbnFS9GAlgiq7OchQfNAW7UAvz0hj5Ebavm9ip4kUJXq71TlZzntPDpOkFM8VL0Hv7Yw7NsafLSxrU1/R/pMIA67NAji6geHWtuZw3hjN
X-MS-Exchange-AntiSpam-MessageData: H3OZN1SokHxr0y/zYVuEhOihC3S/ul2+sZJFPIFQO9OT2Z2Q7enCco4JPB4t8SlzwpnxKri2nTltZbwBMSmSe+620ubd8zw5cDa/79MilWpWLafBvOIPloLZeaXNIZI6lf8jafxWVVpYAydUD+X/hw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e768fe3-4534-4b3c-ef8f-08d7e5e5d0e2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2020 11:19:11.5330 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HP2YW4yywvRmdiNgmELtXKm5K9yvl8lylBiFeS8XQBhLWqhTNVnbn79efm/kv/EyktdscHn4ZE71aJttAUUzgp5x0DoIQ06pVZ/+TVyRGbA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5336
Received-SPF: pass client-ip=40.107.6.110;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 07:19:12
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.110
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
Cc: qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

21.04.2020 13:50, Alberto Garcia wrote:
> On Tue 21 Apr 2020 10:47:17 AM CEST, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
>>> +    if ((flags & BDRV_REQ_ZERO_WRITE) && offset > old_length) {
>>> +        ret = qcow2_cluster_zeroize(bs, old_length, offset - old_length, 0);
>>
>> Hmm. As I understand, qcow2_cluster_zeroize is unprepared to
>> cluster-unaligned offset/size. I think we should handle it somehow.
> 
> You're right, it actually hits an assertion :-/
> 
> I suppose you can simply round the size up to the next cluster.
> 


But we also need to handle unaligned old_length, we can't just align it down, we should write zero to existing cluster if it is NORMAL cluster..


-- 
Best regards,
Vladimir

