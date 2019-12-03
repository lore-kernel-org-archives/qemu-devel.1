Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359AFC432C3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 16:17:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05BA020833
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 16:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="COmc9SUx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05BA020833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icAru-0004Zi-SZ
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 11:17:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56540)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1icAZY-0003uI-TI
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 10:58:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1icAZT-0004ep-D8
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 10:58:40 -0500
Received: from mail-eopbgr130138.outbound.protection.outlook.com
 ([40.107.13.138]:7936 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1icAZS-0004Io-Fy; Tue, 03 Dec 2019 10:58:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nR9YxkBnwZbSAHKyrq3LnyNccBRqDHQILuKgVaalp4ygvOa1lsngDrjJv3gHwO/xQBJu71Oui0p3n8C/pzXtEBNq+MacK7qqxkaSEBQM44WXuvpIznxiib2xikpOdMR9yyZ3M48O7/peRUna2hrLCTmAyeLk73RSzPogzmw/OY3BhOwpfGN8KNdQE/z8PuL3TWZKNbyfMyCGCt2ucJTkOq2BieQmxvxI3UOt0bs46u0ytF04fYQ2ftvLLWy33UdcyFphTJuV5A1Oucg3lFYKMUxBRp313OHxMEaWvRMsN9yYQPHdBJmfqX0n1HTlw3CSAKm8CbdWxUYiOD4VmiNe5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyL9Fop+lpr9Qip6AIhH00AlrfgNqhNR9yGNmDBTRTE=;
 b=YReC4zCNFMNapP9/pTP9pwSIXm7P/3mcqb4xjr9eQDtNkx54vy62WLBEh8ZcbJqG98LAA3B08i7xEnmDZDYCdYI0sHv7SPM7I6SkhWYlk3iycQyio2y5ay+veo9VlB3YrndMlzzo31d0NJEdlNgGeq6dWm2jb9qapYUBjYU1z5AaPcOS30CcnPzzaXOj89l0jkageikrN8M35w8IzfHt8iZIYECRgtfLjGzMoEjV4QTExFs4sC7ReZU+2I5dFpsh4hCxOP+BBWl5c6XfO8x0P/9oRPKWke3sypWRTXbjtY/hE1CrnowHFm54IcE61lxLc4dI77dcqB1ukdpSNgY00g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyL9Fop+lpr9Qip6AIhH00AlrfgNqhNR9yGNmDBTRTE=;
 b=COmc9SUxE1xEwDh/lXkJVdnCdU+KCd0JGNoldy0HXrWW0CZj/5sGB5q283ocJHIXtwUnJ5T648ni8bATpFKOdB/V7JMLmmIV/KfYZ5jSeWB3LS9hTcrPLD5LI2VYN15wcNSEKVjNEecEX8bDBjhSiMXqjjnd38+YABHvxYmlzYM=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3350.eurprd08.prod.outlook.com (52.135.163.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.17; Tue, 3 Dec 2019 15:58:32 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2516.003; Tue, 3 Dec 2019
 15:58:32 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH for-5.0 v2 22/23] iotests: Check that @replaces can
 replace filters
Thread-Topic: [PATCH for-5.0 v2 22/23] iotests: Check that @replaces can
 replace filters
Thread-Index: AQHVmKmTLKw1sAFL3E+HvoNaLKFLj6eos7AA
Date: Tue, 3 Dec 2019 15:58:32 +0000
Message-ID: <c75475a4-f2ab-bd99-1c26-463c48c4d94c@virtuozzo.com>
References: <20191111160216.197086-1-mreitz@redhat.com>
 <20191111160216.197086-23-mreitz@redhat.com>
In-Reply-To: <20191111160216.197086-23-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0200.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::24) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191203185830081
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e92d9da-4f78-4c0a-ec76-08d77809a545
x-ms-traffictypediagnostic: AM6PR08MB3350:
x-microsoft-antispam-prvs: <AM6PR08MB33504868435593889611EE1FC1420@AM6PR08MB3350.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(396003)(346002)(366004)(136003)(39840400004)(189003)(199004)(4326008)(66446008)(6246003)(478600001)(31686004)(6436002)(25786009)(386003)(6512007)(102836004)(52116002)(26005)(6506007)(2501003)(2906002)(3846002)(186003)(54906003)(71190400001)(110136005)(316002)(6486002)(76176011)(14454004)(229853002)(64756008)(66946007)(256004)(36756003)(2616005)(446003)(6116002)(11346002)(66556008)(8676002)(66476007)(31696002)(5660300002)(71200400001)(81166006)(81156014)(86362001)(8936002)(305945005)(7736002)(99286004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3350;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QdrG/RUjEZIkWSXyrdrgcL2ZWE5MuN3I6z0eWa1b5QSq325tzdVFYhT8DWeKwqB+BT+YQHqNBw2dgXlZwUcDFM3SgVLj4lefVRweXWn4vFtxdWAsm2xau2J2fxbcsLPTe6OxX8ZktgtA0xv6o5VMBjSgD3FS458q+dSGsrdeyi9jHXAHHjo8nB9+UzzOaRp1NItmnqnLV+OZZ6Rw/23pYFflmeLyIJGqRpFu+0Ilqn0M7idlRXp/BD7DMn0CjtZ5izqA0oGTI/CPaZPLNQQsJ2JoZ9BvvnbX+v2weIc1KK7tvx6olxQ/vpAYnRP6oKgl6tgQTij5F0kcJw5c1WvpP4Av1LVw/mhJbuvRaImbgtspQF/54A5YiPPVklRJQ7nG+yJ60h/9G12+Uz0/p7R8w60CoFLiX0CFA2sZ61+9ibjrnO2krTdJ8gwnOqcEJDY7
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <E16CAD2BCC919C4FA2263CCB75097979@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e92d9da-4f78-4c0a-ec76-08d77809a545
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 15:58:32.2544 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0j/ULbzlN+gscOSlUSfEhHDY29IbSJChwwHirofAmWPdbCsbQcch0NzMvOgmkBNVe6zI70nZeHhYP35TjwYXd36fzHQ4rlsbHqnXXrhTJOs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3350
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.138
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
>   tests/qemu-iotests/041     | 46 ++++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/041.out |  4 ++--
>   2 files changed, 48 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
> index ab0cb5b42f..9a00cf6f7b 100755
> --- a/tests/qemu-iotests/041
> +++ b/tests/qemu-iotests/041
> @@ -1200,6 +1200,52 @@ class TestOrphanedSource(iotests.QMPTestCase):
>           self.assertFalse('mirror-filter' in nodes,
>                            'Mirror filter node did not disappear')
>  =20
> +# Test cases for @replaces that do not necessarily involve Quorum
> +class TestReplaces(iotests.QMPTestCase):
> +    # Each of these test cases needs their own block graph, so do not
> +    # create any nodes here
> +    def setUp(self):
> +        self.vm =3D iotests.VM()
> +        self.vm.launch()
> +
> +    def tearDown(self):
> +        self.vm.shutdown()
> +        for img in (test_img, target_img):
> +            try:
> +                os.remove(img)
> +            except OSError:
> +                pass
> +
> +    """
> +    Check that we can replace filter nodes.
> +    """

PEP8 says, that doc string should appear after "def" line.
(this applies to previous patch too)

> +    @iotests.skip_if_unsupported(['copy-on-read'])
> +    def test_replace_filter(self):
> +        result =3D self.vm.qmp('blockdev-add', **{
> +                                 'driver': 'copy-on-read',
> +                                 'node-name': 'filter0',
> +                                 'file': {
> +                                     'driver': 'copy-on-read',
> +                                     'node-name': 'filter1',
> +                                     'file': {
> +                                         'driver': 'null-co'
> +                                     }
> +                                 }
> +                             })
> +        self.assert_qmp(result, 'return', {})
> +
> +        result =3D self.vm.qmp('blockdev-add',
> +                             node_name=3D'target', driver=3D'null-co')
> +        self.assert_qmp(result, 'return', {})
> +
> +        result =3D self.vm.qmp('blockdev-mirror', job_id=3D'mirror', dev=
ice=3D'filter0',
> +                             target=3D'target', sync=3D'full', replaces=
=3D'filter1')
> +        self.assert_qmp(result, 'return', {})
> +
> +        self.complete_and_wait('mirror')
> +
> +        self.vm.assert_block_path('filter0', '/file', 'target')
> +
>   if __name__ =3D=3D '__main__':
>       iotests.main(supported_fmts=3D['qcow2', 'qed'],
>                    supported_protocols=3D['file'])
> diff --git a/tests/qemu-iotests/041.out b/tests/qemu-iotests/041.out
> index ffc779b4d1..877b76fd31 100644
> --- a/tests/qemu-iotests/041.out
> +++ b/tests/qemu-iotests/041.out
> @@ -1,5 +1,5 @@
> -........................................................................=
.....................
> +........................................................................=
......................
>   ----------------------------------------------------------------------
> -Ran 93 tests
> +Ran 94 tests
>  =20
>   OK
>=20


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


--=20
Best regards,
Vladimir

