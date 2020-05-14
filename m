Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9C9C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 05:00:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B059205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 05:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="sIj/T9Ec"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B059205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ5yv-0008KR-9L
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 01:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZ5oT-0007Wj-Ef; Thu, 14 May 2020 00:49:41 -0400
Received: from mail-db8eur05on2114.outbound.protection.outlook.com
 ([40.107.20.114]:25409 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZ5oQ-00046d-Uo; Thu, 14 May 2020 00:49:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4kiK79AnkG/nC4OSmcqINgljRyA+9lNguf5stJTB0n+gBXqZqT4fbUUXZqn317laqHQfep+PX5gZKv48TaiBM3r4nPXxdtnWQI/bKHBZlReuhxJaQWC1KPFB+TkGNvHilj4+xeXd6AfmJf6rb0BBH6t/M9z57H0B0P/f+OWyd/zP40K9rh8mbI57vq6Rt9qM8Y2OycwZyMqwmXBFv6TTpFNOgMYY2lPfBgMHSsbM04nmyoqWohH0nWS9AcqiqXXFz8ZDRIIEsf92ve+TFMfswrKUll296gU7DwzzOthXu5Q49QEiJcfcbAibHCO8dwWvkgnQwGs4XDH9mkLiNoz0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIUa+BJgMIKjZFiQ9QlDMY+mJhaiX2/leaO818TXCAc=;
 b=Gj/ejY/m/kI9OrpVW9nPlgFjeEY3SgloXWH5z53z2w73L0patpoPJ8NLX/1hHGdBuBXtvyojD0ApymxdW1KDzm1QUpMmmeEjC+h1PVR5DzD8fhie840oUskdmFULdFg/I8nXAA/9btqhzEqpH8AfXlm2MfAlTWBn9B+dqyxTnc690BoO9O4fgBpta1OZwXMM/gfbJEIpFCnkyJ9+rcuYLckhED0pwucpDL364hlTgXZqolqnVbJR2UM9T2scQh9E2RKQqCuWsviWCD1m6isHlXms8ODLBIbvATM8Sd2j7ISW1T1DNch/odIunyPGxIujbivpGyvlBdiXbmb0B9H0ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIUa+BJgMIKjZFiQ9QlDMY+mJhaiX2/leaO818TXCAc=;
 b=sIj/T9EcpSnYegdXkcbtncDYvMteE0AJeuCr88SJwDPm0yYXDpT3jKE9qFM1mifXHevSrcPiq7ccsJxLA3qzaPvpxehLsD13D5HVGosi8dkMTsFQML7l5B/cQWkLxuI6a63mVh07l98Z3+uPJYo5fn6vLVHmpUl5IQdRXgAODX0=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5349.eurprd08.prod.outlook.com (2603:10a6:20b:107::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Thu, 14 May
 2020 04:49:35 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.3000.016; Thu, 14 May 2020
 04:49:35 +0000
Subject: Re: [PATCH] bitmaps: Add myself as maintainer
To: John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-devel@nongnu.org
References: <20200513141407.185198-1-eblake@redhat.com>
 <55059458-923c-505c-d16b-89ff3334c3c5@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <30070988-e0da-00f2-3780-d4fae816b589@virtuozzo.com>
Date: Thu, 14 May 2020 07:49:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <55059458-923c-505c-d16b-89ff3334c3c5@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0088.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::41) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.186) by
 AM0PR10CA0088.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Thu, 14 May 2020 04:49:35 +0000
