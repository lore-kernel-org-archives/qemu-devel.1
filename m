Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1386AC2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:14:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB2C820672
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="nZaHNXla"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB2C820672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLWG8-00078S-0s
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 14:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42043)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jLWDt-000323-OP
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 14:11:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jLWDs-0000pB-GP
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 14:11:49 -0400
Received: from mail-eopbgr130138.outbound.protection.outlook.com
 ([40.107.13.138]:49853 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jLWDm-0000gc-G1; Mon, 06 Apr 2020 14:11:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+7Eez3mtV5K/MMjzwHZDz7BhHn8UMgTZ3MzAL7VyksVMjE+6dKknmmGn9n6HsDyeY1/ZwBiSfOOJTyc1RaM8QQRRU4nSKcvH71mjpN4ELHGak7CHfeRAkdryTkF70zFGdgoJGis9MJpYWGm/uBKLiLrsXGrkAry3HCY1nbzjWlE/V9ZD2MahF1q4omPl0hyUTTG6KEDXKm9QuoTiil+Bw2DknCta0TbvYjrYDD4WAy2G4cHx07qSeqE1f3YD4BHQL0PpyhkAgGHadm5HnD3TQ+IZ18WNXfQD83P9RQq/07X2z7j1N611HgtUzzj6HK57I/agaLajpNOvyhAy57SIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WoeiNAiZilabHejGMNLyh2ndw5JkHG2GO+RiqeAy+xA=;
 b=odS8rsCINmGp6Ci/OWs9ii6SE3o73THcgFnYqszOQ01h0rgK93tia601r+DJW7E2v2Ip5pjEyJKWT4Fj4DJEB2yrDlhzI3fBxvwHWLin16sVAB7UdCArLbeYj3Ub8qvkF3MOzp28TWsjobwqt5BzsLKYRn8O0qy8LgA9aL2s6U79eotkpYJPSg2YBpcxy6M70kaha5wVr+tRQgeeJ2UBtfYr3Tozjh2NdRvhHLDreJxwqCAlVTgFVP/YrxJc+C9Mw/DktchGRE9QaLCq/8XSNprGC8MzNKKc86behusRcWbtAKubtmfn3FwdcvyPy3+Lg5gsPtRQybt63l+Yn3h1/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WoeiNAiZilabHejGMNLyh2ndw5JkHG2GO+RiqeAy+xA=;
 b=nZaHNXlaQ4j57CfsoeyK4fxDbmabuA2UD21+ZMc3g5LqWbmuXWgWiKxr1FnEUTLWrDZauv/7zmOwl+InTjMU9jR534Kq/Kz0IsdXYyG1vr64b3KlrLPRn0RrLoCCfhgf3E7JoU9gyzqSmScPJBHf3ixjV8kzb1DZ8HmrzWxrHg4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5527.eurprd08.prod.outlook.com (10.141.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.21; Mon, 6 Apr 2020 18:11:39 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%8]) with mapi id 15.20.2878.021; Mon, 6 Apr 2020
 18:11:39 +0000
Subject: Re: [PATCH for-5.0? v2] qcow2: Explicit mention of padding bytes
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200403181907.878751-1-eblake@redhat.com>
 <8fe869d5-baf5-6d04-78d4-bee89cd7ef47@virtuozzo.com>
 <3f720e97-a499-67f9-f85c-1dba29ec9551@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200406211137311
Message-ID: <b5cd74fb-2d58-6b1c-1ef7-2d6d84a760fc@virtuozzo.com>
Date: Mon, 6 Apr 2020 21:11:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <3f720e97-a499-67f9-f85c-1dba29ec9551@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR04CA0030.eurprd04.prod.outlook.com
 (2603:10a6:208:122::43) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.161) by
 AM0PR04CA0030.eurprd04.prod.outlook.com (2603:10a6:208:122::43) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend
 Transport; Mon, 6 Apr 2020 18:11:38 +0000
