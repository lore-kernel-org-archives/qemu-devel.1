Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7C3C2BA2B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 11:44:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 602DE206F7
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 11:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZWEnK4rm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 602DE206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMs5b-0001Z2-EA
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 07:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32846)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jMs4z-00013I-TC
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 07:44:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jMs4y-0000oI-SD
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 07:44:13 -0400
Received: from mail-eopbgr10105.outbound.protection.outlook.com
 ([40.107.1.105]:12937 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jMs4u-0000lZ-S4; Fri, 10 Apr 2020 07:44:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0dMEBA7k78vVF2yUuKFxMa6t0i4+2AMV1suxtViFDG2nsNVUzr2cvN4n2tvrRaMulkxDoIdvst99Wkn9y7CDKd2oz0domSNulehCFk7tyulwcxM1wCewLz6kbO/BuwFV39f79fXfyX/sLZ/2msLtZOZspI56rW1v2sKwloR/dn4Iv6wkp34BcCUF/qxKE//izHhYBMMOw954MjPZNw4QEgimWxvbdz7oyvkqiRWAJUkrE0gXO+bOGVfI9AhBaO0xS+ZRCD1bMy/hTLRjHQQUHW8QtaodSNARxeJotFLfhuVRdx58BEo/TDlzXPxMc1T0RTDWuHfW+gHlqEGoSBXMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xHsknqUE/+MKEPMt6MrgmW4rFHta73/IqiMyJ44MhE=;
 b=eoaUEUblEdyqJEEMhmqCBE09/sN8Xtcd8c4Um4s0p2xN+sCPUV7IsFgrRT/VW5VPGBdwTqQWQLKM6kklE56wbCbMM98KRByYy3VXpeMEFOaaXK+PCEMFQJtLtxxg2z9m9kqdDlf9fNqvBr6WrXHtji7JOx9/ZC7SaLgeAbzRWBOieJ7Fe4+yzTiFAGlSL2YSUef3s7bx8HpUPktbRCic5ANp+PvLsFEJS3f0fRan73ZNgmol1xn3TQz0AErSCSsqy6QeQRtrv2u9eqE8yduFZJU/b71O5G7LiXgWuiRZ00uKeCjXQrSi8nh3QYEFD2RJVs3K4ESlf2/U83n7n08AMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xHsknqUE/+MKEPMt6MrgmW4rFHta73/IqiMyJ44MhE=;
 b=ZWEnK4rmvQj81EfDpB0TtcpsKIvWlRO4BCYAGKAl3Sjon93ScpedZKymH1qYrMlTVXfnMgmJMchEUDNwMNsQOQ0Myupq3DaaZH+vWQq7WTfvt+ZEAGlHqMGGZKXS2hsw2co+3m/iTgxLhExRWNXr5A5jNmXtYDXpaeETciubBMM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5318.eurprd08.prod.outlook.com (2603:10a6:20b:104::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17; Fri, 10 Apr
 2020 11:44:05 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.2900.015; Fri, 10 Apr 2020
 11:44:05 +0000
Subject: Re: [PATCH v12 2/3] qcow2: Allow writing compressed data of multiple
 clusters
To: Alberto Garcia <berto@igalia.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
References: <1575288906-551879-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1575288906-551879-3-git-send-email-andrey.shinkevich@virtuozzo.com>
 <w51y2r41u4d.fsf@maestria.local.igalia.com>
 <5bbb126f-37c0-f107-c3b3-667ed43670fa@virtuozzo.com>
 <w51pncf61do.fsf@maestria.local.igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200410144403359
Message-ID: <c10e8f5d-fb64-c01d-dca3-6dbd0ace28ea@virtuozzo.com>
Date: Fri, 10 Apr 2020 14:44:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <w51pncf61do.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::9) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.134) by
 FR2P281CA0022.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.17 via Frontend Transport; Fri, 10 Apr 2020 11:44:04 +0000
