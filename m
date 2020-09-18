Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6F6C43465
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 10:01:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2394020878
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 10:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="B5YRrHCV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2394020878
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJDCh-0005ZQ-8d
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 06:01:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1kJDAc-0004cd-82
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 05:59:11 -0400
Received: from mail-eopbgr30119.outbound.protection.outlook.com
 ([40.107.3.119]:57388 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1kJDAZ-0000ZQ-AK
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 05:59:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJKVHKUD2CPhM5FvfbSRwUmzjgPQDqT0IjLRwMnrXX8+oTHJQ2TRyxInYlfu1iP5ASSdl340YJcWlJGPVa//OKkLP0OAWyJTJMycMZdtSCgeNalKdH0hgoUXmbPM+UGZOnZqlK6N+zvwNXiipTKe2cdV0lKHLjB7LvV5yKD5BUozaHo/09TOk3CYMw4LJxykgj0MNhjlHHz1heS2KWi8ZBZeA5VJakTMH6cIKLUgneoXrRhiIc1a6Pw7bT/+juvggYhp9kzniffMxxe/MM93ceoODmkN/vjFOJ+48Q0c3sMRRKgu9hygSCQd//SvRGdA+K3LVIpXBQwwOLrxmMEJOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6oTt8ft9QMgryTJVDWknBUfEElRgJ83wpbtSKjHquPo=;
 b=Vsc5ENNg2jhcmyn4lFrvc5MbmtH7rdlEFqI9ALMiEzUhuQpg1uB2WQbOo9jTtygb+5hxfweFXg5uguS5A8EFudEP3R5Kq1B/qwmcIc4t3IUWxtv9L8VxBQK/lEKYzgaVM415lHQHFt9IdHi2U7S218NeTRjRyAZuAfKBgDHklI/Y8aOkbA7gcAXi7XR4AkmuBfu1zDqijlXYQ2YBLoAB3r72c1e0a/GyvJ9DbF252hwYZs46swiR53bYanmRvG0M/bilbj2KULGGw5R33fUr+sQwGS9BhyhOVgeDaIvdJT77z2evMp4XMeUM+3DAPskfYeebIbWALr8rvNaDhKWtoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6oTt8ft9QMgryTJVDWknBUfEElRgJ83wpbtSKjHquPo=;
 b=B5YRrHCVKJx/8PaVH8SDBXEe3BorX4IK5ZNzJYz/oc6DZk1wgB2KvEgfmnqo1czlhUMWMnSjOGWtV28JRj6gK7KgkiOPSdXpQdzgEqNcD+uREuZjWq3HmmsyzRbVMWSi0SC6bcu5u7ZKQSfuZ5tPIz+H4iY1eK9lavnMNJWrDnE=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com (2603:10a6:20b:8d::30)
 by AM6PR08MB3285.eurprd08.prod.outlook.com (2603:10a6:209:4b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Fri, 18 Sep
 2020 09:59:04 +0000
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::948a:2e3c:f9f:66f7]) by AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::948a:2e3c:f9f:66f7%4]) with mapi id 15.20.3391.017; Fri, 18 Sep 2020
 09:59:04 +0000
Subject: Re: QEMU 5.0 virtio-blk performance regression with high queue depths
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Denis Plotnikov <dplotnikov@virtuozzo.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20200824134431.GA35623@stefanha-x1.localdomain>
 <CAJSP0QW3xniHzHS=_Ok1D-NuAViHUShCxYs38YDo-YjUxC_+ZA@mail.gmail.com>
 <709da6a3-d158-270b-fb63-43ef65dfe668@virtuozzo.com>
 <dd5d6d0f-cc52-d3d5-0bbc-c57dcfef6842@virtuozzo.com>
 <CAJSP0QVRMzw5AAJEPpOChyFK4hUuEe1VE909QvYb6HQGOV_8XA@mail.gmail.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
