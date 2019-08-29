Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8980FC3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 15:23:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58A162166E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 15:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="XZMaqdxr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58A162166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3MGm-0000QI-FP
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 11:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52261)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i3MBD-0003mT-Mb
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 11:17:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i3MBC-0004tK-Ev
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 11:17:43 -0400
Received: from mail-eopbgr70139.outbound.protection.outlook.com
 ([40.107.7.139]:56757 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i3MBC-0004sb-5Z; Thu, 29 Aug 2019 11:17:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+u0FfC9VfzApNqIZm8UvzHw+IjP0WYZRENj/mz802z3G1QASvDLGbxx+dEEK106yv0tB084fB5/PFNwdRB0xcStSkQgP0npKU5VLsC44X9f/S5XbKfuIYH6Fm05nhTC1UU+J6UIftAW3cQEfe/1Jt8L5TvHjzoFXUdpB3/KdnGQzNLac7omK+HCA5kiZ26YyozKBROqNZJXiirx10YVLRvOlwaBElyYIy5rGUWzj00SbE0DP7D1YBtxrgeHlT/EMlzEt+2xCSlnAiBO/YEbLlt4PBjnq+2AEXDmx5zkgiF8zvbISkkRJvNhKlQrobQqWpcMCswj59AnfZIXMmUsxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idlQv7pj52g7ULaxZbXI5RMi3eYHRrboD2P5t7A5Xbo=;
 b=YTfKLz3rDFW6Hkd2ohe13OQ4EnSEPFqMgqDPsz/oHcqHQPOXnuEmDjozliKpK2FQoTv0XdF/shz6RoFrjvJLHZkIWy36rMeoVKp+zvBpLiQ/RAAEiOZY9bNC1c6ovikmpfHuCflnBlErO1S6LyPFIsj72tPylWchF9rGD/YTvE2dEA59VsBiBJbzdz9CqPxi07DNyEb4KJJHDE/n4lP3HMZaHjz9sJ1rIGfhe6gLVG8yb+KiH4d5o3z2Qq6pNqP57urGm1IYIVyfgDy6jxb9OFQOfMcoGyDAbQN8PIfjeNfGT8kzmAvW7goRwbQjUu0b6CblGED9bkzrm0gK1vOB5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idlQv7pj52g7ULaxZbXI5RMi3eYHRrboD2P5t7A5Xbo=;
 b=XZMaqdxr53ACpzBIp5jf6PHnUVREicV4eG4jlpelE71g/QMv3ZtmEg6KBrj1BSZDmXVuMaOLTbFT/OUxe7gps+S+reG+YeCinvaj08pJjx0DDb8oM1WJIjoOL+zBfCXlnIRraopBIPypIG/ZyW1Wdf50sIcsxjgYDqdrBnKw1cg=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8SPR01MB0010.eurprd08.prod.outlook.com (20.179.13.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.18; Thu, 29 Aug 2019 15:17:39 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2199.021; Thu, 29 Aug 2019
 15:17:39 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Peter Krempa <pkrempa@redhat.com>, John Snow <jsnow@redhat.com>
Thread-Topic: [PATCH 2/2] qapi: deprecate implicit filters
Thread-Index: AQHVUogdkuEpfSqLt0qlSVbE/q5j26cIg2YAgAb++gCAANxRAIAAjcEAgAFfFwCAAAkugA==
Date: Thu, 29 Aug 2019 15:17:39 +0000
Message-ID: <c3e0c5d2-4c2f-0565-140d-b16c3e4a87b8@virtuozzo.com>
References: <20190814100735.24234-1-vsementsov@virtuozzo.com>
 <20190814100735.24234-3-vsementsov@virtuozzo.com>
 <de4667c2-7fd7-932d-6ce3-9844f284a0b4@virtuozzo.com>
 <d2bf50f1-e441-4cdb-291f-119a3ed93f51@redhat.com>
 <ba0e7e98-d02f-3514-b435-71923a483c6e@virtuozzo.com>
 <5b8dc9fa-6778-add9-01ae-7259d6bf633c@redhat.com>
 <20190829144446.GL13714@angien.pipo.sk>
In-Reply-To: <20190829144446.GL13714@angien.pipo.sk>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0041.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::30) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190829181737372
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4044cd99-38ff-4d18-f14a-08d72c9407f0
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8SPR01MB0010; 
x-ms-traffictypediagnostic: DB8SPR01MB0010:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8SPR01MB0010BCDFBFCCC0EE7227D1DFC1A20@DB8SPR01MB0010.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0144B30E41
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(39850400004)(366004)(376002)(346002)(199004)(189003)(31696002)(478600001)(8676002)(6486002)(2906002)(26005)(6506007)(53546011)(386003)(2616005)(11346002)(446003)(14444005)(107886003)(6246003)(54906003)(53936002)(99286004)(102836004)(3846002)(7736002)(305945005)(25786009)(316002)(256004)(76176011)(4326008)(229853002)(186003)(66556008)(14454004)(8936002)(66946007)(6116002)(66476007)(6436002)(71200400001)(6512007)(71190400001)(476003)(486006)(52116002)(5660300002)(110136005)(66066001)(36756003)(86362001)(81166006)(64756008)(81156014)(66446008)(31686004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8SPR01MB0010;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /YQLcbuybvBwGIAAxf1Pvv3sNtp0NDjU/5XzcP3qiL/OxfLexsRyyJrT7gGlVnJBqjyzS742WW6Stw8zaOeHY+48s7I0pJCdbVGEQuAWJT8tQDboahS2DMSYIsiZBTJMghlZmFy2huJ0roamAlTa5U3ejLDZXhbLVnSY1hPQawbwi+2ylJsA5S4OBGiQb8EbIqfhFjC6icfvq6/2moMhHKJddVCUzz6jF1z7/kj6clMJGBXZYZcsKZ7x5pUEkdyiokjkjYVMOuLZI/Xlx1OuLYJ9ykfyJq0Wk1za/kC5auHwqTfupxCpITwNRGlzsbFbmiE7oNAyxer3HuThBI5rNiIN7oEXer3yYv6FkL2oaLuJnEG30VPihrEAKdCDh0uouINCXIhHmxm2SxUykxHw/tsBNFwJqMrrb0NARny39B0=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <D51B0EC2D22C1D4DA88A41E03145BA21@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4044cd99-38ff-4d18-f14a-08d72c9407f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2019 15:17:39.7808 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3ENg2zAKz+qarkTnp5jJcsHeeHkBGQcyOB/hQcDRWEzpCuy7KnqlfkvIgsy7ZRTULKX7zb4TyUnXw7GSRc8A7MeuHDgPnYyoeRFMK87W6Og=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8SPR01MB0010
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.139
Subject: Re: [Qemu-devel] [PATCH 2/2] qapi: deprecate implicit filters
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

29.08.2019 17:44, Peter Krempa wrote:
> On Wed, Aug 28, 2019 at 13:48:10 -0400, John Snow wrote:
>> (Peter: search for "pkrempa" down below.)
>>
>> On 8/28/19 5:20 AM, Vladimir Sementsov-Ogievskiy wrote:
>=20
> [....]
>=20
>=20
>> So that's a bit of a change, but only visually. The "reality" is still
>> the same, we just report it more "accurately." libvirt MIGHT need a
>> heads up here. I'm looping pkrempa back in for comment.
>>
>> <pkrempa>
>> Would libvirt be negatively impacted by the revelation of formerly
>> internal ("implicit") nodes created by mirror and commit via query block
>> commands? At the moment, QEMU hides them from you if you do not name the=
m.
>=20
> Currently we would not be able to handle that properly at least
> definitely in the pre-blockdev case. In blockdev case I must make sure
> that it will work.
>=20
> The thing is that I didn't really want to touch the pre-blockdev case
> code any more,

Aren't you going to deprecate and drop it at some moment?

  but if you decide that we should do it I'm willing to
> investigate this case also for the old commands.
>=20
>> </pkrempa>
>>
>>> 3. bdrv_refresh_filename, bdrv_reopen_parse_backing, bdrv_drop_intermed=
iate:
>>>     I think it's not a problem, just drop special case for implicit fit=
lers
>>>
>>
>> I'm much less certain about what the impact of this would be and would
>> need to audit it (and don't have the time to, personally.)
>>
>> Do you have a POC or RFC patch that demonstrates dropping these special
>> cases? It might be nice to see as proof that it's safe to deprecate.
>>
>>> So, seems the only real change is query-block and query-blockstats outp=
ut when mirror or commit is started
>>> without specifying filter-node-name (filter would be on top)
>>>
>>> So, how should we deprecate this, or can we just change it?
>>>
>>
>> I'm not sure if it's worth it yet, what does dropping the implicit field
>> buy us? Conceptually I understand that it's simpler without the notion
>> of implicit fields, but I imagine there's some cleanup in particular
>> that motivated this.
>>
>> I'd say to just change the behavior, we should:
>>
>> - Give a standard three-release warning that the behavior will change in
>> an incompatible way
>> - Demonstrate with an RFC patch that special cases around ->implicit in
>> block.c can be removed and do not make the code more complex,
>> - Get blessings from Peter Krempa.
>>
>> As always: Libvirt is not the end-all be-all of QEMU management, but if
>> libvirt is capable of working around design changes then I believe any
>> project out there today also could, so it's a good litmus test.
>=20
> For libvirt we really care more whether a node is format/protocol
> related or not rather than whether it's implicit or not.
>=20
> In this case we could filter it by the known protocol and format driver
> types and filter out the rest in cases when we e.g. detect the node
> names for the pre-blockdev era cases.
>=20
> (Note that even with new qemu, if an SD card is used blockdev will be
> disabled).
>=20


--=20
Best regards,
Vladimir

