Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6275C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 14:14:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F102206BB
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 14:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavecomp.com header.i=@wavecomp.com header.b="VhdocU0L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F102206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hziQw-00082Z-QV
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 10:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34407)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <arikalo@wavecomp.com>) id 1hziQD-0007bz-N6
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 10:14:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arikalo@wavecomp.com>) id 1hziQA-0007be-R0
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 10:14:08 -0400
Received: from mail-eopbgr680138.outbound.protection.outlook.com
 ([40.107.68.138]:24243 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <arikalo@wavecomp.com>)
 id 1hziQA-0007bK-GU
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 10:14:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/v/i3lkFOZJbDfBi8DTHhH41q/zuhi4Zu7t+lBLZaKmnTV4eDERNOAW6kjDjuKflLqzGvXJk/jhWKRxtrtSCBpzeJSeDCzcg0ELlZ+2lkzmaEfK3Xu+IFw119cKGjObM0YSPkqmqCGRoNdZPNsLC2C4YD0tWiWrXTQfpAtyW2epGRoddhpm54JCILGjv/NP/Jo9rcG/p8In0jWSfZbwfPyLbNbOa9vsk14yhszJwjPubr/nj6Cr1+/G+n1WBXLOgnZcIPsW6pxDZ1i6y74mDN60N9xetYqZyswjJUH66YfTUoyc8sDlHvTlBqbjlJsZ0ROgWCl1yYKWXynoHe/SJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uf8xGm9/fsubMWsPT0O4w06WCQSgPh80I3upr7xyCn4=;
 b=gdbUDBi/1Df0bpqwhEWpAj56RzGu2OKxfL/Yj9AsQavApawj8Y5eKy+9406PCe0+clKNBPKBZAlrA/7L5sU0qi4NaU2U7JPf/FL2iumfXJ8frcEP26YEe2wOPy4UvzVzQb8dG6l04zCmYXSYfWxv4fAoL/XDGcNXFMe1z1xtY+nV4jiZ22UuNPfFZsx4yvAYRliVOT3NZ4RQJVgD0CXCLLJWQh9GRMLJ6YOcmyJuAEfvkycdjdkZ/jNnsGVr9GgqqKiyP0CDQrcO7uqPSwk/2smCifcRU9bSIAzVTJS2hFqc1SjLb1W8iORJuI78CdFtJELnBpz+Sco+QJBlbaxIXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wavecomp.com; dmarc=pass action=none header.from=wavecomp.com;
 dkim=pass header.d=wavecomp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uf8xGm9/fsubMWsPT0O4w06WCQSgPh80I3upr7xyCn4=;
 b=VhdocU0LA07EfvBzpF9Zy9E1ZJBKWBTHsLSWDVsgkaitwnoJwgfAoErUVsp7qrQVHR1YUY4ZNGdd2CwasAryxcRKugcSRJ+aYOWXSsCYunv822wbgsgqLQLdTgSSrUXL2/19e7GbXHd4xsC8dydFhhplj+AeTq391Dayd3MsUnQ=
