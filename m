Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B054C3A5A2
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 14:41:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57A8720843
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 14:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavecomp.com header.i=@wavecomp.com header.b="PE+Do0QZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57A8720843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hziqb-0000ho-Jp
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 10:41:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38163)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <arikalo@wavecomp.com>) id 1hzipt-0000HO-7e
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 10:40:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arikalo@wavecomp.com>) id 1hzipq-00064f-Gi
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 10:40:41 -0400
Received: from mail-eopbgr810092.outbound.protection.outlook.com
 ([40.107.81.92]:53591 helo=NAM01-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <arikalo@wavecomp.com>)
 id 1hzipq-000649-3U
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 10:40:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZSEA6uhW4uIRxXXg81JkG3JX9GSoogWVJL4nbrtCk6HY4qsniYLqH2j3XcWDNkenlgUtZWKT9glSDoy0scWydAX3tBPUDzLDE7t9V4Qrm6vqYMhuAF/KwUUBHd+WUbwN3/cQh4thEt6SEZCA1JabrUdhhK/DsdgXBZzzPY3VK+tzbGf+BaYG50WigaRdS6Y2g4SWTRDpt7V2MClMmf0EMeadmfJ966bL4Hy4ezTd9RpPLonQOVoDpr5+nXUfwRJxGHw4R5RfupFPy8qtleWOBquR6KDKyDMkTYgnWEuC3dBB53yEor61voZC5/yQbl9+Y2cHt05CC0bclWsppvpNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wr1SwGVCdGM5fFqCkF0aZmVTrS0G3yZ4C7W/7Y71RyQ=;
 b=G8COuvANaI0qt4zkSpstTACHjJQhns8L+WF263mVot+tq2iDY9caBSYBP5tWX4BjyB+YDPuDuz7S6bsrxfTk4q4batZyLryLuUGq/Hj+Smob+rzJBPlnx1CZY0TR1qWBw47f8pcZg/y/SBeIyn4kAfl0hd+TwX93eLouIneBmiFqe+DdShDDm663zlmPgk7zl5WIK5qY8OlyDdpmnJeZ0AJnTfl6GV7hCwUanxD9Wf53UEBlnb6B7yo/ITLDYfGyaP/CO8DhKsrgVwalWA32iNv2cBgW5RGD9i0rIqQGBKqP4II99LIYMLNfWjtEXJDJ+alJTo7AzBzl8GWUlWtqOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wavecomp.com; dmarc=pass action=none header.from=wavecomp.com;
 dkim=pass header.d=wavecomp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wr1SwGVCdGM5fFqCkF0aZmVTrS0G3yZ4C7W/7Y71RyQ=;
 b=PE+Do0QZ7lo2WWD3hUrpPL4+CSZ7RVCzeXM+hifgg4JPCTMr/Z/t/h33x5Dz3oUsNI/fV8YiNo04kdbXCgVZgJvCsdHc2ZoF7ganFY2sWZf+jqe/JVN9oMRci4f2FGfoXLUn/EyPuP9+9EGg6CG197o8S9J6Z64ghhFCeBNkbDc=
