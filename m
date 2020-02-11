Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF467C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 14:49:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88779206DB
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 14:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="JjUksOkw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88779206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1WrC-00065s-KT
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 09:49:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54733)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1j1WqE-0005Us-Ni
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 09:48:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1j1WqD-0005DK-8t
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 09:48:46 -0500
Received: from mail-eopbgr140128.outbound.protection.outlook.com
 ([40.107.14.128]:17238 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1j1WqC-0005By-Gn
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 09:48:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hx7/roA92iCidYSJd/eN4a9AEF6CZpi0RGnOlYIlIQn7/R4yo+HtpU2Q8QwhwERirD+nBgocTGtMgdosmpkMI2jwoqb1dC3pqhecdG+RDO8bOfdYGgwqbQzov8/koMyVxS6Bk22m6NyrOKLIwkGUH/SfRQDejGPjvtOrl9zCBHCmUc7xcbiyEGwIma2rtTNvMzqexu4xW63gDQWqMXHFIaz5qosnwZFtNqNH8EJOBS5NBj3M6xpRhlua27D6mk0u+DMaa4IJxWoqqBUfl9qk5RqKfss3s9vOT/OLb9JiBZATKin+k6HGWltfBwNcbESp/YyLdnjFeEQ1R873Nk/OMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJhowy0bYVhjlJFUirCnJb8gkBcAvI+G4RvctFfIL2Y=;
 b=b/KJnHWc+N57HL+nJhLpEmpCIK+hgcVhqrG4VmJiY2R60M3QworKiqDmj7I27TeAgXuhXO+MDGziA8W29jpaPnefaPfbd2BuUunZVK+TJdObc8ecApyabtWBieckDwWe9itsyXK5huF8HxoYX/4R0zvQkt819k0VSDOQcANBsV2NXOBS163SjuZs6VWCFDCtaxu4iTWUVdHtLvFArgukBwTpk4qhPM7NXMMcsxsDqLlu5TQ0IPEgq9lVIaVfTCjAYex1i3WGqBaM8XlXcNdP/jSbOWcV2V3qdXHDU71NQxtpd9efzHzMh/HGJ37sxmvNklvedxYUqwj1gkVRya+rVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJhowy0bYVhjlJFUirCnJb8gkBcAvI+G4RvctFfIL2Y=;
 b=JjUksOkwSDcrq8QW/rrQr8LtbbF4ciuhjzMLvOtGOujcBMCrA1Y7XUq5I4+lOJ6VUJNUcB+0g0wTACxV9bgVzFztXMeEH8stdYnSc/N1KOTV5GSfmpfMteTm2tv2XOp8s7yRkfpAsVgw4Bfpq9e7bkNfImJuKu6NDQlGWsUn3nY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB4067.eurprd08.prod.outlook.com (20.178.202.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.25; Tue, 11 Feb 2020 14:48:42 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::5558:d9d2:7f7d:e4]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::5558:d9d2:7f7d:e4%2]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 14:48:41 +0000
Subject: Re: [PATCH v1 0/2] Improve virtio_check_params test
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200211142551.13072-1-dplotnikov@virtuozzo.com>
 <1b7ccdc2-2e3e-32d2-c82b-fb1e6cddd998@redhat.com>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <65c2d1b2-f7d8-ec97-d5f2-8757281b2964@virtuozzo.com>
