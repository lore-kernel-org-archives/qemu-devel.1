Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505BEC2D0E8
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 06:23:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 091A820776
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 06:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vKZtYe/x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 091A820776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJAJL-0000oh-1D
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 02:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45778)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJAIb-0000KR-90
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 02:22:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJAIY-00060z-Qn
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 02:22:57 -0400
Received: from mail-am6eur05on2137.outbound.protection.outlook.com
 ([40.107.22.137]:56224 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jJAIR-0005wn-F2; Tue, 31 Mar 2020 02:22:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ElM1l8Jioa8FS1vcLZj6sX8fhyfW3TrAneIgD1y8aW6SNpbF1FlGr3vrAnFVvJo1tnXPvQsUoL2zjfiA/8vA8BZa4lH/jPM43/ehOts4soYRSVq85g1nJXxY6mncVd1dz9tx77VAesKSVmReWIxmYW26LvAXffOXEfw2E07Nn49Om5awLtjCi6f9ALX8y92Hzfu8LRsMqJE2MgECgXRnociGOB06u3eZvDue29uX4xX+4Das53zCsXziwCc9Xm8MSTl7r8JKwfF9I0pncFFdskOoArLMI+BHyw4omNHsUvSRIDBNKBMohR7g0QB6LGC+AQCL07pnEJ/WKW9w4rLIYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCYlFdEPvEyA8pXatXCvTfzRJQfK46H+BsBv9FYnWVo=;
 b=Z9WMdzUXkFCdCiIFsnzC9GKCwJP8GD5MQJ0+No9CyiSWoveRFib1WkvapNd/KJp1mS9A0LDM6ocRSUGrT3fbACTkIO6dDCAEXjvvbHDE9ZS2d51Y/9tp2W4q26Gk8nelpng/wFwmVjnkztlwx8iAhdcwzBR2fdl6I1TTgm/vn381TCH4wqPAFU+xqeo7UtlWK9CWpiaNSRtrBYTn4j1B5Kz+aLSgSw+88J91Pa2ZU8lhQD8h1kDY5O6f6N6UsuHyA06IjWMcxnkn6oP0rRdkafB0Jlu3x3yTwzB+97L44uOuJ351FcrWqqIDIeu86ueCwpYo08LltNL7n8fFqVYHOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCYlFdEPvEyA8pXatXCvTfzRJQfK46H+BsBv9FYnWVo=;
 b=vKZtYe/xtS3mnmxaAc/7I+JhHbCAOnfdu4E9WmPerxR8RnnWccU66oO6Rude2xscXtLcaAOuhf8sddAjawTXLfh3JhESwlVFaMj+zH1FqEPgJhylX0C3LMGLc7Zl6gj/iISamjPgaYs7WQ7yh+J92prgZOQBnIpJ9yBzzhb2RsU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5511.eurprd08.prod.outlook.com (10.141.174.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Tue, 31 Mar 2020 06:22:44 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%9]) with mapi id 15.20.2856.019; Tue, 31 Mar 2020
 06:22:44 +0000
Subject: Re: [PATCH v11 3/4] qcow2: add zstd cluster compression
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200330095429.26974-1-dplotnikov@virtuozzo.com>
 <20200330095429.26974-4-dplotnikov@virtuozzo.com>
 <3c367b69-0db7-bac6-6ea8-915114df1e01@virtuozzo.com>
 <83d7a7f3-2fdd-2546-1e63-297d8c404496@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200331092242973
