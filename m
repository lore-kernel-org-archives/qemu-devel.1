Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E097C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 14:49:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C24EB2070D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 14:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavecomp.com header.i=@wavecomp.com header.b="TY920ST0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C24EB2070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hziyN-0005tU-DV
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 10:49:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39288)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <arikalo@wavecomp.com>) id 1hziwN-00042D-Rj
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 10:47:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arikalo@wavecomp.com>) id 1hziwK-0000em-5L
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 10:47:23 -0400
Received: from mail-co1nam05on072a.outbound.protection.outlook.com
 ([2a01:111:f400:fe50::72a]:12000
 helo=NAM05-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <arikalo@wavecomp.com>)
 id 1hziwJ-0000dS-NM
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 10:47:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ki2l1F2ipqsE/db54EGHSJPmdvIUc5f1RYoEOFH3jPsUVWrAHlUwOzgN8clfRmZIK/+IU8Kp3j+n0f48WdEJpGgXukb8JjdfIOCCrPppc2uVn47buZnUUM9pF//ZsvAkllEpyVMNrfpxe9isNRjL3Q7lDjL/cz7RTv23iQ19YTgfBykthLkejAW8udnuSABEgXq0j33iBg0R2DPUDVDLPWJ5w5E5a7MyJ9b2ZBQ7mwFa4ieKGlStx6fcDucJ99nW/LO7D3iXGRvhrCs2Rwq3oHFe5ATuy3g5Gow5zJg5JMwB8kuItbmVwIoveHytoVqPIWitTdcgSOhYzcrhCuRF/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rK7zNN8WmMA2hiorpBarlk/AbY+berDSYd5Vy1UsC34=;
 b=kC4jYhXwZDf5PE/MnW869j559IkKup5Nl7fXRUp8u9m7Javtb7YxqG8VvV10vAJYnc9glqa1kiRxCcfY8LQ6WS07vkz8V1pSuD/lPEuEFTtCfkNm7ofRiPQVP9lkCce3KBokWENUABw+ZNY+h3CLzGTKV1c6+ZF7G38TeadSzZWpxcZ4+Js34KzI2iDdBtaAY2aGUD6dwpWIWVRtfoFIXzmbSXfXN8EchroI1XaSPfVwRobIDB8Ls/DTk575ZTNuYeBLYlWvOSGLZwTp+gqo9qlRxjJ1NB+Jy+7bV5WeLJF+JeYWHWdMx9sfDayJ9yafS8tFa/xoFJ6ONUtWLwJx0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wavecomp.com; dmarc=pass action=none header.from=wavecomp.com;
 dkim=pass header.d=wavecomp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rK7zNN8WmMA2hiorpBarlk/AbY+berDSYd5Vy1UsC34=;
 b=TY920ST00D8WV2v/Ox2FcXx8Ef7Leub3ancL6/3Exrv6tTbcZq2hJZoobVpSsuraxTUc5c5EBRiKrvY5jDKyOvn3TciCGwyQZ7xEBjAsb+WYBhrLWaefaTMhywolFnWxKq2JpBEAnJ2YUdqBx0odRJxs0Q4qA2gJQHh6AZSXZdE=
