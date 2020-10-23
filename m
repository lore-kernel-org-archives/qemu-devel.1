Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445F3C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 09:42:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 772C324182
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 09:42:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 772C324182
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVtaL-0007Co-FS
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 05:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiangyifei@huawei.com>)
 id 1kVtZa-0006mI-BB; Fri, 23 Oct 2020 05:41:22 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2945 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiangyifei@huawei.com>)
 id 1kVtZX-0006Dk-HT; Fri, 23 Oct 2020 05:41:21 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id 26E749EBEFB06B6A1720;
 Fri, 23 Oct 2020 17:41:09 +0800 (CST)
Received: from dggemm754-chm.china.huawei.com (10.1.198.60) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 23 Oct 2020 17:41:08 +0800
Received: from dggpemm000001.china.huawei.com (7.185.36.245) by
 dggemm754-chm.china.huawei.com (10.1.198.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 23 Oct 2020 17:41:08 +0800
Received: from dggpemm000001.china.huawei.com ([7.185.36.245]) by
 dggpemm000001.china.huawei.com ([7.185.36.245]) with mapi id 15.01.1913.007;
 Fri, 23 Oct 2020 17:41:08 +0800
From: Jiangyifei <jiangyifei@huawei.com>
To: "Alistair.Francis@wdc.com" <Alistair.Francis@wdc.com>
Subject: RE: [PATCH V3 1/6] target/riscv: Merge m/vsstatus and m/vsstatush
 into one uint64_t unit
Thread-Topic: [PATCH V3 1/6] target/riscv: Merge m/vsstatus and m/vsstatush
 into one uint64_t unit
Thread-Index: AQHWqRys4dCH1TwnVkqlZ+p9iNToy6mk7YzQ
Date: Fri, 23 Oct 2020 09:41:08 +0000
Message-ID: <6b5533929fa74311b3e5264b126a1d18@huawei.com>
References: <20201023091225.224-1-jiangyifei@huawei.com>
 <20201023091225.224-2-jiangyifei@huawei.com>
In-Reply-To: <20201023091225.224-2-jiangyifei@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.186.209]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.187;
 envelope-from=jiangyifei@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 05:41:09
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "sagark@eecs.berkeley.edu" <sagark@eecs.berkeley.edu>,
 "kbastian@mail.uni-paderborn.de" <kbastian@mail.uni-paderborn.de>,
 "Zhangxiaofeng \(F\)" <victor.zhangxiaofeng@huawei.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>, yinyipeng <yinyipeng1@huawei.com>,
 "Wubin \(H\)" <wu.wubin@huawei.com>, "dengkai \(A\)" <dengkai1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> -----Original Message-----
> From: Jiangyifei
> Sent: Friday, October 23, 2020 5:12 PM
> To: qemu-devel@nongnu.org; qemu-riscv@nongnu.org
> Cc: palmer@dabbelt.com; Alistair.Francis@wdc.com;
> sagark@eecs.berkeley.edu; kbastian@mail.uni-paderborn.de;
> richard.henderson@linaro.org; Zhangxiaofeng (F)
> <victor.zhangxiaofeng@huawei.com>; Wubin (H) <wu.wubin@huawei.com>;
> Zhanghailiang <zhang.zhanghailiang@huawei.com>; dengkai (A)
> <dengkai1@huawei.com>; yinyipeng <yinyipeng1@huawei.com>; Jiangyifei
> <jiangyifei@huawei.com>
> Subject: [PATCH V3 1/6] target/riscv: Merge m/vsstatus and m/vsstatush in=
to
> one uint64_t unit
>=20
> mstatus/mstatush and vsstatus/vsstatush are two halved for RISCV32.
> This patch expands mstatus and vsstatus to uint64_t instead of target_ulo=
ng
> so that it can be saved as one unit and reduce some ifdefs in the code.
>=20
> Signed-off-by: Yifei Jiang <jiangyifei@huawei.com>
> Signed-off-by: Yipeng Yin <yinyipeng1@huawei.com>
> ---
......
>  static int write_mstatush(CPURISCVState *env, int csrno, target_ulong va=
l)
> {
> -    if ((val ^ env->mstatush) & (MSTATUS_MPV)) {
> +    uint64_t valh =3D (uint64_t)val << 32;
> +    uint64_t mask =3D MSTATUS_MPV | MSTATUS_GVA;
> +
> +    if ((valh ^ env->mstatus) & (MSTATUS_MPV)) {
>          tlb_flush(env_cpu(env));
>      }
>=20
> -    val &=3D MSTATUS_MPV | MSTATUS_GVA;
> -
> -    env->mstatush =3D val;
> +    env->mstatus =3D (env->mstatus & ~mask) | (valh & mask);
>=20
>      return 0;
>  }

Hi Alistair,

It's a little different here.

Previously, except for MPV and GVA, other bits were cleared.
Now, except for MPV and GVA, other bits are reserved.
Refer to write_mstatus () and specification, I think it's better now.
How does it sound?

Yifei


