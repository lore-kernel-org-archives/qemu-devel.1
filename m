Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6A5C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 11:07:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67E7A22D01
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 11:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="L/QLcUai"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67E7A22D01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3HGt-0001Rf-Fg
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 07:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k3HGB-0000tP-LB; Wed, 05 Aug 2020 07:07:03 -0400
Received: from mail-vi1eur05on2102.outbound.protection.outlook.com
 ([40.107.21.102]:41792 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k3HG7-0001Vc-OT; Wed, 05 Aug 2020 07:07:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8LG4G4vdAGp+6X4aYFFHyB4CFIBZZdZwoMtflh8BRW1Ce2XwW+LyNKRxvSRIuX6hrGjITalXDYJffedugp1Lr21GoHPUdq/kp+Zn5B6DRGWwDGNQUSQRD+Fg0PH6RRPsY7yab02zV7MRI69osyD+ZXrRbuj/HSYJ9TJOJh5jsk/aSOZcL4ABitHKljK3sxcyccWccrzdfZb7XB/ptT+/JqiYbSEDdImhUaw9Vw18TKg16XuNCjlFf7XQYAuh/Ick1LmQnKtQtlMw0YWmNGIhNCbWYk9I4LdVxTEfRNimLlFoq/+GVGDxhhp3RBPwNEmtJwjOMG6RURsrxRINJzuWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZexXKjtDpBSO7sj/jHayR6kHK6LUFiDFRheW03Twvt4=;
 b=ZAllUtZCL0FIxFQrqx+7hawVRLN0HpSrg4ooUKOodoeDs+CM2HEGa0JkXEuFwkWtVGm/b/YvyPu+xYO8a3wzu5WKhnFBM1mGQbxBRYU4PknQLwrnaUtkbi41UrRmZ2MJR6lmdx+HLe3/ECEOLF4kkUjKWL3HMoTIX63qMrpzQI56TYlysZ4YKRV2H4axwj1aFYmerB/MIu8LpBJtB9xhVsU8lKN31wEjTfHiieHly+vCnLMDGQinxEQxZhbxmAeeLtUctKv8D3A2J9lsvruxEcb4chOa+dYDxdRrSRn38buUEmJccZpca2FVwglv6ZSyvOsP7GCK4tQvnzMIn1k6DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZexXKjtDpBSO7sj/jHayR6kHK6LUFiDFRheW03Twvt4=;
 b=L/QLcUai25O/XaBaqFi2WpnzcwcELk4MDNJkBEe+N24F/fAzgov6Z2F48eznnVll2N5UpqhnR96CMVH02ksilZhcm9VMWd1RoczlT0EADRPAxZ6rcmBCw5tGXGtx7rm9JI28OiyJChr7Ga8sJythroIEo+nBXYISYrFNzC/gBVU=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4470.eurprd08.prod.outlook.com (2603:10a6:20b:b5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15; Wed, 5 Aug
 2020 11:06:54 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3261.016; Wed, 5 Aug 2020
 11:06:54 +0000
Subject: Re: [PATCH 1/2] qcow2: Release read-only bitmaps when inactivated
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200730120234.49288-1-mreitz@redhat.com>
 <20200730120234.49288-2-mreitz@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <7d5ce6a3-0244-cdcd-aefe-098b0a176ead@virtuozzo.com>
Date: Wed, 5 Aug 2020 14:06:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200730120234.49288-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0031.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::44) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.157) by
 AM0PR02CA0031.eurprd02.prod.outlook.com (2603:10a6:208:3e::44) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.17 via Frontend Transport; Wed, 5 Aug 2020 11:06:54 +0000
