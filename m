Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B846FC2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 09:47:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8788B2166E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 09:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="RYS45tas"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8788B2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyunQ-0002oM-Mm
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 04:47:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51781)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iyumO-0002Id-SL
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:46:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iyumN-0002J1-HC
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:46:00 -0500
Received: from mail-eopbgr150129.outbound.protection.outlook.com
 ([40.107.15.129]:38597 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iyumN-0002BH-A3; Tue, 04 Feb 2020 04:45:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EwPuIWa1hvxKGJvf/G0hq3A0WGf19CW7O4FT2zCwUYHmkHOKtAtwMiuGCk69kyAdrbJibCSRYab27nBzVlQiEgBK3HK6y981VG34DoOhlnJD3mT1KjCojFgvMLunYCiFqSD0LTclMpVq3AV4f4q5CRUV89FD6j0VPc48qwr3QEpwR3jmO43MYVxWgZO7xFQGEArxnAYmj4mHXxBkkJRQ4stEt0QYAkpMdQYvrJJ7X/4xjYM8CnOuSguIAc9s9O6wzcq1eI4erHklBGdk+1ST4PsE9qOTPGvmiLXg++3ufGUdMhRDxRo+i3dUwjm8eBIlxXmvSsqNF5R0C8AmSUhKCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oi8b2XaUZpbDLV3H9c3FSSd9ZsSkXIgqwYuYcpD5xhE=;
 b=LhCr5exZw/iCBzTmU4/NngYCG5srprVWg/2Yu7LPKKO+xV/E0vIPqLMdP6n37W8hCIcviSFfGv+ujREoSAsrf1unBhtRq4oBPS5hoKLLHLZVS2EJgx+jSVjBcNpSKnNhGnu7LQOdugw5XO79JLGSoXX6HdNiVx+mzkzTuqGSViO8Ani+r1YncQ4d9gs1Vu2Jrw5cxx3ebrV7EhPwp2xYrysYJlxMneZbvKaXyPsDZmQdws4HFG0nrkziy1PMNIHAAeIAb/uAr4zNKczZaN+EiWpnKj+JuVQ6C/rVaaIo3JVFDDGCkGSxFGfHpCOEtn800J2JGBmdNd4rJ/Ne9nWMQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oi8b2XaUZpbDLV3H9c3FSSd9ZsSkXIgqwYuYcpD5xhE=;
 b=RYS45tasW6psA8kbnqRp+j5EAA/DITdoArc7/P+MjiNqmRnRatXSDkAMxxCNmzUl9QTnfTiV8/OvEl46XxqHoOK2e7OLaUW7AorSTKTsuZtMHWgPYV+2xhIjESB0CrFxWv4dnZfegSRtFhWvKoo+/gNHZepIQrM0YwvfK8K6U6E=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3461.eurprd08.prod.outlook.com (20.177.113.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.30; Tue, 4 Feb 2020 09:45:57 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2686.034; Tue, 4 Feb 2020
 09:45:57 +0000
Subject: Re: [PATCH v3 12/21] block: Remove bdrv_recurse_is_first_non_filter()
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200130214431.333510-1-mreitz@redhat.com>
 <20200130214431.333510-13-mreitz@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200204124555104
Message-ID: <57a704f6-b658-2286-5a1c-bae804161e78@virtuozzo.com>
Date: Tue, 4 Feb 2020 12:45:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200130214431.333510-13-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR05CA0254.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::30) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR05CA0254.eurprd05.prod.outlook.com (2603:10a6:3:fb::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32 via Frontend Transport; Tue, 4 Feb 2020 09:45:56 +0000
X-Tagtoolbar-Keys: D20200204124555104
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7c13f14-5023-49bc-3a4c-08d7a95708ec
X-MS-TrafficTypeDiagnostic: AM6PR08MB3461:
X-Microsoft-Antispam-PRVS: <AM6PR08MB346147A4139C81A62A3E94FBC1030@AM6PR08MB3461.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:480;
X-Forefront-PRVS: 03030B9493
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(346002)(376002)(39850400004)(136003)(199004)(189003)(2616005)(558084003)(16526019)(8936002)(26005)(186003)(478600001)(66476007)(956004)(66556008)(66946007)(5660300002)(4326008)(2906002)(52116002)(31696002)(36756003)(316002)(16576012)(86362001)(81156014)(8676002)(81166006)(31686004)(6486002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3461;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FTLAdPu3DNv9z/wHZzJgPVaVliy1cJREV1T12prjHZxiDPdkM2nbJ2Z6PDNKt0RWmB/WCUnRWu33eeec4VeMHOH6VfHjoHLISRvHDi+ukYPso5P9RuESzmUaj3IgiJBRvvc4xqOc79RceKR7uIaA7Su42Hzakqiye90gjhs5R/GANClw9ss7GiHdm60DaHnOZQsLOopZjBDNZYjE7KiO1pvhTBe5+XEWJn23dJvuK9SdgsmCJ3OP+Wl65MK5aqeOEPxGsoSKioqJqI7FDUc2xmYKg3B6MdnDdxhaqvW9gr3ETB0nLbApTqueL3QGheJYnGj5tDLxB04L3B2weSmLcRgq1FxkQEuKRW9XWzSfItT8datX3NMwoJetVB1XGvaMJCKHZlj5lmRoYdsPNAL8TEphrCit9oRAqKTn07LlWC+3EnCGWpW8Qfs6cMNrYbBU
X-MS-Exchange-AntiSpam-MessageData: yiluu4JFNOmUtrzmzNRtVUVa1ObAszoWQxR1W67HfSkHvWFmG4CBct/SkE0UYvAqFTQVPKehptMkqZHq77ALWo/FAY8q9u1RvbOKn0ju5f9UIyFF+sYMKgP08JezBOs1W2zPWz3EcljMpdlZUl3MqQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c13f14-5023-49bc-3a4c-08d7a95708ec
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2020 09:45:57.4501 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aSR4ivubtxSkz+L1NkQKFy+HqbdRqk1HvJNj7+2eENu3Dh+dujeEThlWWliYKdG2szYTdntNh7hVeAtQClktBok6DNUHRbpbjaOF1eJYp1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3461
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.129
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
> It no longer has any users.
> 
> Signed-off-by: Max Reitz<mreitz@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

