Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53370C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 14:50:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CC522082A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 14:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavecomp.com header.i=@wavecomp.com header.b="sTiddv3c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CC522082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hziyt-0006kz-Ou
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 10:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39431)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <arikalo@wavecomp.com>) id 1hzixK-0004qJ-GW
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 10:48:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arikalo@wavecomp.com>) id 1hzixH-00016h-SE
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 10:48:22 -0400
Received: from mail-eopbgr760099.outbound.protection.outlook.com
 ([40.107.76.99]:62318 helo=NAM02-CY1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <arikalo@wavecomp.com>)
 id 1hzixG-000151-OV
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 10:48:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YzN1nSVSQ3+nfy4DQNUg4VTPvQ3IOAHId415u7NYFk3iArhdOouMcs39nIpc3IHKjJap2JqQHJOwUAZi+dZBx1PsmMzWl407WfvXlgANI82C+/bkdaZv0/+coij6tOIQESmw9Xa2l1Nb2xjrBnxq7XXzpXRMo9qunM7IrH+Kr65wk3sVSM81zDpXDjdpxIXw6sSPHFMalduSSR+/qo8ughlIdX3tZKXWeY3/o8/IuxQqs4CCQ5O8kki+XNaODMAlNU1LQCgEhFaVmB1EKHYJBkXa6LsZ09pVSzIpUnVpw2KC0GmezeCnbmPP3EK7vYMUTaj4nacFsGaFiVK5z/j03Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFp2D9VIQfFd5Vov2YPMj5p8DOgxlqaESTiL5qZIYqs=;
 b=nyXPA8Wt6UudrrGYvtCzOZtH1+iidlGKGsubmDLO2yD1cWE3SjOhwXD1Ftn+NpNYX9mRk313nAWPANSVnYGnoQWO/REEi5JtL2ozS5iQkl3EPwZvggr/c6sB+3m5Ny+iOCJyJidb3lwNkAUNDPDvGwUjnW7MFF9SyVIIxr7fVQLq2eyYbm7JIOKZQdpx4nt9f7uKcB1rWn2pvyeOKQYlwwLpnR7gi9Fa5mSwnHb39HE0wiM34glaQUquKLepP0miDsoj1yGCPFwycVcYcgfPYY7htaUORskYn+pxRtqzj1K/65jXxgI/PfggjTxjtcCaDcqRkOoqZIUe7S6uWRZaPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wavecomp.com; dmarc=pass action=none header.from=wavecomp.com;
 dkim=pass header.d=wavecomp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFp2D9VIQfFd5Vov2YPMj5p8DOgxlqaESTiL5qZIYqs=;
 b=sTiddv3cJt56YQrVAnikwSmD6n5QYCJWSxd6rNPAqrvI13vz1kJepV3sxg/Q5UqO6FQMSUw8J3K4Hg47UW+jJMtG3fL26uHCCEvWoXVIqparO0Hug2RFCP/G++l6T7ANGPMff4JAEmtQ1R/1iIghysfFcEGeo33FXbzM+CyMWnE=
