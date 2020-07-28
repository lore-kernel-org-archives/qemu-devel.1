Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E773C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 13:52:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59D5C206D4
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 13:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZouPRKbR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59D5C206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Q1r-0005gM-M8
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 09:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k0Pzn-0002ae-Ru; Tue, 28 Jul 2020 09:50:19 -0400
Received: from mail-eopbgr30091.outbound.protection.outlook.com
 ([40.107.3.91]:9187 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k0Pzk-00040W-H7; Tue, 28 Jul 2020 09:50:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dR7Dd1+jhUNjSMrULG3aSYLJP2+BZjpDC6G3X/pvIFnPWCoDCmi1dqRs/NjnqU9TecvdfrpqXW651Pqin63Ow/ypd+oRpkJz4aT//ynKJR30OLhOoTyGtJxzUVshulIa4mflIX2bwldEtv6ryy8Zh5xtZl5nUXb7y8v5VU3QayKiV7qBBXz+3da1Q35WUviXlB9aMcyBSkD+ziravo5DKj2vONkdDbXM0VJpYmiLly4+D3ogWxK2nZTS2WJSDpxgZOObhYg3F4stSiGVJL0FCRUqY+MeOWk9wz4R0UggCp5axHVITSfeIbVjILPf5yM0vNTGCBh8g/nfgsb5sU3vCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9jAhHNd3tGmTrDdF5v/U2LBZKjislAc13K866Hk5e4=;
 b=f1aihljvjgCnbou1OjM+KSy7qAELLWJBY8qWA75/Ybbh5G0w+YIdCxJtW/1uLO+ScyrYlpp1lu3ZbWieapZ+Xy32V4uvZEGwlBy4/Dsayv/KX/zjARidZ8lmRQ3daHQW82ZWaNNlBT5zS7eA6xp315ETwEQRlwjQQyx3TzLr5nf3Gsj31lK7ZvNJlhYimE3Gw4+i+3tcWvxoo4H4zhEQXDctYDgsJteBsKhcyzE7GrPsuXqsc6Smvdtp1nfcM183yXYmxxhyQrZQPuNQCUQAFOrGQaWfQ+4cNkTew2KQiEWhC1eW8HMfBiAAwEg2wLCmToGeV2j6Genhihr3/kepYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9jAhHNd3tGmTrDdF5v/U2LBZKjislAc13K866Hk5e4=;
 b=ZouPRKbR7MJtQihUZ9/R0rcvIRiKxrTw2BQMZ0NVTZFhFN0/MOBEfDEcEoXQFjIU4/swVreqorxQ+UykLe/+Nr1l1Z7NLKW/ULXCFq6vxmKbIfpzllDR1ocqvFlxDuyF/bg9MhtNjieR+/pKT6X8dbp6gR/ESh8fJa3WhiJ6xDc=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4021.eurprd08.prod.outlook.com (2603:10a6:20b:aa::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Tue, 28 Jul
 2020 13:50:13 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 13:50:13 +0000
Subject: Re: [PATCH v2 3/4] iotests: Add more qemu_img helpers
To: Nir Soffer <nirsof@gmail.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20200727215846.395443-1-nsoffer@redhat.com>
 <20200727215846.395443-4-nsoffer@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <398e7bd6-3bc6-f42a-0a9e-df8cc76e073d@virtuozzo.com>
Date: Tue, 28 Jul 2020 16:50:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200727215846.395443-4-nsoffer@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR05CA0088.eurprd05.prod.outlook.com
 (2603:10a6:208:136::28) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.158) by
 AM0PR05CA0088.eurprd05.prod.outlook.com (2603:10a6:208:136::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend
 Transport; Tue, 28 Jul 2020 13:50:13 +0000
X-Originating-IP: [185.215.60.158]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5d80fed-57af-4959-e7e4-08d832fd2710
X-MS-TrafficTypeDiagnostic: AM6PR08MB4021:
X-Microsoft-Antispam-PRVS: <AM6PR08MB40217BA22050CA39E7F8D1BDC1730@AM6PR08MB4021.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: znn3rWbmvJcOpZM4hYurN9o/Wiu2SB4HXoFxwbGgSJ+13eFj4x9/PHX0rTlKNK0AK1eDwgxtGSPa9uoC53dz4z1Qdy15BEuN9/QJ/Eg8X40/dmDWtyCkydBft2DSAMs//bHA5aJQq3R/5SAYyUjSVfTEproN0GnScT7LSPhAdKgxBEMaNuCX/HWhaSK+as37jt3euPyq+LN5lwCG+fNx/CVo+kWoNOXipv9lnWlOrxAAZu9KMxDuk8gEe59CplqsddYA+GUElqiWIl9KOq09N0gllbummLpXJYCzZLuCjhF/KT+g57spRVE9LmmNFd9rS+uKLpLCS7OK7reKwRfI9AqbPwGsxOmbhcPwU0ePt7ivvHA3OObQ/FxFaB1yttN0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(39840400004)(376002)(366004)(346002)(6486002)(31686004)(36756003)(16526019)(5660300002)(478600001)(4326008)(2906002)(31696002)(8936002)(2616005)(54906003)(52116002)(16576012)(86362001)(186003)(956004)(8676002)(66946007)(316002)(26005)(66556008)(66476007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: w2ax0gIiKgIL/idNbmf6j0b76izTvRkBOdnNFECqW1lys3Y1ObwKIln8cd88ZXDORczOGnTFZ21d98WesJDl0r25X3CFy5iCHrIhZ+vyLpDE9zBLx6AJZXK62+/v+ELdi+OKgmb8s0l27Lm90yUPOxmcX14eJiDz7NciketkDpG5iEh7gxhj7bIdRA0lWKgA7KbewCLNHyllsDP5FgnLseMPyWIZ75eirSmJKTLERQAPzwBn6BDoaNdAjLjL+RHXHKdOQ26YVHG6TgnHHFfC254oA8Ix43we9aVzid7sukmgpDks0UZQpm91cowclxnzfBiPpr9uoKRQ7r0uixvQT82f2ZarAxtK3doQTPzaP4iJZ4A4LDSeovuLFPR5Y1Pbt33nHyhqoU0XrLBA857SQvzx2Rt96Or+VfZifk9xwrw1Zc7tDjm7z94lST7yBF8VKc+37bGv+EvaHl58z+A/MNLV1wJArB9rcR9dBMBPfypkZnUIot6j0JeCfcEQkVhD
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d80fed-57af-4959-e7e4-08d832fd2710
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 13:50:13.7305 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /HwqYD8nml+hhSOXhibvMKMtSWQHAzijlZR1EBEJFJEprjZvBoLBz9dxvfAY1cQrqV481ZMMYl/4DFc4GzF1TbfeDDovnf18ok85Tg0oEm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4021
Received-SPF: pass client-ip=40.107.3.91;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 09:50:14
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
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

28.07.2020 00:58, Nir Soffer wrote:
> Add 2 helpers for measuring and checking images:
> - qemu_img_measure()
> - qemu_img_check()
> 
> Both use --output-json and parse the returned json to make easy to use
> in other tests. I'm going to use them in a new test, and I hope they
> will be useful in may other tests.
> 
> Signed-off-by: Nir Soffer <nsoffer@redhat.com>
> ---
>   tests/qemu-iotests/iotests.py | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
> index 8f79668435..717b5b652c 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -141,6 +141,12 @@ def qemu_img_create(*args):
>   
>       return qemu_img(*args)
>   
> +def qemu_img_measure(*args):
> +    return json.loads(qemu_img_pipe("measure", "--output", "json", *args))
> +
> +def qemu_img_check(*args):
> +    return json.loads(qemu_img_pipe("check", "--output", "json", *args))
> +

qemu_img_pipe has type hints, so I assume we should add them here too.

Also, qemu-img don't report errors in json format, so in case of error, this will raise a problem about something that json can't parse. Probably we need better error handling.

Still, for 5.1 it's OK as is I think, so if we are in a hurry:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

>   def qemu_img_verbose(*args):
>       '''Run qemu-img without suppressing its output and return the exit code'''
>       exitcode = subprocess.call(qemu_img_args + list(args))
> 


-- 
Best regards,
Vladimir

