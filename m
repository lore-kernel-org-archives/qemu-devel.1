Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C98C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 08:04:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88C5720866
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 08:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Xm3CithW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88C5720866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3xMl-00037p-Sg
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 04:04:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k3xM2-0002ZW-13; Fri, 07 Aug 2020 04:03:54 -0400
Received: from mail-eopbgr80122.outbound.protection.outlook.com
 ([40.107.8.122]:57349 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k3xLy-0000dM-Do; Fri, 07 Aug 2020 04:03:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWxZF5aJzCJqyuUrT06CYyKkALVQOUyPSLXfLlH5LhL51SnH8naOsYr0zvgImtzCzrg76bW+BsroEPveCvl3PtfnuEpcKMjYPlQg1VOx1HEryp44yv/JTeLqW60S0nbHcHVve2Ow/bmeRj+w0GAt0HHu+DbLADRS/2t+BMwL8Jy7SMZYiTYykE+T85klz5UDLhNdOzzLugWw8hD/lQ/H7rH0Kk5PfoXmx4R0c6pUYeSUQVhuZby3R8j6456ilnWclmqRwX4Ejm2SGN6WYJE4cTRzgmIIDaKat5caDLYUSAow5/HlgVMaVQfqbuM16dnSglZUKwVN5tz8o6e5/ABxAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OeoA5kdrkJPOg3I6+u3p3nur4LCALSy3Gb505iRNd68=;
 b=CPcwc6SfOttt+y6EICBudEB0IkAV2JC2IXsrETKzTcKx3LdGuE/G37BvO+wZg+ReWrqHcyQ6Nfa+by8mv2RKaPvjZFvpfqyvOmUoKMRuQcycxXM0dDFn5FqIKtXuS2BpywhD3ErAaa+B7T9FE1uWcq0rIbS2ICwMw0JxESoq98arASxaC09qR2aSltaVmnEN10cfOni0vCTmoRqQWOjX3aFJiYUTAETIbUbIBvRmuGeA1ibOTEgDs7/dJdK6jUgyuV9v25hVae3dxihfPxcgkSW8FSejjhE0QHYjzj8JAMsZZdy0Y5DE95oN1865TjJsVN9RklXzlWm4RB/hM4eBZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OeoA5kdrkJPOg3I6+u3p3nur4LCALSy3Gb505iRNd68=;
 b=Xm3CithWRQ0ysomaE9x0zED9R6vhALyihbI64R0ZzcysfFsRgXTRjLzrdVA8YHhpYRcfFUFvyRVsWUEADrOjD5kxm8wK9l/GdPkVO8KeVB9PuSBQLYICzbGQF5Cdn5DBGsoizU1HU/fYmWsC9wxAdOcYwb1tS/A4/BF+w1yDork=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com (2603:10a6:3:89::22)
 by HE1PR0801MB1644.eurprd08.prod.outlook.com (2603:10a6:3:85::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15; Fri, 7 Aug
 2020 08:03:45 +0000
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::b5e5:e4d:ed88:5a3a]) by HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::b5e5:e4d:ed88:5a3a%9]) with mapi id 15.20.3239.023; Fri, 7 Aug 2020
 08:03:45 +0000
Subject: Re: [PATCH v13 09/11] qcow2_format.py: collect fields to dump in JSON
 format
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <1596742557-320265-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1596742557-320265-10-git-send-email-andrey.shinkevich@virtuozzo.com>
 <552171df-3015-4f88-48c9-0862bb0b8396@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <c718f884-579e-c658-1ba6-a584a4598e82@virtuozzo.com>
Date: Fri, 7 Aug 2020 11:03:42 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <552171df-3015-4f88-48c9-0862bb0b8396@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AM0PR01CA0111.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::16) To HE1PR0801MB2124.eurprd08.prod.outlook.com
 (2603:10a6:3:89::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.82) by
 AM0PR01CA0111.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18 via Frontend
 Transport; Fri, 7 Aug 2020 08:03:44 +0000
