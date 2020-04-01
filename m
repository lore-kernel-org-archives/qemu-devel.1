Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD749C2D0F3
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 18:09:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 873B3212CC
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 18:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="V5GjFvud"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 873B3212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJhnh-0000s5-OT
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 14:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50551)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jJhmh-0007uY-03
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 14:08:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jJhme-00072J-5w
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 14:08:14 -0400
Received: from mail-am6eur05on2112.outbound.protection.outlook.com
 ([40.107.22.112]:52705 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jJhmX-0006uh-FW; Wed, 01 Apr 2020 14:08:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ecNlRp8uA7+DS6Ad+Ji8wm2rQeWoLzA04CnJXIJwIkx0vp5TH1oDvQtEgWM/8XryB9cN9araAK1nQUlQJ1Md39rZGIlJGjT0KHf9SEbwUCfKn1Nra82LyYliDECCanqdJgTnVkoBouNUQuRZrehhG+7TJav3amFZzGkDJJUDxij1+HC4RRbF9tgszdoItpKByI1KEf09amal87tKv+LbDK7cmLIoKRB3WbxWR0ZYdRcnZsD1PZ7EjZ26wo9D3AdF7FDVgFIBTo7cudH5klAPY26P5y6zgnGjocL3owucNeZFOCYZuGnLC87tv0nNN+EC6tJUS1ZKVDIgC8nZi5HkPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QJhwhDL2rsYwqc7LOB1xJnpiF7GSSrYwqI0Hu0QSkY=;
 b=Kg9to/YOBNj0N1Gtm7Dvqw+MZ9wes1gjjQ99wBM2TrT7zNqVP0iu+tK7hU+0at3Klmlf+A+E+L6XkWax9nVqTTQEFR3Gnq9OBgphGj2SR5mkOApVEXGEaNiSXQxlHUfy5zjO9erdJ9NRRxuKaRHmItAbNCeFC42l8dwL8l5K6Kp+G0wcppLXMaKXOV4BCDQVqF/9K3lAfApeMetKticI8Lv7DiPpSb+QKEghHX4Ul5W38q6kTzt5XNvChJsNu1V1k9TUGFVl1pBIpX276w0J1BiRWPE2Yxgfn8OTwxdlcWJaOogx/dLN8HqDn05cf/3D4Xr8SjbO++3oxh/y/1miCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QJhwhDL2rsYwqc7LOB1xJnpiF7GSSrYwqI0Hu0QSkY=;
 b=V5GjFvudJ/+XrBMuDYAZHQamX66hXUz9mOfJapk6u9mURkmtdbsWqlp4IqhCR0kXW9nQqjSoQ0y9d7NVBydNwBTtTrLI83bP5G5ZjlClCLtaAux8+8CA9n7NEZSWr/xz9vw6ViLjVLQHpcVu2+TBCX+B3aIyB8RsnhgLxqY1N/c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB5507.eurprd08.prod.outlook.com (52.132.215.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Wed, 1 Apr 2020 18:08:03 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::95e6:1da8:1244:d16f]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::95e6:1da8:1244:d16f%4]) with mapi id 15.20.2856.019; Wed, 1 Apr 2020
 18:08:03 +0000
Subject: Re: [PATCH v16 3/4] qcow2: add zstd cluster compression
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200401143719.21639-1-dplotnikov@virtuozzo.com>
 <20200401143719.21639-4-dplotnikov@virtuozzo.com>
 <2fe8c114-48da-d4c4-6463-65ea36f1d5a5@virtuozzo.com>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <28259e7e-a832-0b3a-8575-1d262aa6ee4f@virtuozzo.com>
