Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0A0C35250
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 10:29:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AA5420726
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 10:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vpGX8vh/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AA5420726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0NN6-0004Xs-HJ
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 05:29:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42513)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j0NM9-0003RM-6V
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 05:28:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j0NM7-0005jQ-Gl
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 05:28:56 -0500
Received: from mail-vi1eur05on2094.outbound.protection.outlook.com
 ([40.107.21.94]:57312 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j0NM5-0005c2-9o; Sat, 08 Feb 2020 05:28:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPve75VqPhYaCehf0iIefF34RvDnD/XPO3+It9ANdOxyibHTHJbFSWbqIdja3s85Jxv9PNARen3eaeVA8PL7mWgghXRBs+7atScKDTToiTmjkHtQdmUXgmsfSWRfyMUBYcNvmPEdD87311iPtFMz5vVEo1vf+jAG67Rr/8GNyk4OUC7dnGcrLHZZtl/7RjBFZR05zFzgbjI+XNP5q/8eZx6Rn64nhIvt8hFxslulIR3mNZ5SeyRqbC+N6dOm5IAVCKgbX9nQfE1HW7ant+GtPn10J/cF5HjcxmGjyg1WC4neWxWltrbia8nnRorBf1epq31EgA/n+5apsamOd/f+2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1HmklBLI2+2YpHXw49VVl/8SovNAaGQQb/pUe9dA2w=;
 b=kEzXyTiirqWFNTR+k/F+8hRYiuecVW/ikF564WBCPK28C2S/Rd0IcXNPUFKvUTG3yoALInWLLdU4UTc7EV1MTB6Z5DLq6DmHTWC0uoolbbXDFagRXMjBoJmxVAiSCrSVyDJU5TReplRoS8dleJ8fDnTsIuVfDgfWjqCBps9/LqS8qZAvEjdhY3VxwGQ0nhUvh6dst1vc8/blgg6gasYkb6nv/4kmwS9ee9z2ao5s8AlKMqCzQJk+nNnIoMtQTq8DQUlKQX4RobQXJJdMB/dvxzQYV9vMb47cx0NlbXBzxmYMGLYNdhRDRxSco8+U4Tk87fZsd1aHprtatGCrJfrvqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1HmklBLI2+2YpHXw49VVl/8SovNAaGQQb/pUe9dA2w=;
 b=vpGX8vh/0Zb1jmbUwtdjzL1Hnj2lN7TsXNVxq/9tqvd3VXGGR9nhexIfwliEnOhdqKR349eg2ApEyH3TujtMquqFkbK/OBXlFEQa+hIHrBJpZDdXzED7oMjE7IU4GRgfLfZIteIdoLvZDOfQx4YLUDF1lvSzwVY8rIOirQMvlWw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4884.eurprd08.prod.outlook.com (10.255.99.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Sat, 8 Feb 2020 10:28:50 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2707.024; Sat, 8 Feb 2020
 10:28:50 +0000
Subject: Re: [PATCH v2 for-5.0 0/7] block-copy improvements: part I
To: Max Reitz <mreitz@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20191127180840.11937-1-vsementsov@virtuozzo.com>
 <bbfcf774-e763-f7ed-2501-e5fba150cd5e@virtuozzo.com>
 <bee43863-28e9-09c8-8058-2d667f114338@virtuozzo.com>
 <a5d0bd06-1193-c646-dbb9-b2b701661c5b@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200208132847575
Message-ID: <45ea9de2-5e1d-6a33-c803-338bbed1824f@virtuozzo.com>
Date: Sat, 8 Feb 2020 13:28:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <a5d0bd06-1193-c646-dbb9-b2b701661c5b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1P195CA0016.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::26)
 To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1P195CA0016.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21 via Frontend Transport; Sat, 8 Feb 2020 10:28:49 +0000
X-Tagtoolbar-Keys: D20200208132847575
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40e95fbb-0100-413e-8661-08d7ac81afda
X-MS-TrafficTypeDiagnostic: AM6PR08MB4884:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4884CEEDF039C1D6B3BF78DDC11F0@AM6PR08MB4884.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 03077579FF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(136003)(366004)(396003)(39830400003)(376002)(346002)(199004)(189003)(31696002)(52116002)(16576012)(36756003)(26005)(110136005)(186003)(54906003)(2616005)(16526019)(956004)(53546011)(6486002)(316002)(8676002)(81166006)(66476007)(86362001)(81156014)(4326008)(66946007)(4744005)(66556008)(8936002)(2906002)(5660300002)(107886003)(478600001)(31686004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4884;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PHtvlqulZbUAK6w5QDsTqcjtX4xGR8wHb4Del2+w0BmvE1/yv5d6T7hi7nqlbEPduTl9fHAbROXK0rKYAuSG0kcR9V5nfjGByu2XhBy7y4xKObYJ48iqKs1EBgmcopk5vpxuw3/DmbKkfn9aShVN55F/y+iG2ZeAtjERZsLpRd7aRkP+HuJteGsPXtaRmkJdiH1AyjBcZT60v+uxEpbjDfNH6ZsbYrucI1l8oilUc6tbeG0tTAViqc1nH0qTuEGn9okMKVjBgiuelGe9wBD/KUKxBVg2fZsQTouvtfKJvsHzhL1k5BfO5kUcA+qwd7r4nFldmTSsHwy4VuviDqc4TVMtfLmG7xwZeTRuslxT6Igi1oDiIFknZksnHG4E0I3yhJdxqeaRKVXsABOBhmUrD5qP2ewyHNZGfVUlNCN2tewUurXQTXYYucf+KNxuAIzg
X-MS-Exchange-AntiSpam-MessageData: V0m0vunhaOnyKwpie6ZT6Lxzj4Hhm0wpYKDZycytaDbwOMcz/u68PM+wjQVdpDuv8yeSyCj9S3AeD2S6UUkFbfUrnEsoZRfNWia58PmoJSqmMFABFF5pUrOiFlN9miWXwJaiWeg6Cnp77O4PauPbvA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e95fbb-0100-413e-8661-08d7ac81afda
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2020 10:28:49.9396 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tX8YhF7tLEZYAGsasU41lsTVLIaoAPIf/9ug1H36ZsYWulUJ9BkRZFfcYAeWl6/61gmW1qlopHm4aivS94z4FqjZRAmlfgPl6Jiqgt96eFs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4884
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.21.94
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

07.02.2020 21:05, Max Reitz wrote:
> On 20.01.20 10:09, Vladimir Sementsov-Ogievskiy wrote:
>> ping
>=20
> Sorry, I only got to patch 5 so far (without major complaints). I=E2=80=
=99ll
> have to pack things up for the weekend now and I=E2=80=99ll be on PTO nex=
t week,
> so I won=E2=80=99t get to review the final two patches before Feb 17, I=
=E2=80=99m afraid...
>=20

Thanks for the start and have a nice rest!


--=20
Best regards,
Vladimir

