Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB8FC43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 11:22:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C545F2063A
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 11:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LOWJmueB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C545F2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJbS4-000161-0B
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 07:22:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33457)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJbRB-0000bY-Qi
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 07:21:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJbRA-000615-8Y
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 07:21:37 -0400
Received: from mail-eopbgr00113.outbound.protection.outlook.com
 ([40.107.0.113]:11191 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jJbR4-0005yZ-HU; Wed, 01 Apr 2020 07:21:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rl6fKyKXz+UhUBFvYvJtTgMWQYCrhog9b7uomijsX6LPFNL5kFwkf31cubkmJZ0ECeGyXxDeXRRUn8LW1Jzm6WFWlPJxXG4VGcEPFpptj4gt9m7KSHphR3OIIdZzABVCqCrRRHW5BMm+vW8ZP77FGQj48yNebG+3SSgDSPIaNZCAR2Fy6tKOHdV5Q46+VF4SmpvTjauNpwSthN4JciVnUcEBZ+q8knxKrpzMgHcn83vX+Fhl7byCf2Gts3G+CuSo+cwOY4ZJLRk3c8y+LfxXtf3s6FWtYrKpUSWra0xJd2ilmRtDdUp7k41/BeQl3Ct2JqkEynBVgyZktvr1XRQ6VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Zq4f765ywyAYukakTx9N1p46/BAd42L77irPzqvZj8=;
 b=CefRI358TDHTaLbwUBk8gLuORgnUaxSYes84vChHLIoyIjMKf7pbSkOJ2tVaWlu8zHJ1DtmleT1PSjSclw21xxDaMS4mYROTIU1c8z7FmVeuJ0M+pE5f81EIHTTfIyT9qynU0fzTuJLsYHSI3KcdxFJ4EF6zZQq0TVT1BkhhbmrTSUBV+1pHoATtEarT12ppV4oVc6K1MAFliFuZSDHHecur+79iPo7YgZhVMVj5y8UOSepkf35fJib3KYTMOahMS4lGszIw+qg7ndyGC7oBrxbFgAe9RZ3v7rIYGFJKH/c8xHhVNnmAdS+HmwSkAAb8zbXEXpC0rG80+tsXlLCLVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Zq4f765ywyAYukakTx9N1p46/BAd42L77irPzqvZj8=;
 b=LOWJmueB64aXtjZGqzdjT0yDgh+/k5Br1THA+wmuNBVn1YtMI374cWAt7fm8AN9ttcEOzY5aAVX9tKRF5qVm8YlJPRkQn1pIzAExgZ3uQbjSObgYl44LON35Zz6rp9UmXhXY8X62tVV88ZmkztkoqlEDqrzCA8JXlXgLbJySHYw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5352.eurprd08.prod.outlook.com (10.141.174.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Wed, 1 Apr 2020 11:21:27 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%8]) with mapi id 15.20.2878.014; Wed, 1 Apr 2020
 11:21:27 +0000
Subject: Re: [PATCH v14 3/4] qcow2: add zstd cluster compression
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200331174455.31792-1-dplotnikov@virtuozzo.com>
 <20200331174455.31792-4-dplotnikov@virtuozzo.com>
 <434f359a-998f-1c60-ecad-fa6cb25e9374@virtuozzo.com>
 <aee58e22-cddb-0cff-4044-f558f207a30d@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200401142125695
