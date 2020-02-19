Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3C4C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 13:52:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB0CD2176D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 13:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Ds/CBsiR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB0CD2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4PmZ-0006Ph-Vn
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 08:52:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43133)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j4Ply-0005pf-Df
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 08:52:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j4Plx-00033v-Ae
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 08:52:18 -0500
Received: from mail-eopbgr10095.outbound.protection.outlook.com
 ([40.107.1.95]:49246 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1j4Plq-0002yo-C6; Wed, 19 Feb 2020 08:52:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHerUb9MQFwkXPdYaIef/3FezhUgWBXIrGUidTRojhtU/0Zx7kdUz3K8qHNbqBX9CDz66jWI+uTSYost0C+zChsrNZr8GpWH/tSOKYSPZ9oR3DxArdvmx7J1M6mUZF7vMxMvhq03ZjEJ2GCyZsNrtLwsIiZiDegY9j7BY85usq4Wvq3Z0Ep4sV5SVhaSgnQ2h6v+7IQSXQBoiNsVrzW0pXDiC5kfLlr80tvKW63YWkCRpZ6h1YxHJa12oO0UtLj3eqXUqzOExY40vllCCsky0CaQwL6dDS1oR6FiUKxy14bEHr/wgBkGHArbkUU1iQ2+QrmFL4UrLIbX/FN6xISr4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCwptWMkl/jo3opn4nGmSROMWfMpvoEcwltmKwtkrSs=;
 b=d3POLttbLrYP7uKxyOqFfAqKjpQ8JSZNq3NXcSk2DW08ZJ4FbT/zHF1Ssbwdkh6h5kzYDTA2yUSFecMgOnOQnNk8mGqOXT6sYtIC4acVqW/8OZR1IJzZ36I9eiKc7s6JOSj/e6wuriHQGlZ0f4qa9gpFn7wlNIMVhgqOVOD1V+Nky5PSlL6JKLe3OQZbRLCAcLxDoAdy/A1CFR9sulESpJHTymJnlyZezDESPih1pcn2N5GIi/uv8sZbpQcpPnOoKMy5y/OslmRlGyP3O1pskOupjUSdVHlxgbr9HIXzVIb0rKz025wyRoXymqD6efkhw0hLYusbhQasYV19f2VsWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCwptWMkl/jo3opn4nGmSROMWfMpvoEcwltmKwtkrSs=;
 b=Ds/CBsiR8JmDREvg8Fm+P0bpe49cP+maQZqqN9+1SIPmGvwaOZA9iaUTrq2pZJoQH+I3MrZAPtRex6UFgVlOcuw3JC1NbpCLI+A8qM6U9ut3Ib1PumHITn1I+b7vCJlg/PnYahaWsZIgmctmpk95+qYXI+2h4k9yRaLgC146oV4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com (10.255.123.95) by
 AM6PR08MB3767.eurprd08.prod.outlook.com (20.178.88.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Wed, 19 Feb 2020 13:52:05 +0000
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d]) by AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d%5]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 13:52:05 +0000
Subject: Re: [PATCH v2 00/22] Fix error handling during bitmap postcopy
To: Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
 <33fa0ba7-714f-c78d-8ca5-1e15dcef5ac4@virtuozzo.com>
 <f44bfdb9-0ddc-3b1a-0279-7e9ebd9f399f@redhat.com>
 <b0e67ac9-987b-811e-f0ac-7a9c92a2771a@virtuozzo.com>
 <633ea62c-dad6-9cd6-1490-7a827f036417@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Organization: Virtuozzo
Message-ID: <ac78111c-853c-50c1-0cc9-cdab2d9a3432@virtuozzo.com>
Date: Wed, 19 Feb 2020 16:52:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <633ea62c-dad6-9cd6-1490-7a827f036417@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR05CA0187.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::11) To AM6PR08MB5048.eurprd08.prod.outlook.com
 (2603:10a6:20b:ee::31)