Received: from DM5PR22MB1658.namprd22.prod.outlook.com (10.164.152.163) by
 DM5PR22MB0331.namprd22.prod.outlook.com (10.173.175.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Mon, 19 Aug 2019 14:48:16 +0000
Received: from DM5PR22MB1658.namprd22.prod.outlook.com
 ([fe80::ed69:1c9f:bdff:2197]) by DM5PR22MB1658.namprd22.prod.outlook.com
 ([fe80::ed69:1c9f:bdff:2197%5]) with mapi id 15.20.2178.018; Mon, 19 Aug 2019
 14:48:16 +0000
From: Aleksandar Rikalo <arikalo@wavecomp.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [EXTERNAL][PATCH v8 16/37] target/mips: Style improvements in
 mips_mipssim.c
Thread-Index: AQHVVobTIGpjcHBw/Ei75EpXFeFfb6cCjQlO
Date: Mon, 19 Aug 2019 14:48:15 +0000
Message-ID: <DM5PR22MB16586963B2C4E1BD18A0C4E5D2A80@DM5PR22MB1658.namprd22.prod.outlook.com>
References: <1566216496-17375-1-git-send-email-aleksandar.markovic@rt-rk.com>,
 <1566216496-17375-17-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1566216496-17375-17-git-send-email-aleksandar.markovic@rt-rk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=arikalo@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31484c7e-3fd4-43e6-ca81-08d724b4449c
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DM5PR22MB0331; 
x-ms-traffictypediagnostic: DM5PR22MB0331:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR22MB03310A7380782E9E0D7BF950D2A80@DM5PR22MB0331.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(376002)(346002)(366004)(396003)(39830400003)(189003)(199004)(99286004)(76116006)(66556008)(66476007)(66946007)(91956017)(64756008)(66066001)(6606003)(256004)(5024004)(2906002)(8676002)(81156014)(110136005)(66446008)(52536014)(71200400001)(71190400001)(2501003)(53936002)(3846002)(54906003)(6116002)(316002)(186003)(107886003)(7696005)(478600001)(76176011)(81166006)(8936002)(5660300002)(14454004)(7736002)(19627405001)(33656002)(6246003)(4326008)(486006)(74316002)(25786009)(446003)(86362001)(55236004)(53546011)(102836004)(6506007)(55016002)(54896002)(9686003)(229853002)(6436002)(476003)(11346002)(26005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR22MB0331;
 H:DM5PR22MB1658.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8jNYrh7w/kAxnQPtjNNzwb+NP1YTfrQ3Pu2moJwELNcYIJ63kiKQoZyWQ0K/eA3NYj0BxuUBCA3a/f9QRrAA4XGH/uJ88WxoJPqnBYHtOh6tAfacTWgNvxqv2dThcJdMp1LR6lUG1EiMNQWbIPfHyWmt6fZQ4vFcJDXeRPvwQcssMBAmKEDegCP6IjlLrvShNZLuYd+KVSfvXXuaavoWa45LHSyuu70iM9cIOFFYVQzOwbKRweLKP0yFULq9vAWxrTIDhWO9zgmFLHmqZ1VzGzXAFu+PXnX8CsDseIS6MKtI75IceYO8KXMruzNPqIsoRygXJwN6ilfAAAl7GoMXMotz/HiuvsH+pdj1+gLiFOEdq8NmWtDscuRzqOIzeDYXstsWMu/JHuDAhoS4WeSSj6MeLWzvejJWtOSmIduekEc=
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31484c7e-3fd4-43e6-ca81-08d724b4449c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 14:48:15.9094 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e8XWNB7ThCj6ejNT4MFGCw9f+1K+tO5V0WOAHzEKX/SpRy3/0YHlMlISR6UCVG450EmeXCoacD3ypfqcPbLl0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR22MB0331
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.76.99
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [EXTERNAL][PATCH v8 16/37] target/mips: Style
 improvements in mips_mipssim.c
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
Cc: "philmd@redhat.com" <philmd@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Sent: Monday, August 19, 2019 2:07 PM
> To: qemu-devel@nongnu.org <qemu-devel@nongnu.org>
> Cc: philmd@redhat.com <philmd@redhat.com>; Aleksandar Markovic <amarkovic=
@wavecomp.com>; Aleksandar Rikalo <arikalo@wavecomp.com>
> Subject: [EXTERNAL][PATCH v8 16/37] target/mips: Style improvements in mi=
ps_mipssim.c
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Fixes mostly errors and warnings reported by 'checkpatch.pl -f'.
>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  hw/mips/mips_mipssim.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
> index 824abda..b3155e17 100644
> --- a/hw/mips/mips_mipssim.c
> +++ b/hw/mips/mips_mipssim.c
> @@ -3,7 +3,7 @@
>   *
>   * Emulates a very simple machine model similar to the one used by the
>   * proprietary MIPS emulator.
> - *
> + *
>   * Copyright (c) 2007 Thiemo Seufer
>   *
>   * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> @@ -75,8 +75,9 @@ static int64_t load_kernel(void)
>                             (uint64_t *)&kernel_high, big_endian,
>                             EM_MIPS, 1, 0);
>      if (kernel_size >=3D 0) {
> -        if ((entry & ~0x7fffffffULL) =3D=3D 0x80000000)
> +        if ((entry & ~0x7fffffffULL) =3D=3D 0x80000000) {
>              entry =3D (int32_t)entry;
> +        }
>      } else {
>          error_report("could not load kernel '%s': %s",
>                       loaderparams.kernel_filename,
> @@ -88,9 +89,10 @@ static int64_t load_kernel(void)
>      initrd_size =3D 0;
>      initrd_offset =3D 0;
>      if (loaderparams.initrd_filename) {
> -        initrd_size =3D get_image_size (loaderparams.initrd_filename);
> +        initrd_size =3D get_image_size(loaderparams.initrd_filename);
>          if (initrd_size > 0) {
> -            initrd_offset =3D (kernel_high + ~INITRD_PAGE_MASK) & INITRD=
_PAGE_MASK;
> +            initrd_offset =3D (kernel_high + ~INITRD_PAGE_MASK) &
> +                            INITRD_PAGE_MASK;
>              if (initrd_offset + initrd_size > loaderparams.ram_size) {
>                  error_report("memory too small for initial ram disk '%s'=
",
>                               loaderparams.initrd_filename);
> @@ -174,8 +176,9 @@ mips_mipssim_init(MachineState *machine)
>      /* Map the BIOS / boot exception handler. */
>      memory_region_add_subregion(address_space_mem, 0x1fc00000LL, bios);
>      /* Load a BIOS / boot exception handler image. */
> -    if (bios_name =3D=3D NULL)
> +    if (bios_name =3D=3D NULL) {
>          bios_name =3D BIOS_FILENAME;
> +    }
>      filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
>      if (filename) {
>          bios_size =3D load_image_targphys(filename, 0x1fc00000LL, BIOS_S=
IZE);
> @@ -211,8 +214,10 @@ mips_mipssim_init(MachineState *machine)
>                               get_system_io(), 0, 0x00010000);
>      memory_region_add_subregion(get_system_memory(), 0x1fd00000, isa);
>
> -    /* A single 16450 sits at offset 0x3f8. It is attached to
> -       MIPS CPU INT2, which is interrupt 4. */
> +    /*
> +     * A single 16450 sits at offset 0x3f8. It is attached to
> +     * MIPS CPU INT2, which is interrupt 4.
> +     */
>      if (serial_hd(0))
>          serial_init(0x3f8, env->irq[4], 115200, serial_hd(0),
>                      get_system_io());
> --
> 2.7.4

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>

