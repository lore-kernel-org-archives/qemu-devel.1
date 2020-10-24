Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D315EC4363A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 10:26:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 073E920780
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 10:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QpW/B53u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 073E920780
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWGkg-0007OU-7Y
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 06:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kWGjS-0006Ke-Pm; Sat, 24 Oct 2020 06:25:06 -0400
Received: from mail-db8eur05on2113.outbound.protection.outlook.com
 ([40.107.20.113]:65498 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kWGjH-0001gq-L4; Sat, 24 Oct 2020 06:25:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f98aaWN7JPEWBbfCIYtwgT75MGGd3H5l6nY0x4w8DV51QsUDIBoFPKbq4ycjeGyIcp47wUgRAQqB9+FvVDTy1Y8I9NDnE2JHv8QSVgq+gMPjkEv7AR8vfeJi2f4UZFRxrRny8PoqkDArC+Knm9RBFOgo9z1+cDpfteha3P16G/34NSZlh15V0k+4PFfoDKVfPELT0hrySo6S9M72oXttiWHIZMJ9yUEh1eCAylfjhaYfG4qKvu5K0W5DSIaCHzpUSvHfdDwOkhR9AtiMVSB6sFybEsTa2R4XegC2qHmIWLbwdejjCLl2KO+PF6AIhJIw/K1XJ5kA6vRAQZHHb7BN7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+G2YPSw8+xo051rsOVPQj2GrJfOkvEhabDg/KBgLHA=;
 b=XWMUycUdHRQk2euj3q/6MP17y8M9IfWi93IccB5mszxBZFQhU16Y7FmHyYrQ6DJ4rlpVmsNGiybKdDlBqbMJ6kNYO7iuilPO8beCJ6N1G5LGf6UTIOfXUdaFfBVKPzXDmJEpGRPdj8g7Tanbv5DRq7VVuivgRoXKhl+Yd2SEJc+Of0yuQ6ZkZNVA7LauF04JnVHQcgFOaprJI1s8+rARiG7fq2UflNeEZ3PFoGCSiXHIYE7TAfwWJ44PGSo/+/Ynzp3SM6mw5GhEOvSY9FkZSQvV1zGt80ZROfCsikkjDWbV8p18aBx4NOzMBeM/c23uRF6ycndWE0z9pVdJ+4zPCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+G2YPSw8+xo051rsOVPQj2GrJfOkvEhabDg/KBgLHA=;
 b=QpW/B53ubBZf8qfVR2t9jzPTGF+V5i9LRcelYCeLRVYTuqhy7H/uxpuGblIFhgF52UbiNhkFjxfWlDKCK/HYWz0X27FMdnsZFS4vuprIXuFNsmGKpegkjijAP0JWRNZYoz6MIAS1fnI7EzSfp84GDNZw7VPFC7TXoA9aSJh8m+s=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4600.eurprd08.prod.outlook.com (2603:10a6:20b:84::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Sat, 24 Oct
 2020 10:24:52 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Sat, 24 Oct 2020
 10:24:52 +0000
Subject: Re: [PATCH v7 19/21] simplebench/results_to_text: add difference line
 to the table
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, eblake@redhat.com, armbru@redhat.com,
 fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com,
 den@virtuozzo.com
References: <20201021145859.11201-1-vsementsov@virtuozzo.com>
 <20201021145859.11201-20-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <961e31f5-eee3-9dfa-b2fe-7a800e5a88f9@virtuozzo.com>
Date: Sat, 24 Oct 2020 13:24:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20201021145859.11201-20-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.99]
X-ClientProxiedBy: AM0PR06CA0107.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::48) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.99) by
 AM0PR06CA0107.eurprd06.prod.outlook.com (2603:10a6:208:fa::48) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.23 via Frontend Transport; Sat, 24 Oct 2020 10:24:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdd98f77-e973-44d2-7c78-08d878070b05
