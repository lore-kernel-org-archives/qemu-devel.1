Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763E4C7619D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 08:25:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F03A2067D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 08:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="oy+hqG2T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F03A2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3big-0008F9-GC
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 03:25:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44479)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j3bi2-0007Yy-E1
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 03:24:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j3bi1-00049K-DB
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 03:24:54 -0500
Received: from mail-eopbgr30124.outbound.protection.outlook.com
 ([40.107.3.124]:22241 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j3bhw-00044q-Av; Mon, 17 Feb 2020 03:24:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WlcWtI8YYN7AaspmyOLjsjfeQwEBBBDreBPgvgm8o08m0frw5gpPoHzqMIWxXxY9GmzU9rgx8mJvei9UJ9+l1AARgKRSMx4HyGEETVnJjWMApkoB+qLP5mS9m8BxKjiu5pXAbegkgUOkMn2zTSSt7OhqGb+LFhyuEQ7Cu6i96oGi3zt2F5I8uFGtYXzffChe58n82VRhCQzrlYTaICYgZG7FzqPIx2J9Fp8biMe9sPLLNGm4EdBXQaFXIo7GTemsLXtPfO3TFRGDWV9c7merPyIKFqIHM6G56gRhbZeXaisZgkP/t9yK+MFp1MdsHbRACq3x2SF62tCEkAhtMUYyzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogyXJWWRYkZk566vQS+QMc+N1fsV9bVh5lMcBy65yyY=;
 b=Z3ee9Smsbzp4bX1Z8nDGrFiE9CKYcul3Rbkc8QkLub6pcBeH++KgCgYPtn/GBPnhuA5CAPgowRnYtrNjcAkB+hGe7FEajJzSvirTASy/KAEII9rbwyGMYWnOYQB5Tp03OWxlkwFysaiEGsDZ0eQV7dgUhGYolnJWMaKGmdWnKMHiscuRlzbnVk3nGCM64ga1Yu9x0WFEUJqFCZ4bcM4ppQNA3D9JmWIQplQs08lh7lyuAI33FWL7ipq4z1vrdPsb5HrwA9zYZGiMauQWPEh5k5JpfZR1CPahuZZZcwWrNlWLfBfARvsIja3jYUya2usnuRRFbtuTwIcgiejEm+UI/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogyXJWWRYkZk566vQS+QMc+N1fsV9bVh5lMcBy65yyY=;
 b=oy+hqG2TJL4QIbL4yc29PTgATcUj/TMpNWSEvS91S50fUQHCd3RrXzGIDkwWI00v7HaTK2rGgUU/saoFCDHgsn3SyAXD18pXGKeAfHEX3O9e8/m8LUUfsPckrlKpQaV5ZBmJH0iHWiweK7yGwrDUWKh4szbkHeHShqgHrPYeij0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3573.eurprd08.prod.outlook.com (20.177.114.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.31; Mon, 17 Feb 2020 08:24:45 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2729.032; Mon, 17 Feb 2020
 08:24:45 +0000
Subject: Re: [PATCH 1/3] block/qcow2-bitmap: Remove unneeded variable
 assignment
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200215161557.4077-1-philmd@redhat.com>
 <20200215161557.4077-2-philmd@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200217112443341
Message-ID: <3cd0f14c-38aa-cb6e-fd5b-ac3a35aaade0@virtuozzo.com>
Date: Mon, 17 Feb 2020 11:24:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200215161557.4077-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR05CA0245.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::21) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR05CA0245.eurprd05.prod.outlook.com (2603:10a6:3:fb::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22 via Frontend Transport; Mon, 17 Feb 2020 08:24:45 +0000
X-Tagtoolbar-Keys: D20200217112443341
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7fc0bc13-70c3-4b68-0cd1-08d7b382d889
X-MS-TrafficTypeDiagnostic: AM6PR08MB3573:
X-Microsoft-Antispam-PRVS: <AM6PR08MB35735B10BBC49DB9C6EB8778C1160@AM6PR08MB3573.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:277;
X-Forefront-PRVS: 0316567485
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(346002)(396003)(136003)(366004)(376002)(39840400004)(189003)(199004)(26005)(956004)(186003)(478600001)(36756003)(31696002)(8936002)(16526019)(66476007)(66556008)(2616005)(66946007)(16576012)(6486002)(316002)(4326008)(52116002)(2906002)(86362001)(5660300002)(4744005)(81156014)(8676002)(31686004)(54906003)(81166006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3573;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dxf9bztUzioFxlF4n0VnlMaapsp9KwFeRyyg/JuE6oDI5OeQyI1r7Nqx8oCtxgyFt9j4soJ7wwLynOhB+u3WPvygSnjbWoiLMzru6MyzedJU2pjFtQrva24o5VNxfxR5TW96/VmNllCp3xYIU/l7263WTZ/b7hJySQiBULg2UKkKMVQSvvXXze+tCbun0Qemrsnp4gNY6wgc5Y7Q+blmGmavcsuig2+VMcdh5JQ2l8nezH8KPJp/gPcuC5eC7cXM909yWfYn9Kg/gZT6yizfsoKj2FLrT6XkMCC0XKid3u9k2r55j3GVQpQxq78+VPCnhuD3Y/knTroD/ghBOAn1fwwktVdBLVzEzsxi3vsE26MQjmOZZqENCYvkjJONHQqm44aVZmQOAjcS6KiwS53z8Hbp6CMtvTOtHxZZp43dEBhQLQp/70SK55AgMBHt7RV2
X-MS-Exchange-AntiSpam-MessageData: oo+Q2uX/oxBn/qsFavzhGgES2nLoIrZEwi35m0p8mQ+yUjnL05kKTf0Dhk4oORcceUbivbzXzlplZujI/ARaJ5dhwQq06Qz6aZVpIv8baRjlr+b5dl66BxfnEmwvvXZ4lZB1Nq5jPbfrCSnzJHh5Nw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc0bc13-70c3-4b68-0cd1-08d7b382d889
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2020 08:24:45.7424 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2UmPSdXVrs6xwNvJH3HqlLGRB8W05+sQapY3TEdJGx/RAS2sRqzl4E9JniyA7Bkodxq2YGzgocplO1t+8ua8TCQAzAloxMfpNnSzCu93Oko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3573
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.124
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

15.02.2020 19:15, Philippe Mathieu-Daud=C3=A9 wrote:
> Fix warning reported by Clang static code analyzer:
>=20
>      CC      block/qcow2-bitmap.o
>    block/qcow2-bitmap.c:650:5: warning: Value stored to 'ret' is never re=
ad
>        ret =3D -EINVAL;
>        ^     ~~~~~~~
>=20
> Reported-by: Clang Static Analyzer
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   block/qcow2-bitmap.c | 1 -
>   1 file changed, 1 deletion(-)
>=20
> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> index d41f5d049b..8cccc2c9f3 100644
> --- a/block/qcow2-bitmap.c
> +++ b/block/qcow2-bitmap.c
> @@ -647,7 +647,6 @@ static Qcow2BitmapList *bitmap_list_load(BlockDriverS=
tate *bs, uint64_t offset,
>       return bm_list;
>  =20
>   broken_dir:
> -    ret =3D -EINVAL;
>       error_setg(errp, "Broken bitmap directory");
>  =20
>   fail:
>=20

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


--=20
Best regards,
Vladimir

