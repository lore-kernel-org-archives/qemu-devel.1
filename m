Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAF4C3F2D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 08:54:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B4B924695
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 08:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ar0L99Bb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B4B924695
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8gqm-0000Ss-HU
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 03:54:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41133)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1j8gq9-0008Qv-Ea
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 03:54:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1j8gq8-0006dQ-7D
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 03:54:17 -0500
Received: from mail-eopbgr70133.outbound.protection.outlook.com
 ([40.107.7.133]:8857 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1j8gq5-0006c8-PF; Mon, 02 Mar 2020 03:54:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3Rm2pqL/p0P0VmGoWll19817sv0lhn10TI+TaZ+vT9SqGvWnLx+1Jjhj8IY3mHJD28d9ASKr/fTpFHKay23RN5MFhCatIigZ+Jxq0k0X/nkcVbMyGPneDq/IBuwII4YPLCfCGMjsTD5FZzjS16tAgeqDw40AyEN2ec1iEWdbTvUxQNUmOQaQ8cRWlS+s0EAISNJytv9T2OVd5yHVajzJSXgP2oipA4rwaLa57jn+9cYamSsOyrSRB6pOiUR8IlX/KFPrFAiYhWDJsnereeY61ZETNHnDxFNqRWl1RRI23r98Mji9aNgdqWcixNpzIXJoMvuFR+VMMGfHvN4geCGjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dh0H1GSxtNPyZFb7sV8Rus/2/iNMX5PwkEQscQw14U4=;
 b=k5pzfxE82jXGYUc+ZEGbQpzd5hcFhXJ6uEMgpHZ+6tzoLHv7WLVMH8mjSVhPFgwOAxFNq65os2wssk3NRvJ4UnI8mIlylSGGFNpC8QApEkCyQmyLAg5dHggB2f1uGjva1GYy1uG5ZR/aZmz1Qvl+DZ2gOpEjUIj3qnGc9HceCXkSkAzn5KokbltM+a4bU2Ra+qVIDKrW+lnNb1fxoez9D68501/djRDD/ULMn0QiBGBqBrQ9KfXjaEhCcsE0ZZxbHcI+q1ZRte2OpSPVIt/paHhHL+eRqJbL2WIqexq12+yIOwrmw1kBoKK9npEmXJHOK2szFMTpyqihdA45++qKSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dh0H1GSxtNPyZFb7sV8Rus/2/iNMX5PwkEQscQw14U4=;
 b=ar0L99BbkMuipNkxDSollqmmQPRPbIDoxL5JwdQEf0w0JD4ih/AYWKwzAAbVxD5C58rBwmy81E5UfRdP0/ynGvmkn5NwSjMULV/07fZDIL3QXfSTdGyqTpD71Mlyjo15+fAdOBi6tgwzxK2+AY+p8U8vpmaW9KTkdKQli2dpLxs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB3570.eurprd08.prod.outlook.com (20.177.110.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.18; Mon, 2 Mar 2020 08:54:11 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::9875:c099:713b:8219]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::9875:c099:713b:8219%4]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 08:54:11 +0000
Subject: Re: [PATCH v2 0/4] qcow2: Implement zstd cluster compression method
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200302082111.21205-1-dplotnikov@virtuozzo.com>
 <2dffd0d2-7a1d-3ecd-1fbc-b89ff270ab21@virtuozzo.com>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <4f6c9ba2-62c2-2d9a-4b96-9f7adb2aa718@virtuozzo.com>
