Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2849AC2D0C9
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:28:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9008A24671
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="dyoiGMUL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9008A24671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifj6F-0001Ij-K7
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 06:27:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35545)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ifj5I-0000Ut-0S
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 06:26:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ifj5G-0008FH-AM
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 06:26:11 -0500
Received: from mail-eopbgr30109.outbound.protection.outlook.com
 ([40.107.3.109]:57929 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ifj5F-000882-FD; Fri, 13 Dec 2019 06:26:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QdXh2tHjShAISIx/oC8CXSBmAOdLOXaC4cvdpGjuend4LocOePozfYHy0JbmGq3TH2VT8Vx723bZiXxIFud1zsL08lI5BxCqSkyJXqOV61tPKKYYYMbkIwQrBC40WZtloRxVbW5o+TPQ5E0R5gTeiV1nkvIu6GTm2pOIj3njONwnRdIW8xgybfoj798lx5eZdsDekyax/qLOCqKnPFkI9WG6/MEdNTIe5v3jLi/9ZYgi3Nd/UXVEN9nNbih9ACg/QuVacT73Z2P/rNQpMz1yuzl7/6uLG8ZKp3G2nPW/4sC5MurtBrpw/LGsnnYnrfn9V/7dR0nEDpCDhL0tn8VtxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0zOaAMuJKT6Fh0LKrsbqMl1dIPEQ43XT31PBVT4nuw=;
 b=ZipUAchutFZ/+XrtEjcN4dyKAZEgqMClHKEh7jzUPifmFbCg0UpM86gdoyoDkNbeh/PsEL7cTvVz0MAiAq9bFtF6UT95YSiGgo4FrzWRqCUIs51vpp+HL8YjhnzKuhPdOzebiP3RENDKWBMdrW8i7VnaE0gbRj+GPgp1acqDruSnT/sDHFsuxImU60A49Bhi3PX7TsIzLHj/c+o2j01Za453SbjnNi1VluXtKW5m2Dfhob5WvQxEainyCXCMnRl9Ld8PJOSzI6YgQm9F/9Z7tkMvDWs5v7BgT4o5ku2QJdU9Rc5HxL/49aqcJB3QHJxVV3dWBkeoGi5M7Iijfv9F5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0zOaAMuJKT6Fh0LKrsbqMl1dIPEQ43XT31PBVT4nuw=;
 b=dyoiGMULXJytdAbZn/i63zYT9iUIVp+LGBBNyeG72O/ZTCIUAnorWCPCSresNcN5aFviReIc6bcVlT3SUiq3vXeRX1kdq1x4If9yamjMeaz2+cvGXc+dPLYdoAbsdDLz4wj9eHhIMnCKdz8Kq7cJIHjH8+etEbZVzH8uPzhBz4w=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB5111.eurprd08.prod.outlook.com (10.255.122.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Fri, 13 Dec 2019 11:26:04 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2516.020; Fri, 13 Dec 2019
 11:26:04 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH for-5.0 v2 18/23] iotests: Add VM.assert_block_path()
Thread-Topic: [PATCH for-5.0 v2 18/23] iotests: Add VM.assert_block_path()
Thread-Index: AQHVmKmLxO8pIw50PUGbvTIVfXIH5qeogbOAgAmSnoCABgqPAA==
Date: Fri, 13 Dec 2019 11:26:04 +0000
Message-ID: <4416b029-dbb2-280d-f2ee-67175a383871@virtuozzo.com>
References: <20191111160216.197086-1-mreitz@redhat.com>
 <20191111160216.197086-19-mreitz@redhat.com>
 <12688028-7bce-228a-4046-f886ac32cf4d@virtuozzo.com>
 <9c1e5973-aef5-20f3-86fd-1515e2977316@redhat.com>
In-Reply-To: <9c1e5973-aef5-20f3-86fd-1515e2977316@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0020.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::30) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191213142602685
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 00f5b54d-2941-434e-a657-08d77fbf3d7b
x-ms-traffictypediagnostic: AM6PR08MB5111:
x-microsoft-antispam-prvs: <AM6PR08MB511157FBDA8CDA9C2933F6F3C1540@AM6PR08MB5111.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0250B840C1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(346002)(396003)(366004)(376002)(136003)(189003)(199004)(36756003)(4326008)(86362001)(8936002)(81156014)(81166006)(8676002)(6486002)(31696002)(478600001)(316002)(6512007)(2616005)(186003)(52116002)(6506007)(53546011)(71200400001)(54906003)(110136005)(31686004)(26005)(2906002)(66476007)(66446008)(66556008)(64756008)(5660300002)(66946007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB5111;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K4RZEMBR1FYif0S/YmT8+rJmu9L5akE4HuPIRgI77pEo/LSpRaUh1KLX2BqqtbEnEI9lebrG0TIT4fIBjLJWvfVZ/o10NJm62MePtk35pS4AF9iBSlP25o+E5BqB/1qTAPxtbRERXHdq06ETTRkTM7eC77T75M8d0RDyrSvZIxk0WIN5o0lTDqlZvKmwgHOcDFgKPixy4FF/7VFMR4ZkCFZn/ECYwe3ocTRrXT5OtoqudghsutXem8j639xjLmyJj21JuXa5LuW2v0sHNJbt55LkmzY7FVPZqWvqhyCL0Jv+kpIuFsVsgVyJ6eX/tQVxt3U7dTSvpPw/qooJqSYKsFKgNFSDXg/RU+Sch8qzE7ZAUqmu3obiCpfQkwnd721SIKo5vufYfaigDcsMeuB2Alvpi+LJ7UL5VjcXezTkx9MWEjxNADZtE0YQ3gl2W3yU
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <CF3F251C94831442B4F3CC89A87D0097@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00f5b54d-2941-434e-a657-08d77fbf3d7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2019 11:26:04.4818 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PgrC87Q2J90IBwxLuME79VvTCACMLoKmj4nNnSPZaaI2e4BV9jRDbWRa2l3X9vQpiIoGBKPd8Z9UwJxWXbbdzFn2cdHrhCkCmgC6CNHtRWA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5111
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.109
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

09.12.2019 18:10, Max Reitz wrote:
> On 03.12.19 13:59, Vladimir Sementsov-Ogievskiy wrote:
>> 11.11.2019 19:02, Max Reitz wrote:
>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>> ---
>>>    tests/qemu-iotests/iotests.py | 59 +++++++++++++++++++++++++++++++++=
++
>>>    1 file changed, 59 insertions(+)
>>>
>>> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests=
.py
>>> index d34305ce69..3e03320ce3 100644
>>> --- a/tests/qemu-iotests/iotests.py
>>> +++ b/tests/qemu-iotests/iotests.py
>>> @@ -681,6 +681,65 @@ class VM(qtest.QEMUQtestMachine):
>>>   =20
>>>            return fields.items() <=3D ret.items()
>>>   =20
>>> +    """
>>> +    Check whether the node under the given path in the block graph is
>>> +    @expected_node.
>>> +
>>> +    @root is the node name of the node where the @path is rooted.
>>> +
>>> +    @path is a string that consists of child names separated by
>>> +    slashes.  It must begin with a slash.
>>
>> Why do you need this slash?
>=20
> I don=92t.  It just looked better to me.
>=20
> (One reason would be so it could be empty to refer to @root, but as I
> said that isn=92t very useful.)
>=20
>> To stress that we are starting from root?
>> But root is not global, it's selected by previous argument, so for me th=
e
>> path is more like relative than absolute..
>>
>>> +
>>> +    Examples for @root + @path:
>>> +      - root=3D"qcow2-node", path=3D"/backing/file"
>>> +      - root=3D"quorum-node", path=3D"/children.2/file"
>>> +
>>> +    Hypothetically, @path could be empty, in which case it would point
>>> +    to @root.  However, in practice this case is not useful and hence
>>> +    not allowed.
>>
>> 1. path can't be empty, as accordingly to previous point, it must start =
with '/'
>=20
> Hence =93hypothetically=94.
>=20
>> 2. path can be '/', which does exactly what you don't allow, and I don't=
 see,
>> where it is restricted in code
>=20
> No, it doesn=92t.  That refers to a child of @root with an empty name.

Hmm, yes, OK.

>=20
>>> +
>>> +    @expected_node may be None.
>>
>> Which means that, we assert existence of the path except its last elemen=
t,
>> yes? Worth mention this behavior here.
>=20
> =93(All elements of the path but the leaf must still exist.)=94?  OK.

OK

>=20
>>> +
>>> +    @graph may be None or the result of an x-debug-query-block-graph
>>> +    call that has already been performed.
>>> +    """
>>> +    def assert_block_path(self, root, path, expected_node, graph=3DNon=
e):
>>> +        if graph is None:
>>> +            graph =3D self.qmp('x-debug-query-block-graph')['return']
>>> +
>>> +        iter_path =3D iter(path.split('/'))
>>> +
>>> +        # Must start with a /
>>> +        assert next(iter_path) =3D=3D ''
>>> +
>>> +        node =3D next((node for node in graph['nodes'] if node['name']=
 =3D=3D root),
>>> +                    None)
>>> +
>>> +        for path_node in iter_path:
>>> +            assert node is not None, 'Cannot follow path %s' % path
>>> +
>>> +            try:
>>> +                node_id =3D next(edge['child'] for edge in graph['edge=
s'] \
>>> +                                             if edge['parent'] =3D=3D =
node['id'] and
>>> +                                                edge['name'] =3D=3D pa=
th_node)
>>> +
>>> +                node =3D next(node for node in graph['nodes'] \
>>> +                                 if node['id'] =3D=3D node_id)
>>
>> this line cant fail. If it fail, it means a bug in x-debug-query-block-g=
raph, so,
>> I'd prefer to move it out of try:except block.
>=20
> But that makes the code uglier, in my opinion.  We=92d then have to set
> node_id to e.g. None in the except branch (or rather just abolish the
> try-except then) and check whether it=92s None before assigning node.
> Like this:
>=20
> node_id =3D next(..., None)
>=20
> if node_id is not None:
>      node =3D next(...)
> else:
>      node =3D None
>=20
> I prefer the current try-except construct over that.

OK

>=20
>>> +            except StopIteration:
>>> +                node =3D None
>>> +
>>> +        assert node is not None or expected_node is None, \
>>> +               'No node found under %s (but expected %s)' % \
>>> +               (path, expected_node)
>>> +
>>> +        assert expected_node is not None or node is None, \
>>> +               'Found node %s under %s (but expected none)' % \
>>> +               (node['name'], path)
>>> +
>>> +        if node is not None and expected_node is not None:
>>
>> [1]
>> second part of condition already asserted by previous assertion
>=20
> Yes, but I wanted to cover all four cases explicitly.  (In the usual 00,
> 01, 10, 11 manner.  Well, except it=92s 10, 01, 11, 00.)
>=20
>>> +            assert node['name'] =3D=3D expected_node, \
>>> +                   'Found node %s under %s (but expected %s)' % \
>>> +                   (node['name'], path, expected_node)
>>
>> IMHO, it would be easier to read like:
>>
>>             if node is None:
>>                 assert  expected_node is None, \
>>                    'No node found under %s (but expected %s)' % \
>>                    (path, expected_node)
>>             else:
>>                 assert expected_node is not None, \
>>                    'Found node %s under %s (but expected none)' % \
>>                    (node['name'], path)
>>
>>                 assert node['name'] =3D=3D expected_node, \
>>                        'Found node %s under %s (but expected %s)' % \
>>                        (node['name'], path, expected_node)
>>
>> Or even just
>>
>>             if node is None:
>>                 assert expected_node is None, \
>>                    'No node found under %s (but expected %s)' % \
>>                    (path, expected_node)
>>             else:
>>                 assert node['name'] =3D=3D expected_node, \
>>                        'Found node %s under %s (but expected %s)' % \
>>                        (node['name'], path, expected_node)
>=20
> Works for me, too.
>=20
>> (I've checked:
>>   >>> 'erger %s erg' % None
>> 'erger None erg'
>>
>> Also, %-style formatting is old, as I understand it's better always use =
.format()
>> )
>=20
> OK.
>=20
> Max
>=20
>>>   =20
>>>    index_re =3D re.compile(r'([^\[]+)\[([^\]]+)\]')
>>>   =20
>>>
>=20
>=20


--=20
Best regards,
Vladimir