Message-ID: <08227565-8b4a-f496-0d66-af339d0bd667@virtuozzo.com>
Date: Tue, 31 Mar 2020 09:22:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <83d7a7f3-2fdd-2546-1e63-297d8c404496@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR0102CA0025.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:14::38) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.2) by
 AM0PR0102CA0025.eurprd01.prod.exchangelabs.com (2603:10a6:208:14::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend
 Transport; Tue, 31 Mar 2020 06:22:44 +0000
X-Tagtoolbar-Keys: D20200331092242973
X-Originating-IP: [185.215.60.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2f5f10c-479f-4d0c-2a5a-08d7d53bec9c
X-MS-TrafficTypeDiagnostic: AM7PR08MB5511:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB55111C3CFA1C67F60C37D228C1C80@AM7PR08MB5511.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0359162B6D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(396003)(346002)(366004)(376002)(39850400004)(136003)(316002)(31686004)(16576012)(478600001)(4326008)(66476007)(66946007)(66556008)(8936002)(86362001)(8676002)(81166006)(81156014)(36756003)(186003)(2906002)(5660300002)(19273905006)(31696002)(30864003)(52116002)(53546011)(6486002)(26005)(16526019)(2616005)(956004)(563064011);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +H1f4uB5QuRQJIV/KWseX7/1YSGKZKPWPHhjIIZYpp4XkfjwZcDKTKx1YXnSa+C4/u7aXtZB4R471r2Cg8dFBCnGKBZvObDIwUy1/w2+kxm1EoHpMlt3tDJmKNhe6Ni5mXpZWTV8OdIpCcqf/MjkDbGUNbtjNLMnvXdPJBUbfcRqg+D6w9KCEM63N6EtXSvsAU3kA8NSSl6417aq/He4w3hdKTtsXWVD3eN22UX/j40VLmULpYxW4eAno+UY969ByY/QhNRth7McGbRDa5QtSUdvWLYd6wTEVSp99OiHUTcCFxgUhHG8SgRl7plcMd+CKlZBF6f5RWMeut6YDp6AdD1decpibAj24KWp4uDFllG3zB2yTQheUiO6/VI7k3wfmUDQ7jMfMmvbkwHjHndAIKhopB0Yl8VlFodxxMBh57Y1YGdS8R26GutLvs3wV1wwStSOYpBiHGa59dolcAaMPEh+7hylD4wO1ByXd2am/k9XgLDVNG9ez4OJ69RAurdSnXrxBwRgBBNFYT3UnQfjnsgb/uRAiCd16q3+OVWcoMKIrD2weeSfoDGCfHjseNnj
X-MS-Exchange-AntiSpam-MessageData: 9S8Ue+nAxUoUS+YoTIKurkwhkdszd7F5EWdKBwWEBJn+DjrWdGzLN+fP2/MwkICwXWQp9P6fbvRnPyHpfotohRy7k/qwXnY8DlJHEeW2Lw0YVfDL+/73XkPYMFaHxBeiN5hqPiLB+vBT4jXOSt7RWA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2f5f10c-479f-4d0c-2a5a-08d7d53bec9c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2020 06:22:44.8167 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BiUR/aH14cUN4SffgRN9EIG7EAJREo4J4AfW9lNp1Q3SFpGEboa/IFWo5O6Ikod0exHbbihvAVS8dY72ku8WZAFTy7m1uFj9fZuho6p61gM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5511
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.22.137
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

30.03.2020 18:04, Denis Plotnikov wrote:
>=20
>=20
> On 30.03.2020 16:14, Vladimir Sementsov-Ogievskiy wrote:
>> 30.03.2020 12:54, Denis Plotnikov wrote:
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
>>> QAPI part:
>>> Acked-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>> =C2=A0 docs/interop/qcow2.txt |=C2=A0=C2=A0 1 +
>>> =C2=A0 configure=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
>>> =C2=A0 qapi/block-core.json=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +-
>>> =C2=A0 block/qcow2-threads.c=C2=A0 | 138 ++++++++++++++++++++++++++++++=
+++++++++++
>>> =C2=A0 block/qcow2.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 7 +++
>>> =C2=A0 5 files changed, 149 insertions(+), 2 deletions(-)
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
>>> index da09c35895..57cac2abe1 100755
>>> --- a/configure
>>> +++ b/configure
>>> @@ -1861,7 +1861,7 @@ disabled with --disable-FEATURE, default is enabl=
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
>>> index d669ec0965..44690ed266 100644
>>> --- a/qapi/block-core.json
>>> +++ b/qapi/block-core.json
>>> @@ -4293,11 +4293,12 @@
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
>>> index 7dbaf53489..b8ccd97009 100644
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
>>> @@ -166,6 +171,129 @@ static ssize_t qcow2_zlib_decompress(void *dest, =
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
>>> +=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * ZSTD spec: "You must continue calling ZSTD_=
compressStream2()
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * with ZSTD_e_end until it returns 0, at whic=
h point you are
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * free to start a new frame".
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * In the loop, we try to compress all the dat=
a into one zstd frame.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * ZSTD_compressStream2 can potentially finish=
 a frame earlier
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * than the full input data is consumed. That'=
s why we are looping
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * until all the input data is consumed.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0 while (input.pos < input.size) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * zstd simple interfa=
ce requires the exact compressed size.
>>
>> on decompression you mean
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * zstd stream interfa=
ce reads the comressed size from
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the compressed stre=
am frame.
>>
>> compressed size is not stored in the stream. I think, that streamed
>> interface just decompress until it have something to decompress and
>> have space to write output.
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Instruct zstd to co=
mpress the whole buffer and write
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the frame which inc=
ludes the compressed size.
>>
>> I think this is wrong. compression size is not written.
> Ok
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * This allows as to u=
se zstd streaming semantics and
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * don't store the com=
pressed size for the zstd decompression.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>
>> Comment is just outdated. Accordingly to our off-list discussion, I'd
>> rewrite it like this:
>>
>> We want to use streamed interface on decompression, as we will not know
>> exact size of compression data.=20
> This one is better then mine.
>> Use streamed interface for compression
>> just for symmetry.
> I think this one is exceeding. If we have stream family functions on both=
 sides this won't rise any questions from the reader.
>=20
>>
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D ZSTD_compressStream=
2(cctx, &output, &input, ZSTD_e_end);
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
>>
>> Here you use "@return provides a minimum amount of data remaining to be =
flushed from internal buffers
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 or an=
 error code, which can be tested using ZSTD_isError()."
>>
>> I think we can safely drop this check
> No, we can't.
> we should check for if zstd managed to write the stream correctly. ZSTD_c=
ompressStream2 may consume all the input buffer but return ret > 0 meaning =
that it needs more space.

Hmm, interesting thing. But your check doesn't protect us from it:

Assume we have

output.size =3D input.size =3D 64K
output.pos =3D 64K
input.pos =3D 10K
ret =3D 10K

- which means that all input is consumed, but we have some cached data (at =
least 10K) to flush.

10K + 10K =3D 20K < 64K, so your check will no lead to an error, but we'll =
exit the loop..

So, actually, what we need it two things:

   1. input.pos =3D input.size, which means that all input is consumed
   2. ret =3D 0, which means that all cached data flushed

So we need something like

do {
    ret =3D ZSTD_compressStream2(cctx, &output, &input, ZDTD_e_end)
    if (ZSTD_isError(ret)) {
        ret =3D -EIO.
        goto out;
    }
} while (ret || input.pos < input.size);

>=20
> This is from my tests:
>=20
> (gdb) p ret
> $1 =3D 11
> (gdb) p input
> $2 =3D {src =3D 0x562305536000, size =3D 65536, pos =3D 65536}
> (gdb) p output
> $3 =3D {dst =3D 0x562305546000, size =3D 65535, pos =3D 65535}
>=20
> Alternatively, we can replace the check with something like
>=20
> if (ret !=3D 0) {
>  =C2=A0=C2=A0=C2=A0 ret =3D -ENOMEM;
> }

It's not correct either, it's not an error: it just means that we need to f=
lush a bit more data.

>=20
> after the loop, but I think both are equivalent, so I would stick with my=
 one :)))
