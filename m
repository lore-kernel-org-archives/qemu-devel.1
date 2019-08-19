Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08758C3A5A1
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 14:48:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAB562070D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 14:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavecomp.com header.i=@wavecomp.com header.b="ZdbHmSLT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAB562070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzixP-0004Rz-7N
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 10:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39063)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <arikalo@wavecomp.com>) id 1hziv0-0002zK-4p
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 10:46:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arikalo@wavecomp.com>) id 1hziux-00006j-MC
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 10:45:58 -0400
Received: from mail-eopbgr710102.outbound.protection.outlook.com
 ([40.107.71.102]:11738 helo=NAM05-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <arikalo@wavecomp.com>)
 id 1hziux-0008UY-9B
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 10:45:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FVgKt7NHhl0+3has70j9+5DlKDr8mLU0JZCxg9A+56hLORfn5/TaU9A53wKd331i5meh9joT2EHYo6od/ls26vI6Hs5pXPLrfLmqoX2SLwxjS598gTPasytNZlqAKllJAZ0I6bO50AYE8C7vGm22RZanwtp5aIkDQgkbVgNEI06dX9QwFUB9HONd7Fs2jZouLrILBm4BDQ/BsxVy+5he2AFmXSkQkjytLZLA920todg5OSBtH0xOMrhP0dZxo/9Io1B0mFucobU0BohmO3dL6g3UPtYHkKJFaFTE51YLazXtX5YhWkEzT1S5iOwDznCQGHCKrC1jwuAMOuQNaWjrPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDZVy6VoC4/ImK/LJfPWsEFA5DAZffmRzO5V9f7QKXQ=;
 b=WUy59LRy8Yg+B9dM1OAyv2OykW2JWOkZkWGVpTwtuvOzyoT/hOkU6J50BJhSVNZyEUyi1z3IbcsfuW8OpO3uf5YGkXMwPHT+OSXdjCOIBDcCJFZ/JDkjcEKHfOgvrfdjUDIklMJ5ip7w25IN+AZsH05a7f2yvxSdXexILv+LPOJSBipH4f175QiuTGVvrNiFAJ2eDAUNblPZRZyWg1nu3AwlnJk0DinPO/L6OHw9595F/r3La8CmdpIKSJOQo6/hqart/BnjnfaWJMQF4umgSVFRRcw63pEYmGn9/I8d9b9mwjxNgApP3qBChdc22wH+HIDxrtGmcVem30IZk3dP4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wavecomp.com; dmarc=pass action=none header.from=wavecomp.com;
 dkim=pass header.d=wavecomp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDZVy6VoC4/ImK/LJfPWsEFA5DAZffmRzO5V9f7QKXQ=;
 b=ZdbHmSLT50gTHeHVFgganErDDJZ7n16k02KKylvjrDJEtuoLVhUxOZQxojMTqcR9AzVu+1COPGtNDjBxQ/bSCiqa01YAADRujyarcoiSCUwCUw6fQHpeK8CRw7bXNzyeNLQCnUvEZ2KsIN414CYvAAksKB+l7pcA3q3fpZOphFw=