Received: from DM5PR22MB1658.namprd22.prod.outlook.com (10.164.152.163) by
 DM5PR22MB0169.namprd22.prod.outlook.com (10.168.175.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Mon, 19 Aug 2019 14:40:35 +0000
Received: from DM5PR22MB1658.namprd22.prod.outlook.com
 ([fe80::ed69:1c9f:bdff:2197]) by DM5PR22MB1658.namprd22.prod.outlook.com
 ([fe80::ed69:1c9f:bdff:2197%5]) with mapi id 15.20.2178.018; Mon, 19 Aug 2019
 14:40:35 +0000
From: Aleksandar Rikalo <arikalo@wavecomp.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [EXTERNAL][PATCH v8 10/37] target/mips: Style improvements in
 helper.c
Thread-Index: AQHVVobVuR9CiX5/8kuStKYomEeCr6cCiuRU
Date: Mon, 19 Aug 2019 14:40:35 +0000
Message-ID: <DM5PR22MB16585F25156F2CE91687E74AD2A80@DM5PR22MB1658.namprd22.prod.outlook.com>
References: <1566216496-17375-1-git-send-email-aleksandar.markovic@rt-rk.com>,
 <1566216496-17375-11-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1566216496-17375-11-git-send-email-aleksandar.markovic@rt-rk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=arikalo@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9dc9de1c-b4fc-4a97-1cbc-08d724b33215
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DM5PR22MB0169; 
x-ms-traffictypediagnostic: DM5PR22MB0169:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR22MB0169EEE57F165537990A36C9D2A80@DM5PR22MB0169.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(366004)(346002)(39840400004)(376002)(199004)(189003)(71190400001)(2501003)(66556008)(25786009)(99286004)(19627405001)(71200400001)(55236004)(102836004)(3846002)(6116002)(53546011)(6506007)(446003)(476003)(9686003)(66066001)(5660300002)(54896002)(26005)(14444005)(186003)(256004)(6246003)(14454004)(4326008)(107886003)(33656002)(7696005)(53936002)(76176011)(91956017)(76116006)(74316002)(7736002)(52536014)(66446008)(486006)(478600001)(30864003)(11346002)(2906002)(86362001)(8676002)(6606003)(81156014)(54906003)(81166006)(229853002)(8936002)(55016002)(110136005)(316002)(64756008)(6436002)(66476007)(66946007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR22MB0169;
 H:DM5PR22MB1658.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MnG13TFg53HrLSeQKUkzc9OSNjLAPOu7j69cpx6FgbmS9Bz5xqCZHmZ/CY+7B18MTK63CYsxWlE0vrvV0TPRCGQWx9VwAF2DXgLNtPEhWg7NGddipxdvFGyOsVWNZg+OtbwvIl7gCjppNpHTlcPXUt2Eaux/cOacY+98YDJbyqHXg+EN7acXWZE9YmaZOO4TeqNiRUj5R+rW5j5dFpqeRxbmNSSRG4aVOjPqp2FXiIfzQQRTfLE+wNiLnK5N2339LLEYrgElFRAOZ3p+1CJJXWfwJFPedIoodG6t6al4KnO1NFhb2be9qjn+8VpaUU411iBEuCbubW9MJcmrwkuM9KDViO5P+Pe7eMT6r+JeEycggfbzoQvQoOkqNig8UcCALc6ds1slhWt31PlYbWDD/iuA0unfvcfkdZo2EkRzPl0=
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dc9de1c-b4fc-4a97-1cbc-08d724b33215
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 14:40:35.3025 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pTP9egTIRIK9bbnIL6jBJLMVyL2ykbl4CMUbYiNaGtcst7vyOMSXJGgjcqpfxQdg7RUogJkyhlbmPizDUOG3dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR22MB0169
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.81.92
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [EXTERNAL][PATCH v8 10/37] target/mips: Style
 improvements in helper.c
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
> Subject: [EXTERNAL][PATCH v8 10/37] target/mips: Style improvements in he=
lper.c
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Fixes mostly errors and warnings reported by 'checkpatch.pl -f'.
>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  target/mips/helper.c | 98 ++++++++++++++++++++++++++++++++--------------=
------
>  1 file changed, 60 insertions(+), 38 deletions(-)
>
> diff --git a/target/mips/helper.c b/target/mips/helper.c
> index 6e583d3..d7a2c77 100644
> --- a/target/mips/helper.c
> +++ b/target/mips/helper.c
> @@ -39,8 +39,8 @@ enum {
>  #if !defined(CONFIG_USER_ONLY)
>
>  /* no MMU emulation */
> -int no_mmu_map_address (CPUMIPSState *env, hwaddr *physical, int *prot,
> -                        target_ulong address, int rw, int access_type)
> +int no_mmu_map_address(CPUMIPSState *env, hwaddr *physical, int *prot,
> +                       target_ulong address, int rw, int access_type)
>  {
>      *physical =3D address;
>      *prot =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> @@ -48,26 +48,28 @@ int no_mmu_map_address (CPUMIPSState *env, hwaddr *ph=
ysical, int *prot,
>  }
>
>  /* fixed mapping MMU emulation */
> -int fixed_mmu_map_address (CPUMIPSState *env, hwaddr *physical, int *pro=
t,
> -                           target_ulong address, int rw, int access_type=
)
> +int fixed_mmu_map_address(CPUMIPSState *env, hwaddr *physical, int *prot=
,
> +                          target_ulong address, int rw, int access_type)
>  {
>      if (address <=3D (int32_t)0x7FFFFFFFUL) {
> -        if (!(env->CP0_Status & (1 << CP0St_ERL)))
> +        if (!(env->CP0_Status & (1 << CP0St_ERL))) {
>              *physical =3D address + 0x40000000UL;
> -        else
> +        } else {
>              *physical =3D address;
> -    } else if (address <=3D (int32_t)0xBFFFFFFFUL)
> +        }
> +    } else if (address <=3D (int32_t)0xBFFFFFFFUL) {
>          *physical =3D address & 0x1FFFFFFF;
> -    else
> +    } else {
>          *physical =3D address;
> +    }
>
>      *prot =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
>      return TLBRET_MATCH;
>  }
>
>  /* MIPS32/MIPS64 R4000-style MMU emulation */
> -int r4k_map_address (CPUMIPSState *env, hwaddr *physical, int *prot,
> -                     target_ulong address, int rw, int access_type)
> +int r4k_map_address(CPUMIPSState *env, hwaddr *physical, int *prot,
> +                    target_ulong address, int rw, int access_type)
>  {
>      uint16_t ASID =3D env->CP0_EntryHi & env->CP0_EntryHi_ASID_mask;
>      uint32_t MMID =3D env->CP0_MemoryMapID;
> @@ -105,8 +107,9 @@ int r4k_map_address (CPUMIPSState *env, hwaddr *physi=
cal, int *prot,
>              if (rw !=3D MMU_DATA_STORE || (n ? tlb->D1 : tlb->D0)) {
>                  *physical =3D tlb->PFN[n] | (address & (mask >> 1));
>                  *prot =3D PAGE_READ;
> -                if (n ? tlb->D1 : tlb->D0)
> +                if (n ? tlb->D1 : tlb->D0) {
>                      *prot |=3D PAGE_WRITE;
> +                }
>                  if (!(n ? tlb->XI1 : tlb->XI0)) {
>                      *prot |=3D PAGE_EXEC;
>                  }
> @@ -136,9 +139,10 @@ static int is_seg_am_mapped(unsigned int am, bool eu=
, int mmu_idx)
>      int32_t adetlb_mask;
>
>      switch (mmu_idx) {
> -    case 3 /* ERL */:
> -        /* If EU is set, always unmapped */
> +    case 3:
> +        /* ERL */
>          if (eu) {
> +            /* If EU is set, always unmapped */
>              return 0;
>          }
>          /* fall through */
> @@ -210,7 +214,7 @@ static int get_segctl_physical_address(CPUMIPSState *=
env, hwaddr *physical,
>                                      pa & ~(hwaddr)segmask);
>  }
>
> -static int get_physical_address (CPUMIPSState *env, hwaddr *physical,
> +static int get_physical_address(CPUMIPSState *env, hwaddr *physical,
>                                  int *prot, target_ulong real_address,
>                                  int rw, int access_type, int mmu_idx)
>  {
> @@ -265,7 +269,8 @@ static int get_physical_address (CPUMIPSState *env, h=
waddr *physical,
>      } else if (address < 0x4000000000000000ULL) {
>          /* xuseg */
>          if (UX && address <=3D (0x3FFFFFFFFFFFFFFFULL & env->SEGMask)) {
> -            ret =3D env->tlb->map_address(env, physical, prot, real_addr=
ess, rw, access_type);
> +            ret =3D env->tlb->map_address(env, physical, prot, real_addr=
ess, rw,
> +                                        access_type);
>          } else {
>              ret =3D TLBRET_BADADDR;
>          }
> @@ -273,7 +278,8 @@ static int get_physical_address (CPUMIPSState *env, h=
waddr *physical,
>          /* xsseg */
>          if ((supervisor_mode || kernel_mode) &&
>              SX && address <=3D (0x7FFFFFFFFFFFFFFFULL & env->SEGMask)) {
> -            ret =3D env->tlb->map_address(env, physical, prot, real_addr=
ess, rw, access_type);
> +            ret =3D env->tlb->map_address(env, physical, prot, real_addr=
ess, rw,
> +                                        access_type);
>          } else {
>              ret =3D TLBRET_BADADDR;
>          }
> @@ -313,7 +319,8 @@ static int get_physical_address (CPUMIPSState *env, h=
waddr *physical,
>          /* xkseg */
>          if (kernel_mode && KX &&
>              address <=3D (0xFFFFFFFF7FFFFFFFULL & env->SEGMask)) {
> -            ret =3D env->tlb->map_address(env, physical, prot, real_addr=
ess, rw, access_type);
> +            ret =3D env->tlb->map_address(env, physical, prot, real_addr=
ess, rw,
> +                                        access_type);
>          } else {
>              ret =3D TLBRET_BADADDR;
>          }
> @@ -669,7 +676,7 @@ static int walk_directory(CPUMIPSState *env, uint64_t=
 *vaddr,
>  }
>
>  static bool page_table_walk_refill(CPUMIPSState *env, vaddr address, int=
 rw,
> -        int mmu_idx)
> +                                   int mmu_idx)
>  {
>      int gdw =3D (env->CP0_PWSize >> CP0PS_GDW) & 0x3F;
>      int udw =3D (env->CP0_PWSize >> CP0PS_UDW) & 0x3F;
> @@ -951,7 +958,8 @@ bool mips_cpu_tlb_fill(CPUState *cs, vaddr address, i=
nt size,
>  }
>
>  #ifndef CONFIG_USER_ONLY
> -hwaddr cpu_mips_translate_address(CPUMIPSState *env, target_ulong addres=
s, int rw)
> +hwaddr cpu_mips_translate_address(CPUMIPSState *env, target_ulong addres=
s,
> +                                  int rw)
>  {
>      hwaddr physical;
>      int prot;
> @@ -1011,7 +1019,7 @@ static const char * const excp_names[EXCP_LAST + 1]=
 =3D {
>  };
>  #endif
>
> -target_ulong exception_resume_pc (CPUMIPSState *env)
> +target_ulong exception_resume_pc(CPUMIPSState *env)
>  {
>      target_ulong bad_pc;
>      target_ulong isa_mode;
> @@ -1019,8 +1027,10 @@ target_ulong exception_resume_pc (CPUMIPSState *en=
v)
>      isa_mode =3D !!(env->hflags & MIPS_HFLAG_M16);
>      bad_pc =3D env->active_tc.PC | isa_mode;
>      if (env->hflags & MIPS_HFLAG_BMASK) {
> -        /* If the exception was raised from a delay slot, come back to
> -           the jump.  */
> +        /*
> +         * If the exception was raised from a delay slot, come back to
> +         * the jump.
> +         */
>          bad_pc -=3D (env->hflags & MIPS_HFLAG_B16 ? 2 : 4);
>      }
>
> @@ -1102,10 +1112,12 @@ void mips_cpu_do_interrupt(CPUState *cs)
>      switch (cs->exception_index) {
>      case EXCP_DSS:
>          env->CP0_Debug |=3D 1 << CP0DB_DSS;
> -        /* Debug single step cannot be raised inside a delay slot and
> -           resume will always occur on the next instruction
> -           (but we assume the pc has always been updated during
> -           code translation). */
> +        /*
> +         * Debug single step cannot be raised inside a delay slot and
> +         * resume will always occur on the next instruction
> +         * (but we assume the pc has always been updated during
> +         * code translation).
> +         */
>          env->CP0_DEPC =3D env->active_tc.PC | !!(env->hflags & MIPS_HFLA=
G_M16);
>          goto enter_debug_mode;
>      case EXCP_DINT:
> @@ -1117,7 +1129,8 @@ void mips_cpu_do_interrupt(CPUState *cs)
>      case EXCP_DBp:
>          env->CP0_Debug |=3D 1 << CP0DB_DBp;
>          /* Setup DExcCode - SDBBP instruction */
> -        env->CP0_Debug =3D (env->CP0_Debug & ~(0x1fULL << CP0DB_DEC)) | =
9 << CP0DB_DEC;
> +        env->CP0_Debug =3D (env->CP0_Debug & ~(0x1fULL << CP0DB_DEC)) |
> +                         (9 << CP0DB_DEC);
>          goto set_DEPC;
>      case EXCP_DDBS:
>          env->CP0_Debug |=3D 1 << CP0DB_DDBS;
> @@ -1138,8 +1151,9 @@ void mips_cpu_do_interrupt(CPUState *cs)
>          env->hflags |=3D MIPS_HFLAG_DM | MIPS_HFLAG_CP0;
>          env->hflags &=3D ~(MIPS_HFLAG_KSU);
>          /* EJTAG probe trap enable is not implemented... */
> -        if (!(env->CP0_Status & (1 << CP0St_EXL)))
> +        if (!(env->CP0_Status & (1 << CP0St_EXL))) {
>              env->CP0_Cause &=3D ~(1U << CP0Ca_BD);
> +        }
>          env->active_tc.PC =3D env->exception_base + 0x480;
>          set_hflags_for_handler(env);
>          break;
> @@ -1165,8 +1179,9 @@ void mips_cpu_do_interrupt(CPUState *cs)
>          }
>          env->hflags |=3D MIPS_HFLAG_CP0;
>          env->hflags &=3D ~(MIPS_HFLAG_KSU);
> -        if (!(env->CP0_Status & (1 << CP0St_EXL)))
> +        if (!(env->CP0_Status & (1 << CP0St_EXL))) {
>              env->CP0_Cause &=3D ~(1U << CP0Ca_BD);
> +        }
>          env->active_tc.PC =3D env->exception_base;
>          set_hflags_for_handler(env);
>          break;
> @@ -1182,12 +1197,16 @@ void mips_cpu_do_interrupt(CPUState *cs)
>                  uint32_t pending =3D (env->CP0_Cause & CP0Ca_IP_mask) >>=
 CP0Ca_IP;
>
>                  if (env->CP0_Config3 & (1 << CP0C3_VEIC)) {
> -                    /* For VEIC mode, the external interrupt controller =
feeds
> -                     * the vector through the CP0Cause IP lines.  */
> +                    /*
> +                     * For VEIC mode, the external interrupt controller =
feeds
> +                     * the vector through the CP0Cause IP lines.
> +                     */
>                      vector =3D pending;
>                  } else {
> -                    /* Vectored Interrupts
> -                     * Mask with Status.IM7-IM0 to get enabled interrupt=
s. */
> +                    /*
> +                     * Vectored Interrupts
> +                     * Mask with Status.IM7-IM0 to get enabled interrupt=
s.
> +                     */
>                      pending &=3D (env->CP0_Status >> CP0St_IM) & 0xff;
>                      /* Find the highest-priority interrupt. */
>                      while (pending >>=3D 1) {
> @@ -1360,7 +1379,8 @@ void mips_cpu_do_interrupt(CPUState *cs)
>
>          env->active_tc.PC +=3D offset;
>          set_hflags_for_handler(env);
> -        env->CP0_Cause =3D (env->CP0_Cause & ~(0x1f << CP0Ca_EC)) | (cau=
se << CP0Ca_EC);
> +        env->CP0_Cause =3D (env->CP0_Cause & ~(0x1f << CP0Ca_EC)) |
> +                         (cause << CP0Ca_EC);
>          break;
>      default:
>          abort();
> @@ -1396,7 +1416,7 @@ bool mips_cpu_exec_interrupt(CPUState *cs, int inte=
rrupt_request)
>  }
>
>  #if !defined(CONFIG_USER_ONLY)
> -void r4k_invalidate_tlb (CPUMIPSState *env, int idx, int use_extra)
> +void r4k_invalidate_tlb(CPUMIPSState *env, int idx, int use_extra)
>  {
>      CPUState *cs =3D env_cpu(env);
>      r4k_tlb_t *tlb;
> @@ -1421,9 +1441,11 @@ void r4k_invalidate_tlb (CPUMIPSState *env, int id=
x, int use_extra)
>      }
>
>      if (use_extra && env->tlb->tlb_in_use < MIPS_TLB_MAX) {
> -        /* For tlbwr, we can shadow the discarded entry into
> -           a new (fake) TLB entry, as long as the guest can not
> -           tell that it's there.  */
> +        /*
> +         * For tlbwr, we can shadow the discarded entry into
> +         * a new (fake) TLB entry, as long as the guest can not
> +         * tell that it's there.
> +         */
>          env->tlb->mmu.r4k.tlb[env->tlb->tlb_in_use] =3D *tlb;
>          env->tlb->tlb_in_use++;
>          return;
> --
> 2.7.4
>

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>