X-Tagtoolbar-Keys: D20200410144403359
X-Originating-IP: [185.215.60.134]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85f1af06-5d6b-44ef-95aa-08d7dd4478d4
X-MS-TrafficTypeDiagnostic: AM7PR08MB5318:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53181C9170E74B1FFF28B197C1DE0@AM7PR08MB5318.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0369E8196C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(366004)(396003)(346002)(39840400004)(376002)(136003)(81156014)(8936002)(956004)(5660300002)(186003)(110136005)(16526019)(6486002)(26005)(2906002)(36756003)(478600001)(8676002)(2616005)(66476007)(107886003)(31696002)(16576012)(316002)(31686004)(66946007)(66556008)(52116002)(86362001)(4326008);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xyj6uQSZHqQ5Y0o5sXangLcyO058nfHuTRnARbcIkbIe0OO0dNaEKN9CBw43i9bWU5m4u5kTm2M3wsteFIWoEmwFFjaX8su0598f90RyHnMxbiN81xcny1fPHl5e/xK5U7jg0MJaP0yXyZrLnViPVuFXIYGs0gzltaHyzD4d87/KG70YFus424yPqsp+HkCG4smUOXqPXEfN8TgdNowi2l29eN3Dm2X41NDMh2EWlN+lngEFMR+Fpb0wYjkwjstsWF6Xa8gcyrlbaVnudCY9nEodU7xOY1/JqsjkgyeySmsVJdY7YCa9XZYfOFBa06V7pC4GktOANgJpIEiihPZwAig4DkLtrBlWoQ3F0jrpHwUoDh3xagokDsX07g4l3wFZkcNB68yfX8aTCfvhTpu/XpydWfYcFLdTV+1/rmvMwkdT0V8on54Ig5scJVhsb8P5
X-MS-Exchange-AntiSpam-MessageData: vHIHxmOXtFyB/tXtAXbaxRwNHXyd9PEvBoeWA8ekc+WoxF01I7bH/YSn9PGipAg1b3oiwJI4U7exIW7mpTRpifKdNuPg6PG2WkRIOaZICieryz1HryYPvvIlsvg6dGTL4FZwepoAQy6QRTfcLUYx0w==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f1af06-5d6b-44ef-95aa-08d7dd4478d4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2020 11:44:05.2739 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MQfVxWXsyDnUMb8v1wb4JDC2yXU6KYTItjMM/s8yDWsP9pUvyvzXzJ6onY+RF5LiNqqN/RmwiBoFV50QOVuVcpqBL5DPfELO+sxtpAk8aj0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5318
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.1.105
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
Cc: kwolf@redhat.com, den@openvz.org, armbru@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

10.04.2020 14:12, Alberto Garcia wrote:
> On Thu 09 Apr 2020 08:39:12 PM CEST, Vladimir Sementsov-Ogievskiy wrote:
>>> Because of this a test cannot expect that running the same commands on
>>> an empty image produces always the same results.
>>>
>>> Is this something that we should be concerned about?
>>
>> Parallel writing compressed clusters is significant improvement, as it
>> allow compressing in really parallel threads.
> 
> I see, I just wasn't sure if you were aware of this side effect.

No, we didn't thought about it, so good to know, thanks.

> 
>> So, I don't think we should make specific workaround for
>> testing... What exactly is the case?
> 
> I noticed this while writing some tests for the subcluster allocation
> feature, but this is not a problem for me. Many of our iotests make
> assumptions about the location of L2 and refcount tables so changing
> those would break a lot of them. This thing only changes the offset of
> the compressed data clusters (and their L2 entries), but as far as I'm
> aware no one relies on them being predictable. I just need to make sure
> that I don't do it either.
> 

OK. I had similar problems (because of asynchronicity) with existing iotests
in may series for backup. As I remember, I had to add options to just disable
asynchronicity for some tests. So, if needed, we can add some options for
qcow2 (which can be used to justify number of parallel requests, not only to
disable them at all). Still, of course, it's better to avoid testing only
sequential IO when it is async without options.



-- 
Best regards,
Vladimir

