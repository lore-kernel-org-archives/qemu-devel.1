Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64C0C4346E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 07:09:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9D5F2388A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 07:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Ffa4us/F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D5F2388A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLLNV-0000i9-LL
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 03:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLLMY-0008Qf-Vv; Thu, 24 Sep 2020 03:08:19 -0400
Received: from mail-eopbgr140093.outbound.protection.outlook.com
 ([40.107.14.93]:25358 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLLMX-00062a-7c; Thu, 24 Sep 2020 03:08:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BAGqaTNzDjf5QIhDRGLmS7S5VHL0BJNtb/EC3aGIvR9+EPw+u25+HIDDtjIs5UCB2ezEUgKTPewtXIuWi3966x2jeOsKSWxMgI8obe4lPtPOw/b9Zv0/32xBI7iQpHRyx8g4rsKROHTu8RFUsczPPvjYrh1YrdlChZn4zfkc42+6Lc5eYudXjVbatYTJJBWf9L3S97ofhoYZcNT6iF3iKer8HMhXEsAWu+kG+e4rm4H0TkinrO+eBITRk90QTCwwMMh3FgDP403VcClXFZVn4HDETZwx6i81aPYzlxgSEmKKKcelNeInHhuQdBN7UxRCfqzxYsZTMHb31VpgyHxhKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBIUl7jjAPjmT9hZVNuEtahOwadMMI4IPxo0P08BzS0=;
 b=Sl80KU8+Sd8jTet7Yd8QmbwwnWTOCrDa7nFHuIeq/lvwufhcHj1fxpSMddRcxCDUmJadyP1EGqXf1vVchC7Fb/hsLN8NeRT3L74joYzlHLMo7IXb/oMSB/l0sOvrjmq2BectHwZB/l4xC/ZVld4mO4GxTU6fQIofuzTaI1MpQfG7au3kir+1T1Dh9BgGIhRDOdr6Ou+DIem9L8lpSCoDgGvWdX+fxkzGAEjX/iyyPHajIV7o/1G7jg5MUnVIKAvjyPBnz/Fk8Dkmg8Bsthy9eOrctLJCgKR6rLlP3E9J5UsMMTILAaDgNYRiPlbcto+1Jtnct15HvgnyMrvEV9rrhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBIUl7jjAPjmT9hZVNuEtahOwadMMI4IPxo0P08BzS0=;
 b=Ffa4us/F/YCdCicZQbpKlxYR7IAaGIuvTGYOPl5nXkTPx+VBHqDpvQRNy/FXEIGpIGYY4vKRcXT3gh+nPUGu5yMjBKQbMCFLDc6PO+VizL7m3Wb7qFZbpwMsXgx+22z0Td0kJMnMf5TLlp0ahmowzwBlES7mO0lWtqRodE49N/8=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5493.eurprd08.prod.outlook.com (2603:10a6:20b:102::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Thu, 24 Sep
 2020 07:08:14 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.033; Thu, 24 Sep 2020
 07:08:14 +0000
Subject: Re: [PATCH v8 4/7] scripts: add block-coroutine-wrapper.py
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, crosa@redhat.com, ehabkost@redhat.com,
 fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com,
 den@openvz.org
References: <20200915164411.20590-1-vsementsov@virtuozzo.com>
 <20200915164411.20590-5-vsementsov@virtuozzo.com>
 <7a3ff4f8-3aa8-90c9-b68a-d1676a7b9960@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <1d60dd3c-1296-710b-b4d2-48fccb8761c9@virtuozzo.com>
Date: Thu, 24 Sep 2020 10:08:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
In-Reply-To: <7a3ff4f8-3aa8-90c9-b68a-d1676a7b9960@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR05CA0017.eurprd05.prod.outlook.com (2603:10a6:205::30)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.94) by
 AM4PR05CA0017.eurprd05.prod.outlook.com (2603:10a6:205::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20 via Frontend Transport; Thu, 24 Sep 2020 07:08:13 +0000
X-Originating-IP: [185.215.60.94]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6bacfc0-62f9-4c97-436c-08d860589abf
X-MS-TrafficTypeDiagnostic: AM7PR08MB5493:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54936EA8D08B732331FD9A6EC1390@AM7PR08MB5493.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SgEs3EoOV5G9F+kBQFD0LiMVOz9gW+/i5tBuhIwltsprz6NCX7eweHz4O9GSwM/XHI8b1TBBe3KhjGJQaMSGZOzkOU8EbbRJYnCfetSgLt/mXKITBG691Cg5izFwX/sYlJkZcXFJdA9kTO6dQ+T2l1LXaKhWVcgs3cL2KTZrinFH/V9617bmoiDFgnphw8khuPTPMrm9pizL4lIyOmC35ekEmWT2/9gy1gcGY7Ca+Vg4W9poHp4rbgCct+rYHK7mmnziXf37r3o8+9UA0unB1xwBdMIX8OgvcRRuBrSHg3OAoXEtRQMBJ25NeyqUqE1FaPJVO74rxBQ4/B3l/zmENPnagMeLnRShSH/oAc9QwmKJYvtmYukQw5ZdteNAtOWJKEwFMvtL6xNyuJE0mG0rbKDk5ACsv6j+jEy5UdPHkBc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(366004)(136003)(346002)(396003)(376002)(26005)(66476007)(66556008)(2906002)(6486002)(4326008)(31686004)(83380400001)(36756003)(478600001)(956004)(2616005)(8936002)(52116002)(16526019)(31696002)(316002)(16576012)(8676002)(86362001)(5660300002)(53546011)(186003)(66946007)(107886003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Sqn6OwzWurbocM/5wz1zvM4hfkJRUy3AuvgOW4HyA7tjS6kP8nP8OPCwxUQmmp2b+DsJCSWlImqrHWlj2k4stfV0lW+fvOLTHwc+tmUodpSCyzl4WFWUeSHVLKH3ekFHqc8RlBl7rJUuPSXjaTOvX6Zi9hPIT/CBq2jmuETm24TUwM0nvo7/MBvUj/C+KGz8v4KU042PVwHen0xzETM947Di4JqDb+tz6wdbe2MJIH8rXDluswZm/TQNx4tqW/W2BPenPJ+w7WNI+bOYAD1WzHJc/ozwFfCZj6QUTdGK469/omDFahS24fBHpxnUDl/Cl8vynqL+P1AtndyEEKWd6Gt0YTLtQcyebAuF9Os+T51w0A4CHZa15/951LvbAv32ruZ/GvplTHF/2IgmdCPaFojwaiR3D4f26y+zK0ksQQPQVW/vbLmULjuAgbIGq5j+3qCe/zfeWp5DJUi3aMsV20Wbz/sHD3LCmzQdrpeXu0RObM/Zt5dyGSowwL99ZA889BOE/GMwhQ10/RTfNQGdUFIlG8clKbco1eqsiKwb6r1yQjSSLlQNaOU2dwGt8kxb9XyIB5xRpxln5KzIT33n5xH65XADoafDuehcmA744vlnLFYlDPfG7OsBssnDLXB+5usN1B4c7O7bFmlHt+BYWg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6bacfc0-62f9-4c97-436c-08d860589abf
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 07:08:14.4003 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HiUje43ro/MEu0OhA7ImUZM/f8chKFP3MGlHiVclYBsfQG83mLXatPHH8TOxdpEQ8/NuiYCqPrUse96Op4D2tHTR07hIfCVnIpo5oXyTd9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5493
Received-SPF: pass client-ip=40.107.14.93;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 03:08:15
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_LOW=-0.7,
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

24.09.2020 03:18, Eric Blake wrote:
> On 9/15/20 11:44 AM, Vladimir Sementsov-Ogievskiy wrote:
>> We have a very frequent pattern of creating coroutine from function
>> with several arguments:
>>
> 
>> +++ b/scripts/block-coroutine-wrapper.py
>> @@ -0,0 +1,187 @@
>> +#!/usr/bin/env python3
>> +"""Generate coroutine wrappers for block subsystem.
> 
> Looking at the generated file after patch 5 is applied,...
> 
> 
>> +
>> +def gen_header():
>> +    copyright = re.sub('^.*Copyright', 'Copyright', __doc__, flags=re.DOTALL)
>> +    copyright = re.sub('^(?=.)', ' * ', copyright.strip(), flags=re.MULTILINE)
>> +    copyright = re.sub('^$', ' *', copyright, flags=re.MULTILINE)
>> +    return f"""\
> 
> This generated comment...
> 
> 
>> +
>> +
>> +def gen_wrappers_file(input_code: str) -> str:
>> +    res = gen_header()
> 
> ...is getting inserted into the generated file...
> 
>> +    for func in func_decl_iter(input_code):
>> +        res += '\n\n\n'
>> +        res += gen_wrapper(func)
>> +
>> +    return prettify(res)  # prettify to wrap long lines
>> +
>> +
>> +if __name__ == '__main__':
>> +    if len(sys.argv) < 3:
>> +        exit(f'Usage: {sys.argv[0]} OUT_FILE.c IN_FILE.[ch]...')
>> +
>> +    with open(sys.argv[1], 'w') as f_out:
>> +        for fname in sys.argv[2:]:
>> +            with open(fname) as f_in:
>> +                f_out.write(gen_wrappers_file(f_in.read()))
> 
> multiple times.  You'll want to hoist the call to gen_header outside the loop over fname in sys.argv[2:].
> 

Right, thanks for fixing. I missed it when rebasing on meson system (and move to calling gen_wrappers_file() several times). Hmm, gen_wrappers_file() is now a bit misleading name, it would better be just gen_wrappers()

-- 
Best regards,
Vladimir

