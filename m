Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD08CC33C9E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 10:41:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87B1C2067C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 10:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="PtaiWAIl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87B1C2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix7GD-0006ra-PX
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 05:41:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41728)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ix7FX-0006Lv-Kf
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 05:40:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ix7FV-00052d-Ud
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 05:40:38 -0500
Received: from mail-eopbgr60101.outbound.protection.outlook.com
 ([40.107.6.101]:14080 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ix7FT-0004tG-Hx; Thu, 30 Jan 2020 05:40:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=On50U0iyOHLKWtvRbVRli25IGEqaMc7elkD72yzSC/pvawpFwOY/QJPtlFa4aVwBAMEq/1xQ8W6qJw6q6UbC+8kPGoS/7edYRDfyH4w0QRkTzClzNeI2vSwCiTzsWzqAlpbeYE/re545P13aBUUwMXOAPVtM92hDCokXe1WLuFK16PNtHwYWEOMbagejwHzZMHkaLttqVW35tlWMnnqDpPFlHufQP+l113U48Z8UoGqC5rwlh0qPeDH/R1ojMBsncgyGHjeI9q+QdkRRntIxUKlGWx/d54D5Upym9vIQRoTEmuZQMDRidLJ39HxtoW83CETtOu3Yt2BSgAtZMf7ykQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+ho8by56Y5ZDGK1LjcDmzzzgMqnHjS7LoBm3Tfk9j0=;
 b=Ga88SOBNgYdXphyRT1dPrwy7mVOAjk0uKzJdCHytfpdtF6c37TkJb2jid48Bh7b6g2H4XUSJ++ewr6a5uGtP5u2or8aijI8cDeo2iHnU9er8YupviglScVu187fgsNjU1oRggJs1m9A8U0592jkk58ZX+cJpm5w3lt4bfc7eZQCfBuR/7j2dAOVk2/p7g4/yuosqmm4kfZYgxgWDv3ciq/v/uFAn8JF1y+fCoAz3SIPeQY3QiHwkxGMGHudGxzf2qZm2WKPTKMsO/n0uPyiIeqQivW7zpRreH9cv2UE+M5HuNEj+365Hiuym2yduajobXbHdVUsTCmefSXHalhQJ/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+ho8by56Y5ZDGK1LjcDmzzzgMqnHjS7LoBm3Tfk9j0=;
 b=PtaiWAIlIwv/zweH+13vpPWzoFKTInkjkk1njagHUPF8sSKoCdanh+eLoRZ4EmDGV7oUu1uu1+0pbnxtAs1gV2OxO6MUZ+s6rVwgOWT8F8Q1LuA2Kc4I4RwLVsiUi+ASMFly0CZCR6xR5DxOFpn3qPA4qEOWl1z5zbvxiLUxA8o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3382.eurprd08.prod.outlook.com (20.177.113.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.26; Thu, 30 Jan 2020 10:40:33 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2686.025; Thu, 30 Jan 2020
 10:40:32 +0000
Subject: Re: request_alignment vs file size, how to fix crash?
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu block <qemu-block@nongnu.org>
References: <2ca46523-44a2-1a48-dfa3-11bda9eef8e8@virtuozzo.com>
X-Tagtoolbar-Keys: D20200130134030916
Message-ID: <24d1a5f8-1f01-ec64-778d-5bab440714c7@virtuozzo.com>
Date: Thu, 30 Jan 2020 13:40:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <2ca46523-44a2-1a48-dfa3-11bda9eef8e8@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1P195CA0020.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::30)
 To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1P195CA0020.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22 via Frontend Transport; Thu, 30 Jan 2020 10:40:32 +0000
X-Tagtoolbar-Keys: D20200130134030916
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa81514b-1f2f-428e-3b50-08d7a570d526
X-MS-TrafficTypeDiagnostic: AM6PR08MB3382:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB338220B658DB57388FCE3F2EC1040@AM6PR08MB3382.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-Forefront-PRVS: 02981BE340
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(396003)(39850400004)(366004)(136003)(376002)(346002)(189003)(199004)(54906003)(4326008)(81166006)(66946007)(66556008)(81156014)(6916009)(66476007)(26005)(8936002)(186003)(16526019)(31686004)(8676002)(52116002)(478600001)(2906002)(2616005)(956004)(36756003)(16576012)(86362001)(31696002)(5660300002)(6486002)(316002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3382;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ka7YoIkQE7Ik2pDV9G79r3ZEqKtpPIRXPQt89JVbRukaVvqnNI23ouXolE4S9YirEEW9S+njCeULyLXk/Uc49PbEGkFkjFEn/VVNMJUGh+rSo/N1TmeUuq9uF9NGnAkOq4nnZgepg9V8P5pvFeBRGqeX4Lu9AHj35jyvceotuVrJyaZIikFdIobOQAs3Vu4URqpUeYwImrOmEHTZ/MeB9blYqEkQM9gnxOBZCRcznEhSA5utshQbCJqn3MMnNMa3bIxL+BTKrZ2WcFsCRuJF4Zyl2DYXEupeHaeN3sZZmj71LmILlTgFDQceWBTPOyxzFkFh3uWHrxgYkct/gOo1V27ErY869HIoQHSwmePVMpws0Zg3nlhizkyRkMYfnjpLqC/I56DM8UtZFUh71PlMuiZIWoR0814ZF9mIRwBfYaMOI0mmC4kqAL1g+G1/9uk
X-MS-Exchange-AntiSpam-MessageData: ulV9Yh+EyUxTHzUt7hh4LO/tAcs1el0BTM7QXksyy56FcC8983CkEkA5D6b1BzUzd2APHCkoE+j5VLngJHFKY4PlZhYYUgt2LeKx1tGe3MHLhFe9tzLgxRU+VYQ09ER6fM9SD4v/g+l2oo5N5z+fNw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa81514b-1f2f-428e-3b50-08d7a570d526
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2020 10:40:32.8466 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ftvRekmwFAmZcP4JVUxnJWzol1g0oUu1rEsXioZo95d+F/3B3AmvnbUg/9zoQ8+czK1qDFTsoQGLFRdGBbh0owO1NG8mOfSlZC1TUg/AofU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3382
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.101
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Nir Soffer <nsoffer@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

29.01.2020 21:01, Vladimir Sementsov-Ogievskiy wrote:
> Hi!
> 
> I found a crash, which may be simply triggered for images unaligned to request_alignment:
> 
> # ./qemu-io --image-opts -c 'write 0 512' driver=blkdebug,align=4096,image.driver=null-co,image.size=512
> qemu-io: block/io.c:1505: bdrv_aligned_pwritev: Assertion `end_sector <= bs->total_sectors || child->perm & BLK_PERM_RESIZE' failed.
> Aborted (core dumped)
> 
> The problem is obvious: 512 is aligned to 4096 and becomes larger than file size.
> 
> I faced it after rebasing our downstream branches to newer Rhel versions. Seems that after some updates of alignment detection in file-posix.c, it started to detect 4096 alignment in our build environment, and iotest 152 started to crash (as it operates on file of 512 bytes).
> 
> My question is:
> 
> What is wrong? Should we restrict images to be aligned to request_alignment, or allow unaligned operations at EOF, if file is unaligned itself?
> 


The problem started with commit

commit a6b257a08e3d72219f03e461a52152672fec0612
Author: Nir Soffer <nirsof@gmail.com>
Date:   Tue Aug 13 21:21:03 2019 +0300

     file-posix: Handle undetectable alignment


It sets request_alignment to 4k, if probing of align=1 succeeded.. I think it's wrong logic. It leads to crashes for images unaligned to 4k.

If we force alignment to be 4k, we at least should check that file size is aligned to 4k. Otherwise our assumption is definitely wrong.

And still, I doubt that it's correct to force alignment to 4k, for devices which doesn't request any alignment..


-- 
Best regards,
Vladimir

