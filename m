Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CE6C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:45:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA70B206E2
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KCUtGh6j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA70B206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3zRb-0003Uw-U9
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 04:45:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43314)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j3zQQ-0001Hh-Jv
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:44:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j3zQP-0005sz-GR
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:44:18 -0500
Received: from mail-am6eur05on2100.outbound.protection.outlook.com
 ([40.107.22.100]:61025 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1j3zQJ-0005n2-Ce; Tue, 18 Feb 2020 04:44:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JH1fz9sp+07lD07FViF7S4QMWO6h2Z8QnNum80BZCmsrDEQXb9qj+I05CVHdvjjZGUW7nXOikgegHK8ljjXeE5wzFAY0iuo2iJjJFgz6lHFkYW8oeorYLOVwAvOpj6Hkm3AXINTyZptQwC1b5V+eyQatt/HY9Uoew1FtHubeQXBj3kDQ9zyc2Kjr3m5h4v4AP2rSFf+a9yVvq/d6pd922YHgnpJWxbQsP/F8A82PQAIbGP9lS331hbxKtuCGRfOFvAY9vk0KR9E5buwZXNc6zt6V4PIl4QhT8Fl9TYQocYEuna9oKt3CyNEPIY9IVtpjKIJvqrQ5X2PpzbuDAWwmYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QbquY3nvaNd98xl9fnrswl5ZxsJlrGwwSC+QgrWGUs=;
 b=AonVwKQB6goOGz1uKNMDKEQrcsQqlxO2QtNRQmlN4VXL8urmpm/5IaR5uL2MOkPYTcJCnAnjQ24VPDkc6jE8AMiWe7OZlTz0LIk2JTETXiCPtAz+tFdDPmB5CvRT1SCppmoTw+ZpY2iAlR2znfBOL1EHMgkzne6lKqdHWmJ6yokyfu/OwHMbrsflzKE+4HurfXwzxG0nQIzf9avB+vBDNdd3FLz49ZvlE9zjh+B9oBqI7uu7eLuq12qTrBhZHqso4dCjEaLxc+PPGk9qi/j2cs20SNGeRNNtKdBxU/kAN4fhMt5p17CxLch+eTPmDOPcW5dtc+o4eR9W+V+rcEgHZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QbquY3nvaNd98xl9fnrswl5ZxsJlrGwwSC+QgrWGUs=;
 b=KCUtGh6jsfGWUT7lQDoC3eroEgxyClPS+dzpJ1ylwekljV4OjpCSORpkSH0L5i5XdNaIA777dH2BVzpjLMFaYIttaXhJkagIZMz5uCXmeNspYHowMwaLi2Z3OeHE2zTvkgRqfzMNeBeCm/x3Yf962MeTKSIOm9WenHs27+GnVn8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com (10.255.123.95) by
 AM6PR08MB3046.eurprd08.prod.outlook.com (52.135.165.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.24; Tue, 18 Feb 2020 09:44:08 +0000
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d]) by AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d%5]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 09:44:08 +0000
Subject: Re: [PATCH v2 01/22] migration/block-dirty-bitmap: fix
 dirty_bitmap_mig_before_vm_start
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
 <20200217150246.29180-2-vsementsov@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Organization: Virtuozzo
Message-ID: <40ee6499-92a3-9427-c5b1-efac2222bb9c@virtuozzo.com>
Date: Tue, 18 Feb 2020 12:44:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200217150246.29180-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0902CA0020.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::30) To AM6PR08MB5048.eurprd08.prod.outlook.com
 (2603:10a6:20b:ee::31)