X-Originating-IP: [185.215.60.186]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab2cf703-c9e9-400c-eb03-08d7f7c23351
X-MS-TrafficTypeDiagnostic: AM7PR08MB5349:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5349A27A94EF8AB6DE092B85C1BC0@AM7PR08MB5349.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QcZtkIQZNilILZ/l0yvbb/NBfXfnO4NsO8+FD9elMzAUaWb1Y6dARA2SQx32anG40ZKY065/cpFVbQaGeisdx0UvLcJrDS40AxjxvVn9Xw0XiH4NBIVyiT7opqEi9O2M8jsVd221hFbV7DVzgkNjXu+Tjy0Q/3rYTyKBFly6hoMnakyIM/sW7DOiytmxQvFNp6I0lsIWN4QFWEA98nqZKYHYGvvmBFJcYSzWMAp2dnk3vUvwU6D03D/jj54pAmXaw9jLgKaZpshxYPpgKtF4NV9zoZJct112KhyAtSZx4ALBgWjisa0N1QCqmCFR+qgq/LorCinYwSefwxQUEXlOX+fDl3HmfKT68qL6pfmGA6/8mu4D8dvjQMsKo/F6c+mNw1EL/DGk8rT2AcH+TFkIinLGhabYoXbLPlbaltZDjx9KgXlkXwdOTi+lIKbBqveGJWYqSIh2N8+JLDZoNQy4z8qSZOeNpr+MYWcfxQLO+npGgmmDbwmSv1avU3//74OhJpTZahASG1Z1C5Ol/R5QVsbfiJmGe4gfstWCTT1ZUQ+mnHvOJ/l396oPPy2dvrqy+DYTGWbAO8zbil6FLdPqdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(346002)(39840400004)(136003)(396003)(52116002)(66946007)(31696002)(66476007)(66556008)(110136005)(956004)(8936002)(53546011)(2616005)(16576012)(8676002)(4326008)(316002)(16526019)(6486002)(2906002)(186003)(966005)(36756003)(31686004)(478600001)(5660300002)(26005)(86362001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: +Y/jCiHmFu7z7/cLSJ0mE10v2eUkvT91c4edxtJmeh43uVFTmnS9vSMOQc+Ym6327jLvVeRwKh6+EsGYuNF09mMo0W5+701DV2KRno0xVSn22dzK3C5DwT/tByFmyji2sUe1J6e6CZ4/J8v1Puata4g1s8I/qed8ZKbH7XHjX+D4VkVvN1afNPxzfr/ZDivms6LdctzDth6SRnPqbEJPKoH3peAjIskRYJQX9WZJSsNg4WQdAHv0Pvp/5OXON+mGOpZwWNl5Ej7MVXaFYjPGWrrQHzS/g7z9vEmxxoTIZ2a1uNKY/APbAONYxDhIwA/XSJhSGJknyZ3GKRvy/ozNcCCPyLGVc/XSSD39+E7Oq4PdYOAa7TF28cPq+kh5x7V1PtGat3egaBD0z3dyjmRLl4wU7o2Nww6wSlqL4rSBAmQ3uazTb41+ZLZfqpR7bA/KSW+9Mg90QSBI8wOxL+I8iWULbC2Q2izkui4CP+J2fLjSEO9tCZ+Hnz9YVcxvjN78
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab2cf703-c9e9-400c-eb03-08d7f7c23351
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 04:49:35.4769 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gG7oS2cjRQEWyUzM1tLJqQxFH2YojUSzxcQ4iV2U6Z1C0N2fGAzF5VswL1iaOoKpvCbBNzsWaaKEUlS6nSjkE1Ym/C/396xqA/XEIjzPAkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5349
Received-SPF: pass client-ip=40.107.20.114;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 00:49:36
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
Cc: qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

13.05.2020 23:24, John Snow wrote:
> 
> 
> On 5/13/20 10:14 AM, Eric Blake wrote:
>> Dirty bitmaps are important to incremental backups, including exposure
>> over NBD where I'm already maintainer.  Also, I'm aware that lately I
>> have been doing as much code/review on bitmaps as John Snow, who is
>> hoping to scale back on this front.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>
>> ---
>> This still leaves John as maintainer for: IDE, Floppy, and Block Jobs,
>> which I did not feel comfortable taking on at this time.
>>
>> If this patch makes sense, I'm happy to take on my recent 'qemu-img
>> bitmap' series as my first bitmap-related pull request, once it has
>> sufficient review.
>> ---
>>   MAINTAINERS | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 6a8dc1e69d42..f7caf7c0cc7f 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2002,6 +2002,7 @@ T: git https://repo.or.cz/qemu/armbru.git block-next
>>
>>   Dirty Bitmaps
>>   M: John Snow <jsnow@redhat.com>
>> +M: Eric Blake <eblake@redhat.com>
>>   R: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>   L: qemu-block@nongnu.org
>>   S: Supported
>>
> 
> I'd also like to point out that I wouldn't mind if Vladimir became an
> official maintainer, but I can't remember if he wanted the title when we
> last spoke at KVM Forum.

Actually, it would be nice, I'd glad to get it, thanks :)
I can send a separate patch, or we may s/R/M/ in this one?

> 
> Regardless; I am clearly not keeping up with reviews right now as my
> attention has been pulled elsewhere, so:
> 
> Reviewed-by: John Snow <jsnow@redhat.com>
> 


-- 
Best regards,
Vladimir

