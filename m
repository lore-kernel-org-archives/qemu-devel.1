Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B2BC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 14:46:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02B8E2070D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 14:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavecomp.com header.i=@wavecomp.com header.b="lLqOW2W4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02B8E2070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzivh-00030P-HI
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 10:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38870)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <arikalo@wavecomp.com>) id 1hziu3-0002Ft-Iq
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 10:45:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arikalo@wavecomp.com>) id 1hziu2-0007z0-EA
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 10:44:59 -0400
Received: from mail-eopbgr750101.outbound.protection.outlook.com
 ([40.107.75.101]:11150 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <arikalo@wavecomp.com>)
 id 1hziu2-0007yd-91
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 10:44:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDxFOSpCoLy7vJC1U4SsKzV6/gb/4wQaytz5f+mH6+GggZ3kCd0vIpo3AXM3ix5SStCrA/QMbjsP+xmh6Kt3cujEhbAj4x/s5jNzvZghd/gp9+YUWaMqjYXVfVBpGMwRSUiRDXK4/t/zj/pqLLSe2snLTDx3tRCVAZNIEq65fC33VGdI2JRqCi6XAFDtAX7O3kgh3ZsHLAxklwakQ3jljBh473ahANtNhZWBeG5MuF4DbPbo+k0EC5mjaEztIbnoq5Jq6ZSnhHOk1BQyx8aMIxOVHuv2YTEwRAF8QvUZoq6H+VARBhcUTk9+WIcsE2jc9qjCJKASrblo8XHLTpojtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhtvuRtxR0ddjGXV4lf5JVFJ40tnK7RwXBeOvSco/e4=;
 b=j1+Av9P4ZZB7KBKGbK/xraqdwMaZpoN0AhFQs8393fR8XaIL+S+NfDdyfMu14aUzvh7Ug8Iu1TlUjXEZaQHUlv1eC/pcdI7k3/xJjXRYm8NBuX2ggvHca+TTCN+WYCw4i0SD6M1/8Qm+GL64Js83qjYmcoRBL2W21BVUfAr2CPHLW3fkKM+HStEfb7ExW3vzMNBJ2E7fxGs0Tpz1uFNIq8McuPXW6pmnpnn6jIEgPmhIZdZSiZSmO/NL0V/BUI0dxqmojeLsiZGFeWLxbPvJRlqOpPLszIVVqrshORjIsatG7jMkhL4QGNrSprnhfoxXRl6+mdDKpOaq7qQjszLdcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wavecomp.com; dmarc=pass action=none header.from=wavecomp.com;
 dkim=pass header.d=wavecomp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhtvuRtxR0ddjGXV4lf5JVFJ40tnK7RwXBeOvSco/e4=;
 b=lLqOW2W4IF4Tu0Ut7Z/CvrdoM4jwpVQvTCJ5HhvenviNoj2tnoY71JYJj6GQHmKa/d85scC7mA1CJ9GOHvuaXXmgpRLezkEMrhDz18RHdguShtyqjBzHQbKIAQPvxS0QACTFvkcmFg+mdYHSczJERReCS7SHUFgg7JQoG4W62sc=
