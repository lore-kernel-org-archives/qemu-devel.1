Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8768C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 15:45:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 870762464E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 15:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="noTRjN5h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 870762464E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4RXu-0008QJ-Mw
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 10:45:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33382)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j4RX0-0006qo-Df
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 10:45:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j4RWy-0005eU-TO
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 10:44:58 -0500
Received: from mail-vi1eur05on2133.outbound.protection.outlook.com
 ([40.107.21.133]:3445 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j4RWu-0005b3-Pl; Wed, 19 Feb 2020 10:44:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJxzQlLCySbFPPzyqEwbF7yVyQArZzPOOeVm1JujllXwmbYCu8nyhdJ3FPIO1cQUWEKct5DJ/vv7wUlmBp12NYpqlMySX07hMGUDiD+fEJo4+ZsknkvCLJv3I7/fTQFZBXrPpDbABYZM8pHljHGShh0zXO/m1ILmQryPtk62NfUaiwkPR3BmOLYmo38yG7v0GyzDXvx4bo6jl6+c4SVkJOq135kwXgsse4BkPXgOAg7st5uY14Xa/Y9x6I6NbUDXAenZCkLLVKoSSfEnmKXdy0k/Sr/FkxkA06a9Yu0dQ2a/JZA+k27ZIVqIqaAUoIsoBpvpu6K257OJEAp5WIk2AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlpS9djL1PUruyUe0GQVRP2ucPb+bVKDSBpI4Kx0QiE=;
 b=Mj1erSz0Rfd7NjVWNPrdNFn67Yj98uMrTFsS1fboKWblgkDkIa+OcwK3zP3eLdPqVLdcGdGuCreQ170rsPUgD/Vn0imZ6l5tjJJxE/RR/7ywcvrU8BLMyWova30U3HrQXo0zlWLof2ShHv3sP5mmyEHcphpwHBhncFVD4qXQfQs7p29/ZwDVk6lkFLKVe1xTrDE7WKogTNAHKc6j0vpIn9ITGwvRxF2vNgoN2UEyOpueprOHJA2Nx5jM07WWAoTxHRPuwMBWke9HTKHHU0Rx0E164rD06vX5W1RUUH1vatPqzkuL2T5dPj/wk370KPMNHn/KO9kKyVip+S5ToDKTSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlpS9djL1PUruyUe0GQVRP2ucPb+bVKDSBpI4Kx0QiE=;
 b=noTRjN5hWLXqhKaOiogM6I2q/R5BiwGkuJFDedP2ywGnApiIUpxXY0iMVdySvzbg0g7DLT782WW5NsHV6Rxw6aHjirPFVtFFOker/HSKiAeGi5TXXO/f29qLqdPWoxd/2ulrZXNihHyej20AGGJlRXSMfb6g9LzaJbGOdroCn00=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4022.eurprd08.prod.outlook.com (20.179.3.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Wed, 19 Feb 2020 15:44:50 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2750.016; Wed, 19 Feb 2020
 15:44:50 +0000
Subject: Re: [PATCH v2 14/22] qemu-iotests/199: better catch postcopy time
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
 <20200217150246.29180-15-vsementsov@virtuozzo.com>
 <ef51a28c-c9d8-7dc3-e203-883f9f48fbad@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200219184448190
Message-ID: <5f9a3372-aa85-9d86-7d06-f831c0a9c320@virtuozzo.com>
Date: Wed, 19 Feb 2020 18:44:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <ef51a28c-c9d8-7dc3-e203-883f9f48fbad@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR0102CA0066.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::43) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0102CA0066.eurprd01.prod.exchangelabs.com (2603:10a6:7:7d::43) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.24 via Frontend
 Transport; Wed, 19 Feb 2020 15:44:49 +0000
X-Tagtoolbar-Keys: D20200219184448190
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0e06ae0-f695-441e-8b54-08d7b552a7ad
X-MS-TrafficTypeDiagnostic: AM6PR08MB4022:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4022506DB236564FA27D2759C1100@AM6PR08MB4022.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:299;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(376002)(136003)(366004)(39850400004)(346002)(396003)(189003)(199004)(16526019)(186003)(66946007)(66476007)(54906003)(316002)(26005)(66556008)(5660300002)(16576012)(2906002)(478600001)(6486002)(53546011)(4326008)(8676002)(956004)(81156014)(2616005)(81166006)(86362001)(31696002)(31686004)(8936002)(52116002)(36756003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4022;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RyUObEkmttA5RD36x/39pxcxdMAnTFuAotsQSzMJ3A2VCiXLwgf10N1e0ZFxGor5YH39Igm440Qa80/2JLEpPLu4b2FXj4EHkimb6KRyzReriQ0cE2g//Xh0yo2rrsjZUqdCf/sSWKx5mP36Zqk/A/LV7CtDx3FSfezJkgfO2WZ3ZHdgL92p8BwTe8kaRK0m+uW4mtsclYA2HqgijloSEHdKsN0Gb00isx1K8bxBi43w592T0arzqgVN2nBIpomOjGwlJMP1Gf4uw0y58Tu7flsIp4PBtsp5ivlNopwZysK1vfbDDCb6uCHqFNMxrGO6+8Koce2viQOhVgcJb5+9sH8GJWmeCOQl452PxnH6jovtt6Z45OuVYbJAYa4OxUraGFzMi/heXqFZBLVjrbkUrUHfr3zLJVGaML2Yy2wriPq7BcPwLyYcexxpinF8X+nZ
X-MS-Exchange-AntiSpam-MessageData: DeLyiGPfYGg2Zr6VvrcD6Di+ssD0AtgwB0RPcY7WLfPz6reZYuQ1tkCZphFq9meg4c6aj0zsznp7xRn/Pt5+kouQbCYDPB5225bBFBd2U5teFudONt6CT1ptJn+jfOYlfN47SQ2c0z1haCRIPiQZ1Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e06ae0-f695-441e-8b54-08d7b552a7ad
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 15:44:50.2488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OL2j98jgZ5jiz2QQMin2si/g5zruiEQhaFHwk6PrZuSKbeukJPoNJPnzmiEOBkloFcXI6z9AVG+cTQw9FPe4SkIpVMQlP6lNLoIpNCSlneE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4022
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.21.133
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 dgilbert@redhat.com, qemu-block@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

19.02.2020 16:16, Andrey Shinkevich wrote:
> On 17/02/2020 18:02, Vladimir Sementsov-Ogievskiy wrote:
>> The test aims to test _postcopy_ migration, and wants to do some write
>> operations during postcopy time.
>>
>> Test considers migrate status=3Dcomplete event on source as start of
>> postcopy. This is completely wrong, completion is completion of the
>> whole migration process. Let's instead consider destination start as
>> start of postcopy, and use RESUME event for it.
>>
>> Next, as migration finish, let's use migration status=3Dcomplete event o=
n
>> target, as such method is closer to what libvirt or another user will
>> do, than tracking number of dirty-bitmaps.
>>
>> Finally, add a possibility to dump events for debug. And if
>> set debug to True, we see, that actual postcopy period is very small
>> relatively to the whole test duration time (~0.2 seconds to >40 seconds
>> for me). This means, that test is very inefficient in what it supposed
>> to do. Let's improve it in following commits.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> =C2=A0 tests/qemu-iotests/199 | 72 +++++++++++++++++++++++++++++++++----=
-----
>> =C2=A0 1 file changed, 57 insertions(+), 15 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/199 b/tests/qemu-iotests/199
>> index dda918450a..6599fc6fb4 100755
>> --- a/tests/qemu-iotests/199
>> +++ b/tests/qemu-iotests/199
>> @@ -20,17 +20,43 @@
>> =C2=A0 import os
>> =C2=A0 import iotests
>> -import time
>> =C2=A0 from iotests import qemu_img
>> +debug =3D False
>> +
>> =C2=A0 disk_a =3D os.path.join(iotests.test_dir, 'disk_a')
>> =C2=A0 disk_b =3D os.path.join(iotests.test_dir, 'disk_b')
>> =C2=A0 size =3D '256G'
>> =C2=A0 fifo =3D os.path.join(iotests.test_dir, 'mig_fifo')
>> +def event_seconds(event):
>> +=C2=A0=C2=A0=C2=A0 return event['timestamp']['seconds'] + \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 event['timestamp']['microsec=
onds'] / 1000000.0
>> +
>> +
>> +def event_dist(e1, e2):
>> +=C2=A0=C2=A0=C2=A0 return event_seconds(e2) - event_seconds(e1)
>> +
>> +
>> =C2=A0 class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 def tearDown(self):
> It's common to put the definition of setUp() ahead
>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if debug:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self=
.vm_a_events +=3D self.vm_a.get_qmp_events()
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self=
.vm_b_events +=3D self.vm_b.get_qmp_events()
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for =
e in self.vm_a_events:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 e['vm'] =3D 'SRC'
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for =
e in self.vm_b_events:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 e['vm'] =3D 'DST'
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 even=
ts =3D (self.vm_a_events + self.vm_b_events)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 even=
ts =3D [(e['timestamp']['seconds'],
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e['timestam=
p']['microseconds'],
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e['vm'],
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e['event'],
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e.get('data=
', '')) for e in events]
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for =
e in sorted(events):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 print('{}.{:06} {} {} {}'.format(*e))
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm_a.shutdow=
n()
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm_b.shutdow=
n()
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 os.remove(disk_a)
>> @@ -47,6 +73,10 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTes=
tCase):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm_a.launch(=
)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm_b.launch(=
)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # collect received events fo=
r debug
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm_a_events =3D []
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm_b_events =3D []
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 def test_postcopy(self):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 write_size =3D 0x=
40000000
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 granularity =3D 5=
12
>> @@ -77,15 +107,13 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPT=
estCase):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 self.vm_a.hmp_qemu_io('drive0', 'write %d %d' % (s, chunk))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 s +=3D 0x10000
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitmaps_cap =3D {'capability=
': 'dirty-bitmaps', 'state': True}
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 events_cap =3D {'capability'=
: 'events', 'state': True}
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 caps =3D [{'capability': 'di=
rty-bitmaps', 'state': True},
> The name "capabilities" would be an appropriate identifier.
>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 {'capability': 'events', 'state': True}]
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result =3D self.vm_a.qmp('mi=
grate-set-capabilities',
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 capabilities=3D[bitmaps_cap, events_ca=
p])
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result =3D self.vm_a.qmp('mi=
grate-set-capabilities', capabilities=3Dcaps)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assert_qmp(r=
esult, 'return', {})
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result =3D self.vm_b.qmp('mi=
grate-set-capabilities',
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 capabilities=3D[bitmaps_cap])
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result =3D self.vm_b.qmp('mi=
grate-set-capabilities', capabilities=3Dcaps)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assert_qmp(r=
esult, 'return', {})
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result =3D self.v=
m_a.qmp('migrate', uri=3D'exec:cat>' + fifo)
>> @@ -94,24 +122,38 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPT=
estCase):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result =3D self.v=
m_a.qmp('migrate-start-postcopy')
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assert_qmp(r=
esult, 'return', {})
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while True:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 even=
t =3D self.vm_a.event_wait('MIGRATION')
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if e=
vent['data']['status'] =3D=3D 'completed':
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 break
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e_resume =3D self.vm_b.event=
_wait('RESUME')
> "event_resume" gives a faster understanding
>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm_b_events.append(e_re=
sume)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s =3D 0x8000
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while s < write_s=
ize:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 self.vm_b.hmp_qemu_io('drive0', 'write %d %d' % (s, chunk))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 s +=3D 0x10000
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 match =3D {'data': {'status'=
: 'completed'}}
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e_complete =3D self.vm_b.eve=
nt_wait('MIGRATION', match=3Dmatch)
> "event_complete" also
>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm_b_events.append(e_co=
mplete)
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # take queued event, should =
already been happened
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e_stop =3D self.vm_a.event_w=
ait('STOP')
> "event_stop"
>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm_a_events.append(e_st=
op)
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 downtime =3D event_dist(e_st=
op, e_resume)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 postcopy_time =3D event_dist=
(e_resume, e_complete)
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # TODO: assert downtime * 10=
 < postcopy_time
>=20
> I got the results below in debug mode:

That's why it's a TODO

>=20
> downtime: 6.194924831390381
> postcopy_time: 0.1592559814453125
> 1582102669.764919 SRC MIGRATION {'status': 'setup'}
> 1582102669.766179 SRC MIGRATION_PASS {'pass': 1}
> 1582102669.766234 SRC MIGRATION {'status': 'active'}
> 1582102669.768058 DST MIGRATION {'status': 'active'}
> 1582102669.801422 SRC MIGRATION {'status': 'postcopy-active'}
> 1582102669.801510 SRC STOP
> 1582102675.990041 DST MIGRATION {'status': 'postcopy-active'}
> 1582102675.996435 DST RESUME
> 1582102676.111313 SRC MIGRATION {'status': 'completed'}
> 1582102676.155691 DST MIGRATION {'status': 'completed'}
>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if debug:
> with no usage in the following patches, you can put the whole block of re=
lative code above under the "if debug: section

TODO will be uncommented soon

>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prin=
t('downtime:', downtime)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prin=
t('postcopy_time:', postcopy_time)
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Assert that bitmap migrati=
on is finished (check that successor bitmap
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # is removed)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result =3D self.v=
m_b.qmp('query-block')
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while len(result['return'][0=
]['dirty-bitmaps']) > 1:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 time=
.sleep(2)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 resu=
lt =3D self.vm_b.qmp('query-block')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert len(result['return'][=
0]['dirty-bitmaps']) =3D=3D 1
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Check content of migrated =
(and updated by new writes) bitmap
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result =3D self.v=
m_b.qmp('x-debug-block-dirty-bitmap-sha256',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node=3D'drive0', name=3D'bitm=
ap')
>> -
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assert_qmp(r=
esult, 'return/sha256', sha256)
>>
>=20
> Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>


--=20
Best regards,
Vladimir

