Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B471C4332E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 12:07:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BF8B2072E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 12:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="i55i3/te"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BF8B2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGLrB-0006fM-3j
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 08:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47077)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jGLqE-00061h-75
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 08:06:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jGLqC-0005Oq-0E
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 08:06:02 -0400
Received: from mail-eopbgr30121.outbound.protection.outlook.com
 ([40.107.3.121]:17470 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jGLq4-0005L8-Lt; Mon, 23 Mar 2020 08:05:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQ8keOLRbNWIM29Zf5biz84WAHLNHc8vJllr1YQ1EgiBAxYpkN/GyduUwspHxHs5kTR/dmZJWKvF+fYCW2GScWUx/ocOAc52WQ4J1OTGZ192XAOGRQuDYoxD07VTW3BctzcQLg8HZKkupYpgbFobceps1gV3rqTv9qd+oJEw4cw3KBJLbUCex4kxafbeQ0E2JL3KrE0PQNHAN9xe5P45EKlj2xWmCTrHS069w8+Ptxuj7sS1kZFiiYFYYUaXy7wHFjBxAitYjUcOdhP1GhU3jx7EyxnwKbg4xoPkbIs438m3kriddH+VpK/edcKweupe6zYJ/9ATPRZ1xAlaLlvGrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHpZ4okkcoMrJ6e0+Kk5O0qmnDcIObLkrTLPI0+nwdA=;
 b=EYw8RX0GXw3hmV4wmLYblXR6xE1FWvBE0kp8WESR33DtLzVZcJCtLaF9RKUm176oz0PKXmg/npp6alqzogHwWGTWx2x5czMyId6fteCYpEFgglE7O10qdj+JMMWjuewXl9/Fl0J4x6dnE6E3wGyaFU6OgbR69DeeIvbffON+brM84Z5GsN7xODDzNToi75zRew0NOBW35J79RCAPR5L8x7RX6kHZvkk/f5JdsRf+Y2Ikd0uksSCgcXme6/NGUo4DZh1jK78uXyTr4y2NNUgRNqxsN6FwJUm3yW5rXkCWOefuxUuCheUQTyjolHWKNwUdrKuFJfbwdb+QyXxRNT8etg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHpZ4okkcoMrJ6e0+Kk5O0qmnDcIObLkrTLPI0+nwdA=;
 b=i55i3/teXwUsddqSdlN3X/hW0xZz+jmZLJjhVdrNzii+/6EcD7HkabEi06uHUcZMlVNX20fquPxOaKxHzK3Envn3w/FZArkkdejXBXAvpW/wAUeZ2s2r6UwnUNiVZyolUnnT+NsPKCM925y2MtFCOcm/LbqiSC5zRT2hLJalAVI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5304.eurprd08.prod.outlook.com (10.141.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18; Mon, 23 Mar 2020 12:05:50 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533%6]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 12:05:50 +0000
Subject: Re: [PATCH v8 3/4] qcow2: add zstd cluster compression
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200321143431.19629-1-dplotnikov@virtuozzo.com>
 <20200321143431.19629-4-dplotnikov@virtuozzo.com>
 <a1830b65-bd38-c458-d382-1f3981355d2e@virtuozzo.com>
 <2914bee8-50b9-2759-7dda-8f5fd39e5fa5@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200323150548303
Message-ID: <cd7c513d-13c9-63e6-1e2f-c3c8e708d4ae@virtuozzo.com>
Date: Mon, 23 Mar 2020 15:05:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <2914bee8-50b9-2759-7dda-8f5fd39e5fa5@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FRYP281CA0004.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::14)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.41) by
 FRYP281CA0004.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18 via Frontend Transport; Mon, 23 Mar 2020 12:05:49 +0000