X-Tagtoolbar-Keys: D20200406211137311
X-Originating-IP: [185.215.60.161]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f39a2a9d-4f80-40c8-60fa-08d7da55f376
X-MS-TrafficTypeDiagnostic: AM7PR08MB5527:
X-Microsoft-Antispam-PRVS: <AM7PR08MB55278692BE45B7B5740D84C6C1C20@AM7PR08MB5527.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-Forefront-PRVS: 0365C0E14B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(396003)(346002)(39840400004)(366004)(136003)(376002)(26005)(16526019)(5660300002)(81166006)(956004)(6486002)(2616005)(52116002)(8936002)(8676002)(31696002)(478600001)(81156014)(186003)(36756003)(53546011)(4326008)(2906002)(16576012)(316002)(66946007)(66476007)(66556008)(31686004)(54906003)(86362001);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bbqNoRlHMe6RgsG5OeeEM/jvivhyTDbTrNCl684755X5JLBkkTGwNg26JPy/Jcke6x88TjNMNCZRmZ3mz6eJPt7khUIPQMAlPUlfkoVqRm2jX9zEQGwpgxc+cjtiK4j3y2/R0XNsAGQVSzMo4pu2u17ctlR7vG8W9EdL2Yfvl3eAtSJ7UL42UK57N60iBY6b4pV/ZfstQUgxiZNFIvbFFyi+fpiq9ddEGzmtfqCBPZMOLU2ehZOfO2IlgrbAniFwovGHqvV4uh6zSZoHnMYTw6Yxufw8nQ1KB5ylTB3M14Z2DcBWAJUvogvN5iO/bhIufJr98DdiQebRPPwg91/SY6hXqc3f4bKkq2zHBmKuRJuRmhfSA5oLluovd8nnnaaXdms8pH+QRJSLEAYUtvGTG610tNFk2FI6ZRjOOoOfxiyfrILzFJplx5Wbzoy7yomCoOWCLHL9jHctvERuZL6w5B8Xsb1Xy1t+Vtgyuj8aSp7miTYf9DdARV8A0zYU+j0/bP10tfEI68jlBSmmEFTg6Q==
X-MS-Exchange-AntiSpam-MessageData: Y5iPxarcGmWKc1FiptV81P66XBss1GhHDvjCS+jngzh5TFj656ESQS81r1vwnTw9jhWhVKqdD+SfqdSrpEWuF/ZlenyMyVg037wA9W/kAn4EAnfwgyz3qp7DePDcMiHtcr58RZMOL9liEEsMieTPPA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f39a2a9d-4f80-40c8-60fa-08d7da55f376
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2020 18:11:39.3327 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JYMTX2ghJT0odPMA6B6PRub5PzCEOGZPWLVTWnZWhbLHAzwEp/5L16DB8BCUIIK9Zrx7DU6fiVqwK5ZiM2LZU6PojG1+S1D0Qd6v2NFlUNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5527
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.13.138
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
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:qcow2" <qemu-block@nongnu.org>,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

06.04.2020 16:32, Eric Blake wrote:
> On 4/6/20 3:50 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 03.04.2020 21:19, Eric Blake wrote:
>>> Although we already covered the need for padding bytes with our
>>> changes in commit 3ae3fcfa, commit 66fcbca5 just added one byte and
>>> relied on the rest of the text for implicitly covering 7 padding
>>> bytes.=C2=A0 For consistency with other parts of the header (such as th=
e
>>> header extension format listing padding from n - m, or the snapshot
>>> table entry mentioning variable padding), we might as well call out
>>> the remaining 7 bytes as padding until such time (as any) as they gain
>>> another meaning.
>>>
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>> ---
>>>
>>> v2: Call out explicit byte range rather than '105 - m' [Max]
>>>
>>> Safe for 5.0 as it is just a doc fix, but only if we actually want it.
>>>
>>> =C2=A0 docs/interop/qcow2.txt | 1 +
>>> =C2=A0 1 file changed, 1 insertion(+)
>>>
>>> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
>>> index 640e0eca4000..80728bc2008d 100644
>>> --- a/docs/interop/qcow2.txt
>>> +++ b/docs/interop/qcow2.txt
>>> @@ -210,3 +210,4 @@ version 2.
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Available compres=
sion type values:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0: zlib <https://www.zlib.net/>
>>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 105 - 111:=C2=A0 Padding, l=
eave as zero.
>>>
>>
>> Looking on this in separate, I'd make a software which will zero this pa=
dding unconditionally. However, if it's an existing image which we just ope=
n, we should keep the content we read.. On the other hand, of course, if re=
ad the whole spec, everything is clear.
>=20
> Maybe:
>  =C2=A0 105 - 111: Padding, contents defined below

Works for me, no objections)

>=20
> rather than an explicit mention of setting to 0?
>=20


--=20
Best regards,
Vladimir

