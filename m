Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8145C433FB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 11:38:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76363206D4
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 11:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="mpwHeQh4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76363206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Nw2-0000Tp-Of
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 07:38:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k0Nub-0007Dm-8F; Tue, 28 Jul 2020 07:36:49 -0400
Received: from mail-am6eur05on2138.outbound.protection.outlook.com
 ([40.107.22.138]:36000 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k0NuZ-0002R5-Fl; Tue, 28 Jul 2020 07:36:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pib1bUd5VY9X3bGyDMesCASH9qBoT6vwTpgtlfCv3kkskXI2Vr27TA+bqAkuRIEy2MCrI79yMHqCwME9LR9orjB84fLtyplpYDEt9CWgo8XS4xniSK/jeljhBUtRqUPtuRRIJw8wzFaaZJ3nHKCtZcojVAzZH4VjnUbLt7iv6GEdGhm4rHbZGVzcQjABkRnItlP4EkGCu7Yr/bcWTAGcr42d+XgO6olLVJgTSg1qCsqAf+zr2T9XbHCoY6f3k/V9ICchrJGj9YP6zOwOgTH1Iv3+Xd1fbTW6cTvLSPONhe/EzLTxRBAubjQdJP+zqcBRbo1morRNh4Nj4oqAO2yyqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+1A//xUTdvCBWXUbuUt1WpMwn654HibMCr0ClpZYZw=;
 b=gEckjTiGnkA1buClu/is+L9coQ6cSU3Xif8chq4Oyd69s16UBSItzGAiRe6XSkBNZ8mhPMxHydcD4fUNgOr+A/OqWmUNb73pNfLPHwb14FaHUrlovLx9CjuB5o4u1jEXnRPyFMcwN0EfNerIMX4NreKvPI9qoNJN/1sXvdiTUAFnOjlZYPaAPfETl3T8Honw1CYwqH2QqUZB9Vd/RlwuUM/9CsR3pd0GStFBBdE20YOALreSdJ/YuOmf34EtGqSQb3r5ILo0SE4kO9r8/tjoLFVAW6lBh3CDi3XSXUnM1KZgCUNfUwKdxTfG+6L3W+lK0d0NiWMvKIkq81+2Bk2X/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+1A//xUTdvCBWXUbuUt1WpMwn654HibMCr0ClpZYZw=;
 b=mpwHeQh4mNu4Tff9ewXujjBSYJZsY4dKtiW0BAOPldBPg0uWmc+G0mBh49xmfRFISlAunBscSkXSPzsGeFFrD3uWl3t+6Tpn3c+W3kLvFtyOtDhpaNfnLFyWd4/1nuQh3BLlrCkJtkOBnHkr/DYojFjuIeCUEMCcpUcdT5qd5Lg=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3765.eurprd08.prod.outlook.com (2603:10a6:20b:8f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Tue, 28 Jul
 2020 11:36:44 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 11:36:44 +0000
Subject: Re: [PATCH v11 10/11] qcow2_format.py: introduce
 Qcow2HeaderExtensionsDoc class
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1594973699-781898-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1594973699-781898-11-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <db73d013-832d-234c-7828-80d8b1ed962e@virtuozzo.com>
Date: Tue, 28 Jul 2020 14:36:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1594973699-781898-11-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0139.eurprd04.prod.outlook.com
 (2603:10a6:208:55::44) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.158) by
 AM0PR04CA0139.eurprd04.prod.outlook.com (2603:10a6:208:55::44) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.21 via Frontend Transport; Tue, 28 Jul 2020 11:36:44 +0000
X-Originating-IP: [185.215.60.158]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef8bd260-bb8b-4ad6-7c3a-08d832ea813e
X-MS-TrafficTypeDiagnostic: AM6PR08MB3765:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB376570B531585D687949898DC1730@AM6PR08MB3765.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VvNUmgq6rpTiu487qKswmLS5oWTEzjsk/1pIhxjt6bhSbiyoFXIWvW1NEfNz0uVOGbCE64IuRKRRzuW+VxT/nAAKZfx+7alkC45951I4bHMgQFpuD9zudvB4dOhCnhLiAXzapEvJEbgINprDLgQ2ziM2cfkeBRIlu/2VUGeAKBDxAlOzX5uwyoad7KdrgcuddNns3VywndBm2Hg0f21DIM6ehoeYmfQsXl0kFK6ZzhcywEPtYh2WJ9BmJ7r0xec4D8slcT/xVJYxQsz9Chz/v4kS0TsyKWg8dy/dW9TbgqouTYUiTM8ty+XV0VZttQ6jYTMChNMENT949aMHOfnQ+d3rP/amY46DRZIodGSqH4A22fOJSS1EKUmMpC4VAbPh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(39850400004)(366004)(396003)(376002)(8936002)(66946007)(16526019)(316002)(2906002)(66556008)(66476007)(6486002)(16576012)(186003)(86362001)(4326008)(5660300002)(26005)(107886003)(956004)(19627235002)(36756003)(31696002)(478600001)(31686004)(2616005)(52116002)(8676002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: j0KvAgseAAkh9oiSQKoltP6YpWFdeD1fYZ+iImKh0T/eNZj+hdkqTak64nThKc8xPtcAujBq3E34URlFY3Q2VchypeDCgA5C5M0LulUPO3Bl/1b9cy0g3x+eydaxP092cFn6Ic0Eh4NKMvjm0sHC3m6j0iJfR7hnQb04kSdW2LvxGA6Pdg05RzS5puGb2yEXAIidGequ2x35jdzWjbi16x4lJjgKl07i97JY5jttErMhb0f904QeQR9hovSwRWpTE0+SRAUZlwxKH/WjTQrKgfJIsoOdaQFEoFFwf76O0RsAGoARldEJ5r+18+XkNnU21hc6HWQnZ074omELPzX861C/tIVyibYa2oPrVrWfI2lTV9ZpGZt6tmf60+RJ4qdVu/1Guv2WjyPC1qEtWcaBF5pjON+lW5vdsm3cX8jLY+eOHdOs1Vm5LXVQ+2HjdtgXqtECYZ7enCjOkWhamMp7ec6YEzlj9qiQwtZ7ZlIXiNO23c83x5Dlh2HGP3zxAdcd
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef8bd260-bb8b-4ad6-7c3a-08d832ea813e
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 11:36:44.5783 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1jkWA/azolDxCdXJfnldZDb30R4bDuW7MkBqq4OY+iA87ouWRfHePBU5TvpmTxloE6BoOx2nfQeMn15Fv1LbVmX8yasvH7WgqBU5J2tQrcI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3765
Received-SPF: pass client-ip=40.107.22.138;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 07:36:45
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

17.07.2020 11:14, Andrey Shinkevich wrote:
> Per original script design, QcowHeader class may dump the QCOW2 header
> info separately from the QCOW2 extensions info. To implement the
> to_dict() method for dumping extensions, let us introduce the class
> Qcow2HeaderExtensionsDoc.

I think, when dumping to qcow2, no needs to omit extensions, let's just always dump them.

> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   tests/qemu-iotests/qcow2_format.py | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
> index 19d29b8..d2a8659 100644
> --- a/tests/qemu-iotests/qcow2_format.py
> +++ b/tests/qemu-iotests/qcow2_format.py
> @@ -248,6 +248,15 @@ class Qcow2BitmapTable:
>           return dict(entries=self.entries)
>   
>   
> +class Qcow2HeaderExtensionsDoc:
> +
> +    def __init__(self, extensions):
> +        self.extensions = extensions
> +
> +    def to_dict(self):
> +        return dict(Header_extensions=self.extensions)

s/H/h/

> +
> +
>   QCOW2_EXT_MAGIC_BITMAPS = 0x23852875
>   
>   
> 



-- 
Best regards,
Vladimir

