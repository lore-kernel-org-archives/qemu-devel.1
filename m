Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01B2C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 15:07:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACEEE20730
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 15:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="RGVgRJtO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACEEE20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyznV-0004ZB-UR
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 10:07:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60209)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iyzms-00044v-Pb
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 10:06:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iyzmr-0004us-SW
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 10:06:50 -0500
Received: from mail-eopbgr20107.outbound.protection.outlook.com
 ([40.107.2.107]:14350 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iyzmp-0004gE-Lg; Tue, 04 Feb 2020 10:06:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0nZgKhiQ/wB12X9zHoZ5+jztxNyUsOlO1+yM1kAoOj8x3k+ckTYJx7BraRASAkQzxsxb7QIKAWin0Pp4ycWL9L5ebTpnv6g0wQYD8ncqA9BFUGT457wpDv5A+pnwI0SEan/wd2mD4eG3be2srxH0cA1TlXbnoAhhec4XN9Syjg5l/Ec7RGQDZ2AENCW+0EgW3R2q3hR+WeiUFsOXzr4IpO2NjXHHzHtg9aVLO3mQTxrEgwLflp4Yp3PxFlGaW0rE9GEA4+pkAXADHY8GGC+fjO/J4c8G7MeNMurGmCx0qiY9a5qRa6PSJrmCXiQrp4lL+995IZwE/LXZM0WvfhRDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bc0J4kzaIqR0Dp9OF+NqelwgMlYOa6VxE4bIJEybdyY=;
 b=Oiui2eE8kMLVBJZBRrtPIJ14zyj6SEt03a9vcEM5hJlWNIs7D25Lf0kALY+WcO2RirKofpu6MFLR/W4pFOdEJzCB5aod4d4G3SgfyOdcpUfNfTGuQvPPglK4sb41g0VR+vXhNkUoOvJoBSPguVlTPg2mmFETXTm46bKvTtRZzKMqWnQ3IHH6yNFbvpO0GtvtxZeCnDPBvMKIm920tchyklNtHsR/B7o+HWyVFFIx2oYTrWT+Ljm4UVSO1KUAGR0g2iJTrGfqd9o9yfkePUBeHJWj/aVedZPoTCJUXtkE9S+NWPYAAs9oeZ+O/B+rrCeBxqHFlQ0xs632NqpsnQHvcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bc0J4kzaIqR0Dp9OF+NqelwgMlYOa6VxE4bIJEybdyY=;
 b=RGVgRJtOTjGC1um/bWiJEHKg8rrUKy7vqxZRfGvRjzn9NaHNk3nx39V7q40tW/ZZ35ve/qSOCSIShn9Tse5zV+/lR0KckZFOGAgAdUqX7UArUxkaNBH7SIYxmq5+SS+udJ4ZFz3HF31JI+aDg54bc2fwXdKZpi8d9zjZkSQ9wpY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB2981.eurprd08.prod.outlook.com (52.135.163.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Tue, 4 Feb 2020 15:06:45 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2686.034; Tue, 4 Feb 2020
 15:06:45 +0000
Subject: Re: [PATCH 07/17] gluster: Drop useless has_zero_init callback
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200131174436.2961874-1-eblake@redhat.com>
 <20200131174436.2961874-8-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200204180642743
Message-ID: <355ee6f6-a2e2-c4ac-930a-325849a5d1e4@virtuozzo.com>
Date: Tue, 4 Feb 2020 18:06:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200131174436.2961874-8-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0502CA0001.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::11) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0502CA0001.eurprd05.prod.outlook.com (2603:10a6:3:e3::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32 via Frontend Transport; Tue, 4 Feb 2020 15:06:44 +0000
X-Tagtoolbar-Keys: D20200204180642743
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7fcb9348-2b8e-4d8e-2d12-08d7a983d98e
X-MS-TrafficTypeDiagnostic: AM6PR08MB2981:
X-Microsoft-Antispam-PRVS: <AM6PR08MB29815C8BF817BC0798D430BFC1030@AM6PR08MB2981.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:499;
X-Forefront-PRVS: 03030B9493
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(366004)(396003)(39850400004)(136003)(199004)(189003)(31696002)(26005)(66946007)(81156014)(81166006)(956004)(8676002)(186003)(16526019)(558084003)(86362001)(2616005)(54906003)(5660300002)(66556008)(66476007)(36756003)(2906002)(52116002)(6486002)(16576012)(316002)(478600001)(31686004)(4326008)(8936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB2981;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +o40jEXOLal9baS+6CBrPXHVMawAD0c5CtpgOmglcIvsXKzS0sHJrAUN1CaUmFtG4gf4Rar/L7v24HsUK1u5I3TlPvqPYvYtBQskmzBpXHNx0dZKMeX3BE4gmzmBtbt90HlMch1PCKDK2YqZ67BiLjV22PBr6m9aV6+hGrbQ6anGHzdjgDmpmIZzKaniZyZutdvo8ZRKa1fIwww2P2A8fdcukKJ4RMn84GhnGCGn8GQcjRHWxCLdu1nFOgF6kqDrBC4I39HYd9DRTIsB5HpoWwaQX/XMxtAKokCSwWV5gmIzo4fBYR5oJpQthuZaDrw5AMOtl0o6b89VL7EsO2A4T5IN6FHOrvSlntl4un17ZpMxokbV9F7r/Xw7fS4HAe8I6HGvFHAHMuF2QjHzVAuDIl1kdzaeX9QJmGRqJ5uWBXgwBHsawSbz1MWuakQu1UEm
X-MS-Exchange-AntiSpam-MessageData: pkFwz8ehrQw/4XCo1gCF7f+fo1lLU0akjgIR0aiwZzwuQbqnVHV9cfQHjYPbAoD+/90d6T/PqCFA/RxR/OjYfCajwE3y2G52bKRYRV19jVCQSsSW2idlrGbu4rItRVKt4Jq+I8Hqpy2XV3lUWj5LxQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fcb9348-2b8e-4d8e-2d12-08d7a983d98e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2020 15:06:45.3307 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zSA1ra5RltR8+M2Ed6vKkESQCrl5JPaP5hjun9OzIyA6mgx3sVsF/zSThYfqDZXz89t8cl56mkY1QlrBRhtI4nzydLbHGawxJpJ8keqhHE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB2981
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.107
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
 "open list:GLUSTER" <integration@gluster.org>, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

31.01.2020 20:44, Eric Blake wrote:
> block.c already defaults to 0 if we don't provide a callback; there's
> no need to write a callback that always fails.
> 
> Signed-off-by: Eric Blake<eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