>> work anyway.
>>
>>> +=C2=A0=C2=A0=C2=A0 };
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* make sure we can safely return compressed buffer=
 size with ssize_t */
>>> +=C2=A0=C2=A0=C2=A0 assert(output.pos <=3D SSIZE_MAX);
>>
>> Hmm. I hope it's not possible for cluster. But taking the function in se=
parate, it _is_ possible.
>> So may be better to assert at function start that
>>
>> =C2=A0 assert(dest_size <=3D SSIZE_MAX);
>>
>> To stress, that this limitation is part of qcow2_zstd_compress() interfa=
ce.
> Agree, this is better
>>
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
>>> +=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * The compressed stream from input buffer may=
 consist from more
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * than one zstd frames. So we iterate until w=
e get a fully
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * uncompressed cluster.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0 while (output.pos < output.size) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D ZSTD_decompressStre=
am(dctx, &output, &input);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * if we don't fully p=
opulate the output but have read
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * all the frames from=
 the input, we end up with error
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * here
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ZSTD_isError(ret)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
 =3D -EIO;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bre=
ak;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Dest buffer size is=
 the image cluster size.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * It should be big en=
ough to store uncompressed content.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * There shouldn't be =
any cases when the decompressed content
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * size is greater the=
n the cluster size, except cluster
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * damaging.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (output.pos + ret > outp=
ut.size) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
 =3D -EIO;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bre=
ak;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> But here, you use
>> "
>> or any other value > 0, which means there is still some decoding or flus=
hing to do to complete current frame :
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the return value is a suggested nex=
t input size (just a hint for better latency)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 that will never request more than t=
he remaining frame size.
>> "
>>
>> I'm afraid that "just a hint" is not safe API to make a conclusion from.=
 So, I'd prefer to drop this optimization
>> and just wait for an error from next ZSTD_decompressStream.
>>
>> And therefore, for symmetry drop similar optimization on compression par=
t..
>>
>> What do you think?
> I'd add some kind of check that we have finished with ret=3D=3D0 (after l=
oop). It looks like this is the only case when we can be sure that everythi=
ng went ok.

I think, we should not check it. It is possible that compressed data of ano=
ther cluster is starting below input end. Is it guaranteed that ZSTD_decomp=
ressStream will not start to decompress (or at least plan to do it) the nex=
t frame, which is unrelated to our cluster? I'm afraid it's not guaranteed,=
 so we can get ret>0 when output.pos=3Doutput.size in correct situation. So=
 I think it's safer not to add this final check for ret. Note that we are n=
ot protected from wrong data anyway.

>>
>>
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 ZSTD_freeDCtx(dctx);
>>> +=C2=A0=C2=A0=C2=A0 return ret;
>>> +}
>>> +#endif
>>> +
>>> =C2=A0 static int qcow2_compress_pool_func(void *opaque)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Qcow2CompressData *data =3D opaque;
>>> @@ -217,6 +345,11 @@ qcow2_co_compress(BlockDriverState *bs, void *dest=
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
>>> @@ -249,6 +382,11 @@ qcow2_co_decompress(BlockDriverState *bs, void *de=
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
>>> index 643698934d..6632daf50b 100644
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
>>> @@ -3461,6 +3464,10 @@ qcow2_co_create(BlockdevCreateOptions *create_op=
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

