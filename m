Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54288C4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 09:59:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 201CD222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 09:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Xksi/k65"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 201CD222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Fx8-0007bM-Ai
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 04:59:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33252)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j7Fvl-0006qT-Kr
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 04:58:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j7Fvj-0000KP-K7
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 04:58:09 -0500
Received: from mail-eopbgr70132.outbound.protection.outlook.com
 ([40.107.7.132]:56629 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j7Fvh-0000E0-Bm; Thu, 27 Feb 2020 04:58:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUWTupDysZ1yH3zdwF6UngzS3Rd/Xhxa3kZ3sUDLKvrlObbG+Ivyc4W15ZMfScFMBbHwWszR8QGwwc7HfgVpoU/ZS4WttHDsC27VAsQ4eeAnWjqGlYYp6Jx2E9F/VafWWMytCJeZielD7M7bBSh+1nNH37yWSZu8+jWz3iCK1ordkWarET287fO0FgpWm5VtThCRKs9AmENO5g3ozzorC6JzEt60qerespec0pNG1pSUdTf1bIp6xgzQ11owp7o//7F2EwFBZuodExz4TyKCyEldgvbU7cgI3NkVegDzn1/Dnvk9d4Tdw+jCb2XKXYow77U5+Bu2zb0l0pxhAv6sPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnWDxVpxUO34YF5UEw6bbVGT6Iyd7iDxL894AiMliC0=;
 b=krDhCCWxDYf82WlRxuLuOhVoJXFYmqlOB0JA/QwL6/+kb0XM6T2Cin1O8QaI8IKiDdvaD+8+zx6CBIEsnoZVtzxQ8xVyQwnWXPzLYwYHl33GjkDgXCDdDYTmJMQ42MsV/Dubj8eJgqLc7SGcn8ZsHEwzGr5LzbubawExMCcAyaLHLWF5chN4y4ATtBVaKsLWF+66sko/38BYRM9kXjBZ2kD948E7ix4u2l4KDwLgtsgzL3C2RazthyXy/DS/IIp2DdRh7ov6qCVSBDw04Bm4Wt0WloU1W134f4VnNDR660o/qN+BhpwDDg7BeZ4AkzcjshvBKiBgdgEgeydXX/Q79Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnWDxVpxUO34YF5UEw6bbVGT6Iyd7iDxL894AiMliC0=;
 b=Xksi/k65dCCSosNYJfki1U0flv5TZEv1DxdbBTgkgv+MScBh5x4AZSziZDGczUuOxBD8iPctiXJq+IcDYLQXmlwaLqY2luteWq9x4LFfXtuzGtBCU3jAVhSQOElDS1dtBWGpFjzHE+xlsomnETFBzSAif6OikmhAeIWZLnrwDH0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com (20.179.28.138) by
 VI1PR08MB3118.eurprd08.prod.outlook.com (52.133.15.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Thu, 27 Feb 2020 09:58:01 +0000
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::91aa:2540:62c:aeda]) by VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::91aa:2540:62c:aeda%5]) with mapi id 15.20.2750.024; Thu, 27 Feb 2020
 09:58:01 +0000
Subject: Re: [PATCH v1 4/8] iotests: filter out compression_type
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200227072953.25445-1-dplotnikov@virtuozzo.com>
 <20200227072953.25445-5-dplotnikov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200227125758597
Message-ID: <0fb709c2-5a06-1287-bc8c-dd41c2e14a7b@virtuozzo.com>
Date: Thu, 27 Feb 2020 12:57:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200227072953.25445-5-dplotnikov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR05CA0170.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::18) To VI1PR08MB4432.eurprd08.prod.outlook.com
 (2603:10a6:803:102::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR05CA0170.eurprd05.prod.outlook.com (2603:10a6:3:f8::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Thu, 27 Feb 2020 09:58:00 +0000
X-Tagtoolbar-Keys: D20200227125758597
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd8620be-8a41-4fb0-f2c0-08d7bb6b8804
X-MS-TrafficTypeDiagnostic: VI1PR08MB3118:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB3118783A8AE09390047FE4E6C1EB0@VI1PR08MB3118.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:800;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(346002)(396003)(366004)(39840400004)(376002)(136003)(189003)(199004)(31686004)(31696002)(66946007)(66556008)(66476007)(5660300002)(16576012)(2906002)(478600001)(2616005)(36756003)(956004)(316002)(86362001)(26005)(186003)(52116002)(8676002)(81166006)(8936002)(16526019)(81156014)(4326008)(6486002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB3118;
 H:VI1PR08MB4432.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3pc2tEgSUfDA1YWBvak4h49l6nHnRPggQyk0Ja7jiuM0BVMsP1authcoVZz/9/0Q1A/oh/3/sXUFngnKao/O0JivMGke12hevb3Ww2wdzJH5g3dFCRw7/iCBcBf0xRW7oIYF6JQdFbAk9MQilcpKobiMoF/6tQdtXgGkR3umrj5qx/YJj2KFUCJ1U3dRb8IBhQiDyd+oQ0hP9enVjdyWs+20ZPJdN2Z2runW1Ad6PAM6uWgzt5OySfuJtglcDpR6mfkBv/yxyNEAds04I1pCxgv7D79RCajFIHrsM2qrs6/Y89clPp6lMR+zdajQd9XLSn1YiBLoyDjVqcmGRDfC0VxOpJn2WyCqwJxYli07wV8SSCglMdjeV1/ytga/Jsh4CkdkkxMTB8UNDWgruebY+ROoLY/UV+34/EQQceakxj9soVYBFlzsBHoueJ+zw50A
X-MS-Exchange-AntiSpam-MessageData: 7DuNc1ScAdBM44Jidn5ozh3x/3vQCYFwrEXk+YLpmDvEYLFAjRAvO9hv8j0fv64VsSU65crqjZAPUydaekdxILz844YhJCR2v9RseTpzcpCOoa8vb3ZEb5M/U4FtFWcXJ2mfaHPSkaoeWXX+A4fLmQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd8620be-8a41-4fb0-f2c0-08d7bb6b8804
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 09:58:01.5034 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zp85qgE9eDaTMv+mYEwiIT0mMMCvGE77IeOLsbKp7d+1M80jNhmBiVHWsyprBvi0jPPVo0jX9NuZpFQAleCHbziKUskYkCXW1ROFi2/X59o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3118
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.132
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, den@vrtuozzo.com,
 armbru@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

27.02.2020 10:29, Denis Plotnikov wrote:
> After adding compression type feature to qcow2 format, qemu framework
> commands reporting the image settingd, e.g. "qemu-img create", started
> reporting the compression type for the image which breaks the iotests
> output matching.
> 
> To fix it, add compression_type=zlib to the list of filtered image parameters.

So, the first patch breaks iotests? Than it should be merged into first patch or
moved before it, to not break git bisect.

> 
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>   tests/qemu-iotests/common.filter | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
> index 3f8ee3e5f7..c6962d199c 100644
> --- a/tests/qemu-iotests/common.filter
> +++ b/tests/qemu-iotests/common.filter
> @@ -152,7 +152,8 @@ _filter_img_create()
>           -e "s# refcount_bits=[0-9]\\+##g" \
>           -e "s# key-secret=[a-zA-Z0-9]\\+##g" \
>           -e "s# iter-time=[0-9]\\+##g" \
> -        -e "s# force_size=\\(on\\|off\\)##g"
> +        -e "s# force_size=\\(on\\|off\\)##g" \
> +        -e "s# compression_type=zlib##g"
>   }
>   
>   _filter_img_info()
> 


-- 
Best regards,
Vladimir