Date: Mon, 2 Mar 2020 11:54:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <2dffd0d2-7a1d-3ecd-1fbc-b89ff270ab21@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: HE1PR0301CA0022.eurprd03.prod.outlook.com
 (2603:10a6:3:76::32) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.64] (178.34.150.179) by
 HE1PR0301CA0022.eurprd03.prod.outlook.com (2603:10a6:3:76::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.16 via Frontend Transport; Mon, 2 Mar 2020 08:54:10 +0000
X-Originating-IP: [178.34.150.179]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c737ab5-4956-4981-a86f-08d7be874692
X-MS-TrafficTypeDiagnostic: AM0PR08MB3570:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB3570485D50AF26079648CE17CFE70@AM0PR08MB3570.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 033054F29A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(376002)(136003)(39840400004)(346002)(199004)(189003)(2616005)(956004)(26005)(5660300002)(8936002)(36756003)(4326008)(8676002)(66946007)(316002)(478600001)(81156014)(81166006)(31686004)(6486002)(16526019)(186003)(2906002)(86362001)(16576012)(66556008)(31696002)(53546011)(66476007)(52116002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3570;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ja+2cVQkzcDX+NAdoyMEWdAXWUTesxas5GO6COIY8krRA1BatdkgLfHzVYh+UJwimiffzv0OQNRZzWn2HppJsrVZRSCXaBBtIuljYy4p9quXtwKT2ZKtSN9m9DAiE5p/z6/7hi4bKmn0xROEVZLEI1p4sPWpqphR+geuu94UR79GkCN5MRBuxvvRXklvI85N/z65rCVB1Whql16gO0b2shVBXrQGuof9GX/oeEAWPlklLdspxMjgWlA+YO4rddSg/ZxOiupNLYWiSZsysDIax1egHdp1cSEVO4gmquMJNLMuM0NSfOgwXbvp92iWBmWD5sVQ+XmeaUYmOTkzuyu1WkpTvRZ57P7P1Hkhtb5yUyGdArOQQtWZYQagTtKcBsG8Ed0aN5spKrYDp8senqmZ2a7vCf1SFIsx74sNLt4PgaDiqn7Gsfj1/ntdQxbIb5W/
X-MS-Exchange-AntiSpam-MessageData: t7f73hxR+G63VIHYxMqr5NkkeaNzrOoA1c4JTJTX3r+S5AACOkLAhfEbQ5eOsJnCQpSTUt+HLXTXLqhCOnNQV9Gec2eU234RMTvDHG1b69F6gymAPitWwWtXBZSmUV3z/Ueskyn40KMMxboeC5JNeg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c737ab5-4956-4981-a86f-08d7be874692
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 08:54:11.1352 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZgnyRm8tBoKoCHRyb1f9E2+Ox0jY+13q7yCzbmulYLcqRrsRDDkIBDZRH9S6nkoMR+S5TJmEzubIrJBUTO2gJqZ3szrRmOCwD08wS2FkMfI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3570
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.133
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
Cc: kwolf@redhat.com, den@openvz.com, qemu-block@nongnu.org, armbru@redhat.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 02.03.2020 11:51, Vladimir Sementsov-Ogievskiy wrote:
> Doesn't apply to master, as zstd already exists in ./configure :) (for=20
> migration)
Mmmmm, will rebase it. Any other comments?
>
>
> 02.03.2020 11:21, Denis Plotnikov wrote:
>> v2:
>> =C2=A0=C2=A0 * rework compression type setting [Vladimir]
>> =C2=A0=C2=A0 * squash iotest changes to the compression type introductio=
n patch=20
>> [Vladimir, Eric]
>> =C2=A0=C2=A0 * fix zstd availability checking in zstd iotest [Vladimir]
>> =C2=A0=C2=A0 * remove unnecessry casting [Eric]
>> =C2=A0=C2=A0 * remove rudundant checks [Eric]
>> =C2=A0=C2=A0 * fix compressed cluster layout in qcow2 spec [Vladimir]
>> =C2=A0=C2=A0 * fix wording [Eric, Vladimir]
>> =C2=A0=C2=A0 * fix compression type filtering in iotests [Eric]
>>
>> v1:
>> =C2=A0=C2=A0 the initial series
>>
>> ---
>> zstd comression method is faster than the only available zlib.
>> The series adds zstd to the methods available for clusters compression.
>>
>> The implementation is done with respect to the recently added=20
>> compression
>> type additional header to the qcow2 specification.
>>
>> Denis Plotnikov (4):
>> =C2=A0=C2=A0 qcow2: introduce compression type feature
>> =C2=A0=C2=A0 qcow2: rework the cluster compression routine
>> =C2=A0=C2=A0 qcow2: add zstd cluster compression
>> =C2=A0=C2=A0 iotests: 287: add qcow2 compression type test
>>
>> =C2=A0 docs/interop/qcow2.txt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 20 ++++
>> =C2=A0 configure=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 29 +++++
>> =C2=A0 qapi/block-core.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 23 +++-
>> =C2=A0 block/qcow2.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 18 =
++-
>> =C2=A0 include/block/block_int.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 1 +
>> =C2=A0 block/qcow2-threads.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 197 ++++++++++++++++++++++++++++---
>> =C2=A0 block/qcow2.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 116 +++++=
+++++++++++++
>> =C2=A0 tests/qemu-iotests/031.out=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 14 +--
>> =C2=A0 tests/qemu-iotests/036.out=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 4 +-
>> =C2=A0 tests/qemu-iotests/049.out=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
102 ++++++++--------
>> =C2=A0 tests/qemu-iotests/060.out=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 1 +
>> =C2=A0 tests/qemu-iotests/061.out=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 34 +++---
>> =C2=A0 tests/qemu-iotests/065=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 20 ++--
>> =C2=A0 tests/qemu-iotests/080=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
>> =C2=A0 tests/qemu-iotests/144.out=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 4 +-
>> =C2=A0 tests/qemu-iotests/182.out=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 2 +-
>> =C2=A0 tests/qemu-iotests/242.out=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 5 +
>> =C2=A0 tests/qemu-iotests/255.out=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 8 +-
>> =C2=A0 tests/qemu-iotests/287=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 127 ++++++++++++++++++++
>> =C2=A0 tests/qemu-iotests/287.out=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 43 +++++++
>> =C2=A0 tests/qemu-iotests/common.filter |=C2=A0=C2=A0 3 +-
>> =C2=A0 tests/qemu-iotests/group=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 1 +
>> =C2=A0 22 files changed, 666 insertions(+), 108 deletions(-)
>> =C2=A0 create mode 100755 tests/qemu-iotests/287
>> =C2=A0 create mode 100644 tests/qemu-iotests/287.out
>>
>
>


