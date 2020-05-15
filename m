Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7510C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 05:34:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E4632065F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 05:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="MLdGRBaK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E4632065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZSzV-0002xb-NH
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 01:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZSyo-0002Qj-7C; Fri, 15 May 2020 01:33:54 -0400
Received: from mail-eopbgr70100.outbound.protection.outlook.com
 ([40.107.7.100]:4079 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZSym-0003ix-0R; Fri, 15 May 2020 01:33:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QX3AzC8NwEfUonCwnyBe2VduDMfKLtg92wB0QK57xTbSSHPTwj9h3Us8uqoewhwCIoCX4bAQItIl2KPwyX4wPbZoqWR4beIUCkB1ZqPRbrMS6m0NhwAATVA2ZYQaXIV4RmAmewT4cL1zEhZC5GwjtC5zpcGSsa0AKUdws9oF08yEX5SQLHmk+8HyDMWpfLBNZfJqZnsaqonElyCjPLogGWqyk7ZzsBy92sZ6qvgkLxPpG0SgThpTrcXBwfKZq6LFvczKFzmI9bSAXWCHNsGB4sxJ0kOcBXHyR1xEqapsEE6iUgLG9XVL9l3mPr/FmsfrDYyoQkWQr8I6jS3PuQ/taw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3niUMommt4w4HJUmFr8nZTfhm/Q0bRA38dwAtNuJSg=;
 b=JnkyOS+8DRI+nBkP0NT4YhdPXWuOfltuTDh8mIcslfjsNae7PlGPDYVnj2FoVgTpEJiK2kaBd/XJCiqpDIeyWinS0aFjTgA/tKOTP8zolkozuzJapcJ07x/m2GMI6o5XkMfCvY2c8jFKR9YoUd2oViRvNoSGOHkY9PePnX96D47T9ucyw9Hu6UUuUhYs5u86DtBnXkCl8jT+I2efxejoeLbpQpugFOGR3OEwGjIbouJygPClsRmgxZUJq5j/Dxo/6jTV7YNaEs2KUPpDaK3SHXpl1H+WFhlxsS4TMYaMSPG8xRnoPtcYbVSvYii/wWCbDIIM/ugZeJPZSDYcnpGvag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3niUMommt4w4HJUmFr8nZTfhm/Q0bRA38dwAtNuJSg=;
 b=MLdGRBaKTVme9Rnv1kATfwPZSrX38W8qyGMYmC/1hRT9JqylpJ3H2KYqodeLSiq7t8WlMSdSQ/Ib9gd0w4YnFD9A8dRtXoFXgM+XGWQhjkLAfIkXaAKTZHkcogTCprFiLSlOYhz6UvTU1tB7dMGOBOC7IkWNf/Jb2HJkg79F7Ws=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5446.eurprd08.prod.outlook.com (2603:10a6:20b:107::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Fri, 15 May
 2020 05:33:47 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.3000.016; Fri, 15 May 2020
 05:33:47 +0000
Subject: Re: [PATCH v2] bitmaps: Update maintainer
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200514180003.325406-1-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <b7388571-9ca0-5668-c45a-90e6fd21e973@virtuozzo.com>
Date: Fri, 15 May 2020 08:33:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200514180003.325406-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM3PR05CA0103.eurprd05.prod.outlook.com
 (2603:10a6:207:1::29) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.184) by
 AM3PR05CA0103.eurprd05.prod.outlook.com (2603:10a6:207:1::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 05:33:46 +0000
X-Originating-IP: [185.215.60.184]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 044ee6d4-9ce9-4425-4a22-08d7f8918a2d
X-MS-TrafficTypeDiagnostic: AM7PR08MB5446:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5446FD10888AE9DE381DAB2BC1BD0@AM7PR08MB5446.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YUUN0F5TJ5jJDUioLWc6e54WyJ13nX91oYJRAjw8KQn6TLzymw4EPAboexdfoAqUMK1oZIbY5rZIpgoOv0O4dkfN1oQvJYGoxD99p9bb+ja72o9u3qLcwL+OD1z06Slley222tJEYhmjH+dhB+/uV0LtUvrwkifkUuxul+/1iy1L1E3x7QGgTFf9iHmSPBvQ+jaG8k1Cm0sQYVzlo0ngEeVtJhxQsgxPD7aR9fqIjbaPFm0dimougrVjo9u/4doyBf8lKL3zlepBv9v/7dJpCbht9eC+bTabDZw2eiNNXCExYlY7N3CXMfH/JyvuTVyBS8Soybsrd8WP131P+l6i6CEGAkw5697q9zNAvyeqYSEOUa6jOSCDarHn0vVGODmOeP9lL2LBpVdJ+lsBF9dwdd9HTWOwDWKthIoFzmuV0ufi2LKs3ldWmwM2v6apipYV2dCPaI7yDiF3kyVwJNRPX51N1IYtfLFVoVzjwQ1fFDn+ai8eJxTEWT9S1y+uDKZ+evUmXoK0IJRpsluUq0KWFU1w36wLYOV9JrJe5ezCKRZmt773HG0urKz9HXameFWEfCVtiRpCoENfNfxc7B/ugw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(39850400004)(136003)(396003)(346002)(4326008)(2616005)(2906002)(16576012)(956004)(316002)(66556008)(66476007)(36756003)(6486002)(66946007)(8936002)(478600001)(26005)(15650500001)(16526019)(186003)(86362001)(52116002)(31686004)(31696002)(966005)(5660300002)(8676002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: o1x6PxqmXCqw+AfxvNSvZIjTPH2XA9dHZcMkBijDCNoaJnKbNZSHu0KmhD34adowdtJmD0IVGKCeTFFogFMyWyXDkq0pW1+P+rvb0HnP0O6jA5j4Oa3sG0jM9JpMHrsJMJUuEkOeSoqbrdoZbSAd4XI8bnKJiwckx84O1I2hE5CcyltTzKrWMG6msOHxOITEcW7hkjK/PImbUGIUFV/ERmukgnU8WaFLwIjIQKEOZnAt18KGRMBvh2NJsbbFHL58kVwTVLj41cMPNBX1jxZIDcfOJiVFfTZwTa6M48z3ILttJby6j7cTBenmbhi52sl23m5lepRG5Fv4bAnGSuReeM2kt6FbwoVNeOeXRphubPuP+54tjzs91Z73Gw4BG+0uEQiGjMI1KNkTgsfAPDFtQqveNmsbx+MkoQWaIYwNXb+6h89Q5dPGnRc1DtME24obfp+NvWbaOZuH9BF0g5LTdxe1G/EVMxToVYzNapXT8yQZsV7bXXlYvpBkvmvk4END
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 044ee6d4-9ce9-4425-4a22-08d7f8918a2d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 05:33:47.0117 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ka2fF7k60ONSmL2MYcV2eOXl0pb+KMRM5QNPOanMwyrJ/C8Bwt+E28vYppRXumyIIzlgjMYyknJFXL/UEuoVsyCj04u9F68iaIaRCz6RwMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5446
Received-SPF: pass client-ip=40.107.7.100;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 01:33:48
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: jsnow@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

14.05.2020 21:00, Eric Blake wrote:
> Dirty bitmaps are important to incremental backups, including exposure
> over NBD where I'm already maintainer.  Also, I'm aware that lately I
> have been doing as much code/review on bitmaps as John Snow who is
> trying to scale back in order to focus elsewhere; and many of the
> recent patches have come from Vladimir, who is also interested in
> taking on maintainer duties, but would like to start with
> co-maintainership.  Therefore, it's time to revamp the ownership of
> this category, as agreed between the three of us.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> 
> v2: further tweak to maintainership, update T: listing
> 
>   MAINTAINERS | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d11f3cb97613..ae23062a51ac 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2001,8 +2001,9 @@ F: qapi/transaction.json
>   T: git https://repo.or.cz/qemu/armbru.git block-next
> 
>   Dirty Bitmaps
> -M: John Snow <jsnow@redhat.com>
> -R: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> +M: Eric Blake <eblake@redhat.com>
> +M: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> +R: John Snow <jsnow@redhat.com>
>   L: qemu-block@nongnu.org
>   S: Supported
>   F: include/qemu/hbitmap.h
> @@ -2013,7 +2014,7 @@ F: migration/block-dirty-bitmap.c
>   F: util/hbitmap.c
>   F: tests/test-hbitmap.c
>   F: docs/interop/bitmaps.rst
> -T: git https://github.com/jnsnow/qemu.git bitmaps
> +T: git https://repo.or.cz/qemu/ericb.git bitmaps
> 
>   Character device backends
>   M: Marc-André Lureau <marcandre.lureau@redhat.com>
> 

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