X-Tagtoolbar-Keys: D20200323150548303
X-Originating-IP: [185.215.60.41]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 846691c2-bceb-4d7e-bb73-08d7cf228712
X-MS-TrafficTypeDiagnostic: AM7PR08MB5304:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB530489A35B3B354C9152964FC1F00@AM7PR08MB5304.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 0351D213B3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(39840400004)(396003)(136003)(366004)(346002)(376002)(199004)(30864003)(8936002)(81156014)(31686004)(81166006)(19273905006)(6486002)(4326008)(478600001)(8676002)(316002)(16576012)(26005)(16526019)(186003)(36756003)(956004)(5660300002)(2616005)(52116002)(53546011)(2906002)(31696002)(66946007)(66556008)(86362001)(66476007)(563064011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM7PR08MB5304;
 H:AM7PR08MB5494.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: syhNiPXArMhZZIgadqWSPCSi19Up8MQeNs/UgqYTEWWwyT8PXklL8/2siKfnxCii0KfM7k0CeyqgdzXdvQRDyEurNj25emWNISEJKStRjGpvId4c6nMp55dRcdKwoUzcSAUnh7Oy/X0IDTJt5/BSn35sDem8hbL9hzajTUmOUmJv3xjDp8krooZbj8NX23q+5C/XCHQK/3Vxx09lupn2+86TFfa6j+NxsZgclqaLY5XZQVaforeQG2QE0Bx36vIu08oI6GPn8JSiCEHqh2KR9aMdgC69rt4gZLnL8QNX1c1NSmEo5myvZj6+4FxUUw62GHKkhgmLu/KHrDRl2LcTyUPSWkmfeGWwpS39KKbG3zedM63LdbDKgnktrkb7bs63Wmu+joxZlyp6yu0/kX3O0BS6xeGzaPC+ar4hx8PWq0S9JSilmtgdKZJO4ZY39Dctc2xxOazHhTMvehkLPRoBuoghPY4KmSeP3RJzuGzICdHhiLkqhGGVGpq/WpgwotafQyX/T77JWoJO8ecAO1e6kjeJO0SegSLYXHcev8U1eP/mwhgf5XAADrcpfySRluFQ
X-MS-Exchange-AntiSpam-MessageData: Z2VimVTSQ5xZth2nHJgjI6TIrmZqElK76BR3zFkFkQOGVNhOibZ5b4YKOSxqd5UvqUiJAycqXqiH/EtUPn5t1ckGlRF55YrL0LAmIWKDAFGSk0YsSiloVVJmBjOvPDWvPWLGuPqMWYm7DL+1NDVQXQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 846691c2-bceb-4d7e-bb73-08d7cf228712
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2020 12:05:50.0155 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fIMIRlWzdE+FE50W4SQ6Zk4rRA+T+IDMUyaNxjFjY+NBk1bFRVtATjffm1nSoQhRzIhpDc64Cud+DzRSQxi7kinDb/Qq03w2LO6O2N3fUyU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5304
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.121
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
Cc: kwolf@redhat.com, berto@igalia.com, qemu-block@nongnu.org,
 armbru@redhat.com, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

23.03.2020 13:20, Denis Plotnikov wrote:
>=20
>=20
> On 23.03.2020 11:44, Vladimir Sementsov-Ogievskiy wrote:
>> 21.03.2020 17:34, Denis Plotnikov wrote:
>>> zstd significantly reduces cluster compression time.
>>> It provides better compression performance maintaining
>>> the same level of the compression ratio in comparison with
>>> zlib, which, at the moment, is the only compression
>>> method available.
>>>
>>> The performance test results:
>>> Test compresses and decompresses qemu qcow2 image with just
>>> installed rhel-7.6 guest.
>>> Image cluster size: 64K. Image on disk size: 2.2G
>>>
>>> The test was conducted with brd disk to reduce the influence
>>> of disk subsystem to the test results.
>>> The results is given in seconds.
>>>
>>> compress cmd:
>>> =C2=A0=C2=A0 time ./qemu-img convert -O qcow2 -c -o compression_type=3D=
[zlib|zstd]
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 src.img [zlib|zstd]_compressed.img
>>> decompress cmd
>>> =C2=A0=C2=A0 time ./qemu-img convert -O qcow2
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [zlib|zstd]_compressed.img uncompre=
ssed.img
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 comp=
ression=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 decompression
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zlib=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 zstd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 zlib=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zstd
>>> ------------------------------------------------------------
>>> real=C2=A0=C2=A0=C2=A0=C2=A0 65.5=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1=
6.3 (-75 %)=C2=A0=C2=A0=C2=A0 1.9=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 1.6 (-16 %)
>>> user=C2=A0=C2=A0=C2=A0=C2=A0 65.0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1=
5.8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.3=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.5
>>> sys=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3.3=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0.2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 2.0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.0
>>>
>>> Both ZLIB and ZSTD gave the same compression ratio: 1.57
>>> compressed image size in both cases: 1.4G
>>>
>>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> Reviewed-by: Alberto Garcia <berto@igalia.com>
>>> QAPI part:
>>> Acked-by: Markus Armbruster <armbru@redhat.com>
>>
>> You forget to drop signs, patch is changed significantly, including algo=
rithm.
> ok, my fault
>>
>>> ---
>>> =C2=A0 docs/interop/qcow2.txt |=C2=A0=C2=A0 1 +
>>> =C2=A0 configure=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
>>> =C2=A0 qapi/block-core.json=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +-
>>> =C2=A0 block/qcow2-threads.c=C2=A0 | 129 ++++++++++++++++++++++++++++++=
+++++++++++
>>> =C2=A0 block/qcow2.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 7 +++
>>> =C2=A0 5 files changed, 140 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
>>> index 5597e24474..795dbb21dd 100644
>>> --- a/docs/interop/qcow2.txt
>>> +++ b/docs/interop/qcow2.txt
>>> @@ -208,6 +208,7 @@ version 2.
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Available c=
ompression type values:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0: zlib <https://www.zlib.net/>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1: zs=
td <http://github.com/facebook/zstd>
>>> =C2=A0 =C2=A0 =C2=A0 =3D=3D=3D Header padding =3D=3D=3D
>>> diff --git a/configure b/configure
>>> index caa65f5883..b2a0aa241a 100755
>>> --- a/configure
>>> +++ b/configure
>>> @@ -1835,7 +1835,7 @@ disabled with --disable-FEATURE, default is enabl=
ed if available:
>>> =C2=A0=C2=A0=C2=A0 lzfse=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 support of lzfse compression library
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (for reading lzfse-compressed=
 dmg images)
>>> =C2=A0=C2=A0=C2=A0 zstd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 support for zstd compression library
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (for migration compression)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (for migration compression and qcow2 clus=
ter compression)
>>> =C2=A0=C2=A0=C2=A0 seccomp=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 seccomp support
>>> =C2=A0=C2=A0=C2=A0 coroutine-pool=C2=A0 coroutine freelist (better perf=
ormance)
>>> =C2=A0=C2=A0=C2=A0 glusterfs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Gluste=
rFS backend
>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>> index a306484973..8953451818 100644
>>> --- a/qapi/block-core.json
>>> +++ b/qapi/block-core.json
>>> @@ -4401,11 +4401,12 @@
>>> =C2=A0 # Compression type used in qcow2 image file
>>> =C2=A0 #
>>> =C2=A0 # @zlib: zlib compression, see <http://zlib.net/>
>>> +# @zstd: zstd compression, see <http://github.com/facebook/zstd>
>>> =C2=A0 #
>>> =C2=A0 # Since: 5.0
>>> =C2=A0 ##
>>> =C2=A0 { 'enum': 'Qcow2CompressionType',
>>> -=C2=A0 'data': [ 'zlib' ] }
>>> +=C2=A0 'data': [ 'zlib', { 'name': 'zstd', 'if': 'defined(CONFIG_ZSTD)=
' } ] }
>>> =C2=A0 =C2=A0 ##
>>> =C2=A0 # @BlockdevCreateOptionsQcow2:
>>> diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
>>> index 7dbaf53489..ee4bad8d5b 100644
>>> --- a/block/qcow2-threads.c
>>> +++ b/block/qcow2-threads.c
>>> @@ -28,6 +28,11 @@
>>> =C2=A0 #define ZLIB_CONST
>>> =C2=A0 #include <zlib.h>
>>> =C2=A0 +#ifdef CONFIG_ZSTD
>>> +#include <zstd.h>
>>> +#include <zstd_errors.h>
>>> +#endif
>>> +
>>> =C2=A0 #include "qcow2.h"
>>> =C2=A0 #include "block/thread-pool.h"
>>> =C2=A0 #include "crypto.h"
>>> @@ -166,6 +171,120 @@ static ssize_t qcow2_zlib_decompress(void *dest, =
size_t dest_size,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>> =C2=A0 }
>>> =C2=A0 +#ifdef CONFIG_ZSTD
>>> +
>>> +/*
>>> + * qcow2_zstd_compress()
>>> + *
>>> + * Compress @src_size bytes of data using zstd compression method
>>> + *
>>> + * @dest - destination buffer, @dest_size bytes
>>> + * @src - source buffer, @src_size bytes
>>> + *
>>> + * Returns: compressed size on success
>>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -ENOMEM desti=
nation buffer is not enough to store compressed data
>>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -EIO=C2=A0=C2=
=A0=C2=A0 on any other error
>>> + */
>>> +static ssize_t qcow2_zstd_compress(void *dest, size_t dest_size,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const void *sr=
c, size_t src_size)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 size_t ret;
>>> +=C2=A0=C2=A0=C2=A0 ZSTD_outBuffer output =3D { dest, dest_size, 0 };
>>> +=C2=A0=C2=A0=C2=A0 ZSTD_inBuffer input =3D { src, src_size, 0 };
>>> +=C2=A0=C2=A0=C2=A0 ZSTD_CCtx *cctx =3D ZSTD_createCCtx();
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!cctx) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EIO;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 ret =3D ZSTD_CCtx_setParameter(cctx, ZSTD_c_compres=
sionLevel,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ZSTD_CLEVEL_DEFAULT);
>>
>> Hmm, looks a bit strange.. Isn't it already default by default?)
> Should I remove it? Doesn't worth to express that explicitly? This line r=
emoves the question what compression level is used.

No it doesn't, as we don't know the constant, neither we have guarantee tha=
t it is the same in different version of library..

I'd drop it if it changes nothing.

> And gives a hint where to change it ,if we decide to implement compressio=
n ratio changing.
>>
>>> +=C2=A0=C2=A0=C2=A0 if (ZSTD_isError(ret)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EIO;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>
>> Hmm, strange that we need a loop, but zstd spec directly requires it, po=
ssibly we need to make a comment from it:
>>
>> =C2=A0 "ZSTD spec: You must continue calling ZSTD_compressStream2() with=
 ZSTD_e_flush until it returns 0, at which point you can change the operati=
on."
> ok
>>
>>> +=C2=A0=C2=A0=C2=A0 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Instruct zstd to co=
mpress the whole buffer and write
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the frame epilogue.=
 This allows as to use zstd streaming
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * semantics and don't=
 store the compressed size for the
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * zstd decompression.
>>
>> May be not "to don't store", but to "decompress without knowing exact co=
mpressed data length" or something like this. I mean, make the comment for =
people who read the final code, not for those who review changes from versi=
on to version.
> I'd better write
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * zstd simple interface=
 requires exact compressed size.
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * zstd stream interface=
 holds all the data in the compressed frame.
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Instruct zstd to comp=
ress the whole buffer and write
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the frame epilogue. T=
his allows as to use zstd streaming
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * semantics and don't s=
tore the compressed size for the
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * zstd decompression.
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D ZSTD_compressStream=
2(cctx, &output , &input, ZSTD_e_end);
>>
>> extra whitespace
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ZSTD_isError(ret)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
 =3D -EIO;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 got=
o out;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Dest buffer isn't big en=
ough to store compressed content */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (output.pos + ret > outp=
ut.size) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
 =3D -ENOMEM;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 got=
o out;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 } while (ret);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* if no error, the input data must be fully consum=
ed */
>>> +=C2=A0=C2=A0=C2=A0 assert(input.pos =3D=3D input.size);
>>> +=C2=A0=C2=A0=C2=A0 /* make sure we can safely return compressed buffer=
 size with ssize_t */
>>> +=C2=A0=C2=A0=C2=A0 assert(output.pos <=3D SSIZE_MAX);
>>> +=C2=A0=C2=A0=C2=A0 ret =3D output.pos;
>>> +
>>> +out:
>>> +=C2=A0=C2=A0=C2=A0 ZSTD_freeCCtx(cctx);
>>> +=C2=A0=C2=A0=C2=A0 return ret;
>>> +}
>>> +
>>> +/*
>>> + * qcow2_zstd_decompress()
>>> + *
>>> + * Decompress some data (not more than @src_size bytes) to produce exa=
ctly
>>> + * @dest_size bytes using zstd compression method
>>> + *
>>> + * @dest - destination buffer, @dest_size bytes
>>> + * @src - source buffer, @src_size bytes
>>> + *
>>> + * Returns: 0 on success
>>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -EIO on any e=
rror
>>> + */
>>> +static ssize_t qcow2_zstd_decompress(void *dest, size_t dest_size,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co=
nst void *src, size_t src_size)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 size_t ret =3D 0;
>>> +=C2=A0=C2=A0=C2=A0 ZSTD_outBuffer output =3D { dest, dest_size, 0 };
>>> +=C2=A0=C2=A0=C2=A0 ZSTD_inBuffer input =3D { src, src_size, 0 };
>>> +=C2=A0=C2=A0=C2=A0 ZSTD_DCtx *dctx =3D ZSTD_createDCtx();
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!dctx) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EIO;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D ZSTD_decompressStre=
am(dctx, &output, &input);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ZSTD_isError(ret)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
 =3D -EIO;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 got=
