Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618FBC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 13:27:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E8E1206BE
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 13:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="ICr4qxUE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E8E1206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqcla-0003tz-Fj
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 09:27:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50134)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1jqckv-0003MJ-T1; Wed, 01 Jul 2020 09:26:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:15993)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1jqckt-0000wi-94; Wed, 01 Jul 2020 09:26:29 -0400
IronPort-SDR: I4V2uwMSuZTkSfN0p557olerPvI9EfJ8dJTkgR6+u996ul2+GI+wIeox8m5AybJc8KCMNKpweO
 Ek7oaa6Da4tw==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="231433704"
X-IronPort-AV: E=Sophos;i="5.75,300,1589266800"; d="scan'208";a="231433704"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2020 06:26:21 -0700
IronPort-SDR: Y7bxvnOClHdxC4tTaEUP0l/SBz9XPlQe89tEto0xI4MEaImG0l0JjOunwPr15epKnXCyLGvoWt
 NumJP4e3GkjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,300,1589266800"; d="scan'208";a="312689649"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
 by orsmga008.jf.intel.com with ESMTP; 01 Jul 2020 06:26:20 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 1 Jul 2020 06:26:20 -0700
Received: from fmsmsx153.amr.corp.intel.com (10.18.125.6) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 1 Jul 2020 06:26:20 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX153.amr.corp.intel.com (10.18.125.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 1 Jul 2020 06:26:18 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 1 Jul 2020 06:26:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ar5HyXyR5yT0HOijUw8IiVogaPPloF86j6gF0lBaw2JRTSUvYm4oOuvOJvf3KKZt+v21J0kwc9VepswTDt715UgCMTJ6fA57t92RTK4DQ2ei7lie922oHQ7TEGjoOUrmQeekc+2x7QQw5sj05Kh+ZavxHjblgPwPlAaDfi2/DBQvcGRk3ii+FiU4ICq7qVsY0ENp4q7HB1SQ3/fm4TVGzPeXjQP0tG44E4OXebx2HsFLY35N4beeDS/mXKTZX0vx72gaoAJiINVm4GVA2yXkfkbp0ePItfQPqmFuNG4IKJ5VN0wT7y37fmQ+9kWOb7qUExaIjNlHdXnw/mctICfC3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNFkWNM1azEOqCX9/+rI2tcrvNA/LyR5KHcRKvQOXf4=;
 b=dUnPZdwi3USrH/ld9/8pDxBEAFAZgEr1eVKeTuBQv5kXPchWkqIkJ7Rkd/6t6171uNB7rHM78ZNME/9A/4HA7rHHVJojdBLIdMnKLa59MgXYkH1k7ZNBE67778L8OF/L9yaQkXYhGFwSf8Fh+JfiLVVUEoxhmYCqEeuz5T2vgzkvsv0ye+2DDKu9ImAMesyQvMVFwBbFmV9jfOPGUFfvn8MQ6oA7VkdQ/U2ugOSstFPvK83JAOHp9Oz/TRCQ9QGntTgQXpXqRG4hR2gqYsOFNI1tQT1GfmCEIKSue73RPvzDQzwr3u9p0jH7JevudOXPdB5W0T37rNLVVXpPDIx2ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNFkWNM1azEOqCX9/+rI2tcrvNA/LyR5KHcRKvQOXf4=;
 b=ICr4qxUEAO6o3qzBMZ+qcmtE6uktlPAAewiLiIr1Z10UJxXBufpSWPllM2dE1ZQOtrpAHDG9RsqSpVH59woZfDER7QliCpWT066hKuCKIRsZ1JnSorAYbJnzUDPQrsUGRDbdsj16nlySuer7Dq5Y7t9zC2DlhVroIFLpW7YadGU=
Received: from DM5PR11MB1833.namprd11.prod.outlook.com (2603:10b6:3:110::12)
 by DM6PR11MB4425.namprd11.prod.outlook.com (2603:10b6:5:1d9::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Wed, 1 Jul
 2020 13:26:15 +0000
Received: from DM5PR11MB1833.namprd11.prod.outlook.com
 ([fe80::4ce3:6680:7257:7c74]) by DM5PR11MB1833.namprd11.prod.outlook.com
 ([fe80::4ce3:6680:7257:7c74%6]) with mapi id 15.20.3131.028; Wed, 1 Jul 2020
 13:26:15 +0000
From: "Wu, Wentong" <wentong.wu@intel.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Subject: RE: [PATCH 3/3] target/nios2: Use gen_io_start around wrctl
 instruction
Thread-Topic: [PATCH 3/3] target/nios2: Use gen_io_start around wrctl
 instruction
Thread-Index: AQHWTe3BOsAD/7AE8EK8jau5tLLWZajyuYYQ
Date: Wed, 1 Jul 2020 13:26:15 +0000
Message-ID: <DM5PR11MB18335DC92550D442DE78DCFB8D6C0@DM5PR11MB1833.namprd11.prod.outlook.com>
References: <20200629160535.3910-1-wentong.wu@intel.com>
 <20200629160535.3910-3-wentong.wu@intel.com>
In-Reply-To: <20200629160535.3910-3-wentong.wu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da6e3005-c523-43ca-caf4-08d81dc2548a
x-ms-traffictypediagnostic: DM6PR11MB4425:
x-microsoft-antispam-prvs: <DM6PR11MB4425C0FF0CC6D9CDB3643D378D6C0@DM6PR11MB4425.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qzkuVC0ZHxZr1H6Y1Td5VokYhVvVp0JCOsRhEsRUIOnjobbLiHDGuBHafReRbi9c6OawZYjd+kKZpdh9WP7ZfdUml7qsxW2WJdvfstq+oH5sYCVEfrb3IOvkO/pj4T1y+gLUA2NAbujDOfliVQddorPcJZhv5GtIRmxpSLjvOPbsbnwtPsyyeF0tkRrBk8WFGsDl89FJ8+Uz/g8K3EU9OmpiKJu8LE+rhzHt8Hsbua3pOwAp/bClRBuGcYW580MXOeUHKxqZIDU6h/3GVaP5ZNFMesnfXlh9+io473r6IHGnpjhNe4EQchRSChKE0awkWYzdXe8zR8021uEJ1ZxnaQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1833.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(376002)(396003)(39860400002)(346002)(76116006)(110136005)(316002)(478600001)(33656002)(52536014)(2906002)(8936002)(6506007)(5660300002)(66946007)(71200400001)(4326008)(7696005)(26005)(186003)(66476007)(64756008)(55016002)(8676002)(66556008)(66446008)(83380400001)(9686003)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: RyfnT1rvN8z8inqX7JgDgDL3Pxt/FCfEt3Opn3OFPdGL0oRy904RKtvF10MH09fUZut/iqWPKkANhPTeMwQQxkPJKgd7Zohwo7ClDBrIA+XBhZILowP8sOdjzmNAWX6O8XLXNmBqyBYndLFc4yXNxI0IGRQp4s6J2mClAj5YWhwAQMhUJBtymzU9YYQ003jjApNdH+8Xz4XfItUj0ElRjaQzJ3RZR0OjbbjCbjBZvjAtabyLx8hccq07MyyYzF5FzlJVgD++/izkzl221MwdhMmix/nqukrsymJktyK6AsSSOFlCgBDlrNwzi4guHS3AmSxJmpovWW2XpdWAYHIxeEezorbWBoYcqBP8a1WETSJxMNpZKOP407Sev5OifoWywXeGu8O5YHSehdDwGGOcv/Pd2YvlqJXaLcPfo2ySSOOUyfu+BZJJz5YR4dxTTnGWBsHAUv6bC6qU0bKUEOnup5YaFrw2kRE5JJTEeFk6Dt68j8rNJrFVaFwgabH6VY0W
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1833.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da6e3005-c523-43ca-caf4-08d81dc2548a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 13:26:15.1388 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8oICWJ5ZegwDC7Xs38655r/KNT1MHAIoWW6Yu9040t7Ec8MxsZUS51evZh2cfFdDIzXlAxYsdfcCnPki+J8Txg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4425
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.43; envelope-from=wentong.wu@intel.com;
 helo=mga05.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 09:26:22
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,
Could you please take a look the new patch?

Thanks

> -----Original Message-----
> Subject: [PATCH 3/3] target/nios2: Use gen_io_start around wrctl instruct=
ion
> wrctl instruction on nios2 target will cause checking cpu interrupt but t=
cg_handle_interrupt() will call cpu_abort() if the CPU gets an interrupt wh=
ile it's not in 'can do IO'
> state, so add gen_io_start around wrctl instruction. Also at the same tim=
e, end the onging TB with DISAS_UPDATE.

> Signed-off-by: Wentong Wu <wentong.wu@intel.com>
> ---
> target/nios2/translate.c | 5 +++++
> 1 file changed, 5 insertions(+)
>
> diff --git a/target/nios2/translate.c b/target/nios2/translate.c index 83=
c10eb2..51347ada 100644
> --- a/target/nios2/translate.c
> +++ b/target/nios2/translate.c
> @@ -32,6 +32,7 @@
> #include "exec/cpu_ldst.h"
> #include "exec/translator.h"
> #include "qemu/qemu-print.h"
> +#include "exec/gen-icount.h"
=20
>  /* is_jmp field values */
> #define DISAS_JUMP    DISAS_TARGET_0 /* only pc was modified dynamically =
*/
> @@ -518,7 +519,11 @@ static void wrctl(DisasContext *dc, uint32_t code, u=
int32_t flags)
>     /* If interrupts were enabled using WRCTL, trigger them. */  #if !def=
ined(CONFIG_USER_ONLY)
>    if ((instr.imm5 + CR_BASE) =3D=3D CR_STATUS) {
> +        if (tb_cflags(dc->tb) & CF_USE_ICOUNT) {
> +            gen_io_start();
> +        }
>          gen_helper_check_interrupts(dc->cpu_env);
> +        dc->is_jmp =3D DISAS_UPDATE;
>    }
> #endif
> }
> --
> 2.21.3


