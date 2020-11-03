Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCB3C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 06:55:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1DBE22277
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 06:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="aWXvyflg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1DBE22277
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZqDm-0004ac-UI
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 01:55:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kZqCt-00048m-LK
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 01:54:15 -0500
Received: from mail-eopbgr770087.outbound.protection.outlook.com
 ([40.107.77.87]:27714 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kZqCq-0007pp-Sc
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 01:54:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRHan91zCRr4RydwzmRQkchjeF+gWArJwVwAf1j0M5l8iihrYdPkcdyFs1bK8lhJH2xziisjCQ4CftZhE0nzYgiIotOqNiEnF/Q15MjdQQOtPbozIdXLRTT8+b+indbXZunplv+Tvkp/orj0+ODEWF7uDivbIZdQWe288Nr8omP0+GQymDiINPQltSsotCR9oTTlldRDMAY89IX36LtJ7bxJcaOzsaLhqDBeIrTcEmlZXKm1bzOxktEnMvXjqvIhxD5llK6wiokcHn3Mn2e6oTi7NizIvVQE+Qj21ywmS4msoeH381gGubtok1kO+Meq20MO1LJlg9dfIirffYwSKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5IJpHmVLirMNyUvFFySSlundHVJNgBwjxEJTeOhFFa4=;
 b=APtvgADsqycIi0UX0fuW0PT7//cXJm65P1vg90OnEXYqAbpiXkXnr0xG4HkmNGjvSr29PQy+VQC1XoUwGdFm5vIkMIAP52/5K7NYv+WZg9kBB/isaDdQanEpTpqDgl6KGabctYNUL2+LMoVGT8DV0kXfTC/an/wft9x2jY9OdIalJApnWPWTuccJK5po6clstlmvIPWfl5+3v7W6Rmc8GWq7bc8udqHxBo8wuwChOr9EucRZj2DSeSIY4YIlQlGLPR5WfKOo6/L/coMUsl4RdWivHZrcUbdxt2dan7OyPaHQYG79c28aP27HmMD9K8+OPeGXtniQVliHD+Y/jciGzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5IJpHmVLirMNyUvFFySSlundHVJNgBwjxEJTeOhFFa4=;
 b=aWXvyflgtUqSLFcokpHOtThHc3qDqVGXyf/usvKPG+yBpODe7Xw2msp04Iyqm/gZZ9X7Df6YF0Eu/75GnrhAe1puQeXDzlgrFs+K7i5c5rsL7tBBdm8eKCr1U5xYOInx+8DIAOKRR7pBLToSZiSTwtMKuzVyzA6NuRBwXxi8cKA=
Received: from BY5PR02MB6772.namprd02.prod.outlook.com (2603:10b6:a03:206::11)
 by BY5PR02MB7027.namprd02.prod.outlook.com (2603:10b6:a03:23e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Tue, 3 Nov
 2020 06:54:08 +0000
Received: from BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::75ed:4271:263b:fd15]) by BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::75ed:4271:263b:fd15%3]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 06:54:08 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH for-5.2] tcg: Remove assert from set_jmp_reset_offset
Thread-Topic: [PATCH for-5.2] tcg: Remove assert from set_jmp_reset_offset
Thread-Index: AQHWsZL8R88o8YrzuUu+dOk+p0JFcam1+H3g
Date: Tue, 3 Nov 2020 06:54:08 +0000
Message-ID: <BY5PR02MB6772BEBDCEA5EB01D6A48784CA110@BY5PR02MB6772.namprd02.prod.outlook.com>
References: <20201103033947.94157-1-richard.henderson@linaro.org>
In-Reply-To: <20201103033947.94157-1-richard.henderson@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2feb92ad-18b1-4176-0896-08d87fc54361
x-ms-traffictypediagnostic: BY5PR02MB7027:
x-microsoft-antispam-prvs: <BY5PR02MB7027145BC9F5874140B1F376CA110@BY5PR02MB7027.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:751;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k0IIQ+qqLVgrBElEz2IUw5sTEujM38ZtBXuueCMbsm8S5xdNELheWUm3J8rcko6bkB0TH/Dh7r7GrQP76XhsaCjrdKNCzr4jl+xCEFHOzrdLpqu7gE65HSaX1IOFUGNZyg/lqB5oShPlUNAL83kawAV2SWy3AgODwlVBdtJBM4Ko6LFD9Scrb7+psNR0oI8eeLxRT9+WFgnjohV8pgzfP2kZXRFlTvBPGZqMRh+mE3b2iWbbGkAschfHTGGQApuCB0/KLzDrv9/oxAK13rmJc2GTGSM15iZHQElwBFBKo8X5pif7kmlVpzwXAsHuQN/cPl8uicnRQaLA1+iRuBhi6A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6772.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(376002)(346002)(39860400002)(5660300002)(71200400001)(8936002)(26005)(86362001)(83380400001)(52536014)(8676002)(478600001)(2906002)(7696005)(186003)(66446008)(33656002)(66556008)(316002)(66476007)(64756008)(76116006)(9686003)(55016002)(66946007)(110136005)(53546011)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: dVmR1Icw5Og+963E9odAxTMlpkrAUUPxnmeDLql9WNwqPcN5lTJcLB+uEHgsKenRG6U3aQvXL2+7wrsrA5wqCzmqKuopKuAEkwTWVrvJbKf5Y57M0SwaPu8fKi8YTeNxR0NPIYA3Y1I/y2FBZBYkGUssrmOrbppX5pdPpqHOSKnKxE1tfyVHC7q2XrblQLObnSKFhg1XshyOuG8ivxH+VCOnB23TDZ9wTETC1goetvI+5sP/4YbmFVssHfnYKBIsN/mZvocJbkgyL+9PLKhKcSTrjmzbJtrEYSFHhDldh1H3AoLuNbDNcvwia+TLfRRIBbWrspmFdmDe+lvaTNXFnZ2JFsojKMstCZBcipaKgqkz11Ty/DjDWJWtItltdeDv+E6b5nOxAxl8LPImdXF+/xst/dESyuh/SGWfywWo1XEv5Pev9u0fBZcv1bC4sdWuOk1JN69oO/VgUJD6fxlQE6jcCWxIg/uBZ3eEtWJBaOCEcG02yc3dyBU7Qzvs12HwBVq50eo4Jq3INxNo/ZBbC+C3lZXdJHewERHL2Qwou4aBgcggRIioEg0I6mYWSRFqOU2W78oBcyWJYXUj86HMeNCtNJq1vfBIarvRoKwqzC22JI2zPls7EAmgSCqR71tCneErY23h7XXZfeP4UoTGmg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6772.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2feb92ad-18b1-4176-0896-08d87fc54361
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2020 06:54:08.7268 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cHq+rPvYZ8hECuseALdStPJe/hrrnz9Ogs8wzzcvUv057YK80c1GY8uwr5IVF2EkraBRmk0yTHLAdvtQL2oJeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB7027
Received-SPF: pass client-ip=40.107.77.87; envelope-from=saipava@xilinx.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:54:10
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Richard

