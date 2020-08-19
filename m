Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93810C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 09:54:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D0B820658
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 09:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="IGcxot9T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D0B820658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Knt-0005Fk-M7
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 05:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8Kn3-0004np-6E; Wed, 19 Aug 2020 05:53:53 -0400
Received: from mail-am6eur05on2131.outbound.protection.outlook.com
 ([40.107.22.131]:29280 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8Kn1-0004SJ-6o; Wed, 19 Aug 2020 05:53:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUqqvw8VWp3HIf8BdZoCe4roc/pGnQHQ/N2q8QrCJll+lr2Ih9GuVZ02wSsT0HjVPKRGuVDD60A1GmRtKfOZxJDW2lzVyqFb8ft0fqevPCoJjL1IetqfO/AYnIbielwWtNGqV6jqCRMaxAC+ggRmeSSvedOJaamOn0lfx62sbvPms269D9uXkk94b+CdOz19g4Aod1Bzcf3cW+ORPGRp1a8NjnOupeFjW/ha0byCh4M6culZooMj3HaPcMIcbTl4rbhM6L0xFvpvWfCLPzbxMnCbNHX9enzGTnC4xKL79g0m1U2DHKpUfqgvqP+jpYB5M3i89bGeOW34+z9d3pBXRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hNE0BImG+ZLe+BeJri7ESL2Ppe5tld9lRAv/zeOIFg=;
 b=FAD7T4JrdCq4PM5FwYyNHa7OMCNh73eFgMTkXwojKwCNv3fQEOwydSYwBoj1gR/CJ6N/IQU5rXL8x5ChldeN60jfrnNmfB8PZfCedvl21yFw8K1SWvBa+Wc+Wi/CbGfDlMgXEXPAUBQ592jmf0C6JwcJbZjhG4uklbd/BBG/A276rZxnOeFqSH0XnTQJulFbYRB3PN1bl+6AAb+amsUayRDu8WTk9xH6xiXtKxChZHA6jDImZQ+w/yhZpLBfZ87AUnTL5N3xbap9s0wF5ZnQBBIFQ5/jCe8KpXHhQNUh/Yk4P72sS3RwNC5ielEsM90wFKMEuFBPSXP2Yu5X9LjX7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hNE0BImG+ZLe+BeJri7ESL2Ppe5tld9lRAv/zeOIFg=;
 b=IGcxot9TK5Sdi6FYqb+KvXpfU9KBnMYsiTXR423CJuDIoTEQrwGx0Um1woXq98gIdXI/axAdg0loBqOyjxui3R5YsTLqqie/UCXUy87bASl4jf1vgaodmigvXh7zUpEONlJ7K6+iKPSNIWBqUdxAYSOaPec9v8I+ejvPXwHKXh0=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5448.eurprd08.prod.outlook.com (2603:10a6:20b:106::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Wed, 19 Aug
 2020 09:53:48 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Wed, 19 Aug 2020
 09:53:48 +0000
Subject: Re: [PATCH v6 1/4] copy-on-read: Support preadv/pwritev_part functions
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1597785880-431103-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1597785880-431103-2-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <5bb6c740-e6b3-2644-4644-8afb8ce98eb0@virtuozzo.com>
Date: Wed, 19 Aug 2020 12:53:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <1597785880-431103-2-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR05CA0033.eurprd05.prod.outlook.com (2603:10a6:205::46)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.171) by
 AM4PR05CA0033.eurprd05.prod.outlook.com (2603:10a6:205::46) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.16 via Frontend Transport; Wed, 19 Aug 2020 09:53:47 +0000
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 039dd9b3-9c3c-42b8-ae74-08d84425c4c1
X-MS-TrafficTypeDiagnostic: AM7PR08MB5448:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB544880B0E9F2447B4DC13908C15D0@AM7PR08MB5448.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GWswZGYmQfe+7F6csvkkqxmT1npOY9edfMmSAHNquDb+Y+UqZd+S92s6+qekRLtn+Aow7IgqJxDo1kJve2bOZXyb3srtIfozOcIHMH459n4IS7aCcaEQqcmWJS3WlB6ZOFPVZ2vxf3X2N71PbcUF78QBnxccg22h3uxckvUcQxAMKmvbFFJoDADYtZSMZip+eXXi53Et9VWDBNXjziNVXLx7u9A3scQAyn11UwY/cwWxSWHrVXnGwQdnW2ye7VhBDHUVIA2xSDIaXjc0Ipv4y9yHzjHsZq2+h6Z6xf3aPMgyrlrAD9d7WgD5tk+iUKofyK6+wAt/BrRmwTyXgCavXpvci8UV22xI39EbfCgNQg8dpIjvSemzB71uJsQs0+KH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(396003)(366004)(39840400004)(5660300002)(8676002)(26005)(16526019)(8936002)(186003)(4744005)(2906002)(6486002)(36756003)(31686004)(107886003)(66476007)(31696002)(66556008)(16576012)(66946007)(83380400001)(478600001)(956004)(316002)(2616005)(86362001)(4326008)(52116002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: pRJTBJlFQ6Yt8hkWeqX4idy7p03cCB1Xe+3lnZP0m0Ue0QuJyyXwWQPSxqMWo6ShhouBRFAz/Z/7di44mJTpw28kKyDWtsLO6o4V7AUgeAnWwM/WNVazzxLhSib90jrv98WsjrWtO9jn+y0psphvpaIV2wH/Ip+3rJC8DdTO3lTVCm3zH+HTW66uzk9WgY6hBeHq5qvGe58YJ7ntw6iDS6e6G5X69otvYSkN3YOcqOz+rCqQnnkw9d158jfWYTfSXSppXlGxjYx7KDwD/quBDspCMlz0SJYxWPxxaLiSkNxyYb4bLgYXAimOXxss4gtW7qwhUpBky+QO2sIxo8YNl9nDJmzn5eKaIPbVDSOCM0PWy6jqylXaWLMQirxZcQoIpfZekPqxQUhmnxYOmCTOcCbMksrOmT7yL9R/RUSgKMkvb/OzXJLMRyQumM3ckavobr8CX06dYs8KH0wSlFi5eppGdjelE11ys2DfxAWENJhAw7qGCp7+kkwB8IX7nT4Cg5jaoGB9R/TyUfta+OAzI2w+SFEvMn7ZL23aSc8+g90zPKOg5N4DW7d85zbmZaLDCWBoQU+S2gQ3dErV/0qBEqjQzXIZJlqXRjeBjt/lhJaVIfCg0yohybTeie9Kk2sFCWj4gzPq9ZsmiPsScYeabg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 039dd9b3-9c3c-42b8-ae74-08d84425c4c1
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 09:53:48.0034 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OJLycympkVa45OqO1COwuwQ1mwFKajBbH4XxEsq28DoPPAB1SPT+X4hMRETxE0cV2Te8NvFUuniAEU28e8jr7ghNGzDP1uakuz51qgtiv0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5448
Received-SPF: pass client-ip=40.107.22.131;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 05:53:48
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
Cc: kwolf@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, den@openvz.org,
 mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

19.08.2020 00:24, Andrey Shinkevich wrote:
> Add support for the recently introduced functions
> bdrv_co_preadv_part()
> and
> bdrv_co_pwritev_part()
> to the COR-filter driver.
> 
> Signed-off-by: Andrey Shinkevich<andrey.shinkevich@virtuozzo.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