Date: Wed, 1 Apr 2020 21:07:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <2fe8c114-48da-d4c4-6463-65ea36f1d5a5@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0014.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:69::27) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.64] (178.34.150.115) by
 AM0PR01CA0014.eurprd01.prod.exchangelabs.com (2603:10a6:208:69::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Wed, 1 Apr 2020 18:08:01 +0000
X-Originating-IP: [178.34.150.115]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a8f6195-6409-4e40-1d62-08d7d6679ea4
X-MS-TrafficTypeDiagnostic: AM0PR08MB5507:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB5507441164D169F1CC276AB3CFC90@AM0PR08MB5507.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 03607C04F0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR08MB3745.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(396003)(136003)(376002)(346002)(366004)(39850400004)(31696002)(81156014)(4326008)(8936002)(2616005)(316002)(52116002)(16576012)(478600001)(53546011)(81166006)(2906002)(86362001)(30864003)(36756003)(956004)(66946007)(6486002)(8676002)(31686004)(16526019)(5660300002)(186003)(26005)(66556008)(66476007)(19273905006)(563064011);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TNel0g+ysP8jJav1wn6HfoKcc+Im3wKAlknBWSRIyfrUeNhxaEF4lCYLuHYK4ydE/3pG2xQtiMtnLd/AW45p+sFrFK7MzpoO2XZCwHF0LSlrFeHQSVzxKhNPInXMZpj7JOUi55/yvNHb/rK58o4rMjZJPfEwrHk7B07NrQn5VaHKps6Ta3ac7loZ6ozPsB1Rg6erbjnLxnfUkl2ERSWZWvWhJHNhGoV87P5W/6+hqVKgDGeoQ60HIbnFZBiE9QXttVM/rJrsVulJMlNdDBCsqMMvgJQ76sy518T4JMsWoPkypPoN3E3i+N20Ne5/62RGmqvx5saWtboUBFxIn86YP2Cm9w/nqrLtoMD9BBMABSxWksNlRf15mhBTy7kGk2NkKoq2A2cLc7IlKWdz15HPUfv/yv+WNoaFQi8FIeZCSxpqq+sdzncncgeu2J5iyBSme+Yo/r5+FlRxe5UVfleY1VhZODBd9fkbnq+c1fvsEb+8gs2mR2kL3tc+VwnU3dRROXQVcZq+SyyprGUfiwALTLInghb36IFhfGoU1YPuc6dgDKVsgRtZmuWEfyBmkqiK
X-MS-Exchange-AntiSpam-MessageData: 36eC0nEa7HDXGepPX0wWGVJXxnGrt4/K1suMRi3dVP8CkJkZDEGeKjnuhLWyxmt2sW+PQku47EA2lCClVGLOD+oO7fcF/ebUaXqZfIbWEOuGmdTbfgOd73S2dWALiEHP2+7vX/14XfYn5gwY6z7M5Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a8f6195-6409-4e40-1d62-08d7d6679ea4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2020 18:08:02.9174 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V1UT57ZVuL5yqbS/U9KarYgZyh7gc1V6zchQXlP5IqXVIeIvAOrCqg8mF4099dJnN2spL9Uavn3RPgDcVq3GLwL94avPA2mYjBNW+XCt214=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5507
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.22.112
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



On 01.04.2020 18:36, Vladimir Sementsov-Ogievskiy wrote:
> 01.04.2020 17:37, Denis Plotnikov wrote:
>> zstd significantly reduces cluster compression time.
>> It provides better compression performance maintaining
>> the same level of the compression ratio in comparison with
>> zlib, which, at the moment, is the only compression
>> method available.
>>
>> The performance test results:
>> Test compresses and decompresses qemu qcow2 image with just
>> installed rhel-7.6 guest.
>> Image cluster size: 64K. Image on disk size: 2.2G
>>
>> The test was conducted with brd disk to reduce the influence
>> of disk subsystem to the test results.
>> The results is given in seconds.
>>
>> compress cmd:
>> =C2=A0=C2=A0 time ./qemu-img convert -O qcow2 -c -o compression_type=3D[=
zlib|zstd]
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 src.img [zlib|zstd]_compressed.img
>> decompress cmd
>> =C2=A0=C2=A0 time ./qemu-img convert -O qcow2
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [zlib|zstd]_compressed.img uncompresse=
d.img
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compr=
ession=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 decompression
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zlib=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 zstd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 zlib=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zstd
>> ------------------------------------------------------------
>> real=C2=A0=C2=A0=C2=A0=C2=A0 65.5=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16=
.3 (-75 %)=C2=A0=C2=A0=C2=A0 1.9=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 1.6 (-16 %)
>> user=C2=A0=C2=A0=C2=A0=C2=A0 65.0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 15=
.8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.3=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.5
>> sys=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3.3=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0.2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 2.0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.0
>>
>> Both ZLIB and ZSTD gave the same compression ratio: 1.57
>> compressed image size in both cases: 1.4G
>>
>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>> QAPI part:
>> Acked-by: Markus Armbruster <armbru@redhat.com>
>> ---
>> =C2=A0 docs/interop/qcow2.txt |=C2=A0=C2=A0 1 +
>> =C2=A0 configure=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
>> =C2=A0 qapi/block-core.json=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +-
>> =C2=A0 block/qcow2-threads.c=C2=A0 | 163 +++++++++++++++++++++++++++++++=
++++++++++
>> =C2=A0 block/qcow2.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 7 ++
>> =C2=A0 5 files changed, 174 insertions(+), 2 deletions(-)
>>
>> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
>> index 640e0eca40..18a77f737e 100644
>> --- a/docs/interop/qcow2.txt
>> +++ b/docs/interop/qcow2.txt
>> @@ -209,6 +209,7 @@ version 2.
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Available c=
ompression type values:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0: zlib <https://www.zlib.net/>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1: zs=
td <http://github.com/facebook/zstd>
>> =C2=A0 =C2=A0 =C2=A0 =3D=3D=3D Header padding =3D=3D=3D
>> diff --git a/configure b/configure
>> index e225a1e3ff..fdc991b010 100755
>> --- a/configure
>> +++ b/configure
>> @@ -1861,7 +1861,7 @@ disabled with --disable-FEATURE, default is=20
>> enabled if available:
>> =C2=A0=C2=A0=C2=A0 lzfse=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 support of lzfse compression library
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (for reading lzfse-compressed dm=
g images)
>> =C2=A0=C2=A0=C2=A0 zstd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 support for zstd compression library
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (for migration compression)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (for migration compression and qcow2 clus=
ter=20
>> compression)
>> =C2=A0=C2=A0=C2=A0 seccomp=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 seccomp support
>> =C2=A0=C2=A0=C2=A0 coroutine-pool=C2=A0 coroutine freelist (better perfo=
rmance)
>> =C2=A0=C2=A0=C2=A0 glusterfs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Gluster=
FS backend
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index 1522e2983f..6fbacddab2 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -4293,11 +4293,12 @@
>> =C2=A0 # Compression type used in qcow2 image file
>> =C2=A0 #
>> =C2=A0 # @zlib: zlib compression, see <http://zlib.net/>
>> +# @zstd: zstd compression, see <http://github.com/facebook/zstd>
>> =C2=A0 #
>> =C2=A0 # Since: 5.1
>> =C2=A0 ##
>> =C2=A0 { 'enum': 'Qcow2CompressionType',
>> -=C2=A0 'data': [ 'zlib' ] }
>> +=C2=A0 'data': [ 'zlib', { 'name': 'zstd', 'if': 'defined(CONFIG_ZSTD)'=
 }=20
>> ] }
>> =C2=A0 =C2=A0 ##
>> =C2=A0 # @BlockdevCreateOptionsQcow2:
>> diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
>> index 7dbaf53489..aa133204f0 100644
>> --- a/block/qcow2-threads.c
>> +++ b/block/qcow2-threads.c
>> @@ -28,6 +28,11 @@
>> =C2=A0 #define ZLIB_CONST
>> =C2=A0 #include <zlib.h>
>> =C2=A0 +#ifdef CONFIG_ZSTD
>> +#include <zstd.h>
>> +#include <zstd_errors.h>
>> +#endif
>> +
>> =C2=A0 #include "qcow2.h"
>> =C2=A0 #include "block/thread-pool.h"
>> =C2=A0 #include "crypto.h"
>> @@ -166,6 +171,154 @@ static ssize_t qcow2_zlib_decompress(void=20
>> *dest, size_t dest_size,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0 }
>> =C2=A0 +#ifdef CONFIG_ZSTD
>> +
>> +/*
>> + * qcow2_zstd_compress()
>> + *
>> + * Compress @src_size bytes of data using zstd compression method
>> + *
>> + * @dest - destination buffer, @dest_size bytes
>> + * @src - source buffer, @src_size bytes
>> + *
>> + * Returns: compressed size on success
>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -ENOMEM destin=
ation buffer is not enough to store=20
>> compressed data
>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -EIO=C2=A0=C2=
=A0=C2=A0 on any other error
>> + */
>> +static ssize_t qcow2_zstd_compress(void *dest, size_t dest_size,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const void *sr=
c, size_t src_size)
>> +{
>> +=C2=A0=C2=A0=C2=A0 ssize_t ret;
>> +=C2=A0=C2=A0=C2=A0 ZSTD_outBuffer output =3D { dest, dest_size, 0 };
>> +=C2=A0=C2=A0=C2=A0 ZSTD_inBuffer input =3D { src, src_size, 0 };
>> +=C2=A0=C2=A0=C2=A0 ZSTD_CCtx *cctx =3D ZSTD_createCCtx();
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!cctx) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EIO;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Use the zstd streamed interface for symmetry=
 with decompression,
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * where streaming is essential since we don't =
record the exact
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * compressed size.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 *
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * In the loop, we try to compress all the data=
 into one zstd=20