X-Originating-IP: [109.252.114.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e14e159-2b01-4ac8-df98-08d83aa86826
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1644:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1644860103D26A54BC3151E7F4490@HE1PR0801MB1644.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pzews/lP8/9clSH3Os+b0MExrQGCqek2qwrWYLlVMYesb6edZfIquHaw/7PeZPKw8WNM2oz8MTwuv0Qq4ApXseVpRSfxXc6+fELvSUyNLjXhGDG3Ti/D8gpgnALnvPk0qJMMrEBSiWunzWqzpITo71xXXGtDbZvZPcxX/fNpqsUhk7uHVQxzmVTgEZPr/dbIjxE8Ar9IjfYa6DtztysosPsK84Gv3yQY/TxOcF+h4ya3JC0yXkvza3rar6G4rWVpXuH2MIqW7M8BXC39NkCDXratrO7rci55mpTklXNuvQ6feByiEAJnxA2PzFvk5sDm8C0nA4WJr9zSQk2WNUoMUHeIjPDIPAeVvSMXatyjzLYzONjyxooxJmQuxf15lwib
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB2124.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(376002)(136003)(346002)(39850400004)(6512007)(52116002)(478600001)(4744005)(31686004)(16526019)(36756003)(2906002)(31696002)(186003)(26005)(66946007)(66476007)(66556008)(86362001)(83380400001)(6486002)(316002)(8676002)(4326008)(2616005)(956004)(44832011)(107886003)(8936002)(53546011)(5660300002)(6506007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: fRCVyo5erfOGSjNNhhJdNe78LIKuQF0hmcCpL+LNHsoWy+RP3a7K2uyRCH2Wi0qzh2hIwTU4aZTiJ2bfYbClFdatbNMakqVDhQhB6UpgG5feMXYvyb5LyWkIfmdhEnki71oT2bAhHIF2zxX2YoqXA4D1Cj2Mlh3xbfnhE9Nw5VR69ihVDYo43CVolY8SCxmjcuWqUpBze8/FBL9QmSkt4rrMMfm7jY48h35naNcfC3c8jgj20RcUNFAa5X+7+Ms6fz4x/kS+tdy5FPFSo3ZaSOW87EbF1JwFWlwhHnpvs7PxqHhKIWWwtuhXn6aJsnE0JKZ238k0slv61LRSsG6dm+dDM/e+ul5HepP6mu1x2bPDHN8vzJ6DRzI8tbves/YpvZmVfMWjzsKDI1Ec58jasOSlo45kkCaiSU4P8ndEMpOMJ5CzTAcKoe7VYpPYOfGPfnRBUspJPbR0z6S8YcBi4Nrzydh3YoMndIJ7GrXd9WIeNnw/4Jk+2o1yJbBRXy6kpXq6RS1FSn48K3+AoLPdtDOjyly/AlnJ07nYfOS/5BZIHG+HWYMmveIVVJtGKBU9BD5DFS7WAud7AyLwDPOkgNt+c0Jf6j5n9ISOAFQITPMjTotxwLBMVlI2ywTRSpVYIO3vJ5niI38dF7HQbUPHqw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e14e159-2b01-4ac8-df98-08d83aa86826
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB2124.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 08:03:45.2338 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G4Ra4Jvbd4s++BJMrH8ZF9Ir5hTpaVuWdymgDooGp4Af9NBfGjEwlrcqT5YEultJ94AAE05kXpbQG9zOlfrmkR4FF48Tx+GTjttxkYA7AW4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1644
Received-SPF: pass client-ip=40.107.8.122;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 04:03:47
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07.08.2020 09:30, Vladimir Sementsov-Ogievskiy wrote:
> 06.08.2020 22:35, Andrey Shinkevich wrote:
>> As __dict__ is being extended with class members we do not want to
>> print, add the to_dict() method to classes that returns a dictionary
>
> to_json() ... that returns a json-dumpable object
>

New version to release with the commit message fix?

Andrey


>> with desired fields and their values. Extend it in subclass when
>> necessary to print the final dictionary in the JSON output which
>> follows.
>>
>> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>
>

