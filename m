Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66783C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 13:27:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32A522078A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 13:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="q8qNRapI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32A522078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH64L-0006OU-BU
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 09:27:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54894)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jH63g-0005r0-6T
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 09:27:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jH63e-0000XK-A8
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 09:26:59 -0400
Received: from mail-eopbgr70115.outbound.protection.outlook.com
 ([40.107.7.115]:63970 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jH63d-0000Uf-GJ; Wed, 25 Mar 2020 09:26:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5QhhftVnEpCiCMzgloo7tgvE11Kqm5pDG/LkMgLZrTpgccse8isvZ/IeZGY5mIaCHM0W4SOFfFWPfp/SBLoLD2WtEnvBaffCCAGgd7hio51BosheOe8hMbLrgcqAggpxBbzzBtA+gS7B0JTWwkW1X54wvGNQeGpaDSoR7yX1aWnn9wAAfSUOcK73ZYf+sxlNh31ZCIB9Vud9xTRRErv0CQHvU9bCvnHRoZm8ekrvBGvxNr9YEnpDk4nUtj9L532gLbS4AIUWVuUJ8YwKcM57Am843e6Mw9aE5MjLMm+Y91OVAxRi/9q+e0Jw5swWhVh52cfZc7avR7DJqS/WOg1QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dL7YYoZwHPMwEdJf6P/PWRFRmYmkkezgn3rnZ+Tra9E=;
 b=aVXJykyRirz0BTXrWXsllHDhQq/6yq2lXaFjTL92VFLdAj2/VYhmFzUUM/LEMHZ1TALD8hY+tLAHAXO6eIfARMcjEnGhAIoexYK82TlZgChJ39NABwSii5RCcTxJc8mh3XX8DOuvPcM+nswvSit8B5IwXKILqC4K0Up7HZCuHWqgphZLglNtvdfPyj/YS1ItRIu6vGPnULpmR85HBTPdVrZv5qcldqxnEdep+gz4dOBt1DEwRWNmEP2PtLPSgVIAkux+XIV5X3pZlFSz6DfNTRNGXftvHIUacunPnK3pU9u1d//C21P/IsNe6ojh5WVHXDroAQfFVJDiX854nkhJ/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dL7YYoZwHPMwEdJf6P/PWRFRmYmkkezgn3rnZ+Tra9E=;
 b=q8qNRapIXsgd28fxuRlCg8suQ5wyye3EUXCQJNvg5taomw4jQboYUH8JGIpQeW3giAoiws4c7HYddrhhrMvsWoxYzOB6k4uUkOnALZxtdXxlsTeVha/y0skC97lXcMl0L+BaVRpYthxJyiYKpZsFvfT+FiUs/ABsYE3R8Nu35Ug=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5413.eurprd08.prod.outlook.com (10.141.173.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20; Wed, 25 Mar 2020 13:26:54 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533%6]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 13:26:54 +0000
Subject: Re: [PATCH v2 0/2] Rework iotests finding
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200325102131.23270-1-vsementsov@virtuozzo.com>
 <11877a2e-2815-19d9-603f-b7ea52cc3d6f@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200325162652310
Message-ID: <934ef272-0141-245c-ef61-528a7d44e3b5@virtuozzo.com>
Date: Wed, 25 Mar 2020 16:26:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <11877a2e-2815-19d9-603f-b7ea52cc3d6f@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: ZR0P278CA0050.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::19) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.35) by
 ZR0P278CA0050.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1d::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.19 via Frontend Transport; Wed, 25 Mar 2020 13:26:53 +0000