>> frame.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * ZSTD_compressStream2 potentially can finish =
a frame earlier
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * than the full input data is consumed. That's=
 why we are looping
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * until all the input data is consumed.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 while (input.pos < input.size) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t zstd_ret =3D 0;
>
> dead assignment
>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * ZSTD spec: "You must=
 continue calling ZSTD_compressStream2()
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * with ZSTD_e_end unti=
l it returns 0, at which point you are
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * free to start a new =
frame". We assume that "start a new=20
>> frame"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * means call ZSTD_comp=
ressStream2 in the very beginning or=20
>> when
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * ZSTD_compressStream2=
 has returned with 0.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zstd=
_ret =3D ZSTD_compressStream2(cctx, &output, &input,=20
>> ZSTD_e_end);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (=
ZSTD_isError(zstd_ret)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ret =3D -EIO;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 goto out;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* D=
est buffer isn't big enough to store compressed=20
>> content */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (=
zstd_ret > output.size - output.pos) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ret =3D -ENOMEM;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 goto out;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } while (zstd_ret);
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 /* make sure we can safely return compressed buffer =
size with=20
>> ssize_t */
>> +=C2=A0=C2=A0=C2=A0 assert(output.pos <=3D SSIZE_MAX);
>> +=C2=A0=C2=A0=C2=A0 ret =3D output.pos;
>> +out:
>> +=C2=A0=C2=A0=C2=A0 ZSTD_freeCCtx(cctx);
>> +=C2=A0=C2=A0=C2=A0 return ret;
>> +}
>> +
>> +/*
>> + * qcow2_zstd_decompress()
>> + *
>> + * Decompress some data (not more than @src_size bytes) to produce=20
>> exactly
>> + * @dest_size bytes using zstd compression method
>> + *
>> + * @dest - destination buffer, @dest_size bytes
>> + * @src - source buffer, @src_size bytes
>> + *
>> + * Returns: 0 on success
>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -EIO on any er=
ror
>> + */
>> +static ssize_t qcow2_zstd_decompress(void *dest, size_t dest_size,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co=
nst void *src, size_t src_size)
>> +{
>> +=C2=A0=C2=A0=C2=A0 size_t zstd_ret =3D 0;
>> +=C2=A0=C2=A0=C2=A0 ssize_t ret =3D 0;
>> +=C2=A0=C2=A0=C2=A0 ZSTD_outBuffer output =3D { dest, dest_size, 0 };
>> +=C2=A0=C2=A0=C2=A0 ZSTD_inBuffer input =3D { src, src_size, 0 };
>> +=C2=A0=C2=A0=C2=A0 ZSTD_DCtx *dctx =3D ZSTD_createDCtx();
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!dctx) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EIO;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * The compressed stream from the input buffer =
may consist of more
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * than one zstd frame. So we iterate until we =
get a fully
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * uncompressed cluster.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * From zstd docs related to ZSTD_decompressStr=
eam:
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * "return : 0 when a frame is completely decod=
ed and fully=20
>> flushed"
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * We suppose that this means: each time ZSTD_d=
ecompressStream=20
>> reads
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * only ONE full frame and returns 0 if and onl=
y if that frame
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * is completely decoded and flushed. Only afte=
r returning 0,
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * ZSTD_decompressStream reads another ONE full=
 frame.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 while (output.pos < output.size) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t last_in_pos =3D input=
