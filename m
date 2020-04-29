Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C0CC83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 11:33:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14BFC214D8
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 11:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="BEVZqFfO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14BFC214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTkxi-0004g9-4T
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 07:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48360)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTkvN-0003Ff-4e
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:32:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTku4-00037l-8F
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:30:42 -0400
Received: from mail-eopbgr20108.outbound.protection.outlook.com
 ([40.107.2.108]:43341 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jTku3-00037O-Bw; Wed, 29 Apr 2020 07:29:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oq0s3y3dtcS8erYcy3mFzeyAawNbglly0RzjZs0k/rdmY4S/IVvZPZMRbYxrl20b3yHx+M1TZnis/hqFSS26rDflQn3VB7eH4xmmy9/Zik3MK5+QshkoFwT5Bb5tLXG/9Y3GHiEL1R1QRE0Z9Etxw0vs8IbF5j5eL2CeUC+nWn/l4LvpEEYUHp3FsKvFws1pdt0ToBnrxavCcwX2bg74aajyLPqHvXoFtyjJ5pF38KoZCQLZsQwNXKSaH6mFkhl0wdoIztW7CDIaJYAWThW1JTWu4FzGTGMvsve3NwzR6d7vHAFFsg1ASVRtn6c4kbz0QrF7XfJyZzYBnqxcL666cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/eb9D2HpmCburg4e3fFxwOUwxHeU91VYRNJDcVs/Xo=;
 b=CGB25kU6iuoO6fgZdIkLfd7hKw16Dy3W9BqWZGHuCEzMwnbR9F4JzUWeguTiWnfNrHrdqR6zzEZZyDfFN5Ae3qsPrwjpjSV9DowGn1VepgZsK7KlZ4swI9dI0rOIljY7rLBqesAxGVLJmvIXJlNXo9II+XkGxOmC/4iBhgHdSkSS0K6Tr0baxyI3gxAs8QO9gyIiJaZKaHw/Om/KZmpy3ntDeLg2GNuC/XnLJ4X3Sbyq4KtP/TxcdbnT/gJenuqpRC2Ox8cz6vMJ598paBuVz/3hMevGFCB8/yfL18Xvd8CP/Q8FTnv3D+fpMbnEuVzyfiFne+bIHA0ZyUNDMICxHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/eb9D2HpmCburg4e3fFxwOUwxHeU91VYRNJDcVs/Xo=;
 b=BEVZqFfOHmT4FzW6w340bG5Bzvpt/xEL3FEVw4YfDGerA69TfRpvm/5zFe/oP4xARuxU5sLfVhZreSgPlxYNaag2WXHFiLYOyvrrGGFRk/QNBmLM01dOcLJQ66PG6+Bk0N23kK8AASQsvZmd/nnSBt9koAYxb5UnBZiB9BBcCHQ=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5397.eurprd08.prod.outlook.com (2603:10a6:20b:dd::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Wed, 29 Apr
 2020 11:29:19 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.023; Wed, 29 Apr 2020
 11:29:19 +0000
Subject: Re: [PATCH 1/3] backup: Improve error for bdrv_getlength() failure
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200429111539.42103-1-kwolf@redhat.com>
 <20200429111539.42103-2-kwolf@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200429142917889
Message-ID: <31f6106e-7e4b-8d86-5241-641b3707e5a4@virtuozzo.com>
Date: Wed, 29 Apr 2020 14:29:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200429111539.42103-2-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0029.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::42) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.184) by
 AM0PR02CA0029.eurprd02.prod.outlook.com (2603:10a6:208:3e::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Wed, 29 Apr 2020 11:29:18 +0000
X-Tagtoolbar-Keys: D20200429142917889
X-Originating-IP: [185.215.60.184]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b181a4c-e9e5-4eae-5e71-08d7ec308eb8
X-MS-TrafficTypeDiagnostic: AM7PR08MB5397:
X-Microsoft-Antispam-PRVS: <AM7PR08MB53974AECAFF2C355C210C97BC1AD0@AM7PR08MB5397.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 03883BD916
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(346002)(396003)(366004)(39840400004)(52116002)(16576012)(5660300002)(316002)(478600001)(66476007)(26005)(66556008)(4744005)(66946007)(36756003)(8936002)(8676002)(186003)(956004)(2616005)(16526019)(86362001)(31696002)(6486002)(2906002)(31686004)(4326008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iB0op3tJcdB+VeehQ/4itWZbU90TNz+/+ioHSpH8zU49dgmPv9ymKWwNVO5Zfn/KcXrM2k60eBRtG3IMly/DMZz3GmQ1Mh6jzuCX8BYq/gpMetFCJdKIctlkQW9+x+Yk6U/S4PWc5l+Bn0gC5iRzZykxNLMnnaUgtQqshQPTlIZOCnQWuKVw9YQ3EvNzpRhYWSc2IxwZt8QGytJ/Zvvf6eBGuWPDEM+A6iI2K7Q+PCPyO2YHpPK54NVXiBD72x1/otP1OoozGhr28vu161aQjCueP3z2Aqc3eTjLm2j589lhtuAkokCHfnlvCns1tqqcZ+lp3PRDWbk9VOji666ywdde2/SDoN9EOFkiiQodUBUMafvp06EDH6nkUiYlXX/LYTOQ2GVT6S4lPZWjp5Gp0P2C+1kepSUdL1ZL9D8B7fmzsqGpEKwEqXF+EOCgRUCU
X-MS-Exchange-AntiSpam-MessageData: gQnIg/FMsUTU64BZ2v2SeOFIjbhnO8welVtAUjeB86/PHd3wDkUJgLKevEEWY9/bwO3sdJfZE3SVTiKq/8v7JEbBn1vsIv7zAG82D4nQDo4iTkW5v+gHaW3aMVOUvQOIMP7THel4r0O3/7kzi7oOgE71hUwNkYr3Zx70i26bTfiGuVwShw+/lTYRzIEBY4KzDHLexzatxjWxRZ7VWNlzF5xPyVRQkULEvTNZ5zxWlB0L3JSawXSwGLfdjm1hcx9LsgGeS1H54KfNiXh7LPdd4mBz4y/8LAoUxFLD3pCjEJRxIaODhoxgffnL5SObmodULy364P/T5qarsD7gebZwK/1YNiEhi0BJ0imNGnpIsWcu2UtIh1mLmm7MwKLd2IPRxgrg8aoyV0pPQIwgy9wmOhlUE24rE9QeE02pV8kbW7sGE+h0xFFEFfkCuxKjfa5Af+V+8oG8dteHdL3HywLk+xVIcbVKQlmY56kpE/BnOcuXikyCYt8HHOsvm8ruPtUIvmv4qhbckuucL88px40d7KTIfXPJrsVmlX362oQGVCecOEZTVA2KMrTrQ1ySmHzfE6UyJROdnJmZ45lIcWk8qDUDPNENkUlJs3BOcc5eThRdSKzBkwmRTD555Dp7bmtQ5xAioPyh5mrHOxVxnG65ZkxDVv13zYWIDdkAvpE4FYk+x5l2A2IooLU/EZgqjfrmLK1kCWeErEz9mC/AQGxyf/zUCW+40SD2Lzw03u8Ex+ghP32czC0dfz+yB0+q8vcy0Ea3l7ZBzeepQ1/p2KEye0L/dyaR3ejK2cZTVI4fa0c=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b181a4c-e9e5-4eae-5e71-08d7ec308eb8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2020 11:29:19.4551 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GhlJEKBbvY0g8itbSN2Ma/eAoFj9eDPgONDdTaqBwGJDaQgB6q6EQomwj7c4+FCJjgH3MTUoY1/6Z7xlD+yw42J7zFzpRzZbaYH1/V1E7XY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5397
Received-SPF: pass client-ip=40.107.2.108;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 07:29:20
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.2.108
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
Cc: jsnow@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

29.04.2020 14:15, Kevin Wolf wrote:
> bdrv_get_device_name() will be an empty string with modern management
> tools that don't use -drive. Use bdrv_get_device_or_node_name() instead
> so that the node name is used if the BlockBackend is anonymous.
> 
> While at it, start with upper case to make the message consistent with
> the rest of the function.
> 
> Signed-off-by: Kevin Wolf<kwolf@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

