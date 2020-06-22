Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80B2C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 05:27:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1248253F9
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 05:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="jCmmHAY3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1248253F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnEzY-000667-Vf
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 01:27:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jnEyx-0005af-8S; Mon, 22 Jun 2020 01:26:59 -0400
Received: from mail-eopbgr80107.outbound.protection.outlook.com
 ([40.107.8.107]:19777 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jnEyu-0007Kz-5G; Mon, 22 Jun 2020 01:26:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lvy5xRq0euLxVjxHIvYugYWm5rt0LB+cZ36g+9Jb965lysORac2IkE4a5FRedTHzQytgNUDwZjSVhOyPExqWUsl0GbrYJ8f1yx3TMZA1hJ7tO5xFMxJzRGVmlaoYo9Y2R+/yk5vem/YLAhF21HuXijItUyKc5xYo9pNv0DBtvzVOrOAeLThwQpzu+owv0yptDne745UeGyDS2c1jmuxxya4PRB0hYxQBenrAPqfspP9TPuDEEMMU0h1ERo08FgFZuo5Wle1o3DX/D7q9PGKFFo8jIboAHPHI9nabP6SjgX2nNqo7MIM+r1IR/gPE1zV5ouHqcarnS5rrRhAnQ47ibw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPKWQqv2XF2iV0Sh5twUciIVkLMfuG6nPUsBSx9S/XE=;
 b=UYQcr6eh3Mh3jIV5wCHukx/Mx6g4v94MwP/iaCnRHp5vsNU0AXebVzhob8/rWi+VupH88kntGGyvGEntBIYBBebsY8zPL99jsx8ue6pkX7aTAIA1FeSs9wX51TqVJ5/fIlxvose6VQN8cLIm2nOfbdMdBVrw1jFidNbY+UAyVBj9ywAH+Bp9N0Ya4XcCf8PimP3+Ioo6pBrMx3Yk00qwZnHCxQnm7rsQgDqj4F1tLxN44ZdY1mP2kFHdT3DohNVUOSwGvnwPPC3LGEB14xBZRZcgnc40qvN+uERc4DU+6+jFNoCjdS21jj2M3M3Og8/QAZZmCRzV+rMi8cbvORf5fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPKWQqv2XF2iV0Sh5twUciIVkLMfuG6nPUsBSx9S/XE=;
 b=jCmmHAY3fyJJdUg9T09VEEsDKlChUg5o9YpiJrI06o9onkCQ8CKcTE5aMqcxvd6mIUhyLPrkIdjRDKzobLGoCut5VVC+qLan98yD9Kq0m+Z61p5N+2FIKGlVaBunHtwJ9Fli1PZXcLF3brnfsPNwVXxX1+33y5nIBTs1DtXZTak=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5464.eurprd08.prod.outlook.com (2603:10a6:20b:10a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Mon, 22 Jun
 2020 05:26:53 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 05:26:53 +0000
Subject: Re: [PATCH v3 4/6] iotests: move bitmap helpers into their own file
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200619195621.58740-1-eblake@redhat.com>
 <20200619195621.58740-5-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <74095b29-eb23-484e-8b07-afe22d94598e@virtuozzo.com>
Date: Mon, 22 Jun 2020 08:26:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200619195621.58740-5-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0072.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::25) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.72) by
 AM0PR10CA0072.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Mon, 22 Jun 2020 05:26:52 +0000
X-Originating-IP: [185.215.60.72]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0db0b938-2d2f-4777-e85d-08d8166cdf23
X-MS-TrafficTypeDiagnostic: AM7PR08MB5464:
X-Microsoft-Antispam-PRVS: <AM7PR08MB54649B329C682C62EEE96D4AC1970@AM7PR08MB5464.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lNwgGgiIg/GisQPdRZ4AK5oLPXKipit6O9J8Ec7G7gXP1ZYRPtKixzSIlzpEme75ulj8CPZu79YQYDInNvSUF82TaVsKTr3jdq18hktMihue7sHUA0nbYt9+hBIvySaeJDdJUjGww1dhWwI7/lGHmnzxBWSkjYz9dZsdWWvp+/VkMii0FPqZks34XXD0r5qmZekckqTAOVwUR5t4K9vZbEaC/vEHh3tAL1Cb0rfA3aGAkqkOG70EHiJYxJ6QGdoMlAh9K9cv24qI0LsaEF/nI56VZEC1Cz9PgmeYAWzIlPfmbXpXqoAXf00w/+rrS/DBMvrE5cPPOie2isCN6HKbfxvslqXRF9lLaGYytjgEDtGtSeJj2qypibkW2I8TXRNF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(396003)(39830400003)(346002)(376002)(316002)(16576012)(2616005)(956004)(186003)(4326008)(16526019)(36756003)(6486002)(66946007)(66556008)(66476007)(31696002)(8676002)(52116002)(8936002)(86362001)(26005)(83380400001)(31686004)(5660300002)(478600001)(2906002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: WD4KU16TQlQN/CXBHgxqqgB6TW6VClTJAlr8hFd029GUSJIx6cF7XsmYMdK0zwOnO2/q3rU1uwTKwKhP0xR1meenPmOKQh1yk3ofh155qZc9voWJu0XayhOFPSZ06WJDg4G/eBl4krFEkfNaKTiWYopS3FPY06vjkfLWwIipEN38xkuyZCzZPOECUGcRCjAr7TOwaoWAQGmhf0Se7asJ2Akzk/dUWNWDQ+OsRBJ2UciLvTynPDwjqDP7d2BsOg1qo2JLE1hnyrbCwuUsUNAH9RNiBkZ24OdyColGw+KQ97anYbCJYz0taZxwEfkhVoX+YAGoiNAz+kjClE7p584+eNAybZ7LEz+3bYa/Ez1abYyJtb/jTcfxWAgicE4bqFJg1znIMjqyjJZKfLXARIfka8nQG9o7Gy1nwKSb5CEZMO6isNg6ChIQlJlXLcVPmRdlKto+Y0mXuITkdTlr80LOzDinQRqqLy8BYdj5mmYwErk=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db0b938-2d2f-4777-e85d-08d8166cdf23
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 05:26:53.0210 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3V/P0nFJkJya0nDlEUvuSVZaRHwhq17SswLlC57wWyfxLRid4ggV27VKFLwljz6PR5Qc1yypaVsR0zMkxBJ0oNDIFOTt5c/wY8P8z5cuel4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5464
Received-SPF: pass client-ip=40.107.8.107;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 01:26:53
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org,
 armbru@redhat.com, mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

19.06.2020 22:56, Eric Blake wrote:
> From: John Snow <jsnow@redhat.com>
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> Message-Id: <20200514034922.24834-5-jsnow@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   tests/qemu-iotests/257        | 110 +---------------------------
>   tests/qemu-iotests/bitmaps.py | 131 ++++++++++++++++++++++++++++++++++
>   2 files changed, 132 insertions(+), 109 deletions(-)
>   create mode 100644 tests/qemu-iotests/bitmaps.py
> 
> diff --git a/tests/qemu-iotests/257 b/tests/qemu-iotests/257
> index 004a433b8be2..2a81f9e30c56 100755
> --- a/tests/qemu-iotests/257
> +++ b/tests/qemu-iotests/257
> @@ -24,120 +24,12 @@ import os
> 
>   import iotests
>   from iotests import log, qemu_img
> +from bitmaps import EmulatedBitmap, GROUPS

Exporting global variable of some unknown to this module structure doesn't seem
to be good module design. One day we may want to refactor this.. For now:

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


-- 
Best regards,
Vladimir

