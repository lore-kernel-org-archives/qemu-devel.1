Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04619C34053
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 15:47:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0E202465D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 15:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="G9Oq8Sdi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E202465D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4RZh-0001by-T1
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 10:47:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33721)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j4RYi-0000fg-7f
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 10:46:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j4RYg-0006xz-Uh
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 10:46:44 -0500
Received: from mail-db8eur05on2071d.outbound.protection.outlook.com
 ([2a01:111:f400:7e1a::71d]:20544
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j4RYd-0006ud-NF; Wed, 19 Feb 2020 10:46:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgQGnhXwLu1Xz7jc0OMhkfsD47NhDXcu2ORfMW8HOe1e4dACzmFHCdszIW2F6kCC6Isgrt12K8NMk7fBJMMlkdsC6WxCl56K+hNb1PPfj8SCutqCM6fGPmGL6pNW0hd6nk7MvA9fOf+SmJldiWc/i3MsJElJ3h1DnkMCJsYImAcRMnnh51+37M/KxSzonEaEaxg4lsFPCRl11LGPj4FMCu4sEf6d13mwnxC5kIh3kmHAWUU7I8TxzylD6cSkUHlYOedKdJUr18O/6FmlgcjmobkQVNdC/cw90PzvK11Cf18lNwqTaefTggWkhlTQ+DTbAVMBp9kk3tClK0vMl1kqYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYif9LrSaP13xQDZ0+LqbDlBWLMhpRLXGGk9PZdOvTQ=;
 b=XJLH0GvHYpPCK68D7wFoXpcfgND0pt8MuBB51AHm1kNZRcLDtpAQoCng2egIr9pEOY6Od2RM5iy+LGHaqXb3O3/JFYjkGS7Xx7LrnQspTwO0KLkL0UPSdz7ywmIbaimfSdaD4xYBnQqfHQKqXC0qR3No8pbL4yhBDVa/9LwHq5IBHKT9LuJQ6op5aoYQxfE7FlzFgKJUcNRY7zRChgqQY404+2HF+1fXvNtLbAguYTtjfB0KBCN5ZoHqLfNUcbTZqi2YV7I4nV0JjO/fyZINdN/vuzIeyp6nqFBQVKyFpU8ULQY7lwwbX6QW4wvy0BV/915rW9X0azUvyXWMvqn6rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYif9LrSaP13xQDZ0+LqbDlBWLMhpRLXGGk9PZdOvTQ=;
 b=G9Oq8Sdiu3hJopzwW+EaCnNf6qCk8MA6dk63qtDGybj3Rti+MxJg/UcV8G9uVRmUrBgXgYmxoo5Rwlq28xdbSEC31MfLButB8SXi5ylbb/GD1JwkTKSQAM+BRmDL7emM5VlSLTg+i6p/7eGriqL//fHe7nXd7XX7vSrGOQ/pxuU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3222.eurprd08.prod.outlook.com (52.135.162.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.27; Wed, 19 Feb 2020 15:46:37 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2750.016; Wed, 19 Feb 2020
 15:46:37 +0000
Subject: Re: [PATCH v2 16/22] qemu-iotests/199: change discard patterns
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
 <20200217150246.29180-17-vsementsov@virtuozzo.com>
 <a2f512b5-ea33-a063-56e7-20fd250e867e@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200219184634920
Message-ID: <14cbd5b4-24dd-8eb9-386e-26c9e984987b@virtuozzo.com>
Date: Wed, 19 Feb 2020 18:46:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <a2f512b5-ea33-a063-56e7-20fd250e867e@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR1001CA0015.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::25) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR1001CA0015.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:3:f7::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17 via Frontend Transport; Wed, 19 Feb 2020 15:46:36 +0000
X-Tagtoolbar-Keys: D20200219184634920
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7508cddc-f5a0-4f94-f5ac-08d7b552e761
X-MS-TrafficTypeDiagnostic: AM6PR08MB3222:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3222B1C6C238F058A4371E8DC1100@AM6PR08MB3222.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:49;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(136003)(39850400004)(376002)(396003)(366004)(346002)(189003)(199004)(6486002)(2906002)(36756003)(53546011)(8936002)(66556008)(81166006)(66946007)(16526019)(66476007)(186003)(81156014)(31686004)(31696002)(16576012)(478600001)(2616005)(8676002)(4326008)(5660300002)(956004)(52116002)(26005)(86362001)(54906003)(316002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3222;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2nPpuzIsC8UpnQec021rqfM1loHfBkrRXKQhOwS2t9KSfUQDIAWMRsGIw68ErrP3e5SgZGRWbH9QoOZxfdpRHE+VTQIcqdbAAc+Rx3ZUJ5q5duyoK5tCnDIxMU9WSdMAA0oALpmOXp/RXgrKYXVv1L+VqF92S7zQQil/gjs9wEKELa3JVrrsaLZR3DHSV3UNPzBSRNiIJMDaBJq06pzg7we4csQu9DZ7ZHDiICNRc//COit8ZxquddG96iaZs57+HgZ6aiOjjTpRR/rn73mXVWDpF9MQVhVUZGZ3ikauPsCEq5iUqClqt57sxvTCyfiq41F6EpCHpscEuyjOqSWTmy412MpCq7OlyA0hiv9af6Nfjsb7WcogDlyqmgwWFJWXTjKIoLro7HZoFalbPkrGEGD7hf9pWMLsl8UNxUQJwxxxUf+o4x3Yey7avSfedXQh
X-MS-Exchange-AntiSpam-MessageData: prdQP7niY/kXA0vdaXHhIjifYGLCx/EnDy8LumRa8ykSQ3fkdULFxNvtZMjlUEEhPVRg1prqJxhe+1XBayhUZeIFCBR7BFnjyA6JA+ZfW32nuAXbAqaHCeJ6lUAhIYAFasWolPEu1wQn+xobngmmQQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7508cddc-f5a0-4f94-f5ac-08d7b552e761
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 15:46:37.0986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rdYDKnmjFGDu3jDzcbYGRpCYDKxJuwpCVS03JTuBuxaDdpFZ4Zi1tNnHzwXyRkXeOEOjGlMrFsmOU/GMqyWzz6V/eGaLDL9nI8Xzw4L2rQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3222
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:7e1a::71d
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

19.02.2020 17:33, Andrey Shinkevich wrote:
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
> If we run qemu-io only once, it will update the bitmap state and will spe=
ed the test performance up. Is that wrong idea?

But it will be less interesting test. Now we have several regions, which ar=
e in different relations in discards1 and
discards2.

And four elements are handled fast enough.

>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vm.hmp_qemu_io('drive0', 'di=
scard {} {}'.format(*d))
>> +
>> +
>> =C2=A0 def event_seconds(event):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return event['timestamp']['seconds'] + \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 event['timestamp'=
]['microseconds'] / 1000000.0
>> @@ -80,9 +102,7 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTes=
tCase):
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
>> @@ -92,14 +112,7 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTe=
stCase):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node=3D'drive0', name=3D'bitm=
ap')
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 empty_sha256 =3D =
result['return']['sha256']
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s =3D 0
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while s < discard_size:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self=
.vm_a.hmp_qemu_io('drive0', 'discard %d %d' % (s, chunk))
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s +=
=3D 0x10000
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s =3D 0x8000
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while s < discard_size:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self=
.vm_a.hmp_qemu_io('drive0', 'discard %d %d' % (s, chunk))
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
>> @@ -111,10 +124,8 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPT=
estCase):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result =3D self.v=
m_a.qmp('block-dirty-bitmap-clear', node=3D'drive0',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name=3D'bitmap')
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assert_qmp(r=
esult, 'return', {})
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s =3D 0
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while s < discard_size:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self=
.vm_a.hmp_qemu_io('drive0', 'discard %d %d' % (s, chunk))
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s +=
=3D 0x10000
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 apply_discards(self.vm_a, di=
scards1)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 caps =3D [{'capab=
ility': 'dirty-bitmaps', 'state': True},
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {'capability': 'events', 'state': True}]
>> @@ -134,10 +145,7 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPT=
estCase):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e_resume =3D self=
.vm_b.event_wait('RESUME')
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm_b_events.=
append(e_resume)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s =3D 0x8000
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while s < discard_size:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self=
.vm_b.hmp_qemu_io('drive0', 'discard %d %d' % (s, chunk))
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
Best regards,
Vladimir