X-MS-TrafficTypeDiagnostic: AM6PR08MB4600:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB460072FCFF9B8A7931F8962DC11B0@AM6PR08MB4600.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rjZIZUiy9dwGMcWLdxHfVs9nLRUT6Zt1QOVNSA/FYVB+dgIWnNlYafzf30nI/v5A6ulsH4TaaSkggtk1vW9YVlEFzxQ1DPDSDkyrvmDGZZFhC1Zg3gJExQNcXZbJSNxSrX9xT3R2TIl6RKcl03ASG2Snr2ICb8xycOFtcEvVoHacDBL3qw2Bpwxvkv3cIDezzS4Jksd2ppophmAEUGr/pIH6UE2STc5xhuEwhx4nV5bqC7ROsiGwRfFQrl897XSh+ISi+WZnsq4SqaXAKZTji95FqZC54BYj6f+80hWqY0P7Y5e4GIjUzFXfouKlPNpl0d/RdT0rMBCMUnsL/KQG1XfeQ4C5zR/wOp7fauyE4dgZJ7AROq91jzLyU9BDn5ck
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(396003)(366004)(346002)(136003)(376002)(31696002)(26005)(8936002)(478600001)(52116002)(16526019)(186003)(16576012)(8676002)(107886003)(4744005)(31686004)(316002)(2616005)(6916009)(66476007)(36756003)(6486002)(2906002)(5660300002)(66946007)(66556008)(86362001)(4326008)(956004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: /o6SAMkm+sW+xcg/hmHLGuwb9jMTMPUYi5F7nyRbxRbxffoao557mQnqPoSLk/NEDj/Y7t+mfVQEwQdm8Eik7/n+wqIr/PHcflpYlH6CgKcs8gitqKjfNB9ex7QXiixCXU++xWihqYsbn0xZtRfDRzyqoGj1u+RJobbuYgF5Z9+cjyGnoBGkhdiusIA9ypM7Bf5l4LCr9ukJmYBJCtIq0hoXBdm6NMuq+irAP27vIPTxjz7Cdm5R4biODZFvqNPbQglH/bX0Rsd3/dHGJdxOU89XKM1VfCnQLypRH+nNLOpxoC6Yhk0ZK+wnol8Jj/9+YD6iQVlxbV58Cc3FIMdxMaXKT8U1MgXXa24bdMqhQgoxMlBSa/ftRTeC361XAZkXzTblXYzjTiPQZQuv3zrlXTOCeQvFKVAICzgHa++3CMOpLOU/i5UPtR1uwukOlFjrZtF4ck6RYIaNGlieSpX5tiZsumW5xErYzvMFTL2cBJ7GzTe+1ZommMMGsDnJueAoi4pJWicyPTgpFcW7+N6iL5rK40je8RaIVdhHcWeHAhkIbb1GkHE6hxSO9BMXgLNHR9Sw4lTExIfNB3kVxwkx87QGJlNBQds/78/UUSNbS1yvWE+rp3ahm90cik2aDYKFJH8yoNdac7tlwxbvGUaYLQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdd98f77-e973-44d2-7c78-08d878070b05
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2020 10:24:51.9451 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qMiHXSQpzMYqYJRSd9zs7JzIE1U4YHyIo2UqgJj/2An2ozyLOlc5N/IWgwKsSg2V8RzRPbVZnvX2zAq8i9Fwy38AR6MPCnqzqJXQtmHFM5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4600
Received-SPF: pass client-ip=40.107.20.113;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/24 06:24:53
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.108, RCVD_IN_DNSWL_NONE=-0.0001,
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

21.10.2020 17:58, Vladimir Sementsov-Ogievskiy wrote:
> @@ -39,21 +43,70 @@ def result_to_text(result):
>           return 'FAILED'
>   
>   
> -def results_to_text(results):
> -    """Return text representation of bench() returned dict."""
> -    from tabulate import tabulate
> -
> +def results_dimension(results):
>       dim = None
> -    tab = [[""] + [c['id'] for c in results['envs']]]
>       for case in results['cases']:
> -        row = [case['id']]
>           for env in results['envs']:
>               res = results['tab'][case['id']][env['id']]
>               if dim is None:
>                   dim = res['dimension']
>               else:
>                   assert dim == res['dimension']
> +
> +    assert dim in ('iops', 'sec')

s/sec/seconds/

> +
> +    return dim
> +
> +


-- 
Best regards,
Vladimir

