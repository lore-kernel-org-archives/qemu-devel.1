Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156BBC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 18:54:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A2F6235FD
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 18:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="gbDt4WEE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A2F6235FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLWNc-0000Hj-9T
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 14:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLWMW-0007vn-A9; Thu, 24 Sep 2020 14:53:00 -0400
Received: from mail-eopbgr130112.outbound.protection.outlook.com
 ([40.107.13.112]:20085 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLWMS-0002Ex-CO; Thu, 24 Sep 2020 14:52:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+PJ6Xgw1iaT5qOCTnH77/829ejETlIH2rexFYSVELI7V3ieWdQGBb9FKFkhbnoGImkvhBk1GC9eGPKaLhc1C+qdfYSwX1WEPOJHQiyOrlkt7us3Ismi94hSAq6dPKdZv0Fa7hw6aeTHPBFIWVHHpzmAQA/vTO86UdJVkCYnUEG4khPktr72/e87VwV4YYRhMyuI897sMgCLjKJsbiZo1+KkOudemIJGv53BIOKF6KwTX41u70YogEBRJxklgvTJxSyNCzJ50xZBXG7s3vozk/1sP/JmwQyBLH/LW1EwB4b2WpVJw95eWVseUcvEHXZBiqPgHJ4gw8HmLaW/WwdyaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IvX3qmB8SUYVWI+nVjKT4yHc3ykJG+iGInkJSgk6yY=;
 b=njG1s0kjC1UDQZheLMCSzb4DWJpOPw7wC9GewfOcd8TUCSoocT8ic+yKgehdao9yKRDopX7GfGinQ8Od/VWqvd5QvGBmljHxJ3+y+Bf2OfUHds9RJe8IPFm7+yfWiquEdxk4HT4hSKgJ3ra5UZJYblGBZzweMLLGMVS5VSlU1Hc+EiAH3rRGyrrd0o+Ygwlebwoga9hRrrcSz6Q6FtzMsMjaNYlVWkJLZg0xpMJYeYj0JO/uJFzcXKvewZkkUrE1po1tEKwrgFB2eAzCtQ33cDfiCWaSPOdgT0ftAy25Cn1bj9AC+u7hMBeYcrIIZFMMvWY6a5fnmSAQYOTbCNkbEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IvX3qmB8SUYVWI+nVjKT4yHc3ykJG+iGInkJSgk6yY=;
 b=gbDt4WEES8UVhI4Kvbz81Q2GOiFEemjNTkre/M2PopS1EdJG+wwjRszLSCZcG/fLXLitKyoQXPuBc3fE7sFKuu7qRr5F5oIHX+S3stijcFTHYvw6QDjhxYtVhQTGx/EMlxtV6YeS6e85jGN6oZNaTvn5iyxJ6tTucUAAtMuJ97c=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4341.eurprd08.prod.outlook.com (2603:10a6:20b:b9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Thu, 24 Sep
 2020 18:52:53 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.033; Thu, 24 Sep 2020
 18:52:53 +0000
Subject: Re: [PATCH v8 4/7] scripts: add block-coroutine-wrapper.py
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, crosa@redhat.com, ehabkost@redhat.com,
 fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com,
 den@openvz.org
References: <20200915164411.20590-1-vsementsov@virtuozzo.com>
 <20200915164411.20590-5-vsementsov@virtuozzo.com>
 <b34d44ab-ef80-0fbe-00f3-96fdca564c9f@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <e2c2758c-173c-fd42-af35-4b8d1fc2b872@virtuozzo.com>
Date: Thu, 24 Sep 2020 21:52:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
In-Reply-To: <b34d44ab-ef80-0fbe-00f3-96fdca564c9f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM3PR05CA0152.eurprd05.prod.outlook.com
 (2603:10a6:207:3::30) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.94) by
 AM3PR05CA0152.eurprd05.prod.outlook.com (2603:10a6:207:3::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20 via Frontend Transport; Thu, 24 Sep 2020 18:52:52 +0000
X-Originating-IP: [185.215.60.94]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2b2e050-3fb4-4fe0-8717-08d860bb0abb
X-MS-TrafficTypeDiagnostic: AM6PR08MB4341:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4341D35EBCBEBC1B39F65587C1390@AM6PR08MB4341.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gz509h/vT8ELDmnmEe+QdHQxzi1RCxeBJK8ZfIyXjQNVxsqQyP6gGrqfnTMe6XMK0RvWeLUmnqwdGmwDEodteo+4avM+IPJ4UJ9VbH9s8KPaRy6IvKhWV6Zw75R7DlnRtOHG7+HUo6qCNCjd3MKxk2gDovIdqbhG042ZeZo3tROFvElnYpvy8TSWFJJyr9pbxUj9O14O8JBssISRAhxFPWGEbdBgfET93WngEznes6sEVewbzR2dbAu20aI4M7VmwKi21jjdz6w+qL5QxoRunOtUsMWptuGogL0x6x+20Txinv53ZZy68Go1XPAtdUbYK6NUdcLfM9NzuhHnrTYYcElw8G3wJIUK3SEyAQIXvY0nslang7jUFtyl1VtbDxDb0m2EJuSlLpwIPN3vSH137MuebACbs9lBV4yr/GB3a+0f/Tmb50ZrzAmz2l6lhnrs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(346002)(366004)(39840400004)(316002)(31696002)(107886003)(83380400001)(66476007)(186003)(16526019)(5660300002)(2906002)(36756003)(8936002)(8676002)(53546011)(66946007)(2616005)(956004)(52116002)(66556008)(86362001)(26005)(16576012)(4326008)(478600001)(31686004)(6486002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: clG9ugIZ737IOwluYiiFD70ka2naqqqze6ghjfcCyylkwWygzMinxsHpMl7aALVowJmL0uTSm3oRHxNc2jEvf4CnfFR2eCcLLujZ+mAaMbrQLTGBBNyp+pUXxlLlT6NhoM5HIDyOR2ZzM5rA1RzeN0ULdAUeobM8YoYBSi+ayqyttNj4iIQyUAlzcxNZLne1XfjJvyzxH3Q6/XfYGyEwF4mK9UbE4rD9geFrhoaLeKQEwbdxr0WRxEHF2hlauLmayUPb9nm4n/k4gn/FgZFDkIERqCp9DFYDavE23dYe6L/3hOq7QbTV69R6Ld5Mbwvk72RM7Xo9XHHqY6d2w+LYNxEcmj63ltz0GJSO+RuzAOatotYf6Z0t5JpBfaSBR6FCIBXCVaO8RfHsmf38+PMXYkPHiSOcprBrgdJNdbVv+6wIUjOlErFifhrppB/7/NYeoh3ekms0sg2c+nAvPKwvfe7Y/Tao+PMY5HpQDZscFiWNPkkxmfUirf2R1SJRBu/dQioVuCbWZ7FuIzxTob3u2qD++cLwyCkZrMdAFrmz5NGtSU4Ta7J31CdOjnV4BFP1ahLRahimkV7UN6r86QjtxQ/KgYlcRZoS+EG55OHcoqq/nD+qNRFbV2eKD7df4VIc237UUPHNdIFu14+y7Ewrmg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b2e050-3fb4-4fe0-8717-08d860bb0abb
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 18:52:52.9163 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B73h/8KrZjO7qabPB3ecHvyhWAll4hqVF48B1ecZCWauDgqizZGj3orb/BNyowkmhty6qBoFBXoBR2B3Nka0/6mP/99cI/mXcwcAPBbIiqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4341
Received-SPF: pass client-ip=40.107.13.112;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 14:52:54
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001,
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

24.09.2020 20:56, Eric Blake wrote:
> On 9/15/20 11:44 AM, Vladimir Sementsov-Ogievskiy wrote:
>> We have a very frequent pattern of creating coroutine from function
>> with several arguments:
>>
> 
>> +++ b/docs/devel/block-coroutine-wrapper.rst
>> @@ -0,0 +1,54 @@
>> +=======================
>> +block-coroutine-wrapper
>> +=======================
>> +
>> +A lot of functions in QEMJ block layer (see ``block/*``) can by called
> 
> My editor italicized everhting after block/*...
> 
>> +only in coroutine context. Such functions are normally marked by
>> +coroutine_fn specifier. Still, sometimes we need to call them from
>> +non-coroutine context, for this we need to start a coroutine, run the
>> +needed function from it and wait for coroutine finish in
>> +BDRV_POLL_WHILE() loop. To run a coroutine we need a function with one
>> +void* argument. So for each coroutine_fn function, which needs
> 
> ...through void*.  I wonder if you need to use \* to let .rst know that these are literal *, and not markup for a different font style. Although I did not check the actual generated docs to see how they look.
> 

Intuitively, `` should have greater priority than *.

I now check ./build/docs/devel/block-coroutine-wrapper.html , it looks OK:

    A lot of functions in QEMU block layer (see <code class="docutils literal notranslate"><span class="pre">block/*</span></code>) can only be

-- 
Best regards,
Vladimir