Message-ID: <54c95fa9-012c-8217-39f3-88f84e605213@virtuozzo.com>
Date: Wed, 1 Apr 2020 14:21:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <aee58e22-cddb-0cff-4044-f558f207a30d@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM3PR05CA0119.eurprd05.prod.outlook.com
 (2603:10a6:207:2::21) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.23) by
 AM3PR05CA0119.eurprd05.prod.outlook.com (2603:10a6:207:2::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.19 via Frontend Transport; Wed, 1 Apr 2020 11:21:26 +0000
X-Tagtoolbar-Keys: D20200401142125695
X-Originating-IP: [185.215.60.23]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdcbc14f-da28-47f8-eea1-08d7d62ed1da
X-MS-TrafficTypeDiagnostic: AM7PR08MB5352:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5352FADCD92D0685D4694523C1C90@AM7PR08MB5352.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03607C04F0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(376002)(396003)(366004)(346002)(39840400004)(136003)(186003)(4326008)(8676002)(31686004)(26005)(5660300002)(956004)(81156014)(81166006)(16576012)(36756003)(86362001)(16526019)(316002)(66946007)(2616005)(66556008)(66476007)(6486002)(478600001)(31696002)(2906002)(53546011)(52116002)(8936002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yGX9VEmzjN4kidE4WgpWu93iZfcE6iRyMg6hTRBoG3wg86MaLJZQhKxuCZIz635z81IS+jOljPZ1GfhIm56Z9HLBlytqPFvQKbzRqyok29Vh1XLMLKKWOXo1aaj9SlDav0wEg5x5uKl0rftJ3GVMz+7K8j12Es9fXlO60T4Jx9rnSJwGrG6fCMEueL2UqSoZmZ18YVDP1UU7gDr/1GeBgMsn3VJNHrSGdDWTi/ezx4ikikI0Sr/uuEyu12EtDWlhdIJJtzJETQbYst146W2YhGkAu9CSpMmot2y7D86jhKjyt09LaOPNXMBFVE55j3j+CoxxnfvegjwEpJqPvhLKop+yRHXVZ7DOirXrda4vBgbpXfDFYVdg3jprK/xmTwgTgPfu4Wz+bmXXBaCRGWMhOdnsvO99Ok81j3ssJ7WRqYuNtB9uNe90sclhdRgXuEq/
X-MS-Exchange-AntiSpam-MessageData: VTSmcwmAt/pEFcQKzoAGEkGONFb0WfIfwH3k6bb3knoleR1Em49SJAeB0QQ7WBwnsf1mY5utUOyk90NFtNKLzhk3dkPr1Ddcye0Awl/oJZvAaMa/ggfcOLbOp/E/HM7X/LxQ3VNngJcG9Aj13VjQFQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdcbc14f-da28-47f8-eea1-08d7d62ed1da
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2020 11:21:27.6807 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2pjDPnAWpQQTyBQjH/IxwB3GMocV4+T9ZHwRX/vhQyVOJM0d0k1obZuHvgbxQUKTVL4Sh9QYSmAOlom6dPRG7RfnPJog1n3joRN8C/y+KkE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5352
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.0.113
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

01.04.2020 10:02, Denis Plotnikov wrote:
>=20
>=20
> On 01.04.2020 08:49, Vladimir Sementsov-Ogievskiy wrote:
>> 31.03.2020 20:44, Denis Plotnikov wrote:
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
>>
>>
>> [..]
>>
>>> +static ssize_t qcow2_zstd_compress(void *dest, size_t dest_size,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const void *sr=
c, size_t src_size)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 ssize_t ret;
>>> +=C2=A0=C2=A0=C2=A0 size_t zstd_ret =3D 0;
>>> +=C2=A0=C2=A0=C2=A0 ZSTD_outBuffer output =3D { dest, dest_size, 0 };
>>> +=C2=A0=C2=A0=C2=A0 ZSTD_inBuffer input =3D { src, src_size, 0 };
>>> +=C2=A0=C2=A0=C2=A0 ZSTD_CCtx *cctx =3D ZSTD_createCCtx();
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!cctx) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EIO;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * We want to use zstd streamed interface on d=
ecompression,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * as we won't know the exact size of the comp=
ressed data.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * In the loop, we try to compress all the dat=
a into one zstd frame.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * ZSTD_compressStream2 potentially can finish=
 a frame earlier
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * than the full input data is consumed. That'=
s why we are looping
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * until all the input data is consumed.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0 while (input.pos < input.size) {
>>
>> zstd_ret may be defined here.
> yep!
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * ZSTD spec: "You mus=
t continue calling ZSTD_compressStream2()
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * with ZSTD_e_end unt=
il it returns 0, at which point you are
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * free to start a new=
 frame". We assume that "start a new frame"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * means call ZSTD_com=
pressStream2 in the very beginning or when
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * ZSTD_compressStream=
2 has returned with 0.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do {
>>
>> Hmm. Why did you decide to use nested loop?=C2=A0 Ok, it works too.
> The previous condition was error prone. It led to loop ending once we fin=
ished the "first frame"
> but there could be a number of them.
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zst=
d_ret =3D ZSTD_compressStream2(cctx, &output, &input, ZSTD_e_end);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
(ZSTD_isError(zstd_ret)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ret =3D -EIO;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 goto out;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* =
Dest buffer isn't big enough to store compressed content */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
(zstd_ret > output.size - output.pos) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ret =3D -ENOMEM;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 goto out;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } while (zstd_ret);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 /* make sure we can safely return compressed buffer=
 size with ssize_t */
>>> +=C2=A0=C2=A0=C2=A0 assert(output.pos <=3D SSIZE_MAX);
>>> +=C2=A0=C2=A0=C2=A0 ret =3D output.pos;
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
>>
>> You forget to fix ret here. ret of the function should be ssize_t and fo=
r
>> ZSTD - size_t.
> I decided not to use two vars since we can return only 0 or -EIO. I added=
 an assert at the very end of the function to check it.

But size_t is unsigned type. Bad idea to assign -EIO to it. And that's why =
we've moved to zstd_ret in _compress

>=20
>>
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
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * from zstd docs related to ZSTD_decompressSt=
ream:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * "return : 0 when a frame is completely deco=
ded and fully flushed"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * We suppose that this means: each time ZSTD_=
decompressStream reads
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * only ONE full frame and return 0 if and onl=
y if that frame
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * is completely decoded and flushed. Only aft=
er returning 0,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * ZSTD_decompressStream reads another ONE ful=
l frame.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0 while (output.pos < output.size) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t last_in_pos =3D inpu=
t.pos;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t last_out_pos =3D out=
put.pos;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D ZSTD_decompressStre=
am(dctx, &output, &input);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * zstd manual doesn't=
 explicitly states what happens,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * if ZSTD_decompressS=
tream reads the frame partially.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * But, based on our t=
ests, if we don't fully populate
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the output and have=
 read all the frames from the input,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * we end up with erro=
r here.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ZSTD_isError(ret)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
 =3D -EIO;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bre=
ak;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * As ZSTD manual is v=
ague about what to do if it
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * reads the buffer pa=
rtially, we afraid of case
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * when we stuck in th=
e infinite loop, because
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * output isn't full a=
nd input has read partially, so
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * ZSTD_decompressStre=
am returns > 0 waiting for
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * another input chunk=
. So, we add a paranoid check
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * that on each step t=
he loop makes some progress.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (last_in_pos >=3D input.=
pos &&
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 las=
t_out_pos >=3D output.pos) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
 =3D -EIO;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bre=
ak;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Make sure that we have the frame fully flus=
hed here
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * if not, we somehow managed to get uncompres=
sed cluster
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * greater then the cluster size, possibly bec=
ause of its
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * damage.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0 if (ret > 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EIO;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 ZSTD_freeDCtx(dctx);
>>> +=C2=A0=C2=A0=C2=A0 assert(ret =3D=3D 0 || ret =3D=3D -EIO);
>>> +=C2=A0=C2=A0=C2=A0 return ret;
>>> +}
>>
>>
>> [..]
>>
>>
>=20


--=20
Best regards,
Vladimir