MIME-Version: 1.0
Received: from [172.16.24.225] (185.231.240.5) by
 HE1PR05CA0187.eurprd05.prod.outlook.com (2603:10a6:3:f9::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17 via Frontend Transport; Wed, 19 Feb 2020 13:52:04 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8e2a3c9-456b-40ed-a1ea-08d7b542e742
X-MS-TrafficTypeDiagnostic: AM6PR08MB3767:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB37671A2F2D1126E3054B957CF4100@AM6PR08MB3767.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(39850400004)(346002)(136003)(376002)(189003)(199004)(2616005)(956004)(54906003)(66556008)(53546011)(81166006)(478600001)(66476007)(8676002)(16576012)(31696002)(110136005)(44832011)(316002)(81156014)(31686004)(36916002)(52116002)(8936002)(4326008)(86362001)(66946007)(26005)(5660300002)(7416002)(16526019)(186003)(6486002)(36756003)(2906002)(966005)(2004002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3767;
 H:AM6PR08MB5048.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b/rTKyKCC77ZEz8VyS7xVd2axdWVzvFORO4x9BsWtQaSTW6EowwipQhSHxSKi5dWo5hD+Cx4D+IzYyhXx4pJilA9ksz6WkhVWrK60NwOur3LqRY98VKb+8sgdi8UgrjKXtXhvqQi+B983yIvjHkrQReiJVrXhPfIC2rkAmCAMtDjrV78h8pBXQlKGzHu2LTwp4b4Tpaog0UzmXnJNsRr0sLhzk0cq23qih74h8nQxEal9w47qcIGXMsQh+laxybDS3suLd7zMfV5JvEoYKrqPeA4gg2w0DqhFVUxdSLXClLwPEhAS/N81vka6RMTNmitiJD08WpTDjHl8tascRXmV6pasV7fAwiUNBm6LCfnnfM1LJmR4HlImty7+CblcYqrEUGvHQOdlZ3Y8XqUleSKKXeX8G3ByWhAn5SAINohzHaRgaNUinvCIoNaYODMX/hJBhgLeYYM5zedKl6Q2a1TSSM7BPDCpPQA5605Upkg0glN8on8vBrH0ztkiE19wQAMKlQXc4UnIoChay5WNg+2vMsdzz6KzYefmxG1Zh2LwzSDRtXHnDO32CrrTWVctePi
X-MS-Exchange-AntiSpam-MessageData: 9SbfFAQlgr6Vst7g/WMgDaBWWLYw2AOdJfO/2AD9awidsuE/dYCukXuDVGcKFORQ6h2E2GlgHyCG+VH5vpLpS7Wqz1YFgPyfSMC1wSzz9/RKMl4lMMkioh6+3xeD5ll7/Z4hmhZPk7rJX24nYVDQXA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e2a3c9-456b-40ed-a1ea-08d7b542e742
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 13:52:04.9796 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cy0dykbHUSLlXaAmo8aNaXEfarAkdKD75nVlg4suuZxu0VSOZWG74nHMX8WoVIqE4A1N40vSZW5lucdvr6w54XFi7D2XweKgjtR5R1g30c8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3767
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.95
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 quintela@redhat.com, qemu-stable@nongnu.org, dgilbert@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 19/02/2020 16:36, Eric Blake wrote:
> On 2/19/20 7:25 AM, Andrey Shinkevich wrote:
>>
>>
>> On 18/02/2020 23:57, Eric Blake wrote:
>>> On 2/18/20 2:02 PM, Andrey Shinkevich wrote:
>>>> qemu-iotests:$ ./check -qcow2
>>>> PASSED
>>>> (except always failed 261 and 272)
>>>
>>> Have you reported those failures on the threads that introduced those=20
>>> tests?
>>>
>>
>> Not yet unfortunately. I have not investigated the case.
>> "$ ./check -qcow2 261" dumps
>>
>> +od: unrecognized option '--endian=3Dbig'
>> +Try 'od --help' for more information.
>> +od: invalid -N argument '--endian=3Dbig'
>> +qemu-img: Could not open 'TEST_DIR/t.IMGFMT': IMGFMT header exceeds=20
>> cluster size
>=20
> Which version of od are you using?=C2=A0 I do recall wondering whether=20

$ od --version
od (GNU coreutils) 8.22
Copyright (C) 2013 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later...

> reliance on the GNU coreutils extension --endian=3Dbig was going to cause=
=20
> problems later - well, here we are, it's later :)
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg06781.html
>=20
>>
>> and "$ ./check -qcow2 272" dumps
>>
>> +od: unrecognized option '--endian=3Dbig'
>> +Try 'od --help' for more information.
>> +od: invalid -N argument '--endian=3Dbig'
>=20
> Yay, same problem for both tests.=C2=A0 Fix common.rc once, and both test=
s=20
> should start working for you.

Thank you Eric! I want to sort it out later...

>=20
>> +qemu-io: can't open device=20
>> .../qemu/tests/qemu-iotests/scratch/t.qcow2: Image is not in qcow2 forma=
t
>>
>=20

--=20
With the best regards,
Andrey Shinkevich


