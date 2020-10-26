Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F62EC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 15:19:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6C4B223AB
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 15:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="J4GsXW2D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6C4B223AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX4HK-0004ab-Kb
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 11:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX4Gc-0003vR-Tc; Mon, 26 Oct 2020 11:18:38 -0400
Received: from mail-eopbgr140139.outbound.protection.outlook.com
 ([40.107.14.139]:45701 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX4GZ-0006dH-5W; Mon, 26 Oct 2020 11:18:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VFV8gZJlVYU4vz5gai54KweLMX00aJSaH3bMS7QEgxBfHV1f3sYSfuzJ3M4Srvxw0jZzcw1TldQOQkKCEZzJT1CZWAXFlBpExzxvrZDOsEg2p/Hl/QRYJtwuVnEG9T89G3JLhPmp35d5xGQXBPrbLBGXcc+IYsSxhfL+qhWvizxvI0IbsbL60msOZZ8QzCLg8zZjEpK3Y5+/DIyV6oOuhon04PFUBSRBTXlZJCNZwj9exrb7uqkgBHLM8RgGuouS1vR7wAbIKGJj19I7bH/KPmTQbJKQLS4Lh3WEWKy3w9xg/nBlap2QOgv1DzKbNVFQIGK8VvtkUXvh0Cu6sjeglA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wq5GvnE006lhBftleuvawZTpIJb13YDnGI5mXMQJMfk=;
 b=TTjYJ9pUbDvpn+bpnMMeh8QD+dhUQHyUkA/UKG6e4x5MDL1voR4z4i1bR85GCOnyNt9rptQj8ATm7Tk5tSvRO8YmnsGrleQthAed6l9qg1pb243IpA3WYbszxE8i3aOZFOLxqvuBRI8L99UybUk1KSZ0iS9lwC1+ics2UG62Slf3rAqpmva0Dbe65XVyooFBGPpJRaJJ163epaAEQj0CjfDlBkGc3dzDjGGw0yOAM8RplMsY8+crSHBD81mvxahYM25aeTQfu6QOUWTiMJBzzQhhM0JFlpssRT2o9VTm1weCP5PMm7c5iJcCD/JAByciFlc0pseMTAGUJqrXIMdL6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wq5GvnE006lhBftleuvawZTpIJb13YDnGI5mXMQJMfk=;
 b=J4GsXW2DSqnFX2kRIpzzi11NtU5Mc87F5wlE62gOKnHqJJA8GNI6FcCmTDMXZTZE4pX44cDO/akDU0CP2o7t5EVCIDUvr3WNqH5tIMJESxI8iXtT9+TFP8lfY75Ukvhzvv/jetDz1/2YYEpxtp4fkrMxG5b6gr8ho9SrFRX/I1Y=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AS8PR08MB6165.eurprd08.prod.outlook.com (2603:10a6:20b:29a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Mon, 26 Oct
 2020 15:18:29 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Mon, 26 Oct 2020
 15:18:29 +0000
Subject: Re: [PATCH v2 17/20] backup: move to block-copy
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, wencongyang2@huawei.com,
 xiechanglong.d@gmail.com, armbru@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org, den@openvz.org
References: <20200601181118.579-1-vsementsov@virtuozzo.com>
 <20200601181118.579-18-vsementsov@virtuozzo.com>
 <6376705f-d24d-1b40-f4dd-480c53c7ae55@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <beafc976-64bb-a278-3a94-4cc7b118fccb@virtuozzo.com>
Date: Mon, 26 Oct 2020 18:18:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <6376705f-d24d-1b40-f4dd-480c53c7ae55@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [185.215.60.99]
X-ClientProxiedBy: AM4PR0701CA0002.eurprd07.prod.outlook.com
 (2603:10a6:200:42::12) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.99) by
 AM4PR0701CA0002.eurprd07.prod.outlook.com (2603:10a6:200:42::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.9 via Frontend
 Transport; Mon, 26 Oct 2020 15:18:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2bd1d9c7-2a0e-4a4f-5d82-08d879c26468
X-MS-TrafficTypeDiagnostic: AS8PR08MB6165:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR08MB6165AB251D2BB1DB93194820C1190@AS8PR08MB6165.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:551;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GFTm9vPfKB5HvVSNqUOYaUYNffn8+ypWXnhTSplSTHaWadRvfYYD+mb7NZ+6B4K19ZXjjdDqTZ0sZlOYD/VroYK32moQc/g1o6uyqVUX+nx2YbzBLUmrMpTMiPvOeIrIR5cczL4gdbwsOnJ7bhaJQQ64dCVkV2zySbH+0grK3EcXId7EuRqsKldF6y/WUUMtK/AoqSEutW6bfD1krSFDqDyXjnr7dYPgxcfvjoQAoLC7037njsJ622ohNNHGU0QgoG6XsAmBJNrlfwhZZQrPraNDCh/hKb+Vj9LMBX5VUaj3CW1kFJjFp6MNRm88sX3yd4hnpaQzrImOe8wzNYiXDRv/4WsJo4aeiWpZ2KOgmlaHOK8UYqqwFOg/uO2H5tBa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(376002)(346002)(39840400004)(16526019)(36756003)(107886003)(8676002)(31686004)(4326008)(2616005)(956004)(2906002)(86362001)(478600001)(6486002)(16576012)(26005)(4744005)(52116002)(8936002)(186003)(83380400001)(316002)(66476007)(31696002)(66556008)(66946007)(5660300002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: jw75dkHuKIMqmVpioPfqsxIRV3G+cSrV0FkLJwjRovbQjLjAhwoQhO+0qNaeOf9ZO/mPDIAZAU/SCJzpSO7fCyZStN+7LZSw3jQFEsBWATk0zbhedGVqq0KRPiSMAFinjzkXusC8H3sHvuzdav2S1eFKFUGoc7V3Bk0ErMPLkUcBqMkYuxzZqEKTICRlWDyI1XE7YzIAfrywAFnWEIFpPn7R4kpxopAjSOp2uZokx1KUVv8ugqNyobKkwSFXlEJvlpb4ZSHarxcnJzItOVrg+Qurz1UIA/Lyz+0WGro8ZbmL3ZsGSltQoH5yYs0nLPLlOJtIG/wTM0Js4JlIaflVYBotu51Z9oCVw7AvayvcO2mgDCeb65zSq1R9tqC6J4u441y5LSTo/pAg4NM70daNqJFgzAts8zdxYHPOcF5myZeXM4t3S85hQbV50yUhhAR8xD6vqARFRYPzjTS8FjfXnCmULv8lL9+GgyQ9AzZqKM0A9T8Up0/2KG5XBKRH+CsMrIdEMNHBkBWEIh/EBh32yzg3CAIitv7l/4XttwzrF3yrCEKzCRiSK11YLINaGBUesV6bbpj7I8EbMBBbaam9cTZ4eYa8m6GWiVtGyE1xIuv7PENc7HfgpuGVypi+cdnW+mX99YiwqeIkWRtwpkCt9Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd1d9c7-2a0e-4a4f-5d82-08d879c26468
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 15:18:29.0512 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wF2XCUOzVtTSwihtqMHOhCwlNL67lCZJiQlMWxFDdFrLbNUv7uNhc5UukFjhjClIS1jlKuGzxmIeF38ixe8Q/P4AXRauqeYoMWSrFyEX35Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6165
Received-SPF: pass client-ip=40.107.14.139;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 11:18:30
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_LOW=-0.7,
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

23.07.2020 12:47, Max Reitz wrote:
>> +static void coroutine_fn backup_set_speed(BlockJob *job, int64_t speed)
>> +{
>> +    BackupBlockJob *s = container_of(job, BackupBlockJob, common);
>> +
>> +    if (s->bcs) {
>> +        /* In block_job_create we yet don't have bcs */
> Shouldn’t hurt to make it conditional, but how can we get here in
> block_job_create()?
> 

block_job_set_speed is called from block_job_create.

-- 
Best regards,
Vladimir

