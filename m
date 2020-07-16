Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF47C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 09:16:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8435E20656
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 09:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="iMEVz4d/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8435E20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvzzk-0000zt-OH
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 05:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jvzyc-00085E-C9; Thu, 16 Jul 2020 05:14:50 -0400
Received: from mail-eopbgr70115.outbound.protection.outlook.com
 ([40.107.7.115]:57218 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jvzya-0005ej-H0; Thu, 16 Jul 2020 05:14:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCpfv1Dg6+QduxaU9A0bvSmo6iMhccAYDqxoQmmHmsxBUQLRIAuyRjialBkNU5hCUas6WkSY6/ZdO8pjDI/a0VFxrW0mJbM/Tx92Wl/bcKQoHgsWeOFn7Udp6ag++C1/suJI+j0BJ3nGptGSiTGw0Dh9Cpt+vrrglleHYG2DpWf5cQ94eiiUBhzPcdeTQFdxYl6NfNoEaQgR/doB/Lcn+46wid/ehqieNAWr4iXHavmaBu9Uq43L5HJK6MLHyNwe6QanAviBDMqj/IGRxI9849Z8VGM6rJDdPBtDG4HoPX2aIreS3nCAK1Llpo/Ou8tUOFE79tG2lAmXp1iGQXB7VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWXZyebRBqIRSYzO7KxbV3bfgTwG2H/qEmWB/wzmJtE=;
 b=jOeMCxtK3zQqU0YA+FSzCrJejJ1/lRD5Rvl9CMNYFUU62kWAz/1Z7WGI98U/Iu+AjFLQt0yPw0NfAIgOfkAN5F82dSrZ5v6AYDqF9iyIdliQvDk+C9sbTXr758YpDyMkaKNknHThrz3+2hdWBRQynQOTncFn3UpZ/9Xcp60R771asj8FWZ5g4wgLZIkF5vy71IFbb0WKiXEPbGDFQrMX8GXzf1RQ7Qu4E+mrl7msXZhGpVJFVtu5qXRhVog5JqTjG9Z0lvMny0eSaVuDDamCXo9zPDmjOAKQq6Ou2p9H5pVp74OGUCbvJMMBSz1zQRJWoc1okkvvR69E+GY3IyDr4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWXZyebRBqIRSYzO7KxbV3bfgTwG2H/qEmWB/wzmJtE=;
 b=iMEVz4d/l2jyCxRCgzBuuLzsgAQsxTNwCx7KakmSGLzlEgDagnG9rKsTYHTxRoM18W7Rc85OQjan421Z5q/uVPk5+czrs6Tv3+UShJUS+WP/rvpRkOWsa+R9clHCBOEQgJvey1vB1KMtEg2uJFUZQG9K4R9N5xrbZW2z4/WNmVE=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4915.eurprd08.prod.outlook.com (2603:10a6:20b:d1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Thu, 16 Jul
 2020 09:14:46 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3195.018; Thu, 16 Jul 2020
 09:14:46 +0000
Subject: Re: [PATCH v10 05/10] qcow2_format.py: Dump bitmap directory
 information
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1594676203-436999-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1594676203-436999-6-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <36313202-7d75-e285-f153-96681dc9e122@virtuozzo.com>
Date: Thu, 16 Jul 2020 12:14:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1594676203-436999-6-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR04CA0148.eurprd04.prod.outlook.com (2603:10a6:207::32)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.164) by
 AM3PR04CA0148.eurprd04.prod.outlook.com (2603:10a6:207::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17 via Frontend Transport; Thu, 16 Jul 2020 09:14:45 +0000
X-Originating-IP: [185.215.60.164]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4424b9b-2973-4736-95a2-08d82968aece
X-MS-TrafficTypeDiagnostic: AM6PR08MB4915:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4915D5C7E70A9C5BC42EFDB9C17F0@AM6PR08MB4915.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:972;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uMy/1mRVpW3hEK/toty8hULdTm/NXjNyVGYzQisZ2Bea4UOWQTyUauYPQ/16zerR2fYnXZzcU6UIc6v+PPooZOC+3eIBGX4G48lP+W7tRvbFyffpt6JlSXVFswfd+N+9Unibjqp0tSo9BKRPh8FzODwHLw3RPXqSfroy7Rl+sXjA1ieUvJIpAnjW305r2nKOu/r6mfQp/RKV7NrlK7RmT8GQj83cu7frWp8cBniffrvz++85ZsvwxmMbC7xUqevlzBLFe4u/Rf+s9iCBjlSYiFwg3rNOCh4u/Wn1cNWccvdS6YDivlZGgP9pLfYgxrWuLs4KcsSqg8n9eGXdd3GdYFSal6nHSFWOCx1VjVNhySt7veYWRf80DZdqeUe0CwYG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(136003)(396003)(366004)(39840400004)(31686004)(8676002)(478600001)(4326008)(16526019)(26005)(186003)(31696002)(2616005)(6486002)(316002)(956004)(2906002)(16576012)(66476007)(66556008)(36756003)(8936002)(4744005)(66946007)(52116002)(5660300002)(107886003)(86362001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: QDrDy+iwhJpxqNsodCfcc7827vM/gHXsFPndXWHqQbZjKm7F5qcn+azuYDNJhsM/Sl3u6ZbkTB33dnucwET29BiJe5WfkIJHJ4Nb0G6WGDhXnv7nqpxOCuXcQiY8QmNh3HyTU5N47lMX0I0JP0L1i8LDcLF5X+vJefiKcYQ8BHJsEks8nHQm0/M6pDcaveogNgelGUF0ZDK5IpZECyuK8Fu832P8AsvFXnb9qeimFZGuqpOlTJvJqJIlhwjvpB4r4lxD2PgzPBr04/TyEymTXoVutXxGGOR4sHym/LoQEgCSqup1+6mJlgVNlJL71LpFFMWxv7YG4eacKOxHI/QtxWnH8FehhcU12suTOsO3e9wA65E0jfVuVva7dwfe9jYqi+BCyE416aURr5AyOSAaZLWlxl6TqKck2ZHnfcF5YsRTjmjp8bJL9gl1TWdpAxghTE6BFC52/AGuoDke068PYD1TAJdKdOQE6/GQhdzfYZc=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4424b9b-2973-4736-95a2-08d82968aece
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 09:14:46.0122 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ONRp2zsBTYnkMLpeSExRAFpmmeOSN4nZzc2Y0Kf5LFlNYJ1To7Fk79SaROxlcYH4Ua+/pfOyzn4WdypPsbmumVF/pi99k4f3Pj0HH7T2XgM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4915
Received-SPF: pass client-ip=40.107.7.115;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 05:14:46
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

14.07.2020 00:36, Andrey Shinkevich wrote:
> Read and dump entries from the bitmap directory of QCOW2 image.
> 
> Header extension:
> magic                     0x23852875 (Bitmaps)
> ...
> Bitmap name               bitmap-1
> bitmap_table_offset       0xf0000
> bitmap_table_size         1
> flags                     0x2 (['auto'])
> type                      1
> granularity_bits          16
> name_size                 8
> extra_data_size           0
> 
> Suggested-by: Kevin Wolf<kwolf@redhat.com>
> Signed-off-by: Andrey Shinkevich<andrey.shinkevich@virtuozzo.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