X-Tagtoolbar-Keys: D20200325162652310
X-Originating-IP: [185.215.60.35]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83a49a8b-920b-4990-3e88-08d7d0c02f30
X-MS-TrafficTypeDiagnostic: AM7PR08MB5413:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5413EE35824CD85A952CE562C1CE0@AM7PR08MB5413.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0353563E2B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(31686004)(8676002)(66556008)(86362001)(31696002)(66476007)(66946007)(36756003)(956004)(52116002)(26005)(2616005)(186003)(16526019)(498600001)(5660300002)(53546011)(81156014)(2906002)(6486002)(16576012)(81166006)(4326008)(8936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM7PR08MB5413;
 H:AM7PR08MB5494.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dnAoLq0IlIaKGaLNyHWCO+b7eJnJ+ViZMRYp0bpSCBRw+tTOoP8lUnkEMEAgNSvlBO/zIw/fRAayvr88lI18tvU9PytReDDOUwvWLd4ayB11/Lgxh/tqzTTcfFbnT7v1TC+j/sJeVihbNOhVZKKppO4TtDOeK04pvuqjiu4QrYvF1TNZrb8qQtxmz8+PfEVpDxWKe2+rNwaM7Le8SM+SFRtKkqfSt8rWbkqEe8Q6Fg4c9aOSBMk5Xlgi1WHXf+2DpXe93decetzC4tDinBeC0iG4iGmpJxU8Gu4aq+RBFAvgWvg8Yy9OGxpe5Y68FDemMHMY40nHzEHD4380StfUOrbJwefXoaYWtv6UbGp4VyQkVl4UnJO1SF0MWHiIk1cnAiond6bT8JAxgmsUa1Uoe/q5DF6Jtw1ZKuJWtKCetfBiwy5WU27SOGp6hsWpBex0
X-MS-Exchange-AntiSpam-MessageData: ouoejKCycBVfd12OVCsciwuV9HlnFubCZR8pbElL3dIeJ8BcRpVQSLRqKZHZxLiHwxo8aBqH197C8TzIi4sDNcLlMLN9RqrKjcMKqcj8mxnRAOD7XzRBoCUwn2kW9/GkDwjkAtPeLI3nAsbvPogU+A==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a49a8b-920b-4990-3e88-08d7d0c02f30
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 13:26:54.1298 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZTQaL+Iv08/ZcazO8p9YhsPUvqpfha63qRsw3ZGipw3MtOANfaOPCZ6pB5hfkgMJnHcc/Au+P8u0GqUhaKcYwB1fIhcUTIoOkgmXDrClJyw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5413
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.115
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
Cc: kwolf@redhat.com, den@openvz.org, jsnow@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

25.03.2020 16:08, Eric Blake wrote:
> On 3/25/20 5:21 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Hi all!
>>
>> When sending iotests to upstream or do patch porting from one branch
>> to another we very often have to resolve conflicts in group file, as
>> many absolutely independent features are intersecting by this file.
>> These conflicts are simple, but imagine how much time we all have
>> already spent on resolving them? Let's finally get rid of group file.
>>
>> Next, another thing I don't like about iotests is race for test number
>> chosing: you should search through mail box, before chosing test number
>> for new test.
>>
>> So, I propose to get rid of group file and search for tests another way
>> [look at patch 02]. Additionally I propose to move to human-readable
>> names for test files, with notation test-* .
>=20
> I suggest swapping the name: It's easier to write a glob for *-test vs. *=
-test.out than it is to write for test-* but not test-*.out.=A0 (You don't =
want to execute the output files as a test).=A0 That is, I suggest that ./c=
heck consider all 3-digit files and all files ending in -test as tests.

I like the idea. It also helps typing test name in terminal: stre<TAB> -> s=
tream-test instead of te<TAB>stre<TAB> -> test-stream.

>=20
>>
>> v1 was one patch "[PATCH] iotests: drop group file"
>>
>> Vladimir Sementsov-Ogievskiy (2):
>> =A0=A0 iotests: define group in each iotests
>> =A0=A0 iotests: rework test finding
>=20
> Do you plan on an additional patch (or set of patches) to rename some or =
all of the existing 3-digit tests?

I think, I'll rename tests that I've written.

>=20
> Overall, having sensibly named tests makes sense to me.
>=20
> If we are going to rename files, I'd also suggest that we rename the dire=
ctory: tests/qemu-iotests/ feels redundant, compared to tests/iotests.
>=20

Agree.


--=20
Best regards,
Vladimir

