Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD875C388F2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 13:27:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CAF52054F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 13:27:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CAF52054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZZsA-0004mJ-5Y
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 08:27:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kZZqF-0004Ky-Pv
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 08:25:47 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2173)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kZZqD-0001BR-Di
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 08:25:47 -0500
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.57])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4CPtvW6Nz4z4wX4;
 Mon,  2 Nov 2020 21:25:27 +0800 (CST)
Received: from DGGEMM423-HUB.china.huawei.com (10.1.198.40) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Mon, 2 Nov 2020 21:25:29 +0800
Received: from DGGEMM531-MBX.china.huawei.com ([169.254.5.225]) by
 dggemm423-hub.china.huawei.com ([10.1.198.40]) with mapi id 14.03.0487.000;
 Mon, 2 Nov 2020 21:25:26 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH v2] pc: comment style fixup
Thread-Topic: [PATCH v2] pc: comment style fixup
Thread-Index: AQHWsQNOGPUu64K5NEKyu6P2/9XNo6m01O2Q
Date: Mon, 2 Nov 2020 13:25:26 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83BA2226C@dggemm531-mbx.china.huawei.com>
References: <20201102102815.1102222-1-mst@redhat.com>
In-Reply-To: <20201102102815.1102222-1-mst@redhat.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.185.149]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.189;
 envelope-from=kuhn.chenqun@huawei.com; helo=szxga03-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 08:25:31
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Qemu-devel
> [mailto:qemu-devel-bounces+kuhn.chenqun=3Dhuawei.com@nongnu.org] On
> Behalf Of Michael S. Tsirkin
> Sent: Monday, November 2, 2020 6:29 PM
> To: qemu-devel@nongnu.org
> Cc: Paolo Bonzini <pbonzini@redhat.com>; Eduardo Habkost
> <ehabkost@redhat.com>; Richard Henderson <rth@twiddle.net>
> Subject: [PATCH v2] pc: comment style fixup
>=20
> Fix up checkpatch comment style warnings.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>=20
> changes from v1:
>     address philippe's comments
> :w
>=20
>  hw/i386/pc.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c index 416fb0e0f6..aae45ba779 100=
644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1149,10 +1149,11 @@ void pc_basic_device_init(struct PCMachineState
> *pcms,
>              error_report("couldn't create HPET device");
>              exit(1);
>          }
> -        /* For pc-piix-*, hpet's intcap is always IRQ2. For pc-q35-1.7
> -            * and earlier, use IRQ2 for compat. Otherwise, use IRQ16~23,
> -            * IRQ8 and IRQ2.
> -            */
> +        /*
> +         * For pc-piix-*, hpet's intcap is always IRQ2. For pc-q35-1.7 a=
nd
> +         * earlier, use IRQ2 for compat. Otherwise, use IRQ16~23, IRQ8 a=
nd
> +         * IRQ2.
> +         */
>          uint8_t compat =3D object_property_get_uint(OBJECT(hpet),
>                  HPET_INTCAP, NULL);
>          if (!compat) {
> --
> MST
>=20

Reviewed-by: Chen Qun <kuhn.chenqun@huawei.com>