Message-ID: <ec0e4c0b-9570-de7c-66fd-5cb4085ab075@virtuozzo.com>
Date: Fri, 18 Sep 2020 12:59:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CAJSP0QVRMzw5AAJEPpOChyFK4hUuEe1VE909QvYb6HQGOV_8XA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR07CA0009.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::22) To AM6PR08MB4214.eurprd08.prod.outlook.com
 (2603:10a6:20b:8d::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.27] (31.148.204.195) by
 AM0PR07CA0009.eurprd07.prod.outlook.com (2603:10a6:208:ac::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.7 via Frontend Transport; Fri, 18 Sep 2020 09:59:03 +0000
X-Originating-IP: [31.148.204.195]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be35cb68-c90b-4969-af5e-08d85bb97983
X-MS-TrafficTypeDiagnostic: AM6PR08MB3285:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3285B90B2A50B63AB4C0664AB63F0@AM6PR08MB3285.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xRc8vL27soasfLuz06eK1ScUEP8IFMtJVCebmQ3hH7uBE8I/zAHcq/ka0EUqNukDzFYBJo0Lf1U/+HLF0mdcaah9UL+sWZ8ENem4B//fN6kRaBsDvRZnsSRG8MpvYHKJBxRasy4BuUyw+YYbtftYcouUiem3chiGPnhSk1KkcCvsWBxaveXqq2BSyI7YB1WE6PAgJXYKZarXJzxMGFKcU79UxT+A5b4D2owTj67BRbbEaP8pXKvVTZqZ8Gw5sKPC5NG4iuOv5TN18j/Ad13H4qN+v2Wam/RR4k+kS5COfhlsvT8MNIsf7QAnYzD7f2dkO5PphNaTxZc8ioCpN0Uvb/ZbjzYe6LbBHcGdhyVSwsjH98nUpQ5eWe/BS8YjAQAT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4214.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(396003)(39840400004)(376002)(366004)(66476007)(66556008)(107886003)(86362001)(4326008)(6916009)(66946007)(5660300002)(6486002)(2906002)(956004)(2616005)(83380400001)(8676002)(52116002)(16576012)(31696002)(26005)(53546011)(316002)(36756003)(31686004)(54906003)(16526019)(8936002)(478600001)(186003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 8r8/ogG4WzC7oYnSuQ8uUbWjRIm36C9NLZDHGcy0rV1/0YuWjfjkTvSekmn3a98iqWd5tzQ1D5N/w6uKs+BMfdlOgMU1l25GE3QEWT34dtB5YFD8eBrzjICX4BwO+FYrply5Sfm0bcw7Mzdas2kpahn1WS/+aIan6wK7+yhMCL6aq4QsOY5m+0jEaA+nCs4u6sY7GvQRzHtrr04HamfJCFCa5ktlo/7+Aa/aqOieR/ctbVo3uoQnAGGAxWe/BA3QczQ1leKWTWGQRCeYMZUuBRpBUFecQ3metqbI14fx8Mfn1euKmBbtO76WNnP4FPnZuoyFi6tiALPxtFAMSoacPMN4qsE69wcoBzAGor1t3E2sw6MfAjpAXeNO3gf9FxpkUkwFx+7DRzvAObimqM+X4jyiZoPeVYJmXInf/CFRzvJQkCBZgB4RGpoKCvgZjH4I2ASU+Qxjat/0LZuJabak0UwkKd/l1/flZIZqzop5+29GFQWdAH34PhqMV1ID1IUJ0Gg5+zdZ/6OuhpQ1okaBFJiiR+0P7BMIH+V2PhEi7XyySPQ9IIOcbvCJxuAhFPv1wRWQ2j/eCOjgNAEg15/EUK/AASyk/7QRnQNpKl06HHAPjr4rkWDJVtQkvLnDn8jDKis8bsh+3EX9wWPjIcAUSQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be35cb68-c90b-4969-af5e-08d85bb97983
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4214.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 09:59:04.0124 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jkMh5brgWg4X2T7FtC0vJHhjOGka1wkElu7FZLYQ8oG60lAZPFPKFw/U1KbTy/tjG4LqKI2MZr5bwAXmUQfSSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3285
Received-SPF: pass client-ip=40.107.3.119; envelope-from=den@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 05:59:04
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/17/20 3:41 PM, Stefan Hajnoczi wrote:
> On Wed, Sep 16, 2020 at 5:43 PM Denis V. Lunev <den@virtuozzo.com> wrote:
>> On 9/16/20 5:07 PM, Denis V. Lunev wrote:
>>> I will make a check today.
>>>
>>> Talking about our performance measurements, we have not
>>> seen ANY performance degradation, especially 30-40%.
>>> This looking quite strange to me.
>>>
>>> Though there is quite important difference. We are always
>>> using O_DIRECT and 'native' AIO engine.
>>>
>>> Den
>> I have put my hands into this and it looks like you are right. There is
>> a difference. It is not as significant for me as in your case, but I observe
>> stable around 10% difference with 128 vs 256 queue size.
>>
>> I have checked with:
>> - QEMU 5.1
>> - Fedora 31 in guest
>> - qcow2 (64k, 1Mb) and raw image on host
>> - nocache and both threaded/native IO modes
>>
>> The test was run on Thinkpad Carbon X1 gen 6 laptop.
>>
>> For the reference, I have seen 330k IOPS for read
>> at max which is looking awesome for native and 220k
>> IOPS for threads.
> Thanks for confirming! Reverting the commit is unattractive since it
> does improve performance in some cases.
>
> It would be good to understand the root cause so the regression can be
> fixed without reducing queue-size again.
>
> Do you have time to investigate?
I will make a try next week.

Den

