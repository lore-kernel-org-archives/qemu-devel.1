Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED573C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 14:06:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6C552067C
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 14:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="cXmcHVvW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6C552067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixWvr-0002HK-RW
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 09:06:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41260)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ixWv3-0001av-Kw
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 09:05:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ixWv0-0004fF-Kv
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 09:05:13 -0500
Received: from mail-eopbgr70102.outbound.protection.outlook.com
 ([40.107.7.102]:5182 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ixWuz-0004ZH-Ux; Fri, 31 Jan 2020 09:05:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imAg0TNQ5lhVHG8meAyDw2jnSBNYbSASboNNDtsl1Yf4cFnzmDs6we8LUhaop88ztbrTJscw6wShvB37Gswpig9Hor/RYqim5Mqv66iZnKhSZMHPE0OfEerUI9fwWPDIojjHENWhdCNEvXBlcywZ6JaUhEdLSz4brFC/3Sv1df/Jbrpb29XuWMF66a2EQACj4xZ+Lf0gu5eN0GXckjJTRZzmAmjlWNnGwD3Hx+Cm/1X/l5GAh46ncuCAhVdeiEfOkbah4lEvtT87C9SdoLv/YsNiBMFN3VpJqPjotFu1qpXcAG0w+2eR+/0ZK3edq9Pg4N+gPEyrkDPBF31pM1w4dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XkppIXkn6G9Fz5BnMFEOr1QakQz09QTmR4Hmb9umY4=;
 b=FWqoensOFgIXQHYobvVPlAxfnYkqvwzEN/U7+jHCDs+NBghYQdsExqAivwLcISy/ax1KnSCwp+xy+wFSNT3/1m8rY1+7kUw1cWQrNKTsXgzq1YCY+hFBQ6LjdvKwFTpNMrpuXo9MygpixL4G/UeQDNNxR5Z5Yp7jbpHt0ANFf1JcnsIr4krSx2XoIz2mahEE1cPrrcLG2buB6CrZFPdxQoocKlcdLY2sNp6HxjWDNHfwL6mmuiHrQ0tF8YZzAtilBfdZ6wnnakhqHw2FHx2uJHMa84UtwFWTBw66MVLDCLY3znfwz7oDjd9jHKXY+Zca/291iD3N0F9IO0c7G7Pfvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XkppIXkn6G9Fz5BnMFEOr1QakQz09QTmR4Hmb9umY4=;
 b=cXmcHVvWG2uOtt0/qrjIj2zIqXM7ek7BJmXiAUoruQWtmSXgv8/ZzX67lwGgOR/EKCWUj9mupS75RP6gkYn3/y0orURDUOx6HTpfyd6bs0l7MiLlISkHEN2fgOE7mEsFkeGOzN3t/cBJkss3rH+NKi5FxaEEZpmjeFludmVbLqU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4053.eurprd08.prod.outlook.com (20.179.2.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.19; Fri, 31 Jan 2020 14:05:06 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2686.028; Fri, 31 Jan 2020
 14:05:06 +0000
Subject: Re: [PATCH v10 1/2] docs: improve qcow2 spec about extending image
 header
To: Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org
References: <20200120171345.24345-1-vsementsov@virtuozzo.com>
 <20200120171345.24345-2-vsementsov@virtuozzo.com>
 <e457c8c4-ae37-9b30-5580-40b34bbf458c@redhat.com>
 <92ff41e1-be36-ddd3-e46d-a867096b6865@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200131170504694
Message-ID: <11f6e7e3-e4e6-2751-297a-aec64e95d5af@virtuozzo.com>
Date: Fri, 31 Jan 2020 17:05:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <92ff41e1-be36-ddd3-e46d-a867096b6865@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR0402CA0051.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::40) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0402CA0051.eurprd04.prod.outlook.com (2603:10a6:7:7c::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29 via Frontend Transport; Fri, 31 Jan 2020 14:05:06 +0000
X-Tagtoolbar-Keys: D20200131170504694
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b47ac84-c01c-461e-a200-08d7a6569373
X-MS-TrafficTypeDiagnostic: AM6PR08MB4053:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4053AE820B4A45CCF9EF61D4C1070@AM6PR08MB4053.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 029976C540
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(39850400004)(366004)(376002)(346002)(136003)(396003)(199004)(189003)(4326008)(8676002)(6486002)(26005)(31686004)(53546011)(107886003)(2906002)(36756003)(478600001)(66556008)(31696002)(66476007)(86362001)(110136005)(81156014)(52116002)(2616005)(956004)(316002)(16576012)(5660300002)(81166006)(8936002)(186003)(16526019)(66946007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4053;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oDAWSX8rLV1Mxc25TMA0dP3e9UXquSXla8+7PZvr0G7BkEukzVbHspmWFGGogM1x4/v2BJr5k+RRqsCOYzwD5BgSGdsePId+IjaVew33YQnXsaVv+O3LWo0VTKzedlLxn96urrJK4uI0KwxNEVa2CJE84Ei3Bh2mJ2fBgo1sY7MVBpbRAOTNEObuq1umroCmFfQXZI+RaAGg0tRVhPwtHXx61UMtMuPlNLGwPoAtocRv2qti4ewMuGOPHcD7aLto4yhtYwOMskQmcx4J/IXtOaMkKWPpLUszl0WR1pFKtdz6dwgFp6BJNWfer5pCgAJqERDY3x9AXhajq7vFbm57uOoAwziiBp0uIDHGfS/LSfKCF9e2Nh6ymG18nYlXbteItQRiOQwTBdFpS2+Tf14qyRKBKSPiDO8zkXmLLxs8D0shCz0lNZkgIbMXN73gLrnc
X-MS-Exchange-AntiSpam-MessageData: IB8BaS1K5daL1j+eGnzeE2Mgjn1vRNSHO6CynPAxXxyJhtz9WWQcjr/DMGejwS0r/DSTZuvpOxUGWy8QTh4zVZzsRIai8BXXy86nWgshJfNkRVfPCNfmicMM+RlvpDhvgZ3bqEsoeMTbuIwztW5vNg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b47ac84-c01c-461e-a200-08d7a6569373
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2020 14:05:06.8710 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1/16u2GrTSNggW0B9EV3O3dHnaqhPoUdoj/1oTxFfbKlJmj9f+bRMvPj5MDmUr3My47jfM7a68kFZiqPPiLev0ZDn/SG9JxLiiNCD5gMMqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4053
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.102
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
Cc: kwolf@redhat.com, den@openvz.org, dplotnikov@virtuozzo.com,
 qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

21.01.2020 19:18, Max Reitz wrote:
> On 20.01.20 20:42, Eric Blake wrote:
>> On 1/20/20 11:13 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> Make it more obvious how to add new fields to the version 3 header and
>>> how to interpret them.
>>>
>>> The specification is adjusted so for new defined optional fields:
>>
>> s/so for/so that for/
>>
>>>
>>> 1. Software may support some of these optional fields and ignore the
>>>  =A0=A0=A0 others, which means that features may be backported to downs=
tream
>>>  =A0=A0=A0 Qemu independently.
>>> 2. If we want to add incompatible field (or a field, for which some its
>>>  =A0=A0=A0 values would be incompatible), it must be accompanied by
>>>  =A0=A0=A0 incompatible feature bit.
>>>
>>> Also the concept of "default is zero" is clarified, as it's strange to
>>> say that the value of the field is assumed to be zero for the software
>>> version which don't know about the field at all and don't know how to
>>> treat it be it zero or not.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>>  =A0 docs/interop/qcow2.txt | 44 ++++++++++++++++++++++++++++++++++++++=
+---
>>>  =A0 1 file changed, 41 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
>>> index af5711e533..355925c35e 100644
>>> --- a/docs/interop/qcow2.txt
>>> +++ b/docs/interop/qcow2.txt
>>> @@ -79,9 +79,9 @@ The first cluster of a qcow2 image contains the file
>>> header:
>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Offset=
 into the image file at which the snapshot
>>> table
>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 starts=
. Must be aligned to a cluster boundary.
>>>  =A0 -If the version is 3 or higher, the header has the following
>>> additional fields.
>>> -For version 2, the values are assumed to be zero, unless specified
>>> otherwise
>>> -in the description of a field.
>>> +For version 2, the header is exactly 72 bytes in length, and finishes
>>> here.
>>> +For version 3 or higher, the header length is at least 104 bytes,
>>> including
>>> +the next fields through header_length.
>>>  =A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 72 -=A0 79:=A0 incompatible_feature=
s
>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Bitmas=
k of incompatible features. An
>>> implementation must
>>> @@ -164,6 +164,44 @@ in the description of a field.
>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0 100 - 103:=A0 header_length
>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Length=
 of the header structure in bytes. For
>>> version 2
>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 images=
, the length is always assumed to be 72
>>> bytes.
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 For version =
3 it's at least 104 bytes and must be
>>> a multiple
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 of 8.
>>> +
>>> +
>>> +=3D=3D=3D Additional fields (version 3 and higher) =3D=3D=3D
>>> +
>>> +In general, these fields are optional and may be safely ignored by
>>> the software,
>>> +as well as filled by zeros (which is equal to field absence), if
>>> software needs
>>
>> We're inconsistent on 'zeros' (git grep has 201 hits) vs. 'zeroes' (688
>> hits); I prefer the latter, but won't object if you don't tweak it since
>> this is the first use of either spelling in qcow2.txt.
>>
>>> +to set field B, but does not care about field A, which precedes B. Mor=
e
>>
>> s/A, which/A which/
>=20
> I=92ve heard before that one should always use a comma before =93which=94=
 and
> never before =93that=94 (in that a subordinate clause opened by =93that=
=94 is a
> mandatory description, whereas those that start with =93why=94 are not
> necessary for understanding).
>=20
> So if this is a mandatory description (which I suppose it is), shouldn=92=
t
> it also be s/which/that/?
>=20
> I suppose =93field A that precedes B=94 sounds a bit weird because =93A=
=94
> hasn=92t been introduced before.  That is, =93the field that precedes B=
=94
> would sound more natural.  Or is that precisely the kind of instance
> where one would use =93which=94 without comma? :-)
>=20
> All in all, I was wondering whether there isn=92t a more natural way to
> rephrase the whole paragraph.  (No, I don=92t have an excuse why I didn=
=92t
> say so in the last revision.)
>=20
> Maybe:
>=20
> In general, these fields are optional and may be safely ignored when
> read and filled with zeroes when written.

The end of sentence is a bit in conflict with following "... other than pre=
serving its value when rewriting the image header ..."

(yes, here we say about creating new fields, not rewriting the existing one=
s, but this is not clear from the context)

So, for v10 I tend to keep it as is (with Eric's corrections).

   For example, say software
> wants to set field B but does not care about its preceding field A.  It
> may then set A to zero, B to its desired value, and adjust header_length
> to include A and B.
>=20
> ?
>=20
> Max
>=20


--=20
Best regards,
Vladimir

