Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA9EC34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 14:45:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7956424656
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 14:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="XvPOdYod"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7956424656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4QbG-0005Z2-SO
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 09:45:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52118)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j4Qad-00054g-CX
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:44:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j4Qac-0001qW-4i
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:44:39 -0500
Received: from mail-eopbgr60106.outbound.protection.outlook.com
 ([40.107.6.106]:61159 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1j4QaY-0001kU-BA; Wed, 19 Feb 2020 09:44:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTqiaZofsS1ztoD9T2scqRKdUt3ZC+7BEShYzYpbfB+g6cfA9cLPrJdvCgQT7hiLlW6v7/HJLThcIZYrS+QVojSTHh/EfXjfsS4DpS0oBVDOCZl4muT+DpxLwVpgBoeEtuJO7m8pls6jcLxyOlLk+28RbGbN0KPjMZyIMrYD/I1XzASSct9RV4uTN9OgD+3pyUA7GQSo5bukOeomR7jSIlwNc08ppylqrXM3OQrV9Hi7blkCuTjhXvc1ZzAOHOAl2qkfC7dGclN/x8Y+qeDLdJVWgFAub5jsIN3wbeBZIpq19Tv6bjnIpLg1CIwraT736p0JhBLxt4o1jo979DVjng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2tdWwVMoP9eM29GpLzUq3VI7tNMy3ifJKZ9qXJnUTM=;
 b=IHboZf6re+DJKcredt2KmO5n+cedzvy7Fw0BTrQwPvVCK+z1GcOhaz6oi7Epu/i4SusI8WhcXb3EQ6Le8YZIrsU6WtEAWmUew+tHcosdyjfKQLsRYfYyAIiU5Yzh58NTr/oV/vaHjbun011BW2rP07gs3VBNHs32Y+nbKa/rOGSLK+nut71m7ecSqc4snIMScCrkZvpAyGsV3X9GIJLpxbKqOHY9Vy/l0qJx6ytctvJJGSCPDJqwj5dwd0qsx5hyAnwucPqMJ9JTFRLkv1MD5o65BsuAHPtYveICBIo2cKmSd3B/BnR5LyStSTL3r/J/Qs9qVJgVX7Wwe+UE4CJ1Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2tdWwVMoP9eM29GpLzUq3VI7tNMy3ifJKZ9qXJnUTM=;
 b=XvPOdYodw6Le1rKT4Q5FvOCB55u3YLTzg/tDf/q/FR78PY13JOGiQbMQKt04LGKrURyI2rSionKb9sb6KZYgrR23ya4f/+TrqRDkdnuICyqccoV6v1HTBlvShrillRe6CnTmS3RX8lR73OCf42ReYhqKU3Jz7bpQtE+mcPWrXqQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com (10.255.123.95) by
 AM6PR08MB5000.eurprd08.prod.outlook.com (10.255.121.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Wed, 19 Feb 2020 14:44:30 +0000
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d]) by AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d%5]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 14:44:30 +0000
Subject: Re: [PATCH v2 16/22] qemu-iotests/199: change discard patterns
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
 <20200217150246.29180-17-vsementsov@virtuozzo.com>
 <a2f512b5-ea33-a063-56e7-20fd250e867e@virtuozzo.com>
Organization: Virtuozzo
Message-ID: <9c71cae9-9315-e67c-0074-24d53e44f107@virtuozzo.com>
Date: Wed, 19 Feb 2020 17:44:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <a2f512b5-ea33-a063-56e7-20fd250e867e@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR06CA0152.eurprd06.prod.outlook.com
 (2603:10a6:7:16::39) To AM6PR08MB5048.eurprd08.prod.outlook.com
 (2603:10a6:20b:ee::31)
