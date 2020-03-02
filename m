Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0807AC3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 20:58:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3BC32173E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 20:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavecomp.com header.i=@wavecomp.com header.b="I/UDMDbV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3BC32173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8s9Q-00031I-1d
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 15:58:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41882)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <amarkovic@wavecomp.com>) id 1j8s8i-0002XL-PJ
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 15:58:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amarkovic@wavecomp.com>) id 1j8s8f-00076n-Cw
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 15:58:12 -0500
Received: from mail-mw2nam10on2090.outbound.protection.outlook.com
 ([40.107.94.90]:58016 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
 id 1j8s8f-00076J-21
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 15:58:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MAcAlA4vQba+lIGyuaX4cjcqxkQvWTriq7E++XhbyKFYF0djlKH7eH0lo2vHt82dp0ECONQTfHxWNOhlHD2+UJOj4CM8/YCnJRJFaGxZzHUWnGdLnV5L4kPerwVnPKCnukAkGArjAP2c7xiKOvO4oeY+Mso+jy6jzBpcnstGLbonntwowU+DSzNbhPa1HaNoVGQjG1xy8kX+uM9fVp5Uu8N1NshXFPnblsq2X7W1S5o+nO/UneNkpoUxcBkwe2G2EtsVEcAHZYdIPDFXmvIcB6K6x4+SsmhyMUbsl3t8DnieFbPiFbS9Vn8sAcXfQjU6FlWenpV0p5/mmnq7XET4gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HESIG9pVlEeAj6/xaeY1OCzt02xwOq5bwowpWLEOybc=;
 b=DSkQFHq4FpGut6qurvp11B4SSC9yAsXrFLTH5K+k7Kv9tCOWhhlALAy83OMQ6k8Xh+XeZXgzftwhlnhgpVVXJ4gFyuYLsupezGjqUBUHzDXdV1YWcU2MmR1ER+Oh8b8ZI6BiFXN9sLzB/tkBxdhx29UbSAUZH+xM7aRC2nkQUJntpAfMklsSAtue6uiCU64w0p6js/+3zkO/uaF3Ss7spHev+kE+p8nhn6uEy3uvz5zs4pt5C+/aTGMKGxw0v8C4OE5BX7I0AvtMFXoK4WCoL/OPhyKmwlDdSFKH7CEHfUPpGOMq8RgLAU+YQn97hzVGjt8lWkeZfXxs//zVuteY5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wavecomp.com; dmarc=pass action=none header.from=wavecomp.com;
 dkim=pass header.d=wavecomp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HESIG9pVlEeAj6/xaeY1OCzt02xwOq5bwowpWLEOybc=;
 b=I/UDMDbV1C73FHfVOAhRirKWEyd7wxjwml6mvjWw/oJ0BzEIqKEiRyf+ow6xnTPbwhcemdDEzAoGwy8/nKsNO+WjvqSQ0TifteE9IbAgC5hiZu7xEciN9MMVU6JJZ0mI3VGW6SCN2F5wC5hNKa/cKYI3zewpsMan/s9Atc6m6X8=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
 (2603:10b6:405:23::11) by BN6PR2201MB1345.namprd22.prod.outlook.com
 (2603:10b6:405:1e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Mon, 2 Mar
 2020 20:58:04 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::c804:a036:269:9290]) by BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::c804:a036:269:9290%4]) with mapi id 15.20.2750.027; Mon, 2 Mar 2020
 20:58:04 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: Peter Maydell <peter.maydell@linaro.org>, Aleksandar Markovic
 <aleksandar.markovic@rt-rk.com>
Subject: Re: [EXTERNAL]Re: [PULL 5/5] tests/acceptance: Count multiple Tux
 logos displayed on framebuffer
Thread-Topic: [EXTERNAL]Re: [PULL 5/5] tests/acceptance: Count multiple Tux
 logos displayed on framebuffer
Thread-Index: AQHV8NDsSXS+4lEPokm25atMOLoJfKg1x17x
Date: Mon, 2 Mar 2020 20:58:04 +0000
Message-ID: <BN6PR2201MB12519E5CF54B5C921CD4404AC6E70@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1582810056-22646-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1582810056-22646-6-git-send-email-aleksandar.markovic@rt-rk.com>,
 <CAFEAcA_ZL8kd+DaHz-debq7A2simEdB8GNzty890sfc=SjrByw@mail.gmail.com>
