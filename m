Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D30C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 15:36:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 849B620730
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 15:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LusjqrUa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 849B620730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz0FB-0007eH-KX
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 10:36:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46781)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iz0EK-00074r-QY
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 10:35:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iz0EJ-00045b-MT
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 10:35:12 -0500
Received: from mail-eopbgr60090.outbound.protection.outlook.com
 ([40.107.6.90]:55911 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iz0EF-0003fD-CC; Tue, 04 Feb 2020 10:35:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vu5EfVRwL6ruPswPrF1LG5boUgjr2m+LNcm3OThsqVHCarE07NpDMr39kAIo+oG9Sve1Ggw+eBIzNkK8NFr2mZ8R5aTcwCZVqgm/FwKWAHNTl2Xm2a266Ww0yflxOwCyV476m8sAYtddPHFXsvvNjyk9OsqDpAmZ0JaNyv89PWwlEiI7wQF5SlPhNb/X4ufi0NcAEKuiy/lafpjTfAPR3WDaxjGPCPmAT2GTsLeehZVa71AcDXb3S64qpFjBy/synjLyjOorAB5QQPb8r58TNZQ5dwwKCC0EtDtlkEMMsMXf7wt0HLGAgg+n8/8O5VHjKt8Kt/4NqvmWvWwqE8Tl1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+V4+6hh+80csyNS03XgKRRGTU1d0es9bABNVkrkbEE=;
 b=gVAvQCpURj/TjTzW8/6mmX3K5Wz9xH7uXh6w8AjH4N8aJWc2Ne8v2UsrjrSzb58eY65+lDn7JyMpjtdKYqvkDyWHwqdu/C1jFivTN5YxOou9DYattziK5e34FrUBvuo7rugAaGqgA8HekyFCmbSpaSce1WOCO3ontglYXBXY3tF88507AO6HDw2UJi5rRAlVyXrpa3hosgUuvYGIRJwKS7YC407v0MuMCYJGwm1NtZgbbobwe2TZkNCwUSdKGg+4HUqTwKaBLax7MhjLneLhGX9UFo38MW4alKco7hNkv4Qz3XDQtJmJD8q7vX0iLg7XMSTPeTChd5n4729zSvU62A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+V4+6hh+80csyNS03XgKRRGTU1d0es9bABNVkrkbEE=;
 b=LusjqrUaYeYtYbgjJ6+lbj6/loqTGqoYAEHi8N4VoGKu8TyJoPyNeT+IFrMEBQvriFi6LFhqvx5zQqz2+Hor4vi/FSQVKHTJTezdpKLo6iYgp+q17xcYUQcpBqnx348y4hqPIwONlP5IXL2Cz1H26P4TCLLoK1oqlqwqN2ZhSJg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB5254.eurprd08.prod.outlook.com (10.255.34.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Tue, 4 Feb 2020 15:35:04 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2686.034; Tue, 4 Feb 2020
 15:35:04 +0000
Subject: Re: [PATCH 09/17] block: Refactor bdrv_has_zero_init{,_truncate}
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200131174436.2961874-1-eblake@redhat.com>
 <20200131174436.2961874-10-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200204183501295
Message-ID: <339f0a60-1e4f-286c-6594-1153bf284082@virtuozzo.com>
Date: Tue, 4 Feb 2020 18:35:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200131174436.2961874-10-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1P192CA0023.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::33)
 To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1P192CA0023.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27 via Frontend Transport; Tue, 4 Feb 2020 15:35:03 +0000
X-Tagtoolbar-Keys: D20200204183501295
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5c20a8a-410c-4f85-7a63-08d7a987ce3a
X-MS-TrafficTypeDiagnostic: AM6PR08MB5254:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB5254A74DCDD50507E0CA21A3C1030@AM6PR08MB5254.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03030B9493
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(39850400004)(136003)(346002)(376002)(199004)(189003)(5660300002)(478600001)(66556008)(66946007)(16576012)(8936002)(54906003)(316002)(31696002)(7416002)(66476007)(6486002)(52116002)(2906002)(86362001)(31686004)(186003)(8676002)(4326008)(956004)(16526019)(36756003)(2616005)(81156014)(81166006)(26005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB5254;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gcZ/+1lkzJ76S7gKbd2FE2aZY5u5m01OqSoPleQ4q6iwhBOKzTxU7J3mztIzfrmrZBCbUQFUqKTYcjhuorHsfgoEMbenXyCELp8dQnI1LeqvHwRYDJkuGSoVnB+X6lYmLcznw/+BoG7unoK3ELQZzn0aBXQnasjzHMAcv0wUFUHm6VM5+r+ht0ILVgk76ILBlogoA6j7u/vk3WWuitWoCUKOkHwl+4UKNLwoQ2t3CJSOvhOecpfGHYRWdIeLGMKjh/AJHQuPNpQA/n9Kp8EYlSBatLRZeL8KVmWNFfZdZHm9h+3DkoANMHzpK+p4wEb6vtWeO8xGhHecqqd2SpeXFs0MbXnYtRydm6fIdOq807J1K5kJX0wyEgE3nlv2U2mHHep54pXfMTc3XakSp8/v7sjUnOkPf06FucgdEnDmeFHqA0cmu1VUls0B+3Iqwv/w
X-MS-Exchange-AntiSpam-MessageData: /6Xd7iLcrjSDo4AxJGBeQ3PDO9j+mrpgQPaYd38UL9UOxagF9ZuMgFVjPifx68B/HteBkfwblFU5/wBQ6MVqL25ZTvT8dn1NuMocywThHqQi22+Y6GBEZgPJQ0xVh/NOYkWH8cEOJBfbaesEgam5Bg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5c20a8a-410c-4f85-7a63-08d7a987ce3a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2020 15:35:04.3511 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nPxNerH9CjwJqsOjTHy3MHsPKNySc9+8AwH3coi1iwoT+AOsng4m4iXOEu2QhSlLnnTNzxFpQ7GA9bqB9XYqORDzywALmzYKb8Q9MQvyp+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5254
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.90
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 "open list:Sheepdog" <sheepdog@lists.wpkg.org>, qemu-block@nongnu.org,
 Jeff Cody <codyprime@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 Peter Lieven <pl@kamp.de>, "Richard W.M. Jones" <rjones@redhat.com>,
 mreitz@redhat.com, david.edmondson@oracle.com,
 Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Liu Yuan <namei.unix@gmail.com>, Jason Dillaman <dillaman@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

31.01.2020 20:44, Eric Blake wrote:
> Having two slightly-different function names for related purposes is
> unwieldy, especially since I envision adding yet another notion of
> zero support in an upcoming patch.  It doesn't help that
> bdrv_has_zero_init() is a misleading name (I originally thought that a
> driver could only return 1 when opening an already-existing image
> known to be all zeroes; but in reality many drivers always return 1
> because it only applies to a just-created image).  Refactor all uses
> to instead have a single function that returns multiple bits of
> information, with better naming and documentation.

Sounds good

> 
> No semantic change, although some of the changes (such as to qcow2.c)
> require a careful reading to see how it remains the same.
> 

...

> diff --git a/include/block/block.h b/include/block/block.h
> index 6cd566324d95..a6a227f50678 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h

Hmm, header file in the middle of the patch, possibly you don't use
[diff]
     orderFile = scripts/git.orderfile

in git config.. Or it is broken.

> @@ -85,6 +85,28 @@ typedef enum {
>       BDRV_REQ_MASK               = 0x3ff,
>   } BdrvRequestFlags;
> 
> +typedef enum {
> +    /*
> +     * bdrv_known_zeroes() should include this bit if the contents of
> +     * a freshly-created image with no backing file reads as all
> +     * zeroes without any additional effort.  If .bdrv_co_truncate is
> +     * set, then this must be clear if BDRV_ZERO_TRUNCATE is clear.

I understand that this is preexisting logic, but could I ask: why? What's wrong
if driver can guarantee that created file is all-zero, but is not sure about
file resizing? I agree that it's normal for these flags to have the same value,
but what is the reason for this restriction?..

So, the only possible combination of flags, when they differs, is create=0 and
truncate=1.. How is it possible?

> +     * Since this bit is only reliable at image creation, a driver may
> +     * return this bit even for existing images that do not currently
> +     * read as zero.
> +     */
> +    BDRV_ZERO_CREATE        = 0x1,
> +
> +    /*
> +     * bdrv_known_zeroes() should include this bit if growing an image
> +     * with PREALLOC_MODE_OFF (either with no backing file, or beyond
> +     * the size of the backing file) will read the new data as all
> +     * zeroes without any additional effort.  This bit only matters
> +     * for drivers that set .bdrv_co_truncate.
> +     */
> +    BDRV_ZERO_TRUNCATE      = 0x2,
> +} BdrvZeroFlags;
> +

...


-- 
Best regards,
Vladimir