Date: Tue, 11 Feb 2020 17:48:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <1b7ccdc2-2e3e-32d2-c82b-fb1e6cddd998@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: HE1PR0402CA0004.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::14) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
Received: from [192.168.1.63] (178.34.162.57) by
 HE1PR0402CA0004.eurprd04.prod.outlook.com (2603:10a6:3:d0::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21 via Frontend Transport; Tue, 11 Feb 2020 14:48:41 +0000
X-Originating-IP: [178.34.162.57]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a50f0b47-5e7a-4811-d528-08d7af017c81
X-MS-TrafficTypeDiagnostic: AM0PR08MB4067:
X-Microsoft-Antispam-PRVS: <AM0PR08MB40679AEA27965078C953077BCF180@AM0PR08MB4067.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0310C78181
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(396003)(136003)(366004)(39850400004)(376002)(346002)(199004)(189003)(2906002)(186003)(956004)(16526019)(2616005)(8676002)(8936002)(16576012)(966005)(81156014)(81166006)(316002)(478600001)(31686004)(52116002)(4326008)(6486002)(36756003)(31696002)(5660300002)(86362001)(66476007)(66946007)(66556008)(53546011)(26005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4067;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lg/6VrZtl0LuT1HEt5Z88S/NgFa9Xazekr696DgS+mDO5LMaM+Xsnv5OEAPs89lVWDHLFWlc5XN7a65GKSJGu8M0qFGaroyrjTpXXc6KPmwNzUNWyFGFnS0HcdVwPdR5nVakdag08AjtfVvVrQBKyrzLe5P5bJk5ZWb0W5jk3IDzZxYvHCvPsguIPQa6OshmM5LeNV3/1oH3gke9IsL4z1sx5d2wLdy0Ut3RM9GV/yRtaRgXlXLm58TiEy8IG5haIut8of59mGDB9ET3xS2iLrJCehrx9PWR/u6K1uK17n5DYoc5yBdrqjCZl6s17Y3EzSawDOCliQGI8LBurbJSeHqRV8UGlkS3Ef7uRCxT3NkpcJgARVd0u9KG792YsIHOEd+WQ0/ORnNmHnEbRYCuurxJETcVWiho1AUNV56q7qS8EpMHQ43rmc0u4j4PfjK6YRYk+bK9nWdh8nXAanPMyYWkumcaEfXgHLMzU2mGU+4Rm3PXvAgOL8jmnbiU+Tc/p+nceltk2+lz6yV+z7ZJ6Q==
X-MS-Exchange-AntiSpam-MessageData: 8PxXLuHtAO2mjsUx14+ZmZeFIrNV0TkGIkc4agp6qfNH+/JvarpIBWPXUamvqxyHA+QYDjQ8PCuH/roft6w6kfhK3R5CIwVIMl3YLAUw3XojekuivxUXyTdlN9I6QW+ooW6Gek1TvToFhnudiARhaA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a50f0b47-5e7a-4811-d528-08d7af017c81
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2020 14:48:41.6984 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V+TsVH4OGb0RMmBoX3yYRcGjjuqkjJhe4/1G3+A7e9MJKJfQzQ1LtuvM6tDEcyNhs09xd0m4d3jJhCmByqghcgMvQdwxUK85AMl4/szQsAA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4067
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.14.128
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
Cc: cohuck@redhat.com, wainersm@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 11.02.2020 17:37, Philippe Mathieu-Daud=E9 wrote:
> Hi Denis,
>
> On 2/11/20 3:25 PM, Denis Plotnikov wrote:
>> * fixed failing on non-existed machine type removal
>> * the test refactored to add more parameters to check
>>
>> Gereral questions left:
>> =A0=A0=A0 How to restric test for using:
>> =A0=A0=A0 1. on a set of target OS-es
>> =A0=A0=A0 2. on a set target architectures
>>
>> Denis Plotnikov (2):
>> =A0=A0 tests/acceptance/virtio_check_params: remove excluded machine typ=
es
>> =A0=A0=A0=A0 carefully
>> =A0=A0 tests/acceptance/virtio_check_params: prepare to check different
>> =A0=A0=A0=A0 params
>>
>> =A0 tests/acceptance/virtio_check_params.py | 52 ++++++++++++++++-------=
--
>> =A0 1 file changed, 33 insertions(+), 19 deletions(-)
>>
>
> Have you noticed my other series suggested by Cornelia?
>
> It runs your test on S390X and PPC:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg675092.html
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg675095.html
>
> Hi, Philippe
Seems that I've missed them. I just made patches upon the fresh master.
Can I get a git tree which has those patches applied? Or should I wait=20
while the patches landed to qemu master and the rebase on them?

Denis