Received: from DM5PR22MB1658.namprd22.prod.outlook.com (10.164.152.163) by
 DM5PR22MB0684.namprd22.prod.outlook.com (10.172.191.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Mon, 19 Aug 2019 14:45:50 +0000
Received: from DM5PR22MB1658.namprd22.prod.outlook.com
 ([fe80::ed69:1c9f:bdff:2197]) by DM5PR22MB1658.namprd22.prod.outlook.com
 ([fe80::ed69:1c9f:bdff:2197%5]) with mapi id 15.20.2178.018; Mon, 19 Aug 2019
 14:45:50 +0000
From: Aleksandar Rikalo <arikalo@wavecomp.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [EXTERNAL][PATCH v8 13/37] target/mips: Style improvements in
 mips_fulong2e.c
Thread-Index: AQHVVobUu+CQZYZ6a0W0+SDx7FaE56cCjFk8
Date: Mon, 19 Aug 2019 14:45:50 +0000
Message-ID: <DM5PR22MB1658B50F920C1D5355B9D0D8D2A80@DM5PR22MB1658.namprd22.prod.outlook.com>
References: <1566216496-17375-1-git-send-email-aleksandar.markovic@rt-rk.com>,
 <1566216496-17375-14-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1566216496-17375-14-git-send-email-aleksandar.markovic@rt-rk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=arikalo@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c49a868-d08d-43dc-f319-08d724b3ede9
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DM5PR22MB0684; 
x-ms-traffictypediagnostic: DM5PR22MB0684:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR22MB06845E0F4519DF379ECA4B51D2A80@DM5PR22MB0684.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:751;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(396003)(346002)(136003)(366004)(39840400004)(189003)(199004)(76176011)(7696005)(76116006)(110136005)(316002)(6606003)(2501003)(74316002)(446003)(229853002)(91956017)(55016002)(54896002)(66476007)(64756008)(52536014)(66556008)(99286004)(66946007)(66066001)(86362001)(6436002)(54906003)(66446008)(9686003)(53546011)(256004)(107886003)(6246003)(3846002)(6116002)(19627405001)(102836004)(33656002)(8676002)(6506007)(55236004)(186003)(53936002)(5660300002)(81156014)(81166006)(14454004)(26005)(4326008)(71200400001)(8936002)(478600001)(71190400001)(7736002)(11346002)(25786009)(476003)(2906002)(486006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR22MB0684;
 H:DM5PR22MB1658.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: E/GI64jknOQ9TF97cvFnkZSzSR2mTBSbOnwMVlvfA8tmcftubhFbBm1tGQoOqTJFp4R+MiUnqhyemVc9WGK7vFpJvHClJlysQKuoq0Jlhm9OtKjDHCe8QlNm/u/92pn4Q+NENVBfnWmQu9dVdp9wLNw8uu5YcRl9n6uK0tRNFOhQDmXvYvVkgqpmjFlf6d+mgVqiuPr5awFU68HgxoN0T0i030bjgmA0C1EljkXsPZ3Llu//trEPbmfYSxyohswtivSZekaHIp/EBu+0pmtWDbJ26Rpei7uPK8hhrR6RoiaMqXmWyd0Q19Kmf/KHwXp5V/wiJX1ITpe6UfYQldyq5giex3h2pA7oPxo2UPVuRgk3rFUWrMR7OSu0q/BWkyxlMXOfJRP5BLGC3rQnLi+SFG5fTFu+eP5lUTJzl9HCeIk=
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c49a868-d08d-43dc-f319-08d724b3ede9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 14:45:50.4753 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hc6yjqTHVqmreDs+vx5v4yKcT2LcPwBgQcqkytcQ1na0mlpdO+06ZqZT5v3D3ArqihMtj0b2SXm/nmltuf90jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR22MB0684
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.71.102
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [EXTERNAL][PATCH v8 13/37] target/mips: Style
 improvements in mips_fulong2e.c
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
> Subject: [EXTERNAL][PATCH v8 13/37] target/mips: Style improvements in mi=
ps_fulong2e.c
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Fixes mostly errors and warnings reported by 'checkpatch.pl -f'.
>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  hw/mips/mips_fulong2e.c | 96 +++++++++++++++++++++++++++++--------------=
------
>  1 file changed, 58 insertions(+), 38 deletions(-)
>
> diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
> index 5dbaa3b..0c3d947 100644
> --- a/hw/mips/mips_fulong2e.c
> +++ b/hw/mips/mips_fulong2e.c
> @@ -48,13 +48,13 @@
>
>  #define DEBUG_FULONG2E_INIT
>
> -#define ENVP_ADDR       0x80002000l
> -#define ENVP_NB_ENTRIES          16
> -#define ENVP_ENTRY_SIZE          256
> +#define ENVP_ADDR               0x80002000l
> +#define ENVP_NB_ENTRIES         16
> +#define ENVP_ENTRY_SIZE         256
>
>  /* fulong 2e has a 512k flash: Winbond W39L040AP70Z */
> -#define BIOS_SIZE (512 * KiB)
> -#define MAX_IDE_BUS 2
> +#define BIOS_SIZE               (512 * KiB)
> +#define MAX_IDE_BUS             2
>
>  /*
>   * PMON is not part of qemu and released with BSD license, anyone
> @@ -83,14 +83,15 @@ static struct _loaderparams {
>      const char *initrd_filename;
>  } loaderparams;
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
> @@ -105,7 +106,7 @@ static void GCC_FMT_ATTR(3, 4) prom_set(uint32_t* pro=
m_buf, int index,
>      va_end(ap);
>  }
>
> -static int64_t load_kernel (CPUMIPSState *env)
> +static int64_t load_kernel(CPUMIPSState *env)
>  {
>      int64_t kernel_entry, kernel_low, kernel_high, initrd_size;
>      int index =3D 0;
> @@ -130,16 +131,18 @@ static int64_t load_kernel (CPUMIPSState *env)
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
>              if (initrd_offset + initrd_size > ram_size) {
>                  error_report("memory too small for initial ram disk '%s'=
",
>                               loaderparams.initrd_filename);
>                  exit(1);
>              }
>              initrd_size =3D load_image_targphys(loaderparams.initrd_file=
name,
> -                                     initrd_offset, ram_size - initrd_of=
fset);
> +                                              initrd_offset,
> +                                              ram_size - initrd_offset);
>          }
>          if (initrd_size =3D=3D (target_ulong) -1) {
>              error_report("could not load initial ram disk '%s'",
> @@ -154,9 +157,10 @@ static int64_t load_kernel (CPUMIPSState *env)
>
>      prom_set(prom_buf, index++, "%s", loaderparams.kernel_filename);
>      if (initrd_size > 0) {
> -        prom_set(prom_buf, index++, "rd_start=3D0x%" PRIx64 " rd_size=3D=
%" PRId64 " %s",
> -                 cpu_mips_phys_to_kseg0(NULL, initrd_offset), initrd_siz=
e,
> -                 loaderparams.kernel_cmdline);
> +        prom_set(prom_buf, index++,
> +                 "rd_start=3D0x%" PRIx64 " rd_size=3D%" PRId64 " %s",
> +                 cpu_mips_phys_to_kseg0(NULL, initrd_offset),
> +                 initrd_size, loaderparams.kernel_cmdline);
>      } else {
>          prom_set(prom_buf, index++, "%s", loaderparams.kernel_cmdline);
>      }
> @@ -175,34 +179,48 @@ static int64_t load_kernel (CPUMIPSState *env)
>      return kernel_entry;
>  }
>
> -static void write_bootloader (CPUMIPSState *env, uint8_t *base, int64_t =
kernel_addr)
> +static void write_bootloader(CPUMIPSState *env, uint8_t *base,
> +                             int64_t kernel_addr)
>  {
>      uint32_t *p;
>
>      /* Small bootloader */
> -    p =3D (uint32_t *) base;
> +    p =3D (uint32_t *)base;
>
> -    stl_p(p++, 0x0bf00010);                                      /* j 0x=
1fc00040 */
> -    stl_p(p++, 0x00000000);                                      /* nop =
*/
> +    /* j 0x1fc00040 */
> +    stl_p(p++, 0x0bf00010);
> +    /* nop */
> +    stl_p(p++, 0x00000000);
>
>      /* Second part of the bootloader */
> -    p =3D (uint32_t *) (base + 0x040);
> -
> -    stl_p(p++, 0x3c040000);                                      /* lui =
a0, 0 */
> -    stl_p(p++, 0x34840002);                                      /* ori =
a0, a0, 2 */
> -    stl_p(p++, 0x3c050000 | ((ENVP_ADDR >> 16) & 0xffff));       /* lui =
a1, high(ENVP_ADDR) */
> -    stl_p(p++, 0x34a50000 | (ENVP_ADDR & 0xffff));               /* ori =
a1, a0, low(ENVP_ADDR) */
> -    stl_p(p++, 0x3c060000 | (((ENVP_ADDR + 8) >> 16) & 0xffff)); /* lui =
a2, high(ENVP_ADDR + 8) */
> -    stl_p(p++, 0x34c60000 | ((ENVP_ADDR + 8) & 0xffff));         /* ori =
a2, a2, low(ENVP_ADDR + 8) */
> -    stl_p(p++, 0x3c070000 | (loaderparams.ram_size >> 16));      /* lui =
a3, high(env->ram_size) */
> -    stl_p(p++, 0x34e70000 | (loaderparams.ram_size & 0xffff));   /* ori =
a3, a3, low(env->ram_size) */
> -    stl_p(p++, 0x3c1f0000 | ((kernel_addr >> 16) & 0xffff));     /* lui =
ra, high(kernel_addr) */;
> -    stl_p(p++, 0x37ff0000 | (kernel_addr & 0xffff));             /* ori =
ra, ra, low(kernel_addr) */
> -    stl_p(p++, 0x03e00008);                                      /* jr r=
a */
> -    stl_p(p++, 0x00000000);                                      /* nop =
*/
> +    p =3D (uint32_t *)(base + 0x040);
> +
> +    /* lui a0, 0 */
> +    stl_p(p++, 0x3c040000);
> +    /* ori a0, a0, 2 */
> +    stl_p(p++, 0x34840002);
> +    /* lui a1, high(ENVP_ADDR) */
> +    stl_p(p++, 0x3c050000 | ((ENVP_ADDR >> 16) & 0xffff));
> +    /* ori a1, a0, low(ENVP_ADDR) */
> +    stl_p(p++, 0x34a50000 | (ENVP_ADDR & 0xffff));
> +    /* lui a2, high(ENVP_ADDR + 8) */
> +    stl_p(p++, 0x3c060000 | (((ENVP_ADDR + 8) >> 16) & 0xffff));
> +    /* ori a2, a2, low(ENVP_ADDR + 8) */
> +    stl_p(p++, 0x34c60000 | ((ENVP_ADDR + 8) & 0xffff));
> +    /* lui a3, high(env->ram_size) */
> +    stl_p(p++, 0x3c070000 | (loaderparams.ram_size >> 16));
> +    /* ori a3, a3, low(env->ram_size) */
> +    stl_p(p++, 0x34e70000 | (loaderparams.ram_size & 0xffff));
> +    /* lui ra, high(kernel_addr) */
> +    stl_p(p++, 0x3c1f0000 | ((kernel_addr >> 16) & 0xffff));
> +    /* ori ra, ra, low(kernel_addr) */
> +    stl_p(p++, 0x37ff0000 | (kernel_addr & 0xffff));
> +    /* jr ra */
> +    stl_p(p++, 0x03e00008);
> +    /* nop */
> +    stl_p(p++, 0x00000000);
>  }
>
> -
>  static void main_cpu_reset(void *opaque)
>  {
>      MIPSCPU *cpu =3D opaque;
> @@ -252,11 +270,11 @@ static void vt82c686b_southbridge_init(PCIBus *pci_=
bus, int slot, qemu_irq intc,
>  }
>
>  /* Network support */
> -static void network_init (PCIBus *pci_bus)
> +static void network_init(PCIBus *pci_bus)
>  {
>      int i;
>
> -    for(i =3D 0; i < nb_nics; i++) {
> +    for (i =3D 0; i < nb_nics; i++) {
>          NICInfo *nd =3D &nd_table[i];
>          const char *default_devaddr =3D NULL;
>
> @@ -308,15 +326,17 @@ static void mips_fulong2e_init(MachineState *machin=
e)
>      memory_region_add_subregion(address_space_mem, 0, ram);
>      memory_region_add_subregion(address_space_mem, 0x1fc00000LL, bios);
>
> -    /* We do not support flash operation, just loading pmon.bin as raw B=
IOS.
> -     * Please use -L to set the BIOS path and -bios to set bios name. */
> +    /*
> +     * We do not support flash operation, just loading pmon.bin as raw B=
IOS.
> +     * Please use -L to set the BIOS path and -bios to set bios name.
> +     */
>
>      if (kernel_filename) {
>          loaderparams.ram_size =3D ram_size;
>          loaderparams.kernel_filename =3D kernel_filename;
>          loaderparams.kernel_cmdline =3D kernel_cmdline;
>          loaderparams.initrd_filename =3D initrd_filename;
> -        kernel_entry =3D load_kernel (env);
> +        kernel_entry =3D load_kernel(env);
>          write_bootloader(env, memory_region_get_ram_ptr(bios), kernel_en=
try);
>      } else {
>          if (bios_name =3D=3D NULL) {
> --
> 2.7.4

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>


