Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6139BC34022
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 08:03:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2675721D56
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 08:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="CC/0LeAj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2675721D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4KKd-0003VI-9p
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 03:03:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54694)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j4KJv-0002yz-42
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 03:02:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j4KJu-0003rE-6L
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 03:02:59 -0500
Received: from mail-eopbgr30108.outbound.protection.outlook.com
 ([40.107.3.108]:60807 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1j4KJq-0003np-9m; Wed, 19 Feb 2020 03:02:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eaBR08ySd0JmHFLaK5EyUcbZDK+Dzt/+0TQm6T7mP+CV1sZnx1HMiRhCmwAa/ZeRFmoxUoyKvfMKw2er2Nd4g6KItKTyk+EX+9v8h34/8Gg5bq/w1Ek97D8mPEsvyWM6sUywy37OZSnXC9I8KAomk3kcTgcB7e2VRow0UHlAIM/zqUp50mgNTfgRMHcHunj+1njMT2YcPl9cyRZpBrD0f9nyzYQBirX3KDg01KVXpaVdS2J4KZkhhg3cAVcvlKc+VBhVbxq/FRmg2jSeai24rT7fwiPVQ5JuO/IRnsw44iQgdGgHm9RZ6WrBYBklSYjDGY9akdZjn9Gj6/aAYQe4Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pG9zouVvMyw8aBNJ+04vFfjU0om6EM9ZEsjUCO+H0gc=;
 b=OIBVqeccXL1qXXXhZnMtbeWAEZM/dPqrKal/8v2XfcC2TpXzwWtzxptgvoSdbiYp6JnDaoLEQBvdkxpKol892xJJfp3viyjNLwfWI2X//ZJ0zxzeXvyb1HnJyleDnCKQh0/NeJfbUyQ40OvIysucEx1saZt+fk4gQeU/MI11uqkY42QR/6+9j43UnM/ETbklGvNAjJQEWCNFV2C1r5ee3R1Ancnx6L6If0gufQ/HzcFNskE+K55N3Z1YsRj2sl6I9XMm8hn76tceGmgVdEOH/tzX8Z+RW5GPlhNitdutrmpvIzAL+Qlz3Lt0wSqkNz51ZuT5BTNEyJKDrCYyMO0ckw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pG9zouVvMyw8aBNJ+04vFfjU0om6EM9ZEsjUCO+H0gc=;
 b=CC/0LeAjBNiHfn4sWDzDma+QHDFgSjeEh5YCo5+1BJN67EAe8PUYUktrPwsO6DXLY5JZjmsNJqU2XPjN93L/4pDsjncqEZ0pl0POiZcsJQHxUyDfOrT6Nx5fRlttpXbWcSF3B6vH8HKEvnnMCOZWye59Igqdh/aC4YK5XxeJAHs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com (10.255.123.95) by
 AM6PR08MB4771.eurprd08.prod.outlook.com (10.255.97.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.27; Wed, 19 Feb 2020 08:02:52 +0000
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d]) by AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d%5]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 08:02:51 +0000
Subject: Re: [PATCH v2 13/22] qemu-iotests/199: drop extra constraints
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
 <20200217150246.29180-14-vsementsov@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Organization: Virtuozzo
Message-ID: <f876d98d-15e0-ff73-7477-1e47ff991e16@virtuozzo.com>
Date: Wed, 19 Feb 2020 11:02:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200217150246.29180-14-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR05CA0190.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::14) To AM6PR08MB5048.eurprd08.prod.outlook.com
 (2603:10a6:20b:ee::31)
MIME-Version: 1.0
Received: from [172.16.24.225] (185.231.240.5) by
 HE1PR05CA0190.eurprd05.prod.outlook.com (2603:10a6:3:f9::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Wed, 19 Feb 2020 08:02:51 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 579a6a27-7fa8-422f-8d31-08d7b5121e3f
X-MS-TrafficTypeDiagnostic: AM6PR08MB4771:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB477187D5D14002E82AA5B094F4100@AM6PR08MB4771.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(366004)(39850400004)(136003)(396003)(199004)(189003)(31686004)(81166006)(8676002)(6486002)(81156014)(8936002)(2906002)(956004)(2616005)(4326008)(4744005)(54906003)(5660300002)(66946007)(16576012)(316002)(66476007)(66556008)(36756003)(478600001)(53546011)(186003)(16526019)(52116002)(36916002)(44832011)(86362001)(31696002)(26005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4771;
 H:AM6PR08MB5048.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /02IoaFxmYwrtjPvxStvO4CKt+zIwZY4DkBfxgmyGLopM9FZVa/30mM42AmCId92SgCY62Yw+IeF0pbR1T9aORnBCA3HnruUPj3PZwUUroq+RyUMVJK2+2+XZ7sc8gnqwVWIbTNq8wKe2Kw+wBFpMaODDoYXIisHIgqz2DPngHizLCZXlvrsffTa0ni4AKCqLSgad9pO4Wkk/wXOL1H2tM26NnPhai5bEn0yTYelt8waVSUu0LkEkW7541sq8X5cmZQKaww6iGQ3FfJM3Ir8Cv65m/GuP88kxQRT3Dztsvqax9aXv3BSXKKC4R2AzsFHqKFPtYXjus4ud6WXvPGSYcDwsOsogXP1x3YDA9MZmUDZo9ORBM443GggmJrdlv2KZ7Ci7/kRm+KOqA/ZJlHAdTYl+GeeG0/dcmo8luFIBrAH1pEtXEBtRNDCEIcp5Rzz
X-MS-Exchange-AntiSpam-MessageData: miHn3ui1P2Ta5sR5lvQEl8E701PUjjvJc8jGaQ23mtKP0XxesUBUPYXWuXobTcolz3fyvryogWZFTb48luESpCjht4UktTdXbVStQwkROIcjHPVdK5yyncsf3tiCJ5EwkiIptAHh/OrWuEWHgd/wtA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 579a6a27-7fa8-422f-8d31-08d7b5121e3f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 08:02:51.9503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Oc7mYob1o52vpLDARpdGo7ny9p+oiRTY0slzJS5CatdiHdJ/48gjSh02rS4DvX/GTwcsfqbhmLAWp4NHClgpQd9IGGumGd2NjV0YIzhjpA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4771
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.108
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 dgilbert@redhat.com, qemu-block@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 17/02/2020 18:02, Vladimir Sementsov-Ogievskiy wrote:
> We don't need any specific format constraints here. Still keep qcow2
> for two reasons:
> 1. No extra calls of format-unrelated test
> 2. Add some check around persistent bitmap in future (require qcow2)
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   tests/qemu-iotests/199 | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tests/qemu-iotests/199 b/tests/qemu-iotests/199
> index de9ba8d94c..dda918450a 100755
> --- a/tests/qemu-iotests/199
> +++ b/tests/qemu-iotests/199
> @@ -116,5 +116,4 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
>   
>   
>   if __name__ == '__main__':
> -    iotests.main(supported_fmts=['qcow2'], supported_cache_modes=['none'],
> -                 supported_protocols=['file'])
> +    iotests.main(supported_fmts=['qcow2'])
> 

Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
-- 
With the best regards,
Andrey Shinkevich

