Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353A8C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 12:00:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A76BC20656
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 12:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="omh8va0l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A76BC20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT2RM-0004of-FN
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 08:00:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60250)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jT2Pw-00048Y-W0
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 07:59:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jT2Pw-0001Ma-L6
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 07:59:20 -0400
Received: from mail-db8eur05on2121.outbound.protection.outlook.com
 ([40.107.20.121]:58336 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jT2Pu-00016O-6d; Mon, 27 Apr 2020 07:59:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8EWhP792/yhsn+P64vBgvbjxGq8FXZdFYe0lahLsUq+CF9q53hWU/7hd4rBPF4h2xRZagYS7EVDDZlRStI+WPRup93w8iyeI0KzOf6N9jxDuA0tKS7VDlsz4j5D3CjJIj1N+PNJtHAdGQGY264Vfe3Wpy7d6vY/C5cYiDQ7wZkMAI2Bafbn159TQU7E7JFi37ypF1eVLcHyE2UxE4P8PoqFEEXegfD0Pypky6wUIwhz2Vgyi1vX5dyEoMs/0BFFM1OJl6ynkDHVUiHpNht0ciHbSF8iBQvQE5KbQfv595nTxHgm6EOIXbgd4VoOvxRqHy9cCZS9e6FcalvID9lg3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBQ7g1vB72BMzlu/60HpTVNTPOWcJYQ5WPZf19D8jfo=;
 b=HZ8+v6BHgeYNVENU0fG9DsnCM2j4GeMOG4Cisytj8xhoDZbmPRdBMAwl3d326Gq90FkQx5TsJqDf9Nyw6Yqf3TvelERQw0/9ffIGvaCHMkag7tS+ukT0kWhF6wjQrgaCh5+dILWYOlSDN+gr+ItAF2bEAMN3o/rbdB26Pm+8ZNQX7cxDnU9i6Rnbpp9snAkZrGst7CKP7xraV0IwHALa9GLaAIETa6xtlq/9ipj6jJgHIQ1JtBKaZoBGAV6v17GHFwdc/vwR2z0qvMwgSPfei3jVrNal14bp/A2FbQsSL+jxnOr/tt2swtNaM74T06ug/4gQv09yskytpe4rW+ldQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBQ7g1vB72BMzlu/60HpTVNTPOWcJYQ5WPZf19D8jfo=;
 b=omh8va0lOa14DzVyShHAat9UVplrGkSvybFsTfOk2q/szEaFy+0PAztKj7jNfSjIrqB+Rran0hrS+TF2N3VRwRBegqnT2W6R8GBcruBh0ZloDaO77I7dgC1/L4Z5YE4oqV6PMUb1UrfWqDitUhnocyyGUvSPdwjYQvlLPlUEyKE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5462.eurprd08.prod.outlook.com (2603:10a6:20b:10b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Mon, 27 Apr
 2020 11:59:14 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.020; Mon, 27 Apr 2020
 11:59:14 +0000
Subject: Re: [PATCH v4 26/30] qcow2: Restrict qcow2_co_pwrite_zeroes() to full
 clusters only
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1584468723.git.berto@igalia.com>
 <1415552fc60acc658e3f80751d9ecd63da2b863d.1584468723.git.berto@igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200427145912983
Message-ID: <116672dc-2d38-adf3-0580-ecd0ec390b65@virtuozzo.com>
Date: Mon, 27 Apr 2020 14:59:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <1415552fc60acc658e3f80751d9ecd63da2b863d.1584468723.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0085.eurprd02.prod.outlook.com
 (2603:10a6:208:154::26) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.182) by
 AM0PR02CA0085.eurprd02.prod.outlook.com (2603:10a6:208:154::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Mon, 27 Apr 2020 11:59:13 +0000
X-Tagtoolbar-Keys: D20200427145912983
X-Originating-IP: [185.215.60.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43dea503-c463-414d-4126-08d7eaa267dc
X-MS-TrafficTypeDiagnostic: AM7PR08MB5462:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54622AEBD07D0488F3EC7955C1AF0@AM7PR08MB5462.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(136003)(376002)(39840400004)(366004)(107886003)(36756003)(956004)(2616005)(31686004)(2906002)(6486002)(16576012)(4326008)(26005)(5660300002)(81156014)(186003)(4744005)(54906003)(316002)(66946007)(8676002)(16526019)(52116002)(31696002)(8936002)(66476007)(86362001)(66556008)(478600001);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tw2UJvmp9XTkZvtr7XlngWVd8HJI0NjgvkYgE+cm6t68JGOnAr12dbJ1tMK0AAoVhHd/fPc9j8p8N02KrmhPOrqzvoTmOdW928SEephJaBSKHFTCRbrkv3/dU4aLZ+GXlTtUpoa7IsP6sGasf8ATEIHOlKjgnZP7LfSOwGiWlx5MgGx2tiLU/UIY9pWdQVeu7DuRXCDc6rxwCJ8ssDms7sNSVBtgpUaAkhKU+wt1MWnofH/GFz04e/JVxzEw3OCyeQSHOoUre3nyba1M3AXWnMuiuSsijo9kmmdToc1fdpeROAX8PGdQaP3UQZ8aowrubIfe/XH7YH4TlqMmof7SbCqRyeIvstjOOTTcpC0TJYq/xedwFtLJkL/bCnoTQvtUjJaCry8wnU6M4xDZDGmh4hGtxScp3zVtleSwUYap1A7rP9JNAXFLo/QUu+MCR1mC
X-MS-Exchange-AntiSpam-MessageData: nn8vn1VNNK1FYhTLNLj7YGOBeJ14HtI5zMZd/v48ReFV/u1KYtWZJ+IfDFzvVAUxdO6/qz4cMFDHl8qXEAAde/LL+PqbNtp4gGrQTH65qwWtoIfAce4beur4PAjLOJ2gh3lywqaZEmVsAPtyJBdzjiaRmsD5seBsbaJPeGP0fMVRLN5dCo2mdkHZb1nBLdMEbk+OqscVqDn3jYfb1T3rIZbAfCWp5UrIb1/MqOWIy1oDLhgQzdoPKSm65JUW5dqPJfpUrHlvngFaI+pqwIOZde0T0hMQMXHm72qggyJ3RvpP73FKFXJk7K0IjIX07mC7NLN6HA16PgR+R6sAx3rAZ/egBD6FZOJRc6ngaPkJZ0p89fKJDn7kSpe166e2jUg1ldiq+TsBVxR+6hmVO7LSz07kpM54gQuNzR1F3iZaYjHTQhx89H14v+zI6lkEXMBLg2yH9THaaL0T2sNiN3qsAT2yiO4gEkCwdPjdPK4jxJySeDvTOfx0eMcm2hhZBR2cDbX8zkwU7m7yQAVFQXQFy9MZOUPbhWTW9nCn6FMIvUtA3IaL4HShLDt6eNZtvMw4f6tsuOFOy3J5o0QjGGnRhk/0e4S5Em/IVq5ebSo7LUKMnaY8D3ABrp+NkXlAF/nY+6iXwugHMw9jcAAbstCIQVlIEWy7WmBM3ZKDkhBGW/SiLEyrAEMEy2k/aSXQWlLr9QutWZ7Fw1VLqqCjLt9ap82xFwsj7fF9EviyCQuzrKSdao0zHAvpE54gOT+Dfy1nq0R4UAR+zrGhFCpe/ZwGzMGE2cZFWXTZpx9JKoVf3LU=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43dea503-c463-414d-4126-08d7eaa267dc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 11:59:14.6026 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b4r8QSmsf2elNG1Uk9YAZ0Zeco36u0IErUTDwyVsw7j/Oi7EXF1KqmGY0TeqIg+IksgVjEW+7Vl3LVg61w9y8GI7VBTqe2D0HXpum5rjdRY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5462
Received-SPF: pass client-ip=40.107.20.121;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 07:59:15
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.20.121
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

17.03.2020 21:16, Alberto Garcia wrote:
> Ideally it should be possible to zero individual subclusters using
> this function, but this is currently not implemented.
> 
> Signed-off-by: Alberto Garcia<berto@igalia.com>
> Reviewed-by: Max Reitz<mreitz@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