Received: from DM5PR22MB1658.namprd22.prod.outlook.com (10.164.152.163) by
 DM5PR22MB0683.namprd22.prod.outlook.com (10.172.190.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Mon, 19 Aug 2019 14:44:56 +0000
Received: from DM5PR22MB1658.namprd22.prod.outlook.com
 ([fe80::ed69:1c9f:bdff:2197]) by DM5PR22MB1658.namprd22.prod.outlook.com
 ([fe80::ed69:1c9f:bdff:2197%5]) with mapi id 15.20.2178.018; Mon, 19 Aug 2019
 14:44:56 +0000
From: Aleksandar Rikalo <arikalo@wavecomp.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [EXTERNAL][PATCH v8 12/37] target/mips: Style improvements in
 cps.c
Thread-Index: AQHVVobSjtPXUTva1UWIsUriwQW95acCjBOO
Date: Mon, 19 Aug 2019 14:44:56 +0000
Message-ID: <DM5PR22MB1658271D037A1AA61DA41928D2A80@DM5PR22MB1658.namprd22.prod.outlook.com>
References: <1566216496-17375-1-git-send-email-aleksandar.markovic@rt-rk.com>,
 <1566216496-17375-13-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1566216496-17375-13-git-send-email-aleksandar.markovic@rt-rk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=arikalo@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4c7ed72-916c-4fc1-7006-08d724b3cda7
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DM5PR22MB0683; 
x-ms-traffictypediagnostic: DM5PR22MB0683:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR22MB0683D450FDF1C3561937DE7CD2A80@DM5PR22MB0683.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(346002)(396003)(366004)(136003)(376002)(189003)(199004)(33656002)(6246003)(7736002)(71200400001)(64756008)(66946007)(66556008)(76116006)(91956017)(71190400001)(229853002)(446003)(66476007)(74316002)(99286004)(66446008)(11346002)(53936002)(6606003)(53546011)(6506007)(55236004)(14454004)(7696005)(8936002)(478600001)(25786009)(2906002)(76176011)(256004)(102836004)(81166006)(107886003)(5660300002)(4326008)(81156014)(66066001)(186003)(9686003)(486006)(316002)(8676002)(476003)(52536014)(55016002)(110136005)(26005)(6436002)(54906003)(19627405001)(54896002)(86362001)(6116002)(2501003)(3846002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR22MB0683;
 H:DM5PR22MB1658.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KDuHGhF0LmlmcnsPL0XfVuYjdeo/Zx1SHAw/evLYHGlqvA7DcMjrs01KIT0ujJCK0eA1Qjewqp6jjhs4kx0A1ZFOiY8CX8JHQwsIkvKe5uNqGrhin3G6Ioxfl0u+ahoydJKxYbPNDWP2fO07YfcZrZNBcJaPNWjviFBy6jLdh+WlhEnB0oEr4liB+mU96j+B+ZQYUgE4dCMW8Cei0tJCRJs8W/QESohrKT44JyINOl7+va7C3DnSjdos2YVNU2zuO83UnLMlmrZt5IltaH/2/Z/PGu+AnKx+vrRwk1ODBqMHSkY69gFDd9chgQJ30K5kWn3sLYMMJXFetDNQz+kFtays0KsphI7qXQvaz51raoaWLW/MHi6yfJfTHE7cQseb8zoeIgAzsHI+9gfsaxnsoTsh/sX0QjeI2GJ2rMbWL2s=
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4c7ed72-916c-4fc1-7006-08d724b3cda7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 14:44:56.3213 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pfcRpJpZ73lI72gY81h4jtpw2KnNcn+vaNYM8/9UkZM0KOTLdwUKp6avPs4+fDWeSDtg5CR763dbq+KEkgkw+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR22MB0683
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.75.101
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [EXTERNAL][PATCH v8 12/37] target/mips: Style
 improvements in cps.c
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
> Subject: [EXTERNAL][PATCH v8 12/37] target/mips: Style improvements in cp=
s.c
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Fixes mostly errors and warnings reported by 'checkpatch.pl -f'.
>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  hw/mips/cps.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/hw/mips/cps.c b/hw/mips/cps.c
> index c84bc64..8fe2f47 100644
> --- a/hw/mips/cps.c
> +++ b/hw/mips/cps.c
> @@ -37,8 +37,10 @@ static void mips_cps_init(Object *obj)
>      SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
>      MIPSCPSState *s =3D MIPS_CPS(obj);
>
> -    /* Cover entire address space as there do not seem to be any
> -     * constraints for the base address of CPC and GIC. */
> +    /*
> +     * Cover entire address space as there do not seem to be any
> +     * constraints for the base address of CPC and GIC.
> +     */
>      memory_region_init(&s->container, obj, "mips-cps-container", UINT64_=
MAX);
>      sysbus_init_mmio(sbd, &s->container);
>  }
> --
> 2.7.4

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>