MIME-Version: 1.0
Received: from [172.16.24.225] (185.231.240.5) by
 HE1PR0902CA0020.eurprd09.prod.outlook.com (2603:10a6:3:e5::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25 via Frontend Transport; Tue, 18 Feb 2020 09:44:07 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 365747d8-5365-4db6-6a18-08d7b45719bb
X-MS-TrafficTypeDiagnostic: AM6PR08MB3046:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3046D5237A7EC3A45E41BCC8F4110@AM6PR08MB3046.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:612;
X-Forefront-PRVS: 031763BCAF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(136003)(39840400004)(396003)(366004)(376002)(346002)(199004)(189003)(316002)(6486002)(36756003)(53546011)(26005)(31686004)(4326008)(52116002)(2616005)(36916002)(16576012)(956004)(16526019)(54906003)(186003)(44832011)(81166006)(31696002)(478600001)(86362001)(66556008)(66476007)(66946007)(2906002)(8676002)(8936002)(5660300002)(81156014)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3046;
 H:AM6PR08MB5048.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tN7Me51sRMukD1XaNS6gqGtwTuvDejccShcb2Lpz/1vSY2SOmALhiSec0ByJh4mLNI+KYKotapxVHPmiLpjwANvsWfSuRa9cnSlHwl4geDbJi5d53qywS7BnmzGU0TEYgn4LpRbFDw49EGcHDYRTp8P36DKOs2LYv7xvxVkI3AfbE5BZiDEwtC4y+FuUJgvLi17/Kqg6/iKp9xhIWLzpQDsyXTxOoQPwyQ0uE3OGfxgMe7bcahjX4JrFrvUQwFytEXzak6wxPy3nO5xkVV2V/4HkSrc1LcJlsv0t1FjudvqM4OWVl6cc8jDNfvfpDh7TY7Zm3pT2SE35SFtrJxHFUyxYg1thNyUryP1w5VL5VYzTwClP0RgDHO6pyEy8dLDjTLybRjNCZp2BQTsyKu6eyZUFH2rSm4SiJghiImZA8cbaeX28ddHbIHtgz7eMOiMou8MhGxN7oPImA+8XAr28tilZJtvNWa+gpUH2JS0UouF4umpc3oGrDw//LF2913I1
X-MS-Exchange-AntiSpam-MessageData: hHlWJiZ0JxRA5xxtBrxyufmlAZ+f1dZBH73oGzjtaRB3b1t07ehm+x2+Gta9uKIdHMN7d3jGrERY7+We/VzV8Fq5PwfbAO6668qQeqtIcPvwoYtbqLe2cdMqsIlBDtzEmDAiKRaC9y+n1xQZd3v0Nw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 365747d8-5365-4db6-6a18-08d7b45719bb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2020 09:44:08.4380 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cs5XN1tuyZiow4GFo6qJ7Dmk5/M8kD5wbw+BTxTfwfvCGUooWi9ai5cj4LXs8PHRdtdfObXD5dPSM5BpXIjRiX58AS7jYw8R2Rj3sbxuPHk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3046
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.22.100
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
Cc: Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, quintela@redhat.com,
 qemu-stable@nongnu.org, dgilbert@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/02/2020 18:02, Vladimir Sementsov-Ogievskiy wrote:
> No reason to use _locked version of bdrv_enable_dirty_bitmap, as we
> don't lock this mutex before. Moreover, the adjacent
> bdrv_dirty_bitmap_enable_successor do lock the mutex.
> 
> Fixes: 58f72b965e9e1q
> Cc: qemu-stable@nongnu.org # v3.0
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   migration/block-dirty-bitmap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
> index 7eafface61..16f1793ee3 100644
> --- a/migration/block-dirty-bitmap.c
> +++ b/migration/block-dirty-bitmap.c
> @@ -498,7 +498,7 @@ void dirty_bitmap_mig_before_vm_start(void)
>           DirtyBitmapLoadBitmapState *b = item->data;
>   
>           if (b->migrated) {
> -            bdrv_enable_dirty_bitmap_locked(b->bitmap);
> +            bdrv_enable_dirty_bitmap(b->bitmap);
>           } else {
>               bdrv_dirty_bitmap_enable_successor(b->bitmap);
>           }
> 

Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
-- 
With the best regards,
Andrey Shinkevich

