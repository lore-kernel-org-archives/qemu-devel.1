Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6906C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 13:05:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73DB320640
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 13:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="R9FgKxGn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73DB320640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic7sM-0007lJ-KL
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 08:05:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50064)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ic7mU-0005nX-TF
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 07:59:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ic7mO-0007tr-0h
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 07:59:50 -0500
Received: from mail-eopbgr10118.outbound.protection.outlook.com
 ([40.107.1.118]:20646 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ic7mN-0007S3-2F; Tue, 03 Dec 2019 07:59:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fr5/3A9s/Ihw27/YLPDyXZcCpOYGaM4EMU8Hhq5/b7/QGl/ybXsa6I00veeEHzq48B4X4CpVqWpSjbc/C/GU05s4sEbZ9ACphv+zSeS1JZodwrm2t9IpkLL1rz0ODYUsuePo9hr/8EntWqkXJHUZ7LbYlF71dND9bPLqQkiN/smS2unHOg/qoiFv827077ng6vr1HSQwGGxWVgZFHC5P3VbNLQHizOx/CZTbF/fn8H0S0sDBOMyAnLqUKTHsWhHQOQJKVEa2WQ8zE0bBD/iAX02Yl+0FkS4kkFFxsnr8sozKpusiImKo7jnms3hECwA3wvCBrDm3HV8l+iULydkHXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2IBNoT6VNHElFtXrj4OJE4wVeyn6DIEmL/kVgBkNaPI=;
 b=FIZs8Ffd2qvQBG7Ma54HAN4+y344ZMTrgR1K1hrB4XHW6I7mE2lqgAsP3KdxlAZFD5yi+L7wCBVYTEQn0i0lJVUvJbwzUTgO/Y4JbVyjr36YDwV3ZJs9geClyqOGypldSz1Guv+JGsy9kw6/e+lpx/zQmOcXZU9xQoGXemU7gWChuF3h4QMmtoRqEuLXgHhqTW48wQB0AxLFMAPviCUpZGfLsQyl5KwSYHLDeubPWUikJ8MpFp3RapL8vePDvG3duUVoUReo17LL/UxJELDfA2QEGH15/cikASgrhiHyiZ8V93HzmsT0AfOxieGLZyjqbWB1Egiwkj3MtNEJPKhw6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2IBNoT6VNHElFtXrj4OJE4wVeyn6DIEmL/kVgBkNaPI=;
 b=R9FgKxGn96rhR4lfgV+oNPaTfHp5PxgLsuan3bY7Ru4t3L4bUvSZv0AHrm06fRMtRZOXCFZ2bprbXUsDa9DF2qnAuJWycEDY+J0XZ9kFP/3vWT1D/KN0OKRaFoKdIiXqRMb4FhTOKOMoOZT+nckgg5q60+JVQuuGy7P39bQH4+U=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3351.eurprd08.prod.outlook.com (52.135.165.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Tue, 3 Dec 2019 12:59:38 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2516.003; Tue, 3 Dec 2019
 12:59:38 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH for-5.0 v2 18/23] iotests: Add VM.assert_block_path()
Thread-Topic: [PATCH for-5.0 v2 18/23] iotests: Add VM.assert_block_path()
Thread-Index: AQHVmKmLxO8pIw50PUGbvTIVfXIH5qeogbOA
Date: Tue, 3 Dec 2019 12:59:38 +0000
Message-ID: <12688028-7bce-228a-4046-f886ac32cf4d@virtuozzo.com>
References: <20191111160216.197086-1-mreitz@redhat.com>
 <20191111160216.197086-19-mreitz@redhat.com>
In-Reply-To: <20191111160216.197086-19-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0224.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::24) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191203155935885
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 761c3a52-44d5-4c12-281b-08d777f0a74a
x-ms-traffictypediagnostic: AM6PR08MB3351:
x-microsoft-antispam-prvs: <AM6PR08MB335171ED1C8265B3B403F47AC1420@AM6PR08MB3351.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(136003)(39840400004)(376002)(396003)(346002)(199004)(189003)(4326008)(446003)(6512007)(26005)(186003)(11346002)(102836004)(478600001)(2616005)(99286004)(110136005)(14454004)(6246003)(54906003)(31686004)(256004)(66946007)(66556008)(25786009)(64756008)(6486002)(6436002)(66476007)(6506007)(52116002)(6116002)(386003)(76176011)(316002)(229853002)(66446008)(3846002)(14444005)(2906002)(5660300002)(81156014)(305945005)(71190400001)(71200400001)(7736002)(86362001)(8676002)(31696002)(8936002)(81166006)(36756003)(2501003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3351;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BgP8MvY+rvfkQdAxUpJB74Vd4KojfSXgoI6ELyNQD3eY5bYbewfcJxc0t07NKG0Df9LPjtSDQKufu4y4uBFSQQi1lHowJ2rUrQc2r8+Ia/bnIwSB+fbes7DGzyXhXINUd3S3SQQ+G9UkkDw3+zJTuut/I+alGudS/icWcVEAU3gTEqd21QJ99wUSEFZd63Y2+PGmYrgKt9MGOGWm7JHpGaAnrAD2vzUGqMNTQFf7Oaunn8Mn8fNlF+JIh18u+MoZcPAZOaO65KNoXqsL5ORlALXUGE2js8c/VWpdQyHtCPMBWT/pQyLlfdYKKPuVDHJyXj+RZwvp2ghXANmaHwvhuyRxPZUp3h1h4YpyxhYjZVzUyg5uIOmqv/ULEUuAjmZdQ3J0+zgKQRY5xIE343g2f1do0+rrvlB50bdMjaaQ36kQ6HKn5zAOeFvSpAyA005p
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <790FBABD9280004D83F13A0056E96BC0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 761c3a52-44d5-4c12-281b-08d777f0a74a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 12:59:38.0235 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QwC/fhQ4tOL7NYORC2XcRs4XxIbLV+7GPuSYLpCTmBtLYdOQxgbRRfu+POFrpRnOfDuxAYpyckEehbcITGTSzMCl5d8IaugJiKOj/WZVhQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3351
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.118
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

11.11.2019 19:02, Max Reitz wrote:
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   tests/qemu-iotests/iotests.py | 59 +++++++++++++++++++++++++++++++++++
>   1 file changed, 59 insertions(+)
>=20
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
> index d34305ce69..3e03320ce3 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -681,6 +681,65 @@ class VM(qtest.QEMUQtestMachine):
>  =20
>           return fields.items() <=3D ret.items()
>  =20
> +    """
> +    Check whether the node under the given path in the block graph is
> +    @expected_node.
> +
> +    @root is the node name of the node where the @path is rooted.
> +
> +    @path is a string that consists of child names separated by
> +    slashes.  It must begin with a slash.

Why do you need this slash? To stress that we are starting from root?
But root is not global, it's selected by previous argument, so for me the
path is more like relative than absolute..

> +
> +    Examples for @root + @path:
> +      - root=3D"qcow2-node", path=3D"/backing/file"
> +      - root=3D"quorum-node", path=3D"/children.2/file"
> +
> +    Hypothetically, @path could be empty, in which case it would point
> +    to @root.  However, in practice this case is not useful and hence
> +    not allowed.

1. path can't be empty, as accordingly to previous point, it must start wit=
h '/'
2. path can be '/', which does exactly what you don't allow, and I don't se=
e,
where it is restricted in code

> +
> +    @expected_node may be None.

Which means that, we assert existence of the path except its last element,
yes? Worth mention this behavior here.

> +
> +    @graph may be None or the result of an x-debug-query-block-graph
> +    call that has already been performed.
> +    """
> +    def assert_block_path(self, root, path, expected_node, graph=3DNone)=
:
> +        if graph is None:
> +            graph =3D self.qmp('x-debug-query-block-graph')['return']
> +
> +        iter_path =3D iter(path.split('/'))
> +
> +        # Must start with a /
> +        assert next(iter_path) =3D=3D ''
> +
> +        node =3D next((node for node in graph['nodes'] if node['name'] =
=3D=3D root),
> +                    None)
> +
> +        for path_node in iter_path:
> +            assert node is not None, 'Cannot follow path %s' % path
> +
> +            try:
> +                node_id =3D next(edge['child'] for edge in graph['edges'=
] \
> +                                             if edge['parent'] =3D=3D no=
de['id'] and
> +                                                edge['name'] =3D=3D path=
_node)
> +
> +                node =3D next(node for node in graph['nodes'] \
> +                                 if node['id'] =3D=3D node_id)

this line cant fail. If it fail, it means a bug in x-debug-query-block-grap=
h, so,
I'd prefer to move it out of try:except block.

> +            except StopIteration:
> +                node =3D None
> +
> +        assert node is not None or expected_node is None, \
> +               'No node found under %s (but expected %s)' % \
> +               (path, expected_node)
> +
> +        assert expected_node is not None or node is None, \
> +               'Found node %s under %s (but expected none)' % \
> +               (node['name'], path)
> +
> +        if node is not None and expected_node is not None:

[1]
second part of condition already asserted by previous assertion

> +            assert node['name'] =3D=3D expected_node, \
> +                   'Found node %s under %s (but expected %s)' % \
> +                   (node['name'], path, expected_node)

IMHO, it would be easier to read like:

           if node is None:
               assert  expected_node is None, \
                  'No node found under %s (but expected %s)' % \
                  (path, expected_node)
           else:
               assert expected_node is not None, \
                  'Found node %s under %s (but expected none)' % \
                  (node['name'], path)

               assert node['name'] =3D=3D expected_node, \
                      'Found node %s under %s (but expected %s)' % \
                      (node['name'], path, expected_node)

Or even just

           if node is None:
               assert expected_node is None, \
                  'No node found under %s (but expected %s)' % \
                  (path, expected_node)
           else:
               assert node['name'] =3D=3D expected_node, \
                      'Found node %s under %s (but expected %s)' % \
                      (node['name'], path, expected_node)

(I've checked:
 >>> 'erger %s erg' % None
'erger None erg'

Also, %-style formatting is old, as I understand it's better always use .fo=
rmat()
)

>  =20
>   index_re =3D re.compile(r'([^\[]+)\[([^\]]+)\]')
>  =20
>=20
--=20
Best regards,
Vladimir

