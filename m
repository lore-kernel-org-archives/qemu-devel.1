Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B8EC2D0CA
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8042624680
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="lm6MZz0I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8042624680
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifj7U-0002T6-IM
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 06:28:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50203)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ifj6k-0001t8-Hp
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 06:27:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ifj6j-0002LH-AJ
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 06:27:42 -0500
Received: from mail-eopbgr40139.outbound.protection.outlook.com
 ([40.107.4.139]:61830 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ifj6j-0002IB-3d; Fri, 13 Dec 2019 06:27:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fR+3RF5M5flsi1RynRP4VnVumJYabd0urKOMYKCuWd/CHgybQ9ZIaI1JPpjmCna4ov57RXegTYpbapX2spUtf9Z+47TTUVujrl5N9TXiM9CekNFOni3rGeW6ffdF6JsAciNhY8QD+SEa+0qjTqirYNmzzxoQtOLYeceyB1gBJYFDKicnwA8oQ9u24/GrI//TRwyxtyCgZV5AuWOPND7CZPF3TFZpT4K4sd/vhieFvH7moeGoovGuHKCNs1zPTZYQbSL2DvN7c8yZpOzAY5HFxGRaA1U6lXiGDtGI7rftNOau7hnIU6Bvuvo2W0OCrxTi5x86EyN2g/P9YsRrzpjjgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2JZ787Oqr2ic2K3v+EFoOHXRzH9OS+1bB0Z3gtMtcYc=;
 b=FzgGnA8huGbLGiqFNbCKvv5yMC0CpaRh1+QKRACYur9W28xT/Af7rT8+j8UCSoR900Br+vVdRhGMJa1hbw/du2scLPtXj7wmNOGQvhjJhlXZ/obFkXAjlhh2BIp8ZMcxoTeCZGs+t4WWVPtLAD14sU1yt04qi6Qolo2BV274uslVpAHK1TZ9w2S9o558vGLUdF3PwXl9YBQTWEe7NaB4EYi0J4Abf3eoegwnN5vsFgJVxQqF+Cy1JqKRhbeORM87Gqxv6093wTn7wAywxl7C+E8kDissfeD3Vq8FUapX7h7fDJVHRZ7NTOdhQG2QeYooI8QTJGcTRypnvBgrlUSnrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2JZ787Oqr2ic2K3v+EFoOHXRzH9OS+1bB0Z3gtMtcYc=;
 b=lm6MZz0Ich5r9Tmc/sdGtj8S4mhuntvlkmjZywfwt3vPNraEbbM/9gjJwVhkg4VfU1crQBO10GpOWN0m1b21zNOMqYfE56BD/jKsv8wACpPefFhkh9qASV+N9H7l5pkt+a5FEml9Xl52mLGnH89DdjxMShVVis2vTePqPcqLuY8=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3079.eurprd08.prod.outlook.com (52.135.163.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Fri, 13 Dec 2019 11:27:37 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2516.020; Fri, 13 Dec 2019
 11:27:37 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH for-5.0 v2 18/23] iotests: Add VM.assert_block_path()
Thread-Topic: [PATCH for-5.0 v2 18/23] iotests: Add VM.assert_block_path()
Thread-Index: AQHVmKmLxO8pIw50PUGbvTIVfXIH5qe4H0+A
Date: Fri, 13 Dec 2019 11:27:37 +0000
Message-ID: <16697362-7d89-74a0-53d4-7d9d48a1386a@virtuozzo.com>
References: <20191111160216.197086-1-mreitz@redhat.com>
 <20191111160216.197086-19-mreitz@redhat.com>
In-Reply-To: <20191111160216.197086-19-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P192CA0002.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::12)
 To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191213142734996
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 708d1141-78d2-4a56-1041-08d77fbf74ce
x-ms-traffictypediagnostic: AM6PR08MB3079:
x-microsoft-antispam-prvs: <AM6PR08MB30796D928F02FEB7CEBC80B2C1540@AM6PR08MB3079.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0250B840C1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(346002)(396003)(39840400004)(376002)(366004)(199004)(189003)(6506007)(6486002)(31696002)(54906003)(5660300002)(2906002)(52116002)(110136005)(66556008)(66946007)(66476007)(66446008)(64756008)(4326008)(86362001)(478600001)(31686004)(6512007)(71200400001)(186003)(8936002)(2616005)(8676002)(36756003)(316002)(81156014)(26005)(81166006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3079;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OAvVHc56Zh2dksWG6/vJZ5dtXspFhVn9cEawqQoJIdhqnFqQshtlfsKE2lO6BZ+frqYigj9Qh8g0dAqh5HJcwN14amGNQvLR+NJXyZtlLG6kDN8WLNL/c/7g8rfj9kf2NKl9TMs+crEAPmb8DjSIgFN3iLD+kE+sk+N6aVJlKFvkvKME0i9/GKCEXz8ohceqr99GZNvMoIX5Hs1/fFgdjhocr8I2Op7L1jgtgu1Hff4cn3K/Y17h9tU8tY3xA9GEIfa/erfzkq7ymMvD4XRjVByXssToY2BNIvfiMGPcvUbmplmnrvMGojDAjKZhQnk8QENpsUltd2RW15fWwdeHrYWcLXjTEfr38JJkb0xUAHceChmRvHDKpu/zYZNWUsHwV7jVScQuh61YXv0+HKgZV5e+vGOKa6Yspf7QG15nf9sFKVa8NfosU2W6P5ESG+7J
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <038BECF9CBECB04B89C56326884AC97A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 708d1141-78d2-4a56-1041-08d77fbf74ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2019 11:27:37.2966 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cBH2OtKqFSl/SmgirkQ4b8tAutdwoUbRCSGQCGNTe4W9vAKrnOIePTy19+AulzQsVd24GxsiUEcZ3w+ncGbxzkTQhkcnBKBzZ0/gDMbljFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3079
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.139
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
> +
> +    Examples for @root + @path:
> +      - root=3D"qcow2-node", path=3D"/backing/file"
> +      - root=3D"quorum-node", path=3D"/children.2/file"
> +
> +    Hypothetically, @path could be empty, in which case it would point
> +    to @root.  However, in practice this case is not useful and hence
> +    not allowed.
> +
> +    @expected_node may be None.
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

I'd rename path_node to child or edge, to not interfere with block nodes he=
re.

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
> +            assert node['name'] =3D=3D expected_node, \
> +                   'Found node %s under %s (but expected %s)' % \
> +                   (node['name'], path, expected_node)
>  =20
>   index_re =3D re.compile(r'([^\[]+)\[([^\]]+)\]')
>  =20
>=20


--=20
Best regards,
Vladimir