MIME-Version: 1.0
Received: from [172.16.24.225] (185.231.240.5) by
 HE1PR06CA0152.eurprd06.prod.outlook.com (2603:10a6:7:16::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17 via Frontend Transport; Wed, 19 Feb 2020 14:44:29 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3565ad2-8069-48f6-69b3-08d7b54a39ff
X-MS-TrafficTypeDiagnostic: AM6PR08MB5000:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB5000E8F9E6A4951B282F6CBAF4100@AM6PR08MB5000.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:46;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(366004)(199004)(189003)(498600001)(66556008)(86362001)(66946007)(36756003)(6486002)(36916002)(53546011)(16526019)(186003)(5660300002)(2616005)(26005)(4326008)(44832011)(52116002)(8676002)(16576012)(81156014)(66476007)(31696002)(2906002)(31686004)(81166006)(54906003)(8936002)(956004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB5000;
 H:AM6PR08MB5048.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xd7sZf3INDBGbAAMTNCb4/AkiH5JNwpkPzJprAP5vn8GIWxYVv1pNDh0xQltKKzuWMKFDSfOKMC7EyKTF7yRNFAxoI5eWZvwc/j7iMqstYR5hBChD8zDh9XUc0eKCUd1/NSBSysmdRq9L0lxZEb/n+hRLkgpxjsn1ZmchMax7BfgrFUmm2V94AHXRjcS+HpzXyzHojUENbkzZFzSzUZIUBNZySUaenbvlmQjsIZ5MolNQun5EpWcXadCV2yR/OgXE5XeQ1jlvHI3rkv84WrPrROBshPxDz10fLZN1P1bHWSByutIvxYAj9IfbQELe7i+ueDY0o9UCZnPHqIGQrLwyV/InoZ+o771M9hvQys7Yktg/EAWwANyQ9mZ3kOk0e39EHipZcyWjFYUOAIRvoajuekXe5tj3u20VxcHwcVwqFQtbp2x9AwqhEd9H2qYQacB
X-MS-Exchange-AntiSpam-MessageData: r1ijZVxNrcV9MjiiMv+mqhvIOv5FgzYVdXcCJEsKA14J0Uf1SAMt3eMru6w9GfcjiFAspq33hqUCbk0RX/uGU1Nb1KY2PivONi7BACiJQpIk5lS/u8ITyKxLDUVnXcpbeOuBd3ybHyFZ2LR3PkRTLA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3565ad2-8069-48f6-69b3-08d7b54a39ff
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 14:44:30.3160 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GZS9GN4hSWzQVb+vAo281n4PWymByPjbY7edX/rWENY1XdCU95XRWik0RJP+RZTwY9mLmhyXULNeLI5ch7sYrAyI4guoUs9PjgGeud32jcE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5000
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.106
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



On 19/02/2020 17:33, Andrey Shinkevich wrote:
> On 17/02/2020 18:02, Vladimir Sementsov-Ogievskiy wrote:
>> iotest 40 works too long because of many discard opertion. On the same
>=20
> operations
> At the same time
>=20
>> time, postcopy period is very short, in spite of all these efforts.
>>
>> So, let's use less discards (and with more interesting patterns) to
>> reduce test timing. In the next commit we'll increase postcopy period.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> =C2=A0 tests/qemu-iotests/199 | 44 +++++++++++++++++++++++++------------=
-----
>> =C2=A0 1 file changed, 26 insertions(+), 18 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/199 b/tests/qemu-iotests/199
>> index d78f81b71c..7914fd0b2b 100755
>> --- a/tests/qemu-iotests/199
>> +++ b/tests/qemu-iotests/199
>> @@ -30,6 +30,28 @@ size =3D '256G'
>> =C2=A0 fifo =3D os.path.join(iotests.test_dir, 'mig_fifo')
>> +GiB =3D 1024 * 1024 * 1024
>> +
>> +discards1 =3D (
>> +=C2=A0=C2=A0=C2=A0 (0, GiB),
>> +=C2=A0=C2=A0=C2=A0 (2 * GiB + 512 * 5, 512),
>> +=C2=A0=C2=A0=C2=A0 (3 * GiB + 512 * 5, 512),
>> +=C2=A0=C2=A0=C2=A0 (100 * GiB, GiB)
>> +)
>> +
>> +discards2 =3D (
>> +=C2=A0=C2=A0=C2=A0 (3 * GiB + 512 * 8, 512),
>> +=C2=A0=C2=A0=C2=A0 (4 * GiB + 512 * 8, 512),
>> +=C2=A0=C2=A0=C2=A0 (50 * GiB, GiB),
>> +=C2=A0=C2=A0=C2=A0 (100 * GiB + GiB // 2, GiB)
>> +)
>> +
>> +
>> +def apply_discards(vm, discards):
>> +=C2=A0=C2=A0=C2=A0 for d in discards:
>=20
> If we run qemu-io only once, it will update the bitmap state and will=20
> speed the test performance up. Is that wrong idea?

Yes, that is. I have seen with the later review.

Andrey

>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vm.hmp_qemu_io('drive0', 'di=
scard {} {}'.format(*d))
>> +
>> +
>> =C2=A0 def event_seconds(event):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return event['timestamp']['seconds'] + \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 event['timestamp'=
]['microseconds'] / 1000000.0
>> @@ -80,9 +102,7 @@ class=20
>> TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm_b_events =
=3D []
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 def test_postcopy(self):
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 discard_size =3D 0x40000000
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 granularity =3D 5=
12
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chunk =3D 4096
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result =3D self.v=
m_a.qmp('block-dirty-bitmap-add', node=3D'drive0',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name=3D'bitmap', granularity=
=3Dgranularity)
>> @@ -92,14 +112,7 @@ class=20
>> TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node=3D'drive0', name=3D'bitm=
ap')
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 empty_sha256 =3D =
result['return']['sha256']
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s =3D 0
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while s < discard_size:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self=
.vm_a.hmp_qemu_io('drive0', 'discard %d %d' % (s,=20
>> chunk))
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s +=
=3D 0x10000
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s =3D 0x8000
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while s < discard_size:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self=
.vm_a.hmp_qemu_io('drive0', 'discard %d %d' % (s,=20
>> chunk))
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s +=
=3D 0x10000
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 apply_discards(self.vm_a, di=
scards1 + discards2)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result =3D self.v=
m_a.qmp('x-debug-block-dirty-bitmap-sha256',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node=3D'drive0', name=3D'bitm=
ap')
>> @@ -111,10 +124,8 @@ class=20
>> TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result =3D self.v=
m_a.qmp('block-dirty-bitmap-clear',=20
>> node=3D'drive0',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name=3D'bitmap')
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assert_qmp(r=
esult, 'return', {})
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s =3D 0
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while s < discard_size:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self=
.vm_a.hmp_qemu_io('drive0', 'discard %d %d' % (s,=20
>> chunk))
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s +=
=3D 0x10000
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 apply_discards(self.vm_a, di=
scards1)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 caps =3D [{'capab=
ility': 'dirty-bitmaps', 'state': True},
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {'capability': 'events', 'state': True}]
>> @@ -134,10 +145,7 @@ class=20
>> TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e_resume =3D self=
.vm_b.event_wait('RESUME')
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm_b_events.=
append(e_resume)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s =3D 0x8000
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while s < discard_size:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self=
.vm_b.hmp_qemu_io('drive0', 'discard %d %d' % (s,=20
>> chunk))
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s +=
=3D 0x10000
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 apply_discards(self.vm_b, di=
scards2)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 match =3D {'data'=
: {'status': 'completed'}}
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e_complete =3D se=
lf.vm_b.event_wait('MIGRATION', match=3Dmatch)
>>
>=20
> Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

--=20
With the best regards,
Andrey Shinkevich


