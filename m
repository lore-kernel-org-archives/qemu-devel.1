Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A411AC35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 15:04:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EC3920674
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 15:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Q02aTfwZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EC3920674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyzkO-00031g-GC
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 10:04:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58497)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iyzjX-00027J-VP
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 10:03:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iyzjT-0005Yg-2T
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 10:03:23 -0500
Received: from mail-eopbgr20093.outbound.protection.outlook.com
 ([40.107.2.93]:14147 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iyzjP-00054u-1P; Tue, 04 Feb 2020 10:03:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E56BWfAeUfIm+whlFYTfVQZF86gS9ahy8eIFhdb+bT8WnzVD/Jrc43tb4cfjafpCj+BNglcW2X7Ff2HkxTRjzvXsXCcBXfw0idF1qcGbekHm1ZOad+74+NHIL2dUj0upfWzreaHkF+J0E0MN28Gsa04kqcFsNv2Upxcx3JxOn6nKKtxiVhVlgC113M4eLsD8ifAnB53Ikfg1BRkmBHCv1+hFRUDv8HYbe6E5R2uD1HPxhwqcVvmIH3KJb3WorQXwdMhqZkSuEUZGPWJ9jkmaOgXp5DtLdez5wEDFq4XNG0SNshnTYZXHYX7zgxoaNOo+l3QY4fgKakEqM0NFC7+3sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96X2l3L4GSogLViIunL1NvnIaiNbiXSa0I2JALkhjXQ=;
 b=naadm0surUsYs8APO2e/dJlb2E6obhLoh7SS1waQnmemtze2bSdMSzG/HeZEqbWaKQK+Q4Ce7DlQLHbi/PjtErWv0QO4U1RvaWBpLS3Zw/JEntCagKkH4nbtOVqsrbzMAf7bjetHAuXih8fWqzrx/l0jdNTGKTMIpX84dz5K3BcsayTzqOGG0QPpUciwm8azAdcJH4HxhsWoLZlwVlgQHUjJkhzQLq8C9gtsZmQVVJDT/O3ztldR/kwwvtFWWuUAXDyuFVNsGte8ikihF+D/OqCD3kyhxprOLdA3vVyNFvHsyAMP4KkVkVr0c9XkMeP8a8n5nMBdr1nh6mxrLYX4Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96X2l3L4GSogLViIunL1NvnIaiNbiXSa0I2JALkhjXQ=;
 b=Q02aTfwZ6qHYD9PlThQjpnv6nhq6OooAobgrYhzFjJ6Zp3IWV8hQtH/rgSg9K/1JFTfQ8XU0ydvU9jPe1IVT2f4oL1GTYcLxFFeBM2Um+zQG6ZPAEhMA90Hg+iErWYZvdhvduMwxcW8kI22Av5M4JFTia1DDyZNG7NWWPqlkEkc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB2981.eurprd08.prod.outlook.com (52.135.163.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Tue, 4 Feb 2020 15:03:12 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2686.034; Tue, 4 Feb 2020
 15:03:12 +0000
Subject: Re: [PATCH 04/17] block: Improve documentation of .bdrv_has_zero_init
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200131174436.2961874-1-eblake@redhat.com>
 <20200131174436.2961874-5-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200204180309952
Message-ID: <b223356c-8c90-e4c9-2db0-4a08717d559d@virtuozzo.com>
Date: Tue, 4 Feb 2020 18:03:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200131174436.2961874-5-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR05CA0333.eurprd05.prod.outlook.com
 (2603:10a6:7:92::28) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR05CA0333.eurprd05.prod.outlook.com (2603:10a6:7:92::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.30 via Frontend Transport; Tue, 4 Feb 2020 15:03:11 +0000
X-Tagtoolbar-Keys: D20200204180309952
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3773aeda-0e66-4f21-9409-08d7a9835a60
X-MS-TrafficTypeDiagnostic: AM6PR08MB2981:
X-Microsoft-Antispam-PRVS: <AM6PR08MB29811DE28257CBAD018F46F7C1030@AM6PR08MB2981.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 03030B9493
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(366004)(396003)(39850400004)(136003)(199004)(189003)(31696002)(26005)(66946007)(81156014)(81166006)(956004)(8676002)(186003)(16526019)(86362001)(2616005)(5660300002)(66556008)(66476007)(36756003)(2906002)(52116002)(6486002)(16576012)(316002)(478600001)(31686004)(4326008)(8936002)(142923001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB2981;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rJkZaqPGRszkGztNpFmyLnAhMfToCDd/ieYv8tEziXNfpx1XaUWy00GRn8GyseidjLPwYMPkknKdYocBrBakN+8rh/YMmmqL1Ps/8dlDbChcpKUM2wwS+njAHiISd2AhCDJP67PAihO6DsZvL6w4jyHKoOdzSqJbqF3ytuhKofTqrpHLugZr0nrMIAZk/qvSY3+Hna2BFH68lXpNuGZgqFYX/dwBgMPHUrGYyBCRH7h90oOIEFbcnFdThB421cuKwt6AFSmZKTNtNuf3126YwaRJU7RjTGpjbDmGuUI0JwXdU1laYr0uWpVDmR/3CMgWXxV3Yw2JMbXtAeOgLjPvChsNEE/Z0EjZND+R7IFe+vDi65O7zQvXxWkpbYh+dgW3muxSjPZTyPYxAoIT05cmWQ/Yk63T/dlRSzc0GlF+wUBdpgAsEgj7NKB2B3t6SjO/PooXGBoGn2if00CUTlpZCOczj9E0eJ29WFqTpUW6ZCd/ZvUAf/+ylr4/xQvhXwrD
X-MS-Exchange-AntiSpam-MessageData: mbL/o1wrxFKyoVUr3nR0WfJjY17qpJBShXdhm+gP2dyFlJJ2tKZCt/mPSL1Acs9MmE+kxJSouyN5KExVMjmirnRntmc5htXJEGUxYd7FOBUWMPJM7YcYsUCpOvl/m+WZtW1ueLnVBQgelPGntXVk/Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3773aeda-0e66-4f21-9409-08d7a9835a60
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2020 15:03:11.9782 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +DHRI413TOU1n4YBl1R7PzkfEzAKuuSaqAPAy2+Yt6vtlLEgCXYYcnYqkRZXCCwQE/lgP4q7Lt11FQ9E+OoVdf8PkEC1PC+r7KqowL6YGLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB2981
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.93
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
Cc: david.edmondson@oracle.com, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

31.01.2020 20:44, Eric Blake wrote:
> Several drivers supply .bdrv_has_zero_init that returns 1, but lack
> the .bdrv_has_zero_init_truncate callback (parallels and qed outright,
> vdi in some scenarios).  A literal reading of the existing
> documentation says such drivers are broken, because
> bdrv_has_zero_init_truncate() defaults to zero if the callback is
> missing; but in practice, the tie between the two functions is only
> relevant when truncate is supported.  Clarify the documentation to
> make it obvious that this is okay.
> 
> Fixes: 1dcaf527
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   include/block/block_int.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 640fb82c789e..77ab45dc87cf 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -444,7 +444,8 @@ struct BlockDriver {
>       /*
>        * Returns 1 if newly created images are guaranteed to contain only
>        * zeros, 0 otherwise.
> -     * Must return 0 if .bdrv_has_zero_init_truncate() returns 0.
> +     * Must return 0 if .bdrv_co_truncate is set and
> +     * .bdrv_has_zero_init_truncate() returns 0.
>        */
>       int (*bdrv_has_zero_init)(BlockDriverState *bs);
> 

I doubt, shouldn't 1dcaf527 be fixed by adding all needed bdrv_has_zero_init_truncate functions?

(sorry, I started to dig in the code and patches around bdrv_has_zero_init_truncate and tired :(.,
  hope Max will comment this).

-- 
Best regards,
Vladimir

