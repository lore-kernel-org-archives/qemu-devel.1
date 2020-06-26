Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FAAC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 14:37:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6A772070A
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 14:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="S5wAjtOK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6A772070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jopUH-0003Kw-5e
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 10:37:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jopT3-0001pQ-Rd; Fri, 26 Jun 2020 10:36:43 -0400
Received: from mail-eopbgr70093.outbound.protection.outlook.com
 ([40.107.7.93]:57657 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jopT0-0006Xh-N1; Fri, 26 Jun 2020 10:36:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=coBFWzOZQRKfL97ZvnxdumZGFdoDuLfsJ7mVV3AjJtKgaDHK1LUaeD1ppGSKZK6y2jWaZxB9izhuVrwYjdw3KqvPdIk4J8YKDigP0j+KiJpkzRxhbK55PYmDCHc1cdEb3cFZgQFlUEx08eQZerOgjrET+u9DZla9RkTUe2B8i65nmmXL1HUByTzhMRLYHjnFdpgyF46UU4NMw4LYg7X7pyb3b0qFy96o3Lw4gWkFk6aF8kpu94BuTpYVFAi+CicEGu891dPhzaeJPgu1p4kquEcBvd2EQ+KyPJU/hWXXI8ABCXxWEYu3oaSNUysVBLhteCuxb3x96Ep5TY7C3nNnAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/p0vsit4IdZqALNZfOFoQ7dDlMgIHm/Z1d26cMDP84=;
 b=AxOXbYv5wOHWA+uJV8+aQVJ9v0M1/YlB2HY8jubmDGOYiZvZnpSbQYihavVxTAyrjZ4teo0DZ76XyC4Yc2ESqoHAKfl313MxqHmksfHUqo34MS15OqgaK9vFAaQsAk9FyiPlxYNLvpgkal+ufvfIhSBvJapSdDHfcGV3A1Gl5ppnticsU2d/Lz9j2q/qakjpzXKcKSpQHZBoohGZGqjsgiT/TDiPK7Phdfyw3K39J0vGrefHENb498ME6jXRGoGhwy+wwGP9mavlpibqoayGO9HGrILa4nrRar2FnwJDZ1/9+tbKgL/ZlJV6YUt0CndRt3j3zczaW3Rjz3DBAagMiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/p0vsit4IdZqALNZfOFoQ7dDlMgIHm/Z1d26cMDP84=;
 b=S5wAjtOKqy2QAMxm57myAnOGbTivlz9it2RMHGDa3NTc1gB8ZdFI8mJPr5wscYH+YZb4hgHzxXlrtfW3Vghz4DKlf7K2MtSLVZEqdk1JyPxhFzXfXlQd5dYl8po5swGpxpd1QmWTcq72b+esuzlEsTAc8NbetGqVg1ofbGVyDuY=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5205.eurprd08.prod.outlook.com (2603:10a6:20b:ee::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.24; Fri, 26 Jun
 2020 14:36:31 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.025; Fri, 26 Jun 2020
 14:36:31 +0000
Subject: Re: [PATCH 06/46] error: Avoid error_propagate() when error is not
 used here
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-7-armbru@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <45536875-9cf2-72d5-b555-8b8b1992085b@virtuozzo.com>
Date: Fri, 26 Jun 2020 17:36:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200624164344.3778251-7-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0101CA0067.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::35) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.17) by
 AM4PR0101CA0067.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend
 Transport; Fri, 26 Jun 2020 14:36:30 +0000