> -----Original Message-----
> From: Richard Henderson <richard.henderson@linaro.org>
> Sent: Tuesday, November 3, 2020 9:10 AM
> To: qemu-devel@nongnu.org
> Cc: Sai Pavan Boddu <saipava@xilinx.com>
> Subject: [PATCH for-5.2] tcg: Remove assert from set_jmp_reset_offset
>=20
> The range check done here is done later, more appropriately, at the end o=
f
> tcg_gen_code.  There, a failing range check results in a returned error c=
ode,
> which causes the TB to be restarted at half the size.
>=20
> Reported-by: Sai Pavan Boddu <saipava@xilinx.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>=20
> Sai, would you try this against your failing testcase?
[Sai Pavan Boddu] Thanks, this patch fixes the test. Thanks for the support=
.


Tested-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>


Regards,
Sai Pavan
>=20
>=20
> r~
>=20
> ---
>  tcg/tcg.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index f49f1a7f35..43c6cf8f52 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -335,10 +335,11 @@ static bool tcg_resolve_relocs(TCGContext *s)
>=20
>  static void set_jmp_reset_offset(TCGContext *s, int which)  {
> -    size_t off =3D tcg_current_code_size(s);
> -    s->tb_jmp_reset_offset[which] =3D off;
> -    /* Make sure that we didn't overflow the stored offset.  */
> -    assert(s->tb_jmp_reset_offset[which] =3D=3D off);
> +    /*
> +     * We will check for overflow at the end of the opcode loop in
> +     * tcg_gen_code, where we bound tcg_current_code_size to UINT16_MAX.
> +     */
> +    s->tb_jmp_reset_offset[which] =3D tcg_current_code_size(s);
>  }
>=20
>  #include "tcg-target.c.inc"
> --
> 2.25.1


