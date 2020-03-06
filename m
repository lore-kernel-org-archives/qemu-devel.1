Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDA4C10F00
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 07:46:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4632420728
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 07:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZuV1nWzd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4632420728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jA7gf-00018f-Gg
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 02:46:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60587)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jA7fV-0008A4-KN
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 02:45:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jA7fU-00075p-K9
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 02:45:13 -0500
Received: from mail-am6eur05on20706.outbound.protection.outlook.com
 ([2a01:111:f400:7e1b::706]:47713
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jA7fU-0006zX-D9; Fri, 06 Mar 2020 02:45:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JVwxU7XfjbRfwXTNI+kX2f+aJSDZHDExQOR14bdQdJuZRd3Dq/u2co4wzc5sVOtLJ5Y2cdkF6ZOoJfAa791CNxd5fNoDd0CBe7Ue6HNkIYb8rfkvm0QBZHDIQKcAaN2jluvBvkEURzTzfIT3r6ANpfXB8D1PrqdWnZcva7vlpBB0kmX6M8KRJR0SleqYmBmnFY766fMHKLhKFLWxl6KYbxG6NUrJUfE7MfsT/ghvuwoIh1ubRKBw8ul9dPZPFJzm0POIuj9lbREEgtuNAqdH2LD20esCoiOFBDEC8/rrBrr8sNZxpcETiSDKle6c6WseBm8MIT7/X6ehcAWGYV7p5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fC2qxSGVMOcILOKWdx/Qu10ZMwEjKH44OOckisvQgmw=;
 b=apSnFxYSVPxwUrnZPUaqItysA8EQ10hzeNlKb4FRczC8lpHZiySkHHge+5/Kd+25mgTkOaafM+wu042gzdoT0AFwd5odQ5kvGjbp3Pi2EegHP+BFAC+Foahqdr0zshediib2IBqTLNDyFx2vaof9p15LmfPVcgdqeDpUxSKMX7ICuAxPTcfnR+BrLwcEwPxVgsdoUZl3E0ZXdLt5N9ORJ12SliYsmCJiwzyzdlAEk2je9XldD3RpMLuO8hxBEmKndoHMfUE9qddrntnqPhuFE4FYMwU9DL8r9PZQey1TYa5LcRZQW1R8Aw+ofBjIcZukSZIwU6YuZmRLIfdgA2/5Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fC2qxSGVMOcILOKWdx/Qu10ZMwEjKH44OOckisvQgmw=;
 b=ZuV1nWzdWQcoFsIA1LGTB62vC8Wi8uiUKeNWKAT4YfskT4GduZZ8pNiCPMeFFPtaG8G7WzU/8f7MtIDoaa3MfJfjx38bEXjUo2YKp1SK+zW2T6H4t6fudJArLazpKCwW0tApL8Bop0/+ahBnLJakf7ipupyDKnenKsiSRnkrsBg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3270.eurprd08.prod.outlook.com (52.135.169.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.18; Fri, 6 Mar 2020 07:45:10 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2793.013; Fri, 6 Mar 2020
 07:45:10 +0000
Subject: Re: [PATCH v4 00/10] Further bitmaps improvements
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200205112041.6003-1-vsementsov@virtuozzo.com>
 <4cf33f31-cdbb-cee4-a1b4-4053c88a002e@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200306104508312
Message-ID: <6b570584-100b-248f-5412-98a5d91f62f5@virtuozzo.com>
Date: Fri, 6 Mar 2020 10:45:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <4cf33f31-cdbb-cee4-a1b4-4053c88a002e@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR05CA0213.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::13) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR05CA0213.eurprd05.prod.outlook.com (2603:10a6:3:fa::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.11 via Frontend Transport; Fri, 6 Mar 2020 07:45:10 +0000
X-Tagtoolbar-Keys: D20200306104508312
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84d09754-7719-4139-d9e1-08d7c1a24c47
X-MS-TrafficTypeDiagnostic: AM6PR08MB3270:
X-Microsoft-Antispam-PRVS: <AM6PR08MB327018BEF70F3039327EBC73C1E30@AM6PR08MB3270.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:758;
X-Forefront-PRVS: 0334223192
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(39850400004)(136003)(346002)(396003)(376002)(366004)(199004)(189003)(2906002)(186003)(16526019)(52116002)(6486002)(8676002)(4744005)(81156014)(81166006)(478600001)(8936002)(4326008)(31686004)(26005)(5660300002)(66946007)(31696002)(66476007)(66556008)(956004)(36756003)(86362001)(16576012)(316002)(2616005)(53546011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3270;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K8KJrzp7iDbHlWn2yLm5q8130uyQrvWw/kVXFmryQNhZ0aCtz/zg112NEbopi8sh9hIu/8QHdKBelhLVQaUOCoUMLKi049WsEBmaWRZi55Yf7l5gvkI0HI7lo/lkAGhzu+8xf+iJ6d0wRFNnw04NJPcYk1HQbIoYFacWHzWFFWoXYOsc9lxgqXja36m1peGcq05Kb+xsMeTrwL8QiVqBWE1QZl3+M22hBMCkCqN/KsbaBbW1RyPAxu2Nq3RZDL2UuKu8/nQ75K0oLefwuRihZmfwEErAQ9izC3luanwEyb0EKcJKqxoUwZMYWzq0Vd4oYgbjNWKRA11SidXKGoU3sYJFcKvLs40Uve5v+gwGOFPd7crC4SC8bsCQbbKzEVKLXHqTtZvRa6WvU10MwiuZ1aNm8xpsyaK9Tju7nQ+v8WPIpteRavAFttglNAZFrjRI
X-MS-Exchange-AntiSpam-MessageData: NC0/19dJpNOp5toWqjGU52U2cvqa6Njhdr2tD9RQOqPeEMXJJphyDuTPzwMg+qWWZSFxn3jQJlu7cZ+aRCvb9FjOpIerUGUiKt5cRx9lr823+nw1UnCV8BZXjLMUw5g2bt/HJMf6NDUdl7TQqlKx1Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d09754-7719-4139-d9e1-08d7c1a24c47
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2020 07:45:10.5973 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NHi7Vlb6SqGvpqBqg1hDQT3krh7bSXuPVZYu7tHP1U26SAsFoDzkcu8aSB/ak04zY1iT68z3DPkPJXcSONrU9qkBEuzJQfkrFln5V5ms72s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3270
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:111:f400:7e1b::706
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
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

26.02.2020 16:13, Max Reitz wrote:
> On 05.02.20 12:20, Vladimir Sementsov-Ogievskiy wrote:
>> Hi!
>>
>> The main feature here is improvement of _next_dirty_area API, which I'm
>> going to use then for backup / block-copy.
>>
>> Somehow, I thought that it was merged, but seems I even forgot to send
>> v4.
>=20
> The changes from v3 look good to me, but I=92d prefer a review from Eric
> on patch 8.
>=20

Hi!

Could you take it now, or do you prefer me to resend?


--=20
Best regards,
Vladimir