X-Originating-IP: [185.215.60.17]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d45f94f-eef6-4d5b-cf96-08d819de514a
X-MS-TrafficTypeDiagnostic: AM6PR08MB5205:
X-Microsoft-Antispam-PRVS: <AM6PR08MB5205CB08CEE9581E18332078C1930@AM6PR08MB5205.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0446F0FCE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D5pJ40bwLhGJHSH7CG39UdzV7zu5S8XdOi0SN7QSQneX55Jfqzc2+J15CMJYukCfRMoHPHx2GhT+eXVVzdP9UnJ4PPSr9NvbIX/9I4w85+LP0s/+y6soL/7VX8Eq9TzOJiZuAlC2b3VsNJUJ8/sClsrReV50Xae++O6dPAjlfu70y8Jev36orNECUjkqGrm69dT2HDf6S5tfhO1uhmQ/2s/ZzRehJe+Gf3xkAinLpF4zTE3lrU2m8L0YCfaFqXXrpTeu7F4GfE313LRJdbjwiHWOG6D3bsNVpdK35RgxQbGNxHKchINfCX1PbCxeZFqT3qvFRcK8TAyoIAz+A3sqHBJKvGW19QFeIGvLvApk7KQWJyN/FtWmNoXwmpnHNVe6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(136003)(396003)(346002)(39840400004)(4326008)(8676002)(6486002)(26005)(52116002)(8936002)(186003)(36756003)(2906002)(16526019)(31696002)(66556008)(5660300002)(86362001)(6666004)(66476007)(316002)(16576012)(2616005)(31686004)(66946007)(956004)(478600001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: dv74LsIA0OJWdkkAKE3CQDMQCsjFsSAO2+a4l6CSqnQ4qWe7Mxek5xe0AfsYX5wlo24TrbSb4cNgEXed5iP84ea1u5G9/HuapyPqjXgxkrSUMLC93Qd5sWsJ0Ln+bSXM4qCr/uevUPzh19yBX2tM705blelqjIZktKQsdHqC6doVDVd7pgn70Mx2rJw6Btet+dRrzyS7ycJkvoKsYob9b20S8NVl+id0vtswDODfxHAHsJCHs2A6bvZWY8M3yf+7odJbf9I9TAOvaqMgsWe2wkfz0MvyWNVreM9+Rkk4jDxHg+urK8yxUPUUWT3RJKR2ftA4dF1KiIPxaHDX3kVoiOpxnbHzToGyY81UhKUlqO51rM8agssXb9Ks/FfFqckRcyqC30bCA3Z1gNdSlkNyICtNmNhwylCTEqVsYsu9Y/Q4Uru/x1DbpD9Rmanb9XpqUen6LjDIVjnsWIoPRTZFOO+76g82Rqzqg5YwY3j3Yp8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d45f94f-eef6-4d5b-cf96-08d819de514a
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2020 14:36:31.1242 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N6TJG4RfF3F7TE8m+CWx1LyQLtvlsnsZlcRB3TKYFI6Fd3PEfAJtKHux2ragUOBsid5OVKJSomSJHNBBkhElRcqV+V1ZGae/hhHiD8jcNuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5205
Received-SPF: pass client-ip=40.107.7.93;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 10:36:32
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

24.06.2020 19:43, Markus Armbruster wrote:
> When all we do with an Error we receive into a local variable is
> propagating to somewhere else, we can just as well receive it there
> right away.  Coccinelle script:
> 
>      @@
>      identifier fun, err, errp;
>      expression list args;
>      @@
>      -    fun(args, &err);
>      +    fun(args, errp);
>           ... when != err
>               when strict
>      -    error_propagate(errp, err);
> 
>      @@
>      identifier fun, err, errp;
>      expression list args;
>      expression ret;
>      @@
>      -    ret = fun(args, &err);
>      +    ret = fun(args, errp);
>           ... when != err
>               when strict
>      -    error_propagate(errp, err);
> 
>      @@
>      identifier fun, err, errp;
>      expression list args;
>      expression ret;
>      @@
>      -    ret = fun(args, &err);
>      +    ret = fun(args, errp);
>           ... when != err
>               when strict
>           if (
>      (
>               ret
>      |
>               !ret
>      |
>               ret == 0
>      |
>               ret != 0
>      |
>               ret < 0
>      |
>               ret != NULL
>      |
>               ret == NULL
>      )
>              )
>           {
>               ... when != err
>                   when strict
>      -        error_propagate(errp, err);
>               ...
>           }
> 
>      @@
>      identifier fun, err, errp;
>      expression list args;
>      @@
>           if (
>      (
>      -        fun(args, &err)
>      +        fun(args, errp)
>      |
>      -        !fun(args, &err)
>      +        !fun(args, errp)
>      |
>      -        fun(args, &err) == 0
>      +        fun(args, errp) == 0
>      |
>      -        fun(args, &err) != 0
>      +        fun(args, errp) != 0
>      |
>      -        fun(args, &err) < 0
>      +        fun(args, errp) < 0
>      |
>      -        fun(args, &err) == NULL
>      +        fun(args, errp) == NULL
>      |
>      -        fun(args, &err) != NULL
>      +        fun(args, errp) != NULL
>      )
>              )
>           {
>               ... when != err;
>                   when strict
>      -        error_propagate(errp, err);
>               ...
>           }
> 
> The first two rules are prone to fail with "error_propagate(...)
> ... reachable by inconsistent control-flow paths".  Script without
> them re-run where that happens.
> 
> Manually double-check @err is not used afterwards.  Dereferencing it
> would be use after free, but checking whether it's null would be
> legitimate.  One such change to qbus_realize() backed out.
> 
> Suboptimal line breaks tweaked manually.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

[..]

> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index 8d6156578f..6705220380 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -316,9 +316,8 @@ int ics_set_kvm_state(ICSState *ics, Error **errp)
>               continue;
>           }

local_err becomes unused in this function, we should drop it

with this fixed:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

>   
> -        ret = ics_set_kvm_state_one(ics, i, &local_err);
> +        ret = ics_set_kvm_state_one(ics, i, errp);
>           if (ret < 0) {
> -            error_propagate(errp, local_err);
>               return ret;
>           }
>       }

-- 
Best regards,
Vladimir

