Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D661C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 21:21:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8F51208C3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 21:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavecomp.com header.i=@wavecomp.com header.b="L+/ZojBd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8F51208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8sVT-0001N6-17
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 16:21:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45140)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <amarkovic@wavecomp.com>) id 1j8sUk-0000wd-2G
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 16:20:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amarkovic@wavecomp.com>) id 1j8sUf-00037F-8Q
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 16:20:57 -0500
Received: from mail-eopbgr700127.outbound.protection.outlook.com
 ([40.107.70.127]:18475 helo=NAM04-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
 id 1j8sUb-00032c-Px
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 16:20:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLrnOXmMKxS0/dlfxBoBkvXVJWhwxCWqM8no/tgo11PH97N6S63PkqpM6pFavPTKuG87OjsKX8jX8N2yRXFGfcFHV8nmgQn7NlMfV0J0s3FA6WopRFDW0KOVQhSWvc2UgfKsxk0BhNLVhM5yppN+wTirNfiHmuMAwL/SRnN9NVeaZcbqWRE4bc5a/6AsesnmKxIPvFab9zkv7HdP+9Qyj9/ZXDEEZgq21mpVFXrDLUeRtsGYGY9M5kLtHijLql2wPqCdEmLRrHarNPlwXzeE3jXqMujkoXAbOo/phbpsRRaVZAvYUPLs8xEgiichCZ1D+qdd2rSG3wqkRpkHzgPu8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Cq9RlJ52SrC7jlGBmnNkYFIKCg91mOJnI6z5hiPMMU=;
 b=a1+TvhVk+lLAgYHh0KupN8Kq+LN6hfMZC4lqAH1u88wwbsfn+4oWNjgJ+WGCmVqOE68/8r/bvmqtSytvscqhwOp1KAI8wBySZw4P7X4vwnaYMQYGAGrZyfU0LZFATB5ZkNHzClt2UE5KcAD7nXwm1+m9+g6RmDfFPSHvWlc7bCfJmkXEX4wS6fjjTLfl07y2Gp6uNJ0ihltpDYX2hqDcAHQKsvHduZsXBcSEWjmDsRsX5EU3YBxty9XWErhWYwGFQhFAnP9SQEFzLxGLv5SCXP/cZ1LNrRfZVG+YyLa9lGYimkM3AEFN805IN/99YkfSlhzJjPo3VuQa8eYFNCsJuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wavecomp.com; dmarc=pass action=none header.from=wavecomp.com;
 dkim=pass header.d=wavecomp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Cq9RlJ52SrC7jlGBmnNkYFIKCg91mOJnI6z5hiPMMU=;
 b=L+/ZojBdViOmZ8NN4+uEzQB7vqW7FlIKB+KECvp697iJdl6ALlkNMqszpJ4b21vL51Sa5OVg5Ean4Rs4xv8oQ9lR9Qwo/Lczl6Il35U3INJJV4YsHv8MBysQKy64d3yufigoI2sJxy9VNwRcqJm4RH5gM7U0FWzG9dRA3hUexd0=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
 (2603:10b6:405:23::11) by BN6PR2201MB1410.namprd22.prod.outlook.com
 (2603:10b6:405:24::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Mon, 2 Mar
 2020 21:20:46 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::c804:a036:269:9290]) by BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::c804:a036:269:9290%4]) with mapi id 15.20.2750.027; Mon, 2 Mar 2020
 21:20:46 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: Peter Maydell <peter.maydell@linaro.org>, Aleksandar Markovic
 <aleksandar.markovic@rt-rk.com>, =?iso-8859-1?Q?Alex_Benn=E9e?=
 <alex.bennee@linaro.org>
Subject: Re: [EXTERNAL]Re: [PULL 5/5] tests/acceptance: Count multiple Tux
 logos displayed on framebuffer
Thread-Topic: [EXTERNAL]Re: [PULL 5/5] tests/acceptance: Count multiple Tux
 logos displayed on framebuffer
Thread-Index: AQHV8NDsSXS+4lEPokm25atMOLoJfKg1x17xgAAHYKA=
Date: Mon, 2 Mar 2020 21:20:46 +0000
Message-ID: <BN6PR2201MB12510B153B53049B80046D09C6E70@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1582810056-22646-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1582810056-22646-6-git-send-email-aleksandar.markovic@rt-rk.com>,
 <CAFEAcA_ZL8kd+DaHz-debq7A2simEdB8GNzty890sfc=SjrByw@mail.gmail.com>,
 <BN6PR2201MB12519E5CF54B5C921CD4404AC6E70@BN6PR2201MB1251.namprd22.prod.outlook.com>
