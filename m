Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0224C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:01:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78DCC2075A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="R7s7szhX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78DCC2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k02l5-0005DZ-O6
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 09:01:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k02jV-0004Oa-Bm; Mon, 27 Jul 2020 08:59:57 -0400
Received: from mail-eopbgr140131.outbound.protection.outlook.com
 ([40.107.14.131]:37269 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k02jR-00030m-CU; Mon, 27 Jul 2020 08:59:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DC3Ad+f1Cc9h7bujbnqKg7sN1wLN5ARWhYzAHgCALQA7JJ3lEaIqgDTBuCsVk4b1FmQ9Nwo4MirKrKVGLmZ8+9kNRfXS3fHaoZROlXVWM4HcC3dMfJCic6wWemzP6e5dfdkYnkh3pdv9BVw6X4ANfJSMsZ7xeFMtI4bz0R4JV/Tpc1Lk0v98ktfbNGsTtxPl5iJon18PMIoyaviT1stKEBCsNZeW5ZZMs/mAoCxXF+cd98e99tjLy4vPZ8BNNN0BOWQ6Udws5E599rwf5W2+dLXa3hlkbMJ2kbTOTjgr1qa6N21qD/ybxH30Q9jKdKSdjtfbR1iRNkf8ZDfHQE34jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2j5sMl5Zn1uEYx+7St2JrYfYYw335edVGyEqn7Hx58=;
 b=XLjml3dxHBxTpvnkngOqWWt/93L5dJhPx5AC3L7oA5vx1/zCxFoEsI6a2edRfe8MVqPu9ZQaGOFJEQpg90yJ3qSfsZipZbdl234vAjqAmgB4+K6khAG02fxxCwPJw3MiA0ljIZXRwitihobUxrU1H1XJDijs1dLUFDs9cTqh2lKff8Fveuwkx40vWqYJSPC2GEsZDIcjplGSoAViDh9mhvhS5+iz5Xdv5+LUkFNYrTqXOeEVbMEr+XW1+A193K/geHY2mX62t9mHy5aELK58297yclS5KIpZfPaNWbcXJvg4LI7h2CDlHHOPE6ocWRbtPb/O+PK7TyKnMpTlh8JbDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2j5sMl5Zn1uEYx+7St2JrYfYYw335edVGyEqn7Hx58=;
 b=R7s7szhXz5qRQcLi368deVNt5TiTO6NTLQGFHrYTeq4M/PnnhbYQNVGriBqyykdQgVK4AN26LqpH5drU9dHGMQTVcQsZ0bh4tUR8wKToqVZrJKssKjHKr1rYGRwXEfS/KfA+1zHm3H+2HS3wGkbmsuPRi0wfes3yrJuDxJoJg04=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5493.eurprd08.prod.outlook.com (2603:10a6:20b:102::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Mon, 27 Jul
 2020 12:59:45 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 12:59:45 +0000
Subject: Re: [PATCH v7 0/7] coroutines: generate wrapper code
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20200610100336.23451-1-vsementsov@virtuozzo.com>
 <20200727124840.GC386429@stefanha-x1.localdomain>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <c610e7b2-9c1a-30fd-4217-e1bcb812ec7c@virtuozzo.com>
Date: Mon, 27 Jul 2020 15:59:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200727124840.GC386429@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0138.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::43) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.158) by
 AM0PR01CA0138.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::43) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend
 Transport; Mon, 27 Jul 2020 12:59:44 +0000
X-Originating-IP: [185.215.60.158]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2540769-e0cb-4d38-8e90-08d8322cef6d
X-MS-TrafficTypeDiagnostic: AM7PR08MB5493:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5493A66F8729585E76CCB1D1C1720@AM7PR08MB5493.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AHEQtDSYnVke7tUal8gOZcX/WgZ2o2LaI0pllSYT0FpF+dYTglJHrvzJWfVnv/6f01JGfdkjx+0ayEmQxUR38GisK0dI8HW3Hl38YjNUtV/hcII5wjUsAUPAbrKGvj1Mi+EIN/kPZFIjOjP/p71CPMvLLLeqZGVacKWbroPsbpgnbKs6Tto61c5BBmBYMD7/jNUzRB5TBcLfFSbK4Z2HT9D7/Suma1mx+3w/jtZSog2WrwGldVfDnF2BCknfM1PMpvzuC7LOsKo1ZyfS+1vVNg41guBSouHcJKAq/yCuwAmQtdqOmNryl4N76CE4TWVeg+6D5UXaSqkxiWXY5Lsn17uR+UBpkuAuFbOEm6mmlX6tLM4IIax7bmG6AuSXQq3Y
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(396003)(376002)(39840400004)(366004)(4326008)(26005)(107886003)(316002)(6486002)(16576012)(52116002)(956004)(186003)(2616005)(36756003)(16526019)(66476007)(66946007)(31686004)(8676002)(31696002)(5660300002)(4744005)(2906002)(83380400001)(66556008)(86362001)(6916009)(478600001)(8936002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 5YjkcBDXCHEDd5V7LjgGiWztTEf4NROFpneGLcQ6ZEC8+YacJQ1Xm3YTMi2ux96LzJ2XlWQeHxng+ZbMI6d6/YTTvz0nE5BjfNAQxXx3v3vUyRDxyTaYyPaHievAcVQxALHLsCXw3JE4TkWBIGmtYeAT7aKy+uYQj24Xjhn5n/JSkL80JUSoX6lVj1x+5mZeKDO4hSbmMlOSQ/Rd6SMcMeVOjQaVz1w6dfuCpwBhDzLUvCB9fnJ4V1no7qyrrNrXF4HEZJXoFlpxKUNgPZRoWAn7ponerlUNc58CymKGc67cVU78NNctoqZWxUAN4f0/ftgc+cjxUgMn1XOkxJ89hRgud5iFhfE+yfU57NqsHonACxDhgFpK3/VmzG1Q7SiGRsv7I/Ly3+Wrl6pslC2FdQD1hg1A4BTuSLyEPNS9E9XZo8yaWKMQ8i5VssRAAT4nsf5TYAjcGFCVnoLEaDTRVglztlI45KDQ3tUs3GLuValemujASG9uDVwBLsu4bkuy
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2540769-e0cb-4d38-8e90-08d8322cef6d
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 12:59:45.1960 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vf/vlmG7T/DJz2yQvmSnibT+s7DaUPG8amW/repSOAui/0QeO+47kILSHG6WIFQr1M6exAoEknDEqAI5p0rqvT6QciVmCIG08zZI3e2eZPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5493
Received-SPF: pass client-ip=40.107.14.131;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 08:59:50
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
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
Cc: fam@euphon.net, kwolf@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 crosa@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

27.07.2020 15:48, Stefan Hajnoczi wrote:
> On Wed, Jun 10, 2020 at 01:03:29PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> Hi all!
>>
>> The aim of the series is to reduce code-duplication and writing
>> parameters structure-packing by hand around coroutine function wrappers.
>>
>> Benefits:
>>   - no code duplication
>>   - less indirection
> 
> Please add documentation so others know when and how to use this.
> 
> I suggest adding a docs/devel/coroutine-wrapper.rst document and adding
> a code comment to #define generated_co_wrapper pointing to the
> documentation.
> 
> Please rename coroutine-wrapper.py to block-coroutine-wrapper.py since
> it is specific to the block layer.
> 

OK, will do. Thanks for taking a look!


-- 
Best regards,
Vladimir