o out;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Dest buffer size is=
 the image cluster size.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * It should be big en=
ough to store uncompressed content.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * There shouldn't be =
any cases when the decompressed content
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * size is greater the=
n the cluster size.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>
>> But consider corrupted image: it may contain any data. And we should not=
 crash because of it. So, we should return error here.
> If the image is corrupted we can't continue anyway. If we return -EIO on =
this condition, we need to do some work investigating what has happened. As=
sert explicitly points out what happened. I though we should return -EIO if=
 we know what to do with the error. But if the invariant doesn't hold, do w=
e really know what to do rather then stop the execution and report an error=
?

If only one compressed cluster is corrupted because of one changed byte, it=
's not a reason to crash the whole program. We still can read another clust=
ers. You already return EIO on ZSTD failure, which includes some kind of co=
rrupted image of course.

What to do with error - nothing. This cluster is corrupted, unreadable. Why=
 not? Real devices may have corrupted clusters too.

>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(output.pos + ret <=
=3D output.size);
>>> +=C2=A0=C2=A0=C2=A0 } while (ret);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * If decompression went fine we must have the=
 compressed
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * cluser fully consumed and flushed
>>
>> cluster
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0 assert(output.pos =3D=3D output.size);
>>
>> again, it should be EIO, not crash.
>>
>>> +out:
>>> +=C2=A0=C2=A0=C2=A0 ZSTD_freeDCtx(dctx);
>>> +=C2=A0=C2=A0=C2=A0 return ret;
>>> +
>>> +}
>>> +#endif
>>> +
>>> =C2=A0 static int qcow2_compress_pool_func(void *opaque)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Qcow2CompressData *data =3D opaque;
>>> @@ -217,6 +336,11 @@ qcow2_co_compress(BlockDriverState *bs, void *dest=
, size_t dest_size,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fn =3D qcow2_zli=
b_compress;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> =C2=A0 +#ifdef CONFIG_ZSTD
>>> +=C2=A0=C2=A0=C2=A0 case QCOW2_COMPRESSION_TYPE_ZSTD:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fn =3D qcow2_zstd_compress;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> +#endif
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abort();
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> @@ -249,6 +373,11 @@ qcow2_co_decompress(BlockDriverState *bs, void *de=
st, size_t dest_size,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fn =3D qcow2_zli=
b_decompress;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> =C2=A0 +#ifdef CONFIG_ZSTD
>>> +=C2=A0=C2=A0=C2=A0 case QCOW2_COMPRESSION_TYPE_ZSTD:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fn =3D qcow2_zstd_decompres=
s;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> +#endif
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abort();
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> diff --git a/block/qcow2.c b/block/qcow2.c
>>> index 899b5541f5..6420d27a6d 100644
>>> --- a/block/qcow2.c
>>> +++ b/block/qcow2.c
>>> @@ -1246,6 +1246,9 @@ static int validate_compression_type(BDRVQcow2Sta=
te *s, Error **errp)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (s->compression_type) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case QCOW2_COMPRESSION_TYPE_ZLIB:
>>> +#ifdef CONFIG_ZSTD
>>> +=C2=A0=C2=A0=C2=A0 case QCOW2_COMPRESSION_TYPE_ZSTD:
>>> +#endif
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
>>> @@ -3454,6 +3457,10 @@ qcow2_co_create(BlockdevCreateOptions *create_op=
tions, Error **errp)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (q=
cow2_opts->compression_type) {
>>> +#ifdef CONFIG_ZSTD
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case QCOW2_COMPRESSION_TYPE=
_ZSTD:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bre=
ak;
>>> +#endif
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 error_setg(errp, "Unknown compression type");
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 goto out;
>>>
>>
>>
>=20


--=20
Best regards,
Vladimir