In-Reply-To: <CAFEAcA_ZL8kd+DaHz-debq7A2simEdB8GNzty890sfc=SjrByw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c8e27d0-9146-4760-a1dd-08d7beec66d8
x-ms-traffictypediagnostic: BN6PR2201MB1345:
x-microsoft-antispam-prvs: <BN6PR2201MB134599C5F1C80A6D3DC48273C6E70@BN6PR2201MB1345.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(136003)(366004)(39840400004)(346002)(396003)(199004)(189003)(2906002)(66446008)(81156014)(64756008)(66556008)(66946007)(66476007)(8676002)(8936002)(81166006)(4326008)(508600001)(966005)(52536014)(71200400001)(5660300002)(33656002)(7696005)(9686003)(316002)(186003)(6506007)(91956017)(76116006)(55016002)(53546011)(26005)(86362001)(54906003)(55236004)(110136005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1345;
 H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zvv12F90X0hcMgTBGKHJiLhJsZcgPFHIKF8M2Ba61K7PMecv8WA3ufSfrm7u2IshTeC75e8n6PK4vvGfUg6fuqqkztwquIujvItftVCYa8+XIoTgMpPFGKo/H39LRBvQIIrFAJWt4EuscCdixt5ycNjuinYtzOImWrju8PkV6246EWH5cHre1aOfDdMu1g84BBNioHWvZ660Ain3icDJn5wkVRkP7NsiOn/BbsuHKtaG2fZA+PZMPbMxTpaHul0Ab90jW1IAtwQ8HWRuToV26Ycnf+7KFlndGB5zA9bPEPkQUtlllfqjDvcfwB5AbBIJiKUItTnzWDspQxTiloO/3bk+6LmtiXVPoAd95T37To0rh1ZR/3mXNjWovBhp4KXq61L/BFi9/UyJknsaD5cpPO4+PxJ1/nd2kLq+v53gbaIm3bEGJmfGWasXOycHZFHaTcXSTxlSEFtcO4o6RRL6nDyp4uFfhgnyw9s+OYEhL08/HoKdWc1TFnkm/zffUD8pvd66TkPzivoFNuXdP7ve3Q==
x-ms-exchange-antispam-messagedata: nHhb/gjVD6rz7fejE00gkZkBbo2ExnowOLsEKu/WtbRwgnah4OXZzmUcA80lKXkLPOhw15IJQL2xcxl+t+omckrRzUVJLtnKXrONFFVlsMkn/qYutQQ1Zdy1n7YkKGnLEU20GV6MTrpMwoXyaPjeVg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c8e27d0-9146-4760-a1dd-08d7beec66d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 20:58:04.1897 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0PBeq31gXtb4nJF8xGOTJJIl3wkO6LdVy0eOJmumj6luSRs1xCAsaMP8CghHfojMQcPYifJmXDX3TKMN6PF8SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1345
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.94.90
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

> From: Peter Maydell <peter.maydell@linaro.org>=0A=
> Sent: Monday, March 2, 2020 9:26 PM=0A=
> To: Aleksandar Markovic=0A=
> Cc: QEMU Developers; Aleksandar Markovic; Philippe Mathieu-Daud=E9=0A=
> Subject: [EXTERNAL]Re: [PULL 5/5] tests/acceptance: Count multiple Tux lo=
gos displayed on framebuffer=0A=
> =0A=
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
> =0A=
> Hi -- this doesn't seem to work on my system:=0A=
> =0A=
=0A=
Thank you for bringing this to our attention.=0A=
=0A=
It looks like an honest mistake to me. Too bad=0A=
none of us tested the case of environment like=0A=
yours, even though it looked reasonable to test it.=0A=
=0A=
Philippe, Peter's solution looks good to me. What=0A=
do you think?=0A=
=0A=
Peter, would you like me to submit a patch with your=0A=
proposal, authored by you, and than soon send it as=0A=
a part of a small pull request?=0A=
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
> =0A=
> It looks like the @skipUnless directive on the class didn't=0A=
> have any effect. Moving it to the individual test functions seems=0A=
> to cause them to be skipped as intended (as the integratorcp=0A=
> framebuffer test is):=0A=
> =0A=
> diff --git a/tests/acceptance/machine_mips_malta.py=0A=
> b/tests/acceptance/machine_mips_malta.py=0A=
> index 92b4f28a112..98463f77573 100644=0A=
> --- a/tests/acceptance/machine_mips_malta.py=0A=
> +++ b/tests/acceptance/machine_mips_malta.py=0A=
> @@ -30,8 +30,6 @@ except ImportError:=0A=
>      CV2_AVAILABLE =3D False=0A=
> =0A=
> =0A=
> -@skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')=0A=
> -@skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')=0A=
>  class MaltaMachineFramebuffer(Test):=0A=
> =0A=
>      timeout =3D 30=0A=
> @@ -91,6 +89,8 @@ class MaltaMachineFramebuffer(Test):=0A=
>              cv2.imwrite(debug_png, screendump_bgr)=0A=
>          self.assertGreaterEqual(tuxlogo_count, cpu_cores_count)=0A=
> =0A=
> +    @skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')=0A=
> +    @skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')=0A=
>      def test_mips_malta_i6400_framebuffer_logo_1core(self):=0A=
>          """=0A=
>          :avocado: tags=3Darch:mips64el=0A=
> @@ -99,6 +99,8 @@ class MaltaMachineFramebuffer(Test):=0A=
>          """=0A=
>          self.do_test_i6400_framebuffer_logo(1)=0A=
> =0A=
> +    @skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')=0A=
> +    @skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')=0A=
>      def test_mips_malta_i6400_framebuffer_logo_7cores(self):=0A=
>          """=0A=
>          :avocado: tags=3Darch:mips64el=0A=
> @@ -108,6 +110,8 @@ class MaltaMachineFramebuffer(Test):=0A=
>          """=0A=
>          self.do_test_i6400_framebuffer_logo(7)=0A=
> =0A=
> +    @skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')=0A=
> +    @skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')=0A=
>      def test_mips_malta_i6400_framebuffer_logo_8cores(self):=0A=
>          """=0A=
>          :avocado: tags=3Darch:mips64el=0A=
> =0A=
> thanks=0A=
> -- PMM=0A=

