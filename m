Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E836FC33CB2
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 12:18:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B306820705
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 12:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="wBOgtigE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B306820705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixVGE-0002c4-TS
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 07:18:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57589)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1ixVFQ-00026u-V4
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 07:18:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1ixVFQ-00006w-0x
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 07:18:08 -0500
Received: from mail-eopbgr60115.outbound.protection.outlook.com
 ([40.107.6.115]:10510 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1ixVFM-0008TB-HO; Fri, 31 Jan 2020 07:18:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4g9KrxJ3J1dh4dfAaNOGwCvtTg5V8zfyZRWK+p/HcWXLgxuBgC+fJIdNUd7/WppV6axbMazMNRO2ZVTTo1wVxvju4fx6q5bGSGd0SDJKx71ps/7oUWFi2uBhlzHIAukpJjRyC/RvLVakiMU6owpARb2tNAfHSzCTBxLLuLjYOxNzc1PiAHDah//Fd4+O4DKT6LIPAHlxRo0epQElAqR8BgWssOtUK/HdGYilq8fX7Bf7gZMVsJGwq0jbJpoJCiZyN/TaQ4eCZdxwHDsUDMgmP+dt3B+ynY9hnQ8l8A44WpoiM9TFQGBE780+JC72P8zXzzJpK3CuzDyXYHAf1C+BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkVYE+5QxinVJ5sp1/g0SDbyXAyEBG473ksTM7ecgNQ=;
 b=L9YN7skSrSF7yc67Eo77GbXsb0On3aSQ/fLSeINWmegCGuywBU9DLSpB4sMNkjog4mgUqPJMfHZqvEd77BlZJ+g1u9efnD5DT0Pid92ffsBem/5ymfaJHA/unB8fQUbAAecuKK7NM1/V2pNNTzCnZuePjDeNv+IuXXgPQ30qeBrwz12UhNQQ01z/UYCr9aaxpHHRhv1x3LkROZ/BbuSCiK/MHfzDj178FoEMt501AFecSnQDYT3uixFRxXssgk8Ia/GvGOQRNlGBawTqheS87jGQSfQf/Jd0/sgZgdrhrA8zvJ7IEOmfqeCDt9pCM4LU8WY2EmsS2fkV43C8DH+HKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkVYE+5QxinVJ5sp1/g0SDbyXAyEBG473ksTM7ecgNQ=;
 b=wBOgtigE2FkbuaCBg0thnAp/3rfDJOSyNONN1X7csXLXdBKwzMBh4QuK2xQ8V8YDutKAuq1WPyNMu4cChZmDLuGlndKR7knNfvi1/ySKUpH4VkHL9REkpo2rq1eoR5TrQ8JWnzH8CWCBs59ZxAJ9w7obhaI4ukb2ifXGgpPy9O4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com (10.255.123.95) by
 AM6PR08MB4707.eurprd08.prod.outlook.com (10.255.96.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Fri, 31 Jan 2020 12:18:01 +0000
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::8805:5633:ca46:c8c8]) by AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::8805:5633:ca46:c8c8%7]) with mapi id 15.20.2686.028; Fri, 31 Jan 2020
 12:18:00 +0000
Subject: Re: [PATCH] iotests: Remove the superfluous 2nd check for the
 availability of quorum
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
References: <20200129141751.32652-1-thuth@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Organization: Virtuozzo
Message-ID: <e15aec66-d586-c3c9-09b3-7c4c88714353@virtuozzo.com>
Date: Fri, 31 Jan 2020 15:17:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20200129141751.32652-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0202CA0022.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::32) To AM6PR08MB5048.eurprd08.prod.outlook.com
 (2603:10a6:20b:ee::31)
MIME-Version: 1.0
Received: from [172.16.24.225] (185.231.240.5) by
 HE1PR0202CA0022.eurprd02.prod.outlook.com (2603:10a6:3:8c::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29 via Frontend Transport; Fri, 31 Jan 2020 12:17:59 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 948c25d0-c6f5-41fb-4da9-08d7a6479cea
X-MS-TrafficTypeDiagnostic: AM6PR08MB4707:
X-Microsoft-Antispam-PRVS: <AM6PR08MB4707E5C34EDD37F1FF9A6620F4070@AM6PR08MB4707.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 029976C540
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(396003)(376002)(366004)(136003)(346002)(39840400004)(199004)(189003)(2906002)(6486002)(31696002)(4326008)(44832011)(86362001)(31686004)(81156014)(81166006)(8676002)(8936002)(316002)(16576012)(110136005)(66556008)(26005)(5660300002)(53546011)(66476007)(36756003)(52116002)(478600001)(2616005)(16526019)(186003)(36916002)(956004)(66946007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4707;
 H:AM6PR08MB5048.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P2I4nJj2zbbE2pIg4uR4Pv6uAlMuyFLBJ07DEdx8Dfhz8+fKQWczIIyzhil2WiqqFElbHaqC9Npu+QFtxMw7LQinrgwlwPZJjMrwdN8VKr3GjAG8PUjrnRDxvmJz+S1jf08e3nPhtB4tYd0mTHtl2/QOb9CVY+4dSV9xgxGw60Gv0A5M9kktz3hvS6wyuOZn13I9tJY5FRynCr9vBDwJ2JkAXgY/BXKMbXyEReJC9/Ir20u4c5FAMTOgyLn7PVqL8nhS9ImH7dkeBs07pKw3dR+yZZMWob+jkMqcpHrGNHRg+I6F761ou/Szyhr9PajF+ldnYJTcIH9hlv8R/bMsKquxEstNOdwE+HOuNVzRgMj8KhnH4D6cuGW7yXJVVo7gyk408sRke0iGipDO31e0YUp9FxgCs4mzNvAPOo536Wm+HKOKQ6TwqJcA+ls135JR
X-MS-Exchange-AntiSpam-MessageData: 6CgknCDJ4KgSLNuHH6VhQIev7B6iHaBHTmYSnilq1B64Q1HAA6TPVAVwHlEBHbTGr3VZcADetbTs7ILa2Oeo2QEumOX+E0BbIq0tu0daXN64cFh2R4I82HI+eoyQBzVcDfDCsz9BZg/x7eah7UTkAg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 948c25d0-c6f5-41fb-4da9-08d7a6479cea
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2020 12:18:00.6091 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oNByfrKWM07Gcd8yFSsyUIgdPHue9lXaUX+F3QB6FE0FIy+fPIgK9D3XmY01WC686B0dV7noiyiDwgk7RRGMuS+EMI/FepZgPwV1oS62kTQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4707
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.115
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
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/01/2020 17:17, Thomas Huth wrote:
> Commit d9df28e7b07 ("iotests: check whitelisted formats") added the
> modern @iotests.skip_if_unsupported() to the functions in this test,
> so we don't need the old explicit test here anymore.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/qemu-iotests/139 | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/tests/qemu-iotests/139 b/tests/qemu-iotests/139
> index cbb5a76530..2f075888ba 100755
> --- a/tests/qemu-iotests/139
> +++ b/tests/qemu-iotests/139
> @@ -344,9 +344,6 @@ class TestBlockdevDel(iotests.QMPTestCase):
>   
>       @iotests.skip_if_unsupported(['quorum'])
>       def testQuorum(self):
> -        if not iotests.supports_quorum():
> -            return
> -
>           self.addQuorum('quorum0', 'node0', 'node1')
>           # We cannot remove the children of a Quorum device
>           self.delBlockDriverState('node0', expect_error = True)
> 

Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Tested-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
-- 
With the best regards,
Andrey Shinkevich