.pos;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t last_out_pos =3D outp=
ut.pos;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zstd_ret =3D ZSTD_decompress=
Stream(dctx, &output, &input);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * ZSTD manual doesn't =
explicitly state what happens,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * if ZSTD_decompressSt=
ream reads the frame partially.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * But, based on our te=
sts, if we don't fully populate
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the output and have =
read all the frames from the input,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * we end up with error=
 here.
>
> Hmm, based on my test, that's wrong, see below. So, I'd drop the comment.
Yes, you are right. I double checked it. If we have the input fully=20
consumed and
dosen't fill the output fully we end up with infinite loop. I'll drop=20
the comment.
>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ZSTD_isError(zstd_ret)) =
{
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =
=3D -EIO;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 brea=
k;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * The ZSTD manual is v=
ague about what to do if it reads
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the buffer partially=
, and we don't want to get stuck
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * in an infinite loop =
where ZSTD_decompressStream
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * returns > 0 waiting =
for another input chunk. So, we add
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * a paranoid check tha=
t on each step the loop makes some
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * progress.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>
> As my test shows, it's not paranoid. It's really needed. So, I'd drop=20
> (or rewrite) the comment.
>
> And, with dropped dead assignment and these two comments:
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (last_in_pos >=3D input.p=
os &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 last=
_out_pos >=3D output.pos) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =
=3D -EIO;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 brea=
k;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Make sure that we have the frame fully flush=
ed here
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * if not, we somehow managed to get uncompress=
ed cluster
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * greater then the cluster size, possibly beca=
use of its
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * damage.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 if (zstd_ret > 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EIO;
>> +=C2=A0=C2=A0=C2=A0 }
>
> I still don't believe that we need this check. Experiments shows that=20
> yes, it returns 0 after each frame... But experiment is not a guarantee.
> But OK, if you want, keep it.
>
>> +
>> +=C2=A0=C2=A0=C2=A0 ZSTD_freeDCtx(dctx);
>> +=C2=A0=C2=A0=C2=A0 assert(ret =3D=3D 0 || ret =3D=3D -EIO);
>> +=C2=A0=C2=A0=C2=A0 return ret;
>> +}
>> +#endif
>> +
>> =C2=A0 static int qcow2_compress_pool_func(void *opaque)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Qcow2CompressData *data =3D opaque;
>> @@ -217,6 +370,11 @@ qcow2_co_compress(BlockDriverState *bs, void=20
>> *dest, size_t dest_size,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fn =3D qcow2_zlib=
_compress;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> =C2=A0 +#ifdef CONFIG_ZSTD
>> +=C2=A0=C2=A0=C2=A0 case QCOW2_COMPRESSION_TYPE_ZSTD:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fn =3D qcow2_zstd_compress;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +#endif
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abort();
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> @@ -249,6 +407,11 @@ qcow2_co_decompress(BlockDriverState *bs, void=20
>> *dest, size_t dest_size,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fn =3D qcow2_zlib=
_decompress;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> =C2=A0 +#ifdef CONFIG_ZSTD
>> +=C2=A0=C2=A0=C2=A0 case QCOW2_COMPRESSION_TYPE_ZSTD:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fn =3D qcow2_zstd_decompress=
;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +#endif
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abort();
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> diff --git a/block/qcow2.c b/block/qcow2.c
>> index 6cb000be19..3ae9624ba3 100644
>> --- a/block/qcow2.c
>> +++ b/block/qcow2.c
>> @@ -1246,6 +1246,9 @@ static int=20
>> validate_compression_type(BDRVQcow2State *s, Error **errp)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (s->compression_type) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case QCOW2_COMPRESSION_TYPE_ZLIB:
>> +#ifdef CONFIG_ZSTD
>> +=C2=A0=C2=A0=C2=A0 case QCOW2_COMPRESSION_TYPE_ZSTD:
>> +#endif
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
>> @@ -3478,6 +3481,10 @@ qcow2_co_create(BlockdevCreateOptions=20
>> *create_options, Error **errp)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (qc=
ow2_opts->compression_type) {
>> +#ifdef CONFIG_ZSTD
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case QCOW2_COMPRESSION_TYPE_=
ZSTD:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 brea=
k;
>> +#endif
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 error_setg(errp, "Unknown compression type");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto out;
>>
>
>
> ----
> test:
> #include <stdio.h>
> #include <assert.h>
> #include <zstd.h>
> #include <zstd_errors.h>
>
> int main() {
> =C2=A0=C2=A0=C2=A0 char buf1[] =3D "erbebewbwe";
> =C2=A0=C2=A0=C2=A0 char buf2[1000000];
> =C2=A0=C2=A0=C2=A0 char buf3[1000000];
> =C2=A0=C2=A0=C2=A0 int ret;
>
> =C2=A0=C2=A0=C2=A0 ZSTD_outBuffer output =3D { buf2, sizeof(buf2), 0 };
> =C2=A0=C2=A0=C2=A0 ZSTD_inBuffer input =3D { buf1, 5, 0 };
> =C2=A0=C2=A0=C2=A0 ZSTD_CCtx *cctx;
>
> =C2=A0=C2=A0=C2=A0 cctx =3D ZSTD_createCCtx();
> =C2=A0=C2=A0=C2=A0 assert(cctx);
>
> =C2=A0=C2=A0=C2=A0 ret =3D ZSTD_compressStream2(cctx, &output, &input, ZS=
TD_e_end);
>
> =C2=A0=C2=A0=C2=A0 printf("ret1: %d\n");
>
>
> =C2=A0=C2=A0=C2=A0 input =3D (ZSTD_inBuffer){ buf1, 5, 0 };
> =C2=A0=C2=A0=C2=A0 ret =3D ZSTD_compressStream2(cctx, &output, &input, ZS=
TD_e_end);
> =C2=A0=C2=A0=C2=A0 printf("ret2: %d\n");
>
> =C2=A0=C2=A0=C2=A0 ZSTD_freeCCtx(cctx);
>
> =C2=A0=C2=A0=C2=A0 // Now, we have written at least two frames.
>
> =C2=A0=C2=A0=C2=A0 printf("output.pos: %ld\n", output.pos);
>
> =C2=A0=C2=A0=C2=A0 ZSTD_DCtx *dctx =3D ZSTD_createDCtx();
>
> =C2=A0=C2=A0=C2=A0 input =3D (ZSTD_inBuffer){buf2, output.pos, 0};
> =C2=A0=C2=A0=C2=A0 output =3D (ZSTD_outBuffer){buf3, sizeof(buf3), 0};
>
> =C2=A0=C2=A0=C2=A0 ret =3D ZSTD_decompressStream(dctx, &output, &input);
>
> =C2=A0=C2=A0=C2=A0 printf("ret: %d, input.pos: %ld, output.pos: %ld\n", r=
et,=20
> input.pos, output.pos);
>
> =C2=A0=C2=A0=C2=A0 ret =3D ZSTD_decompressStream(dctx, &output, &input);
>
> =C2=A0=C2=A0=C2=A0 printf("ret: %d, input.pos: %ld, output.pos: %ld\n", r=
et,=20
> input.pos, output.pos);
>
> =C2=A0=C2=A0=C2=A0 ret =3D ZSTD_decompressStream(dctx, &output, &input);
>
> =C2=A0=C2=A0=C2=A0 printf("ret: %d, %d, input.pos: %ld, output.pos: %ld\n=
", ret,=20
> ZSTD_isError(ret), input.pos, output.pos);
>
> =C2=A0=C2=A0=C2=A0 ret =3D ZSTD_decompressStream(dctx, &output, &input);
>
> =C2=A0=C2=A0=C2=A0 printf("ret: %d, %d, input.pos: %ld, output.pos: %ld\n=
", ret,=20
> ZSTD_isError(ret), input.pos, output.pos);
>
> =C2=A0=C2=A0=C2=A0 return 0;
> }
>
> compile:
> gcc -lzstd -g a.c
>
> output:
> [root@kvm zstd]# ./a.out
> ret1: 1
> ret2: 1
> output.pos: 28
> ret: 0, input.pos: 14, output.pos: 5
> ret: 0, input.pos: 28, output.pos: 10
> ret: 9, 0, input.pos: 28, output.pos: 10
> ret: 9, 0, input.pos: 28, output.pos: 10
>
>
> So, as you can see, last two decompress'es shows, that we still not=20
> fully populate the output, nothing more in the input, and it returns=20
> not-error... It returns 9. Interesting :)
>
>