Received: from DM5PR22MB1658.namprd22.prod.outlook.com (10.164.152.163) by
 DM5PR22MB0969.namprd22.prod.outlook.com (10.171.160.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Mon, 19 Aug 2019 14:14:03 +0000
Received: from DM5PR22MB1658.namprd22.prod.outlook.com
 ([fe80::ed69:1c9f:bdff:2197]) by DM5PR22MB1658.namprd22.prod.outlook.com
 ([fe80::ed69:1c9f:bdff:2197%5]) with mapi id 15.20.2178.018; Mon, 19 Aug 2019
 14:14:03 +0000
From: Aleksandar Rikalo <arikalo@wavecomp.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [EXTERNAL][PATCH v8 02/37] target/mips: Amend CP0 WatchHi
 register implementation
Thread-Index: AQHVVphajK9WGL0IF0C1ssg0Wy0PYA==
Date: Mon, 19 Aug 2019 14:14:03 +0000
Message-ID: <DM5PR22MB16589E0534B19469B3E0E78FD2A80@DM5PR22MB1658.namprd22.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=arikalo@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b5060e7-f5f1-4251-70aa-08d724af7d2e
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DM5PR22MB0969; 
x-ms-traffictypediagnostic: DM5PR22MB0969:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR22MB096996BDFBD740C8BD475451D2A80@DM5PR22MB0969.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(136003)(396003)(376002)(346002)(366004)(189003)(199004)(81166006)(55236004)(53546011)(102836004)(99286004)(186003)(2906002)(14444005)(256004)(33656002)(26005)(229853002)(71190400001)(6506007)(71200400001)(6246003)(478600001)(107886003)(53936002)(7736002)(4326008)(74316002)(2501003)(19627405001)(110136005)(25786009)(14454004)(54906003)(476003)(316002)(66066001)(6606003)(9686003)(6436002)(55016002)(7696005)(86362001)(52536014)(54896002)(66946007)(8936002)(8676002)(81156014)(91956017)(76116006)(66556008)(6116002)(3846002)(486006)(66446008)(64756008)(5660300002)(66476007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR22MB0969;
 H:DM5PR22MB1658.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /X60NmkO9nsA5AToapzyez7Ln+XI/TTUl8/wxoy4ehSOV0lReVi4zAe4B6YW3iCRAe2mAC04J0HnJFfmNKI+vdW8V2oFxEKBhklzr1ilOKcORyybFlioLvn4N2WpM8FJ+cU6UH7A7y/WxouzgForSdb7AgvQ7byzATvR5I/YisLv68m/k0XWduCpXULfagaBW8n0jwJCMoNdmiW0DZQOtsnpr4ZQ1UFEv/6qIkmaTxctOyCj7uJa4vGjRFoK0ghocfA4pMbw/6pcLbwJGriBQNSiKexqO8/pIMqT39aN1t3gO50BZtMUWcJQJRMwz0s6pPn32Y9Rp80G9jY7JKLVzyVpnGx3d+aSMDaVBB+AbFtcIv3BZoI7beJsJs5usAkGPSzeh6r3qQYP31ryNKQN/llPIr52hT8ifngreFW/4Gs=
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b5060e7-f5f1-4251-70aa-08d724af7d2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 14:14:03.3777 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RJl/4U9mQu7xI3xmmqrmwJ55/EneTzxsgpb+iz/YqfyVtsNpVtUj/o4/bmIAX7pmdKR/Fw7i+hLXJoFEoRq6Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR22MB0969
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.68.138
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [EXTERNAL][PATCH v8 02/37] target/mips: Amend CP0
 WatchHi register implementation
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
> Subject: [EXTERNAL][PATCH v8 02/37] target/mips: Amend CP0 WatchHi regist=
er implementation
>
> From: Yongbok Kim <yongbok.kim@mips.com>
>
> WatchHi is extended by the field MemoryMapID with the GINVT instruction.
> The field is accessible by MTHC0/MFHC0 in 32-bit architectures and DMTC0/
> DMFC0 in 64-bit architectures.
>
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  target/mips/cpu.h       |  2 +-
>  target/mips/helper.h    |  3 +++
>  target/mips/machine.c   |  6 +++---
>  target/mips/op_helper.c | 23 +++++++++++++++++++++--
>  target/mips/translate.c | 42 +++++++++++++++++++++++++++++++++++++++++-
>  5 files changed, 69 insertions(+), 7 deletions(-)
>
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index 90a2ed8..6406ba8 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -898,7 +898,7 @@ struct CPUMIPSState {
>  /*
>   * CP0 Register 19
>   */
> -    int32_t CP0_WatchHi[8];
> +    uint64_t CP0_WatchHi[8];
>  #define CP0WH_ASID 16
>  /*
>   * CP0 Register 20
> diff --git a/target/mips/helper.h b/target/mips/helper.h
> index 51f0e1c..aad0951 100644
> --- a/target/mips/helper.h
> +++ b/target/mips/helper.h
> @@ -78,6 +78,7 @@ DEF_HELPER_1(mfc0_maar, tl, env)
>  DEF_HELPER_1(mfhc0_maar, tl, env)
>  DEF_HELPER_2(mfc0_watchlo, tl, env, i32)
>  DEF_HELPER_2(mfc0_watchhi, tl, env, i32)
> +DEF_HELPER_2(mfhc0_watchhi, tl, env, i32)
>  DEF_HELPER_1(mfc0_debug, tl, env)
>  DEF_HELPER_1(mftc0_debug, tl, env)
>  #ifdef TARGET_MIPS64
> @@ -89,6 +90,7 @@ DEF_HELPER_1(dmfc0_tcschefback, tl, env)
>  DEF_HELPER_1(dmfc0_lladdr, tl, env)
>  DEF_HELPER_1(dmfc0_maar, tl, env)
>  DEF_HELPER_2(dmfc0_watchlo, tl, env, i32)
> +DEF_HELPER_2(dmfc0_watchhi, tl, env, i32)
>  DEF_HELPER_1(dmfc0_saar, tl, env)
>  #endif /* TARGET_MIPS64 */
>
> @@ -159,6 +161,7 @@ DEF_HELPER_2(mthc0_maar, void, env, tl)
>  DEF_HELPER_2(mtc0_maari, void, env, tl)
>  DEF_HELPER_3(mtc0_watchlo, void, env, tl, i32)
>  DEF_HELPER_3(mtc0_watchhi, void, env, tl, i32)
> +DEF_HELPER_3(mthc0_watchhi, void, env, tl, i32)
>  DEF_HELPER_2(mtc0_xcontext, void, env, tl)
>  DEF_HELPER_2(mtc0_framemask, void, env, tl)
>  DEF_HELPER_2(mtc0_debug, void, env, tl)
> diff --git a/target/mips/machine.c b/target/mips/machine.c
> index eb2d970..c3e52f8 100644
> --- a/target/mips/machine.c
> +++ b/target/mips/machine.c
> @@ -213,8 +213,8 @@ const VMStateDescription vmstate_tlb =3D {
>
>  const VMStateDescription vmstate_mips_cpu =3D {
>      .name =3D "cpu",
> -    .version_id =3D 18,
> -    .minimum_version_id =3D 18,
> +    .version_id =3D 19,
> +    .minimum_version_id =3D 19,
>      .post_load =3D cpu_post_load,
>      .fields =3D (VMStateField[]) {
>          /* Active TC */
> @@ -297,7 +297,7 @@ const VMStateDescription vmstate_mips_cpu =3D {
>          VMSTATE_INT32(env.CP0_MAARI, MIPSCPU),
>          VMSTATE_UINTTL(env.lladdr, MIPSCPU),
>          VMSTATE_UINTTL_ARRAY(env.CP0_WatchLo, MIPSCPU, 8),
> -        VMSTATE_INT32_ARRAY(env.CP0_WatchHi, MIPSCPU, 8),
> +        VMSTATE_UINT64_ARRAY(env.CP0_WatchHi, MIPSCPU, 8),
>          VMSTATE_UINTTL(env.CP0_XContext, MIPSCPU),
>          VMSTATE_INT32(env.CP0_Framemask, MIPSCPU),
>          VMSTATE_INT32(env.CP0_Debug, MIPSCPU),
> diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
> index 628da45..279b800 100644
> --- a/target/mips/op_helper.c
> +++ b/target/mips/op_helper.c
> @@ -979,7 +979,12 @@ target_ulong helper_mfc0_watchlo(CPUMIPSState *env, =
uint32_t sel)
>
>  target_ulong helper_mfc0_watchhi(CPUMIPSState *env, uint32_t sel)
>  {
> -    return env->CP0_WatchHi[sel];
> +    return (int32_t) env->CP0_WatchHi[sel];
> +}
> +
> +target_ulong helper_mfhc0_watchhi(CPUMIPSState *env, uint32_t sel)
> +{
> +    return env->CP0_WatchHi[sel] >> 32;
>  }
>
>  target_ulong helper_mfc0_debug(CPUMIPSState *env)
> @@ -1055,6 +1060,11 @@ target_ulong helper_dmfc0_saar(CPUMIPSState *env)
>      }
>      return 0;
>  }
> +
> +target_ulong helper_dmfc0_watchhi(CPUMIPSState *env, uint32_t sel)
> +{
> +    return env->CP0_WatchHi[sel];
> +}
>  #endif /* TARGET_MIPS64 */
>
>  void helper_mtc0_index(CPUMIPSState *env, target_ulong arg1)
> @@ -1896,11 +1906,20 @@ void helper_mtc0_watchlo(CPUMIPSState *env, targe=
t_ulong arg1, uint32_t sel)
>
>  void helper_mtc0_watchhi(CPUMIPSState *env, target_ulong arg1, uint32_t =
sel)
>  {
> -    int mask =3D 0x40000FF8 | (env->CP0_EntryHi_ASID_mask << CP0WH_ASID)=
;
> +    uint64_t mask =3D 0x40000FF8 | (env->CP0_EntryHi_ASID_mask << CP0WH_=
ASID);
> +    if ((env->CP0_Config5 >> CP0C5_MI) & 1) {
> +        mask |=3D 0xFFFFFFFF00000000ULL; /* MMID */
> +    }
>      env->CP0_WatchHi[sel] =3D arg1 & mask;
>      env->CP0_WatchHi[sel] &=3D ~(env->CP0_WatchHi[sel] & arg1 & 0x7);
>  }
>
> +void helper_mthc0_watchhi(CPUMIPSState *env, target_ulong arg1, uint32_t=
 sel)
> +{
> +    env->CP0_WatchHi[sel] =3D ((uint64_t) (arg1) << 32) |
> +                            (env->CP0_WatchHi[sel] & 0x00000000ffffffffU=
LL);
> +}
> +
>  void helper_mtc0_xcontext(CPUMIPSState *env, target_ulong arg1)
>  {
>      target_ulong mask =3D (1ULL << (env->SEGBITS - 7)) - 1;
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 4ebeabe..b40468d 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -2547,6 +2547,7 @@ typedef struct DisasContext {
>      bool nan2008;
>      bool abs2008;
>      bool saar;
> +    bool mi;
>  } DisasContext;
>
>  #define DISAS_STOP       DISAS_TARGET_0
> @@ -6680,6 +6681,25 @@ static void gen_mfhc0(DisasContext *ctx, TCGv arg,=
 int reg, int sel)
>              goto cp0_unimplemented;
>          }
>          break;
> +    case CP0_REGISTER_19:
> +        switch (sel) {
> +        case 0:
> +        case 1:
> +        case 2:
> +        case 3:
> +        case 4:
> +        case 5:
> +        case 6:
> +        case 7:
> +            /* upper 32 bits are only available when Config5MI !=3D 0 */
> +            CP0_CHECK(ctx->mi);
> +            gen_mfhc0_load64(arg, offsetof(CPUMIPSState, CP0_WatchHi[sel=
]), 0);
> +            register_name =3D "WatchHi";
> +            break;
> +        default:
> +            goto cp0_unimplemented;
> +        }
> +        break;
>      case CP0_REGISTER_28:
>          switch (sel) {
>          case 0:
> @@ -6766,6 +6786,25 @@ static void gen_mthc0(DisasContext *ctx, TCGv arg,=
 int reg, int sel)
>              goto cp0_unimplemented;
>          }
>          break;
> +    case CP0_REGISTER_19:
> +        switch (sel) {
> +        case 0:
> +        case 1:
> +        case 2:
> +        case 3:
> +        case 4:
> +        case 5:
> +        case 6:
> +        case 7:
> +            /* upper 32 bits are only available when Config5MI !=3D 0 */
> +            CP0_CHECK(ctx->mi);
> +            gen_helper_0e1i(mthc0_watchhi, arg, sel);
> +            register_name =3D "WatchHi";
> +            break;
> +        default:
> +            goto cp0_unimplemented;
> +        }
> +        break;
>      case CP0_REGISTER_28:
>          switch (sel) {
>          case 0:
> @@ -8805,7 +8844,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, =
int reg, int sel)
>          case 6:
>          case 7:
>              CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
> -            gen_helper_1e0i(mfc0_watchhi, arg, sel);
> +            gen_helper_1e0i(dmfc0_watchhi, arg, sel);
>              register_name =3D "WatchHi";
>              break;
>          default:
> @@ -29965,6 +30004,7 @@ static void mips_tr_init_disas_context(DisasConte=
xtBase *dcbase, CPUState *cs)
>      ctx->mrp =3D (env->CP0_Config5 >> CP0C5_MRP) & 1;
>      ctx->nan2008 =3D (env->active_fpu.fcr31 >> FCR31_NAN2008) & 1;
>      ctx->abs2008 =3D (env->active_fpu.fcr31 >> FCR31_ABS2008) & 1;
> +    ctx->mi =3D (env->CP0_Config5 >> CP0C5_MI) & 1;
>      restore_cpu_state(env, ctx);
>  #ifdef CONFIG_USER_ONLY
>          ctx->mem_idx =3D MIPS_HFLAG_UM;
> --
> 2.7.4

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>


