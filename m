Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE2FC2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 09:38:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 865352166E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 09:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="diH5c92F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 865352166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyufK-0000AR-Ps
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 04:38:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46666)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iyuea-00088y-TZ
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:37:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iyuea-0007CE-02
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:37:56 -0500
Received: from mail-eopbgr00129.outbound.protection.outlook.com
 ([40.107.0.129]:55773 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iyueZ-00076H-QV; Tue, 04 Feb 2020 04:37:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WX9Y9wi+ifX4ESR6ldYA0OSCI+8seB+5rFhGUUP/dpHW78VqbvO/A74kdGAknPKab45a552mCLJwDCT75rgoFSPYGs5GeyVEm5Alc8df9gu6sVCrKmxzANIfGXX6P4A+VLzMgBL4o1WVpZ2atQgBUEsA043JTXMk4QnlZkMyp80cJrGkNwoM33tR+m1p0zxDg0d1S60HBvxpWrbaYRZ6ekiOY8Nahb5UVperKLoU6Vnzayzl1R1UgZBslpyQEahC3od+68u+pNJWFT4pZTnUrOgPep2h6625l0ZnD1EO3LfG863FkMsLQ0uC/AlmvCatDK6cDYX0aopzqmecBTKpNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQpsEFhbZG6BfX+SPGDSjh7JpMZ/m1TehwPPs/nglhc=;
 b=C9+Z6KcwuE1fVfJoG4BLyO+DOqr7JBxtj/nluj60BBPsGoJOA6s/D6Mrqyzj4Fb6ifKXe57Z4TCYGtE9bYuUqNOs5smkZQZbecnQ2hJXRJqVG5mLj3Yo2atnVXtB+gsFIceL40M2xOTxSIiowIZICIMetOFT8CbaqXrjHc1j3mVkW3mFRrdpcptBNZg2pT7Svk+OQw8EB2qIYFXY0AgiEFpdoe3y92VLeB9tmceOilQkNkcYRp2+GfX5Z9AWpTQOvx9SqI/q0zU/ypW286q1MyJGpLPfHCZLMGyxT2xMfA9Bf9685iRqWDko/FWbX1nxjDmIaUOqMh07RYo+LpMBhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQpsEFhbZG6BfX+SPGDSjh7JpMZ/m1TehwPPs/nglhc=;
 b=diH5c92FuJGuu5y2FTqkvmT+U11ZnDcEQ3cjbijjJwMGtXbkTDr2ZPW49CscShVZUTRtpk4qkzXY8OWUgdORnHB/ypgQY7W+k9AFXIKJGo7TjBlhyWT/mtMrNHgCFHISJwvbAJQiRpMVLtMxD+gNv9YwOrbEp+PjLcyQX0oDYfE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3334.eurprd08.prod.outlook.com (52.135.165.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Tue, 4 Feb 2020 09:37:53 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2686.034; Tue, 4 Feb 2020
 09:37:53 +0000
Subject: Re: [PATCH v3 10/21] quorum: Implement .bdrv_recurse_can_replace()
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200130214431.333510-1-mreitz@redhat.com>
 <20200130214431.333510-11-mreitz@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200204123751642
Message-ID: <662fdc75-35fa-05d8-631d-cce585b0a25b@virtuozzo.com>
Date: Tue, 4 Feb 2020 12:37:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200130214431.333510-11-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0701CA0071.eurprd07.prod.outlook.com
 (2603:10a6:3:64::15) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0701CA0071.eurprd07.prod.outlook.com (2603:10a6:3:64::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.14 via Frontend Transport; Tue, 4 Feb 2020 09:37:53 +0000
X-Tagtoolbar-Keys: D20200204123751642
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b31e2aa-3e3e-4ab1-cd6d-08d7a955e887
X-MS-TrafficTypeDiagnostic: AM6PR08MB3334:
X-Microsoft-Antispam-PRVS: <AM6PR08MB333416DC41366A9C93B9F712C1030@AM6PR08MB3334.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:400;
X-Forefront-PRVS: 03030B9493
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(366004)(346002)(39850400004)(396003)(136003)(376002)(199004)(189003)(8936002)(4326008)(36756003)(478600001)(5660300002)(52116002)(558084003)(81166006)(8676002)(81156014)(2616005)(956004)(31686004)(186003)(16526019)(2906002)(26005)(6486002)(31696002)(316002)(16576012)(86362001)(66946007)(66556008)(66476007)(142923001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3334;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dvpr5opdRy4BkrpsnTv5xQ/dUlo8C+UV0ukEdFCCEpmSgSfjnLTV+2o9BOPzZbHhnux82VVf4VuAagaIpeDwpJughotM/joxVbdfB948Ao2xtkawgj+QbO7CuWYacK2aqprBXlCtsygLnkLcfbqUCbsgRgswDG7i8SWkKZc8Uuhy0uVSXfINcdDWlFlHM93NUZQWtPgarf0z38HfR8NUkU9/RRb/wY8uEC64eJZ2TYy/+5JwV065Jsl8dryvzo9BInjbQkMJ9VJ/W76W4SlNZWVLlHkotUSjCKLqyROBUqWmK85p06quxtp7WgSQ975WYPwkSXuCGlQ2jXbB826jVzHWPxQYgZquErwj5T7P0I5r4mYU3zNLsEpo5O1WM7f8fVRLGnwo8cpXWiCdq85tfR2dTGOlCUUpjZ7/21ALwzUmjKz7H1N7gXscNvT1xZIwyViXsqXFHxVkD5MzOVMXgd7gAwTK7mq398BXQkQ+KslySwVV/NGmP9Dq4QGvcVQX
X-MS-Exchange-AntiSpam-MessageData: 5VycOG5qjhUJ1EHbh7sFT+iHoCW8TUvUGiE1f1FzgWlSl2zFfQ213YGdlAOG4LDrBsAAWUB68jRc/C33c3VJZ68gV0/h7GF5xlV6VtSnBdQJJUVgBlFzSL7EYkiRDWyYRc3cRvw/ehO2urhSTi4N6g==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b31e2aa-3e3e-4ab1-cd6d-08d7a955e887
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2020 09:37:53.7021 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2LgahAq9WHm/nnVgTouUaDRzAlqlcgLUeDm3EqrrFp/xU0llLw6kDhgka7KpGb9ARmwJy1MwjUt5oWAdgYILQgnWS0RsIpHPiK2ttvjRs2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3334
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.129
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

31.01.2020 0:44, Max Reitz wrote:
> Signed-off-by: Max Reitz<mreitz@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