Received: from DM5PR22MB1658.namprd22.prod.outlook.com (10.164.152.163) by
 DM5PR22MB0683.namprd22.prod.outlook.com (10.172.190.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Mon, 19 Aug 2019 14:47:15 +0000
Received: from DM5PR22MB1658.namprd22.prod.outlook.com
 ([fe80::ed69:1c9f:bdff:2197]) by DM5PR22MB1658.namprd22.prod.outlook.com
 ([fe80::ed69:1c9f:bdff:2197%5]) with mapi id 15.20.2178.018; Mon, 19 Aug 2019
 14:47:15 +0000
From: Aleksandar Rikalo <arikalo@wavecomp.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [EXTERNAL][PATCH v8 15/37] target/mips: Style improvements in
 mips_malta.c
Thread-Index: AQHVVobUBy646e2sr063ubhdBg/BUacCjMrz
Date: Mon, 19 Aug 2019 14:47:15 +0000
Message-ID: <DM5PR22MB1658090DD9EF830F43F7957DD2A80@DM5PR22MB1658.namprd22.prod.outlook.com>
References: <1566216496-17375-1-git-send-email-aleksandar.markovic@rt-rk.com>,
 <1566216496-17375-16-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1566216496-17375-16-git-send-email-aleksandar.markovic@rt-rk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=arikalo@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a086b69-5f83-4493-2f04-08d724b42083
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DM5PR22MB0683; 
x-ms-traffictypediagnostic: DM5PR22MB0683:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR22MB068361126EE6412ECEEB01AED2A80@DM5PR22MB0683.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(136003)(346002)(396003)(39840400004)(366004)(199004)(189003)(186003)(66066001)(9686003)(81166006)(102836004)(4326008)(81156014)(107886003)(5660300002)(54906003)(6436002)(54896002)(19627405001)(110136005)(26005)(6116002)(86362001)(3846002)(2501003)(55016002)(486006)(52536014)(476003)(8676002)(316002)(256004)(6606003)(6506007)(30864003)(53546011)(11346002)(53936002)(55236004)(14454004)(66446008)(64756008)(71200400001)(7736002)(6246003)(33656002)(99286004)(71190400001)(91956017)(76116006)(66556008)(66946007)(229853002)(74316002)(66476007)(446003)(2906002)(25786009)(53946003)(76176011)(7696005)(14444005)(5024004)(478600001)(8936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR22MB0683;
 H:DM5PR22MB1658.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1+jti+ZDUkPMBr6RyaT2CCjFhTjcg+JLonEt60xZ2sHTsx3CiKG8ywt+YNMOEllARh/hhpZLJDqfL4IJ2f7se7OhP2j7ebP/7YXTdRT5tAZmAi4x1uhuZ3vir4wTFKaWQyuDVgW0BF1btLnMO7f1U2TpcOJC3BqrDMign3FLfgFSAlJjFcSRq/x7oLXKQRhM2rOUOngpTLgplnpS0jElvagj6NPiit6lMti2iUYeAXnOHXUT1Ele66qqKG2GtF58HrgxVEqzFtdK2r8jp+AE6MCW+27NKPaS+CpiVcSLGXw+3WB5PNitD4JSM9Jsmu3afprKj32789lcZ8m+Cld70z4XIeutjqAISEy/F5My1omuYWSNB0D2zdLJ/AALD80WDYcLbQxMTEl8ATm4YphXuwmHF1bO4R9h48r0RmDFiFM=
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a086b69-5f83-4493-2f04-08d724b42083
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 14:47:15.3506 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6cqUToQq2rOWUzm+NaGcSNIO8y1hRh9FINp7wlwlSJnCL0iT4Vu2YtuLmzI7rCA+beoQTgistPktAZPj3nGYDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR22MB0683
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe50::72a
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [EXTERNAL][PATCH v8 15/37] target/mips: Style
 improvements in mips_malta.c
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

From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Sent: Monday, August 19, 2019 2:07 PM
> To: qemu-devel@nongnu.org <qemu-devel@nongnu.org>
> Cc: philmd@redhat.com <philmd@redhat.com>; Aleksandar Markovic <amarkovic=
@wavecomp.com>; Aleksandar Rikalo <arikalo@wavecomp.com>
> Subject: [EXTERNAL][PATCH v8 15/37] target/mips: Style improvements in mi=
ps_malta.c
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Fixes mostly errors and warnings reported by 'checkpatch.pl -f'.
>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  hw/mips/mips_malta.c | 216 ++++++++++++++++++++++++++++++---------------=
------
>  1 file changed, 128 insertions(+), 88 deletions(-)
>
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 20e019b..0b5ee37 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -58,18 +58,18 @@
>  #include "hw/semihosting/semihost.h"
>  #include "hw/mips/cps.h"
>
> -#define ENVP_ADDR              0x80002000l
> -#define ENVP_NB_ENTRIES          16
> -#define ENVP_ENTRY_SIZE          256
> +#define ENVP_ADDR           0x80002000l
> +#define ENVP_NB_ENTRIES     16
> +#define ENVP_ENTRY_SIZE     256
>
>  /* Hardware addresses */
> -#define FLASH_ADDRESS 0x1e000000ULL
> -#define FPGA_ADDRESS  0x1f000000ULL
> -#define RESET_ADDRESS 0x1fc00000ULL
> +#define FLASH_ADDRESS       0x1e000000ULL
> +#define FPGA_ADDRESS        0x1f000000ULL
> +#define RESET_ADDRESS       0x1fc00000ULL
>
> -#define FLASH_SIZE    0x400000
> +#define FLASH_SIZE          0x400000
>
> -#define MAX_IDE_BUS 2
> +#define MAX_IDE_BUS         2
>
>  typedef struct {
>      MemoryRegion iomem;
> @@ -115,10 +115,11 @@ static void malta_fpga_update_display(void *opaque)
>      MaltaFPGAState *s =3D opaque;
>
>      for (i =3D 7 ; i >=3D 0 ; i--) {
> -        if (s->leds & (1 << i))
> +        if (s->leds & (1 << i)) {
>              leds_text[i] =3D '#';
> -        else
> +        } else {
>              leds_text[i] =3D ' ';
> +        }
>      }
>      leds_text[8] =3D '\0';
>
> @@ -138,8 +139,6 @@ static void malta_fpga_update_display(void *opaque)
>   * Typical device names include Microchip 24C02SC or SGS Thomson ST24C02=
.
>   */
>
> -//~ #define DEBUG
> -
>  #if defined(DEBUG)
>  #  define logout(fmt, ...) fprintf(stderr, "MALTA\t%-24s" fmt, __func__,=
 ## __VA_ARGS__)
>  #else
> @@ -154,7 +153,7 @@ struct _eeprom24c0x_t {
>    uint8_t scl;
>    uint8_t sda;
>    uint8_t data;
> -  //~ uint16_t size;
> +  /* uint16_t size; */
>    uint8_t contents[256];
>  };
>
> @@ -162,22 +161,38 @@ typedef struct _eeprom24c0x_t eeprom24c0x_t;
>
>  static eeprom24c0x_t spd_eeprom =3D {
>      .contents =3D {
> -        /* 00000000: */ 0x80,0x08,0xFF,0x0D,0x0A,0xFF,0x40,0x00,
> -        /* 00000008: */ 0x01,0x75,0x54,0x00,0x82,0x08,0x00,0x01,
> -        /* 00000010: */ 0x8F,0x04,0x02,0x01,0x01,0x00,0x00,0x00,
> -        /* 00000018: */ 0x00,0x00,0x00,0x14,0x0F,0x14,0x2D,0xFF,
> -        /* 00000020: */ 0x15,0x08,0x15,0x08,0x00,0x00,0x00,0x00,
> -        /* 00000028: */ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> -        /* 00000030: */ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> -        /* 00000038: */ 0x00,0x00,0x00,0x00,0x00,0x00,0x12,0xD0,
> -        /* 00000040: */ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> -        /* 00000048: */ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> -        /* 00000050: */ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> -        /* 00000058: */ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> -        /* 00000060: */ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> -        /* 00000068: */ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> -        /* 00000070: */ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> -        /* 00000078: */ 0x00,0x00,0x00,0x00,0x00,0x00,0x64,0xF4,
> +        /* 00000000: */
> +        0x80, 0x08, 0xFF, 0x0D, 0x0A, 0xFF, 0x40, 0x00,
> +        /* 00000008: */
> +        0x01, 0x75, 0x54, 0x00, 0x82, 0x08, 0x00, 0x01,
> +        /* 00000010: */
> +        0x8F, 0x04, 0x02, 0x01, 0x01, 0x00, 0x00, 0x00,
> +        /* 00000018: */
> +        0x00, 0x00, 0x00, 0x14, 0x0F, 0x14, 0x2D, 0xFF,
> +        /* 00000020: */
> +        0x15, 0x08, 0x15, 0x08, 0x00, 0x00, 0x00, 0x00,
> +        /* 00000028: */
> +        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +        /* 00000030: */
> +        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +        /* 00000038: */
> +        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x12, 0xD0,
> +        /* 00000040: */
> +        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +        /* 00000048: */
> +        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +        /* 00000050: */
> +        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +        /* 00000058: */
> +        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +        /* 00000060: */
> +        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +        /* 00000068: */
> +        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +        /* 00000070: */
> +        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +        /* 00000078: */
> +        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x64, 0xF4,
>      },
>  };
>
> @@ -347,7 +362,8 @@ static uint64_t malta_fpga_read(void *opaque, hwaddr =
addr,
>
>      /* SWITCH Register */
>      case 0x00200:
> -        val =3D 0x00000000;              /* All switches closed */
> +        /* ori a3, a3, low(ram_low_size) */
> +        val =3D 0x00000000;
>          break;
>
>      /* STATUS Register */
> @@ -386,10 +402,11 @@ static uint64_t malta_fpga_read(void *opaque, hwadd=
r addr,
>      /* GPINP Register */
>      case 0x00a08:
>          /* IN =3D OUT until a real I2C control is implemented */
> -        if (s->i2csel)
> +        if (s->i2csel) {
>              val =3D s->i2cout;
> -        else
> +        } else {
>              val =3D 0x00;
> +        }
>          break;
>
>      /* I2CINP Register */
> @@ -414,8 +431,8 @@ static uint64_t malta_fpga_read(void *opaque, hwaddr =
addr,
>
>      default:
>  #if 0
> -        printf ("malta_fpga_read: Bad register offset 0x" TARGET_FMT_lx =
"\n",
> -                addr);
> +        printf("malta_fpga_read: Bad register offset 0x" TARGET_FMT_lx "=
\n",
> +               addr);
>  #endif
>          break;
>      }
> @@ -467,8 +484,9 @@ static void malta_fpga_write(void *opaque, hwaddr add=
r,
>
>      /* SOFTRES Register */
>      case 0x00500:
> -        if (val =3D=3D 0x42)
> +        if (val =3D=3D 0x42) {
>              qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> +        }
>          break;
>
>      /* BRKRES Register */
> @@ -501,8 +519,8 @@ static void malta_fpga_write(void *opaque, hwaddr add=
r,
>
>      default:
>  #if 0
> -        printf ("malta_fpga_write: Bad register offset 0x" TARGET_FMT_lx=
 "\n",
> -                addr);
> +        printf("malta_fpga_write: Bad register offset 0x" TARGET_FMT_lx =
"\n",
> +               addr);
>  #endif
>          break;
>      }
> @@ -561,7 +579,7 @@ static MaltaFPGAState *malta_fpga_init(MemoryRegion *=
address_space,
>      memory_region_init_alias(&s->iomem_lo, NULL, "malta-fpga",
>                               &s->iomem, 0, 0x900);
>      memory_region_init_alias(&s->iomem_hi, NULL, "malta-fpga",
> -                             &s->iomem, 0xa00, 0x10000-0xa00);
> +                             &s->iomem, 0xa00, 0x10000 - 0xa00);
>
>      memory_region_add_subregion(address_space, base, &s->iomem_lo);
>      memory_region_add_subregion(address_space, base + 0xa00, &s->iomem_h=
i);
> @@ -585,7 +603,7 @@ static void network_init(PCIBus *pci_bus)
>  {
>      int i;
>
> -    for(i =3D 0; i < nb_nics; i++) {
> +    for (i =3D 0; i < nb_nics; i++) {
>          NICInfo *nd =3D &nd_table[i];
>          const char *default_devaddr =3D NULL;
>
> @@ -799,27 +817,28 @@ static void write_bootloader_nanomips(uint8_t *base=
, int64_t run_addr,
>                                  /* jalrc   t8                   */
>  }
>
> -/* ROM and pseudo bootloader
> -
> -   The following code implements a very very simple bootloader. It first
> -   loads the registers a0 to a3 to the values expected by the OS, and
> -   then jump at the kernel address.
> -
> -   The bootloader should pass the locations of the kernel arguments and
> -   environment variables tables. Those tables contain the 32-bit address
> -   of NULL terminated strings. The environment variables table should be
> -   terminated by a NULL address.
> -
> -   For a simpler implementation, the number of kernel arguments is fixed
> -   to two (the name of the kernel and the command line), and the two
> -   tables are actually the same one.
> -
> -   The registers a0 to a3 should contain the following values:
> -     a0 - number of kernel arguments
> -     a1 - 32-bit address of the kernel arguments table
> -     a2 - 32-bit address of the environment variables table
> -     a3 - RAM size in bytes
> -*/
> +/*
> + * ROM and pseudo bootloader
> + *
> + * The following code implements a very very simple bootloader. It first
> + * loads the registers a0 to a3 to the values expected by the OS, and
> + * then jump at the kernel address.
> + *
> + * The bootloader should pass the locations of the kernel arguments and
> + * environment variables tables. Those tables contain the 32-bit address
> + * of NULL terminated strings. The environment variables table should be
> + * terminated by a NULL address.
> + *
> + * For a simpler implementation, the number of kernel arguments is fixed
> + * to two (the name of the kernel and the command line), and the two
> + * tables are actually the same one.
> + *
> + * The registers a0 to a3 should contain the following values:
> + *   a0 - number of kernel arguments
> + *   a1 - 32-bit address of the kernel arguments table
> + *   a2 - 32-bit address of the environment variables table
> + *   a3 - RAM size in bytes
> + */
>  static void write_bootloader(uint8_t *base, int64_t run_addr,
>                               int64_t kernel_entry)
>  {
> @@ -857,14 +876,23 @@ static void write_bootloader(uint8_t *base, int64_t=
 run_addr,
>      } else {
>          stl_p(p++, 0x24040002);                         /* addiu a0, zer=
o, 2 */
>      }
> -    stl_p(p++, 0x3c1d0000 | (((ENVP_ADDR - 64) >> 16) & 0xffff)); /* lui=
 sp, high(ENVP_ADDR) */
> -    stl_p(p++, 0x37bd0000 | ((ENVP_ADDR - 64) & 0xffff));        /* ori =
sp, sp, low(ENVP_ADDR) */
> -    stl_p(p++, 0x3c050000 | ((ENVP_ADDR >> 16) & 0xffff));       /* lui =
a1, high(ENVP_ADDR) */
> -    stl_p(p++, 0x34a50000 | (ENVP_ADDR & 0xffff));               /* ori =
a1, a1, low(ENVP_ADDR) */
> -    stl_p(p++, 0x3c060000 | (((ENVP_ADDR + 8) >> 16) & 0xffff)); /* lui =
a2, high(ENVP_ADDR + 8) */
> -    stl_p(p++, 0x34c60000 | ((ENVP_ADDR + 8) & 0xffff));         /* ori =
a2, a2, low(ENVP_ADDR + 8) */
> -    stl_p(p++, 0x3c070000 | (loaderparams.ram_low_size >> 16));     /* l=
ui a3, high(ram_low_size) */
> -    stl_p(p++, 0x34e70000 | (loaderparams.ram_low_size & 0xffff));  /* o=
ri a3, a3, low(ram_low_size) */
> +
> +    /* lui sp, high(ENVP_ADDR) */
> +    stl_p(p++, 0x3c1d0000 | (((ENVP_ADDR - 64) >> 16) & 0xffff));
> +    /* ori sp, sp, low(ENVP_ADDR) */
> +    stl_p(p++, 0x37bd0000 | ((ENVP_ADDR - 64) & 0xffff));
> +    /* lui a1, high(ENVP_ADDR) */
> +    stl_p(p++, 0x3c050000 | ((ENVP_ADDR >> 16) & 0xffff));
> +    /* ori a1, a1, low(ENVP_ADDR) */
> +    stl_p(p++, 0x34a50000 | (ENVP_ADDR & 0xffff));
> +    /* lui a2, high(ENVP_ADDR + 8) */
> +    stl_p(p++, 0x3c060000 | (((ENVP_ADDR + 8) >> 16) & 0xffff));
> +    /* ori a2, a2, low(ENVP_ADDR + 8) */
> +    stl_p(p++, 0x34c60000 | ((ENVP_ADDR + 8) & 0xffff));
> +    /* lui a3, high(ram_low_size) */
> +    stl_p(p++, 0x3c070000 | (loaderparams.ram_low_size >> 16));
> +    /* ori a3, a3, low(ram_low_size) */
> +    stl_p(p++, 0x34e70000 | (loaderparams.ram_low_size & 0xffff));
>
>      /* Load BAR registers as done by YAMON */
>      stl_p(p++, 0x3c09b400);                                      /* lui =
t1, 0xb400 */
> @@ -968,14 +996,15 @@ static void write_bootloader(uint8_t *base, int64_t=
 run_addr,
>
>  }
>
> -static void GCC_FMT_ATTR(3, 4) prom_set(uint32_t* prom_buf, int index,
> +static void GCC_FMT_ATTR(3, 4) prom_set(uint32_t *prom_buf, int index,
>                                          const char *string, ...)
>  {
>      va_list ap;
>      int32_t table_addr;
>
> -    if (index >=3D ENVP_NB_ENTRIES)
> +    if (index >=3D ENVP_NB_ENTRIES) {
>          return;
> +    }
>
>      if (string =3D=3D NULL) {
>          prom_buf[index] =3D 0;
> @@ -991,7 +1020,7 @@ static void GCC_FMT_ATTR(3, 4) prom_set(uint32_t* pr=
om_buf, int index,
>  }
>
>  /* Kernel */
> -static int64_t load_kernel (void)
> +static int64_t load_kernel(void)
>  {
>      int64_t kernel_entry, kernel_high, initrd_size;
>      long kernel_size;
> @@ -1039,11 +1068,13 @@ static int64_t load_kernel (void)
>      initrd_size =3D 0;
>      initrd_offset =3D 0;
>      if (loaderparams.initrd_filename) {
> -        initrd_size =3D get_image_size (loaderparams.initrd_filename);
> +        initrd_size =3D get_image_size(loaderparams.initrd_filename);
>          if (initrd_size > 0) {
> -            /* The kernel allocates the bootmap memory in the low memory=
 after
> -               the initrd.  It takes at most 128kiB for 2GB RAM and 4kiB
> -               pages.  */
> +            /*
> +             * The kernel allocates the bootmap memory in the low memory=
 after
> +             * the initrd.  It takes at most 128kiB for 2GB RAM and 4kiB
> +             * pages.
> +             */
>              initrd_offset =3D (loaderparams.ram_low_size - initrd_size
>                               - (128 * KiB)
>                               - ~INITRD_PAGE_MASK) & INITRD_PAGE_MASK;
> @@ -1069,9 +1100,10 @@ static int64_t load_kernel (void)
>
>      prom_set(prom_buf, prom_index++, "%s", loaderparams.kernel_filename)=
;
>      if (initrd_size > 0) {
> -        prom_set(prom_buf, prom_index++, "rd_start=3D0x%" PRIx64 " rd_si=
ze=3D%" PRId64 " %s",
> -                 xlate_to_kseg0(NULL, initrd_offset), initrd_size,
> -                 loaderparams.kernel_cmdline);
> +        prom_set(prom_buf, prom_index++,
> +                 "rd_start=3D0x%" PRIx64 " rd_size=3D%" PRId64 " %s",
> +                 xlate_to_kseg0(NULL, initrd_offset),
> +                 initrd_size, loaderparams.kernel_cmdline);
>      } else {
>          prom_set(prom_buf, prom_index++, "%s", loaderparams.kernel_cmdli=
ne);
>      }
> @@ -1111,9 +1143,11 @@ static void main_cpu_reset(void *opaque)
>
>      cpu_reset(CPU(cpu));
>
> -    /* The bootloader does not need to be rewritten as it is located in =
a
> -       read only location. The kernel location and the arguments table
> -       location does not change. */
> +    /*
> +     * The bootloader does not need to be rewritten as it is located in =
a
> +     * read only location. The kernel location and the arguments table
> +     * location does not change.
> +     */
>      if (loaderparams.kernel_filename) {
>          env->CP0_Status &=3D ~(1 << CP0St_ERL);
>      }
> @@ -1211,9 +1245,11 @@ void mips_malta_init(MachineState *machine)
>      DeviceState *dev =3D qdev_create(NULL, TYPE_MIPS_MALTA);
>      MaltaState *s =3D MIPS_MALTA(dev);
>
> -    /* The whole address space decoded by the GT-64120A doesn't generate
> -       exception when accessing invalid memory. Create an empty slot to
> -       emulate this feature. */
> +    /*
> +     * The whole address space decoded by the GT-64120A doesn't generate
> +     * exception when accessing invalid memory. Create an empty slot to
> +     * emulate this feature.\
> +     */
>      empty_slot_init(0, 0x20000000);
>
>      qdev_init_nofail(dev);
> @@ -1329,8 +1365,10 @@ void mips_malta_init(MachineState *machine)
>                  exit(1);
>              }
>          }
> -        /* In little endian mode the 32bit words in the bios are swapped=
,
> -           a neat trick which allows bi-endian firmware. */
> +        /*
> +         * In little endian mode the 32bit words in the bios are swapped=
,
> +         * a neat trick which allows bi-endian firmware.
> +         */
>  #ifndef TARGET_WORDS_BIGENDIAN
>          {
>              uint32_t *end, *addr;
> @@ -1384,8 +1422,10 @@ void mips_malta_init(MachineState *machine)
>
>      piix4_devfn =3D piix4_init(pci_bus, &isa_bus, 80);
>
> -    /* Interrupt controller */
> -    /* The 8259 is attached to the MIPS CPU INT0 pin, ie interrupt 2 */
> +    /*
> +     * Interrupt controller
> +     * The 8259 is attached to the MIPS CPU INT0 pin, ie interrupt 2
> +     */
>      s->i8259 =3D i8259_init(isa_bus, i8259_irq);
>
>      isa_bus_irqs(isa_bus, s->i8259);
> --
> 2.7.4

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>