X-Originating-IP: [185.215.60.157]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 163737e2-c6dd-4cab-5682-08d8392fa9aa
X-MS-TrafficTypeDiagnostic: AM6PR08MB4470:
X-Microsoft-Antispam-PRVS: <AM6PR08MB4470D02D2C75F80B7B6A5117C14B0@AM6PR08MB4470.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jjQODPZDP2wZfxUAsIYjCcJYQZMwzxKz7XCoCZEjwUYw+66gO9/Mo0rQtdWAFvEhSGeA3q2YFhz6c/MzrwCvsR+Minmy/c5VRf/dfhGnqpiVyBmD0EhmkIgA3oypeoh+sm9Y6ysslUtgYMSqEUF89XQH0VV9WmNr9RnkuR/5ponnMaE+ejNMMkA5d5Vc9gdMXCEnJlu9QE0tOQ8VYMzey727B13WwlBdKv/uGPjBEg3VgRbhFP+FAo59yWnjXo2D+U1pHm8U1NlULHznRCPqa8V7wlrXIc0yZvss3Hkyh8l/ZxR+evNODNXIoVa/9S4UWNS1suf5DNn+HVIAh5aY+hxSPrQ0j6WeUIPoCekxBlhFkYqihpodDVpt94bYNS6T
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(39840400004)(346002)(376002)(396003)(478600001)(186003)(2616005)(26005)(52116002)(5660300002)(86362001)(16526019)(31696002)(54906003)(956004)(4326008)(2906002)(316002)(66476007)(66556008)(83380400001)(66946007)(16576012)(36756003)(6486002)(31686004)(8676002)(8936002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: IXfcgYMK1QDZS8hkBNDvc4f5hP4QGhKoMg8IqaMFsHZNYydXCdI8MNqGtDGAW3XN+LhvEY6oPa/+Pa9Z6krBF+jgEjShtALTzzVIVsEuXYL2OkB39auTgQzD2U4Qb8HZsjajLA1F5hb0RWub/ip2vi+PDvrGvnUiLVIP84Sx06VvQXftTpH20t4keZGDjKEADMj0CGALviZbX0IyCHQwn0geNUWcpjiVC0grUOh0+kt3l++q2+qf0KKLhcx9X65e4f/D1QJHRcd2eFnVS5Vt41XBFYfGjAlQ/uSE1sDwgM3at6AsMbD4j6GvEHngNHfatYM9O+h1XsihDA41PRUGSBf+OJZToQMDtMSIMC7JZxjHNaa08auYBjB8S3RiyETdW1/nb6ldvy6q11NGBs6jaVWn9mssbzXvF/A5mRETWkDRJdNFu68xgO76bsz1WqIGPCXPBQB4dlh+6zUKV9/7W08w2MxvbxZQySZmnZ/Kumi+bbLajuKg5yyz6ps2jKDLHguliqGLLC9NGzur9PVcWJua0mc4yHTLzY7X/LPHtAGrvQOowlEd5PJ+skp0hm4ic+o4BjOpPJNO3SNrOYIJZgAlmic4BOUDf3xj+4zuTRsCEzEQm2ByJxvKNvBuw4vtV6DPsxT5qkSRBG0ZWeo/9w==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 163737e2-c6dd-4cab-5682-08d8392fa9aa
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2020 11:06:54.7147 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qTDvV0zCR9jXR0kNf9FNp5+w5ZbENQqW7bTM78aj/uQ9IqmUP9SLbODR3/NQrH3+1FeIq+PWn2QTHa1hQdoXuDWnjRLuze2vQs4NR/H6a+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4470
Received-SPF: pass client-ip=40.107.21.102;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 07:06:56
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

30.07.2020 15:02, Max Reitz wrote:
> During migration, we release all bitmaps after storing them on disk, as
> long as they are (1) stored on disk, (2) not read-only, and (3)
> consistent.
> 
> (2) seems arbitrary, though.  The reason we do not release them is
> because we do not write them, as there is no need to; and then we just
> forget about all bitmaps that we have not written to the file.  However,
> read-only persistent bitmaps are still in the file and in sync with
> their in-memory representation, so we may as well release them just like
> any R/W bitmap that we have updated.

Agree, better to release all image-owned bitmaps on inactivation of the image.

> 
> It leads to actual problems, too: After migration, letting the source
> continue may result in an error if there were any bitmaps on read-only
> nodes (such as backing images), because those have not been released by
> bdrv_inactive_all(), but bdrv_invalidate_cache_all() attempts to reload
> them (which fails, because they are still present in memory).
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

The patch seems OK to me, thanks!

-- 
Best regards,
Vladimir