In-Reply-To: <BN6PR2201MB12519E5CF54B5C921CD4404AC6E70@BN6PR2201MB1251.namprd22.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83522e07-8445-48fa-ba4e-08d7beef92b6
x-ms-traffictypediagnostic: BN6PR2201MB1410:
x-microsoft-antispam-prvs: <BN6PR2201MB1410A92CD9D0EDD21A8A48E4C6E70@BN6PR2201MB1410.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(396003)(136003)(376002)(346002)(366004)(189003)(199004)(66476007)(66946007)(5660300002)(52536014)(66446008)(91956017)(4326008)(66556008)(64756008)(2906002)(86362001)(966005)(508600001)(33656002)(55016002)(9686003)(71200400001)(76116006)(8676002)(186003)(7696005)(53546011)(2940100002)(54906003)(81166006)(81156014)(6506007)(8936002)(316002)(110136005)(26005)(55236004)(586874002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1410;
 H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5mF+xxpBs9UlmMBVk1cKbtL54GTejBHYE8r6nfthwIZvCO2RiIRfVrUHInSIV1MBx0UW/at+KQROeNi+T3Jn9luhQCV5Vl7iqDKj+cd3/V19BfkrPNedqRt5o2lLiZksOg8rTlN25iylicUVlhxrLBWCksYAUPEvbyLv98adt+p+dSnunZZqWDhonYPpgGcNZMcJIoV8IY7YUxDRk67uS/9bIgKnu3t+F9/zSzSStRJCPJgVjAwd0kUuuFN2dwWczDEnvaB/OddwM7kmfwNIz4Ve1RnKns9eaY+iYccVhfmJVwgf/s5DWDXK/DSv1BjAaIzG1qp8Bk+aZPujMyU0h10Avtfe2OpgCDVvFPOUSqWo5Wco8qez+OJO9BJtvjqi0K7qhgdR/z+G7KfPfRqvJEFOsKDU9th5LAhsp5cNCMXuL7ElSr9DkFC1WpTTw704UaXmLapQcbqv00DJ7bVuLYK9lLtuxyQabs3iC0n8gLmnKrVF9PNxel+LX+ZFiRN3oLVdnVkymKyV3pf5x5xra8cN9wD7EugjUOetSBFnytRSMpw0F4y207y6lXDOZtvN/NvC2ejOyx6nY8Df6D4y2w==
x-ms-exchange-antispam-messagedata: 8qhZZgUs36SwLS1sMRvCN/klUaI/VdNv/QqMD5G0quLW/fXDNKqsdDROgB7xzYwJMrXUmzicq7VGIObecMmfszavl1TphTJtN150RJzWsbt+Hrfq54XsU5av/kStat+WOs1JpqUJSkAy49LM3s42LQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83522e07-8445-48fa-ba4e-08d7beef92b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 21:20:46.2385 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ygTgEtmRYd+tTbR/G94/THmZjZ/T2WzZuVVu+qkfSyyypi9LmZwiJ3jKQ7atb3s3rMWT3h+pk1aqzxcSV2TdkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1410
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.70.127
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=0A=
=0A=
________________________________________=0A=
From: Aleksandar Markovic <amarkovic@wavecomp.com>=0A=
Sent: Monday, March 2, 2020 9:58 PM=0A=
To: Peter Maydell; Aleksandar Markovic=0A=
Cc: QEMU Developers; Philippe Mathieu-Daud=E9=0A=
Subject: Re: [EXTERNAL]Re: [PULL 5/5] tests/acceptance: Count multiple Tux =
logos displayed on framebuffer=0A=
=0A=
> From: Peter Maydell <peter.maydell@linaro.org>=0A=
> Sent: Monday, March 2, 2020 9:26 PM=0A=
> To: Aleksandar Markovic=0A=
> Cc: QEMU Developers; Aleksandar Markovic; Philippe Mathieu-Daud=E9=0A=
> Subject: [EXTERNAL]Re: [PULL 5/5] tests/acceptance: Count multiple Tux lo=
gos displayed on framebuffer=0A=
>=0A=
> On Thu, 27 Feb 2020 at 13:28, Aleksandar Markovic=0A=
> <aleksandar.markovic@rt-rk.com> wrote:=0A=
> >=0A=
> > From: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>=0A=
> >=0A=
> > Add a test that verifies that each core properly displays the Tux=0A=
> > logo on the framebuffer device.=0A=
> >=0A=
> > We simply follow the OpenCV "Template Matching with Multiple Objects"=
=0A=
> > tutorial, replacing Lionel Messi by Tux:=0A=
> > https://docs.opencv.org/4.2.0/d4/dc6/tutorial_py_template_matching.html=
=0A=
>=0A=
> Hi -- this doesn't seem to work on my system:=0A=
>=0A=
=0A=
It appears Alex send a similar, but different patch already:=0A=
=0A=
https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg00324.html=0A=
=0A=
What do we do, Alex?=0A=
=0A=
Thanks again,=0A=
Aleksandar=0A=
=0A=
>  (38/74) tests/acceptance/machine_arm_integratorcp.py:IntegratorMachine.t=
est_integratorcp_console:=0A=
> SKIP: untrusted code=0A=
>  (39/74) tests/acceptance/machine_arm_integratorcp.py:IntegratorMachine.t=
est_framebuffer_tux_logo:=0A=
> SKIP: Python NumPy not installed=0A=
>  (40/74) tests/acceptance/machine_arm_n8x0.py:N8x0Machine.test_n800:=0A=
> SKIP: untrusted code=0A=
>  (41/74) tests/acceptance/machine_arm_n8x0.py:N8x0Machine.test_n810:=0A=
> SKIP: untrusted code=0A=
>  (42/74) tests/acceptance/machine_m68k_nextcube.py:NextCubeMachine.test_b=
ootrom_framebuffer_size:=0A=
> PASS (3.47 s)=0A=
>  (43/74) tests/acceptance/machine_m68k_nextcube.py:NextCubeMachine.test_b=
ootrom_framebuffer_ocr_with_tesseract_v3:=0A=
> SKIP: tesseract v3 OCR tool not available=0A=
>  (44/74) tests/acceptance/machine_m68k_nextcube.py:NextCubeMachine.test_b=
ootrom_framebuffer_ocr_with_tesseract_v4:=0A=
> SKIP: tesseract v4 OCR tool not available=0A=
>  (45/74) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.t=
est_mips_malta_i6400_framebuffer_logo_1core:=0A=
> ERROR: name 'cv2' is not defined (5.43 s)=0A=
>=0A=
> It looks like the @skipUnless directive on the class didn't=0A=
> have any effect. Moving it to the individual test functions seems=0A=
> to cause them to be skipped as intended (as the integratorcp=0A=
> framebuffer test is):=0A=
>=0A=
> diff --git a/tests/acceptance/machine_mips_malta.py=0A=
> b/tests/acceptance/machine_mips_malta.py=0A=
> index 92b4f28a112..98463f77573 100644=0A=
> --- a/tests/acceptance/machine_mips_malta.py=0A=
> +++ b/tests/acceptance/machine_mips_malta.py=0A=
> @@ -30,8 +30,6 @@ except ImportError:=0A=
>      CV2_AVAILABLE =3D False=0A=
>=0A=
>=0A=
> -@skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')=0A=
> -@skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')=0A=
>  class MaltaMachineFramebuffer(Test):=0A=
>=0A=
>      timeout =3D 30=0A=
> @@ -91,6 +89,8 @@ class MaltaMachineFramebuffer(Test):=0A=
>              cv2.imwrite(debug_png, screendump_bgr)=0A=
>          self.assertGreaterEqual(tuxlogo_count, cpu_cores_count)=0A=
>=0A=
> +    @skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')=0A=
> +    @skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')=0A=
>      def test_mips_malta_i6400_framebuffer_logo_1core(self):=0A=
>          """=0A=
>          :avocado: tags=3Darch:mips64el=0A=
> @@ -99,6 +99,8 @@ class MaltaMachineFramebuffer(Test):=0A=
>          """=0A=
>          self.do_test_i6400_framebuffer_logo(1)=0A=
>=0A=
> +    @skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')=0A=
> +    @skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')=0A=
>      def test_mips_malta_i6400_framebuffer_logo_7cores(self):=0A=
>          """=0A=
>          :avocado: tags=3Darch:mips64el=0A=
> @@ -108,6 +110,8 @@ class MaltaMachineFramebuffer(Test):=0A=
>          """=0A=
>          self.do_test_i6400_framebuffer_logo(7)=0A=
>=0A=
> +    @skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')=0A=
> +    @skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')=0A=
>      def test_mips_malta_i6400_framebuffer_logo_8cores(self):=0A=
>          """=0A=
>          :avocado: tags=3Darch:mips64el=0A=
>=0A=
> thanks=0A=
> -- PMM=0A=

