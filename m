Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EEDC19759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 13:28:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F04C20657
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 13:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="E4qKgWrn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F04C20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htB7f-0005XA-Cq
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 09:27:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36852)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aaron@os.amperecomputing.com>) id 1htB7A-0004ng-6Y
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 09:27:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aaron@os.amperecomputing.com>) id 1htB78-0000jc-AM
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 09:27:28 -0400
Received: from mail-eopbgr820092.outbound.protection.outlook.com
 ([40.107.82.92]:19729 helo=NAM01-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aaron@os.amperecomputing.com>)
 id 1htB78-0000i1-0T; Thu, 01 Aug 2019 09:27:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4S9Vnx0RqBisog9RJU6DY9mZrY9Q/BEhlWDC0aNKHoJM/4IjcbhTqogNKuH5g9qgbMygfqBmDkSnw6L3MYMU5aviOhJgDp7NfJXNIOkoLsggSsxZ4vmFR594xdAaDI1NUgWZQ7KrryVEFXaP4fI9a7XfVwPbAtMZ40ZPy/6bFckAwcQid/773Wv/YZ8/qjr3FX6PH8O2ReTxs3jY8Npr/lwd9fO1ZgAfCW/rUZv99FZzYVYXw/qAAHNN/c5klEgrQlxA+227stEmEP2qrapzoh7715wNKC+Huw6IVjy3CmZ80mjt6aHhQFA9A9W0DCGOep+1SKiAPp9fhcDxQkBQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cLIhCJHLXxq+SWthXwvTMEcYdhMZSn+6Zpj5ZqUCJY=;
 b=iuqffrxpLP/V66BuFg/EfKQebBTwmwxNOiMF5skYXZAZj5WlUPPyHmjXrk65x15mk37SXhNoxcx/2iATwXiou7U12EEnalAxsrznz0DaaITPCWHG8fGiGG4PmEjqUbgI/rW2Isbr2Mt2cuxs1VYqbUa5meIWrEFwJH8+9Hqxoq9cfcCfwSWRhyjoampRbRS1pRH+xVKNeTq4UbQezKNLPUEqWC5q6STjPioZ/2Z66UhsarvrF8v4BJ+tOrKP0opNB7PvaN0LjoldYQIleizaUqbo+ob1PCVgJdaibAkGRVeHSZFRTOat/4/EsC3k0ruNqyHCV1Wiolxo1nt79OyD7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=os.amperecomputing.com;dmarc=pass action=none
 header.from=os.amperecomputing.com;dkim=pass
 header.d=os.amperecomputing.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cLIhCJHLXxq+SWthXwvTMEcYdhMZSn+6Zpj5ZqUCJY=;
 b=E4qKgWrn5rTRbMJFAz7sxb6VcFEjoXAtv0hmztfu/5NAW7SSHe6KaPW4k56laWMRdhz7mq4jicn8QR1PLS7LhzQZ0Q+T2kn4c2GXREU95mueg5c+L6nTAGBAxXwNDFDUnpnVAItDkG9icm/dkwQAqkwQ0RgGEYVRfCCuGZEMFGs=
