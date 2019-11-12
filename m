Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CB6C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 10:25:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E3172196E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 10:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="rz9cxgEA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E3172196E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUTMF-0001zo-Bz
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 05:25:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56117)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iUTLQ-0000yh-95
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 05:24:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iUTLO-0006xD-Ut
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 05:24:20 -0500
Received: from mail-eopbgr50094.outbound.protection.outlook.com
 ([40.107.5.94]:2178 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iUTLJ-0006t1-Ci; Tue, 12 Nov 2019 05:24:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MIqgANyUMzucDO25+cJFV1U7GIxX/W7jqu3Kvgqm2BHtrAB3l+DI0I+XHarUS9SaTmVMND8UtdWMwv7FY/eh4mZXd0RHjcOFNhITEjNlWM5Ge6tDX+nYX3gxPxNtpuq65uoKkZ5M21GF3FUkwNNF1j4YjjdEhxn+n5niIgOsmCxP4bjvIu/Cs1GtvrvlmYPuESyF5LIXBpUCQHVP0ESqL0cgBqyQCx8C4cwwrM0+EmGn2Vf9R8LxY4q3g+vNHGe5xgjnFx1gtZ70cFUY7z8TPb6wu4BTNdBUTxwJsdFVRcjZ9OQQcyBBRTweoBK4xoh+OpK0In/wj0FUgwEZ89YaeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nz5i11PSGaUIGLbhIleXh36aZnMlNNg3GLvcssvRgBI=;
 b=LjRFm9mPHCwvbH0cjGSC4sYrdFTM5p0w0m27WM2F/5gskvwYiNK0LblPoVkak/KvLC0aWoacFARjUrsp8aStucMpCWFPRwHno7nJIczaA7Ah6vfEKyEaEDDcc2fZfjNUASrTK4FcWNY5YlgnEs2pLby6n+dLo0HiADfe3GgDomrOPyUskQOjUVZwrRo5GHk01ucvboXK5dDKV6jwNDknm0VYEco5w5woks7frJTSWnGhaaEvsGpJ/0cf35e/NUnlBbK8LLyLNfQy2DuSWdil6rsoDj1hT7UvILeyf+M+xHix8RsQIKc5C6EbrvjosSUko/rBqiubmFxj64yX+jstJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nz5i11PSGaUIGLbhIleXh36aZnMlNNg3GLvcssvRgBI=;
 b=rz9cxgEApt4IZA3rzM3zTCq6NqJFzd1nA5Osd0T2o5wD2+bNe3I7OcZyERX+HeQTDkB/49O3+1aEtJJ9rEZqLRjLq05dZ6splKL7qEIi71fJjkdY9EcpR2Gtg+yCJLVXpQQ7SbRFIiC9b58JvB+AAZHQAOY3CfyzhmjZM5pR260=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3816.eurprd08.prod.outlook.com (20.178.90.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Tue, 12 Nov 2019 10:24:09 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 10:24:09 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, Kevin Wolf
 <kwolf@redhat.com>
Subject: Re: [PATCH v6 1/3] block: introduce compress filter driver
Thread-Topic: [PATCH v6 1/3] block: introduce compress filter driver
Thread-Index: AQHVmKnAqgdeikmhBEKvDN05CFcI96eHSMAAgAAH/YCAAASJgA==
Date: Tue, 12 Nov 2019 10:24:09 +0000
Message-ID: <da3f0b66-7836-7e21-87f5-95d6ae0fc347@virtuozzo.com>
References: <1573488277-794975-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1573488277-794975-2-git-send-email-andrey.shinkevich@virtuozzo.com>
 <20191112093912.GC5364@linux.fritz.box>
 <9df49b41-c2a5-d087-36ac-3f31ae7f4c85@virtuozzo.com>
In-Reply-To: <9df49b41-c2a5-d087-36ac-3f31ae7f4c85@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0901CA0065.eurprd09.prod.outlook.com
 (2603:10a6:3:45::33) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191112132401036
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d476ed1-26d6-461b-8f96-08d7675a7422
x-ms-traffictypediagnostic: AM6PR08MB3816:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB3816F1F75E9BF35456EA8550C1770@AM6PR08MB3816.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(39840400004)(396003)(366004)(136003)(51444003)(189003)(199004)(66476007)(110136005)(99286004)(66446008)(66556008)(107886003)(4326008)(66946007)(6512007)(54906003)(53546011)(386003)(64756008)(6506007)(316002)(26005)(186003)(31686004)(102836004)(256004)(14444005)(5660300002)(66066001)(6436002)(71200400001)(71190400001)(478600001)(6116002)(6246003)(3846002)(2906002)(25786009)(6486002)(7736002)(2616005)(36756003)(76176011)(305945005)(14454004)(52116002)(229853002)(8936002)(11346002)(476003)(446003)(486006)(81166006)(8676002)(81156014)(86362001)(31696002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3816;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:3; A:3; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RPfMJPwgcuCT0fx8eqqLppRzHrG5+TrdHad7OWBuLskysyYrR1u+xSdMLVWr2ZxnJPTBdBC0ywVo3PZPJ29fRwsKGWjecqVSBJj85yIIlIcqwAxRdwom3iVMCgfexJJe4i6oYSK8YZT3vYpIp3kMTDQ4+ta9lU+N5oyQ7jKTljS+quRqHuAkxRe4QGrqAaljHCO3iKiSM9VFQ7Lc8Zshht3aMTDCMIjuHg/4Qu387J/MWCGWAaRmaI9haWfOQu76pHeWp58Lq7Lc1Ch2rDsY7YtM8/746u6LEt1P1saEVel1XxBxOUAouQZK0j/OKjZasK8qLTAQkCt1mVRKCt/mPDISQfFTviintM0RGchTJvLAiHJppjSYiFHSD17nB29yE0o9F8wHSlyPQ7KfpoUsLFx4eJIoRBf1fF7WN//b6i5NLyMn3aHrxu6Ctct6AKX9
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <0380C843739C0E4484C874BEC57A2712@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d476ed1-26d6-461b-8f96-08d7675a7422
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 10:24:09.0543 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hGjJn29En72Gn9PA9BDylRBmNuT0Gvr7lLiPN9lLfJPXUVqiZ33nicz5tN3c6hHxt5TdQms62bYeIW7bBKxTCHrB7aBq5ihujiKWemjn9H0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3816
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.94
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
Cc: Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

12.11.2019 13:07, Andrey Shinkevich wrote:
> On 12/11/2019 12:39, Kevin Wolf wrote:
>> Am 11.11.2019 um 17:04 hat Andrey Shinkevich geschrieben:
>>> Allow writing all the data compressed through the filter driver.
>>> The written data will be aligned by the cluster size.
>>> Based on the QEMU current implementation, that data can be written to
>>> unallocated clusters only. May be used for a backup job.
>>>
>>> Suggested-by: Max Reitz <mreitz@redhat.com>
>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>
>>> +static BlockDriver bdrv_compress =3D {
>>> +    .format_name                        =3D "compress",
>>> +
>>> +    .bdrv_open                          =3D zip_open,
>>> +    .bdrv_child_perm                    =3D zip_child_perm,
>>
>> Why do you call the functions zip_* when the driver is called compress?
>> I think zip would be a driver for zip archives, which we don't use here.
>>
>=20
> Kevin,
> Thanks for your response.
> I was trying to make my mind up with a short form for 'compress'.
> I will change the 'zip' for something like 'compr'.

I'd keep it compress, it sounds better.

>=20
>>> +    .bdrv_getlength                     =3D zip_getlength,
>>> +    .bdrv_co_truncate                   =3D zip_co_truncate,
>>> +
>>> +    .bdrv_co_preadv                     =3D zip_co_preadv,
>>> +    .bdrv_co_preadv_part                =3D zip_co_preadv_part,
>>> +    .bdrv_co_pwritev                    =3D zip_co_pwritev,
>>> +    .bdrv_co_pwritev_part               =3D zip_co_pwritev_part,
>>
>> If you implement .bdrv_co_preadv/pwritev_part, isn't the implementation
>> of .bdrv_co_preadv/pwritev (without _part) dead code?
>>
>=20
> Understood and will remove the dead path.
>=20
>>> +    .bdrv_co_pwrite_zeroes              =3D zip_co_pwrite_zeroes,
>>> +    .bdrv_co_pdiscard                   =3D zip_co_pdiscard,
>>> +    .bdrv_refresh_limits                =3D zip_refresh_limits,
>>> +
>>> +    .bdrv_eject                         =3D zip_eject,
>>> +    .bdrv_lock_medium                   =3D zip_lock_medium,
>>> +
>>> +    .bdrv_co_block_status               =3D bdrv_co_block_status_from_=
backing,
>>
>> Why not use bs->file? (Well, apart from the still not merged filter
>> series by Max...)
>>
>=20
> We need to keep a backing chain unbroken with the filter inserted. So,
> the backing child should not be zero. It is necessary for the backup
> job, for instance. When I initialized both children pointing to the same
> node, the code didn't work properly. I have to reproduce it again to
> tell you exactly what happened then and will appreciate your advice
> about a proper design.
>=20
> Andrey


file-child based filters are pain, which needs 42-patches (seems postponed =
now :(
Max's series to work correct (or at least more correct than now). file-chil=
d
based filters break backing-chains, and backing-child-based works well. So,=
 I don't
know any benefit of file-child based filters, and I think there is no reaso=
n to
create new ones. If in future for some reason we need file-child support in=
 the filter
it's simple to add it (so filter will have only one child, but it may be ba=
cking or
file, as requested by user).

So, I propose to start with backing-child which works better, and add file-=
child support
in future if needed.

Also, note that backup-top filter uses backing child, and there is a reason=
 to make it
public filter (to realize image fleecing without backup job), so we'll have=
 public
backing-child based filter anyway.

Also, we have pending series about using COR filter in block-stream (it bre=
aks
backing-chain, as it is file-child-based), and now I think that the simples=
t
way to fix it is support backing child in block-stream (so, block-stream jo=
b
will create COR filter with backing child instead of file child).

>=20
>>> +    .bdrv_recurse_is_first_non_filter   =3D zip_recurse_is_first_non_f=
ilter,
>>> +
>>> +    .has_variable_length                =3D true,
>>> +    .is_filter                          =3D true,
>>> +};
>>
>> Kevin
>>
>=20


--=20
Best regards,
Vladimir