Received: from DM6PR01MB4825.prod.exchangelabs.com (20.177.218.222) by
 DM6PR01MB4587.prod.exchangelabs.com (20.177.222.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Thu, 1 Aug 2019 13:27:16 +0000
Received: from DM6PR01MB4825.prod.exchangelabs.com
 ([fe80::4943:2b46:af24:e807]) by DM6PR01MB4825.prod.exchangelabs.com
 ([fe80::4943:2b46:af24:e807%7]) with mapi id 15.20.2136.010; Thu, 1 Aug 2019
 13:27:16 +0000
To: =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Thread-Topic: [PATCH v4 04/54] target/arm: remove run time semihosting checks
Thread-Index: AQHVR7oL9+ayys4sVECwZPH13XtFFKbmSjSA
Date: Thu, 1 Aug 2019 13:27:15 +0000
Message-ID: <20190801132659.GJ5034@quinoa.localdomain>
References: <20190731160719.11396-1-alex.bennee@linaro.org>
 <20190731160719.11396-5-alex.bennee@linaro.org>
In-Reply-To: <20190731160719.11396-5-alex.bennee@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR21CA0046.namprd21.prod.outlook.com
 (2603:10b6:903:12b::32) To DM6PR01MB4825.prod.exchangelabs.com
 (2603:10b6:5:6b::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aaron@os.amperecomputing.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [108.169.132.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd635bab-cd88-4e70-9824-08d71683f814
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DM6PR01MB4587; 
x-ms-traffictypediagnostic: DM6PR01MB4587:
x-microsoft-antispam-prvs: <DM6PR01MB45877FECC47FB74BF12A05738ADE0@DM6PR01MB4587.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01165471DB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(39830400003)(346002)(396003)(376002)(366004)(199004)(189003)(256004)(3846002)(6486002)(25786009)(478600001)(66946007)(486006)(14444005)(66476007)(66556008)(64756008)(66446008)(53936002)(14454004)(66066001)(11346002)(229853002)(4326008)(476003)(6436002)(6512007)(9686003)(6246003)(81156014)(81166006)(68736007)(71190400001)(71200400001)(66574012)(1076003)(6916009)(33656002)(2906002)(186003)(26005)(8676002)(5660300002)(8936002)(54906003)(99286004)(76176011)(6116002)(316002)(86362001)(446003)(102836004)(52116002)(305945005)(7736002)(6506007)(386003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR01MB4587;
 H:DM6PR01MB4825.prod.exchangelabs.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:0; MX:1; 
received-spf: None (protection.outlook.com: os.amperecomputing.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4Jjd34pR9lA4HJDqk/GD7oAaEttz395vk3q/5tFmd57HEdQ6qCuw8UHhJa0EG9boDqAx0VS7SreuQrt4v9dEjgO1sl0AzUM9FKrw68fPJ0cxQX9t+h4GkF7vMnSG8z9/dxuBALpLD0RxsX2nA1OM6LolfZvnd0zXaXeemzP3jvKQCAIP1YiUwGVvybBkV2Yd7w+ZNc90t37ylmcYVmq4lWTs/zOa+P0R+wYRfJAv7I76nTQ4f/R7XEDbsXtey6axCgRXva0uAou9F1w77CFIVEvgoJd1LHb25D6Nsum9Ruekpme5sYV2zQouobUT4suR+rpHmZ+/oXFI64zcccefhoaizrkUwYmE5UR94qDevljddFznoDZ+s+CqFhabQgPLvgZQ/ttHlIabYY/jxP25w7++5t4MuS4XyYq1k5diHa0=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <23CDEE135EF656488066B3295778FC98@prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd635bab-cd88-4e70-9824-08d71683f814
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2019 13:27:15.9228 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Aaron@os.amperecomputing.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB4587
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.82.92
Subject: Re: [Qemu-devel] [PATCH v4 04/54] target/arm: remove run time
 semihosting checks
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
From: Aaron Lindsay OS via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Aaron Lindsay OS <aaron@os.amperecomputing.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "bobby.prani@gmail.com" <bobby.prani@gmail.com>,
 "cota@braap.org" <cota@braap.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jul 31 17:06, Alex Benn=E9e wrote:
> Now we do all our checking and use a common EXCP_SEMIHOST for
> semihosting operations we can make helper code a lot simpler.
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
>=20
> ---
> v2
>   - fix re-base conflicts
>   - hoist EXCP_SEMIHOST check
>   - comment cleanups
> ---
>  target/arm/helper.c | 90 +++++++++------------------------------------
>  1 file changed, 18 insertions(+), 72 deletions(-)
>=20
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index b74c23a9bc0..c5b90a83d36 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -8259,86 +8259,30 @@ static void arm_cpu_do_interrupt_aarch64(CPUState=
 *cs)
>                    new_el, env->pc, pstate_read(env));
>  }
> =20
> -static inline bool check_for_semihosting(CPUState *cs)
> +/*
> + * Do semihosting call and set the appropriate return value. All the
> + * permission and validity checks have been done at translate time.
> + *
> + * We only see semihosting exceptions in TCG only as they are not
> + * trapped to the hypervisor in KVM.
> + */
> +static void handle_semihosting(CPUState *cs)
>  {
>  #ifdef CONFIG_TCG
> -    /* Check whether this exception is a semihosting call; if so
> -     * then handle it and return true; otherwise return false.
> -     */
>      ARMCPU *cpu =3D ARM_CPU(cs);
>      CPUARMState *env =3D &cpu->env;
> =20
>      if (is_a64(env)) {
> -        if (cs->exception_index =3D=3D EXCP_SEMIHOST) {
> -            /* This is always the 64-bit semihosting exception.
> -             * The "is this usermode" and "is semihosting enabled"
> -             * checks have been done at translate time.
> -             */
> -            qemu_log_mask(CPU_LOG_INT,
> -                          "...handling as semihosting call 0x%" PRIx64 "=
\n",
> -                          env->xregs[0]);
> -            env->xregs[0] =3D do_arm_semihosting(env);
> -            return true;
> -        }
> -        return false;
> +        qemu_log_mask(CPU_LOG_INT,
> +                      "...handling as semihosting call 0x%" PRIx64 "\n",
> +                      env->xregs[0]);
> +        env->xregs[0] =3D do_arm_semihosting(env);
>      } else {
> -        uint32_t imm;
> -
> -        /* Only intercept calls from privileged modes, to provide some
> -         * semblance of security.
> -         */
> -        if (cs->exception_index !=3D EXCP_SEMIHOST &&
> -            (!semihosting_enabled() ||
> -             ((env->uncached_cpsr & CPSR_M) =3D=3D ARM_CPU_MODE_USR))) {
> -            return false;
> -        }
> -
> -        switch (cs->exception_index) {
> -        case EXCP_SEMIHOST:
> -            /* This is always a semihosting call; the "is this usermode"
> -             * and "is semihosting enabled" checks have been done at
> -             * translate time.
> -             */
> -            break;
> -        case EXCP_SWI:
> -            /* Check for semihosting interrupt.  */
> -            if (env->thumb) {
> -                imm =3D arm_lduw_code(env, env->regs[15] - 2, arm_sctlr_=
b(env))
> -                    & 0xff;
> -                if (imm =3D=3D 0xab) {
> -                    break;
> -                }
> -            } else {
> -                imm =3D arm_ldl_code(env, env->regs[15] - 4, arm_sctlr_b=
(env))
> -                    & 0xffffff;
> -                if (imm =3D=3D 0x123456) {
> -                    break;
> -                }
> -            }
> -            return false;
> -        case EXCP_BKPT:
> -            /* See if this is a semihosting syscall.  */
> -            if (env->thumb) {
> -                imm =3D arm_lduw_code(env, env->regs[15], arm_sctlr_b(en=
v))
> -                    & 0xff;
> -                if (imm =3D=3D 0xab) {
> -                    env->regs[15] +=3D 2;
> -                    break;
> -                }
> -            }
> -            return false;
> -        default:
> -            return false;
> -        }
> -
>          qemu_log_mask(CPU_LOG_INT,
>                        "...handling as semihosting call 0x%x\n",
>                        env->regs[0]);
>          env->regs[0] =3D do_arm_semihosting(env);
> -        return true;
>      }
> -#else
> -    return false;
>  #endif
>  }
> =20
> @@ -8371,11 +8315,13 @@ void arm_cpu_do_interrupt(CPUState *cs)
>          return;
>      }
> =20
> -    /* Semihosting semantics depend on the register width of the
> -     * code that caused the exception, not the target exception level,
> -     * so must be handled here.
> +    /*
> +     * Semihosting semantics depend on the register width of the code
> +     * that caused the exception, not the target exception level, so
> +     * must be handled here.
>       */
> -    if (check_for_semihosting(cs)) {
> +    if (cs->exception_index =3D=3D EXCP_SEMIHOST) {
> +        handle_semihosting(cs);
>          return;
>      }

Previously, this code would never return here if CONFIG_TCG was not
defined because check_for_semihosting() always returned false in that
case. Is it now true that `cs->exception_index` will never hold a value
of EXCP_SEMIHOST if CONFIG_TCG is not defined (or that it is otherwise
correct to return here in that case where it wasn't previously)?

-Aaron

