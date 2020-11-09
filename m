Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CA4C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 10:55:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A67A20679
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 10:55:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A67A20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc4q1-0001xz-Tj
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 05:55:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1kc4oY-00014S-J3; Mon, 09 Nov 2020 05:54:22 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2174)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1kc4oV-0001sv-MF; Mon, 09 Nov 2020 05:54:22 -0500
Received: from dggeme755-chm.china.huawei.com (unknown [172.30.72.56])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4CV7CZ5p3mz52SD;
 Mon,  9 Nov 2020 18:54:02 +0800 (CST)
Received: from lhreml703-chm.china.huawei.com (10.201.108.52) by
 dggeme755-chm.china.huawei.com (10.3.19.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 9 Nov 2020 18:54:11 +0800
Received: from lhreml703-chm.china.huawei.com ([10.201.68.198]) by
 lhreml703-chm.china.huawei.com ([10.201.68.198]) with mapi id 15.01.1913.007; 
 Mon, 9 Nov 2020 10:54:09 +0000
From: Salil Mehta <salil.mehta@huawei.com>
To: fangying <fangying1@huawei.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>
Subject: RE: [RFC PATCH v3 02/13] hw/arm/virt: Remove unused variable
Thread-Topic: [RFC PATCH v3 02/13] hw/arm/virt: Remove unused variable
Thread-Index: AQHWtkUqNQJlsUS++0OVBoWRn9nyw6m/oBkA
Date: Mon, 9 Nov 2020 10:54:09 +0000
Message-ID: <7ff86d80c3b64fd98a9b39eec0829685@huawei.com>
References: <20201109030452.2197-1-fangying1@huawei.com>
 <20201109030452.2197-3-fangying1@huawei.com>
In-Reply-To: <20201109030452.2197-3-fangying1@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.28.252]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.189;
 envelope-from=salil.mehta@huawei.com; helo=szxga03-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 05:54:13
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
Cc: "drjones@redhat.com" <drjones@redhat.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "alistair.francis@wdc.com" <alistair.francis@wdc.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Fangying,
Same here. Why not club [01/13] and [02/13] together and send it separately=
?

Thanks

> From: fangying
> Sent: Monday, November 9, 2020 3:05 AM
> To: peter.maydell@linaro.org
> Cc: qemu-devel@nongnu.org; qemu-arm@nongnu.org; drjones@redhat.com;
> imammedo@redhat.com; shannon.zhaosl@gmail.com; alistair.francis@wdc.com;
> Zhanghailiang <zhang.zhanghailiang@huawei.com>; Salil Mehta
> <salil.mehta@huawei.com>
> Subject: [RFC PATCH v3 02/13] hw/arm/virt: Remove unused variable
>=20
> From: Andrew Jones <drjones@redhat.com>
>=20
> We no longer use the smp_cpus virtual machine state variable.
> Remove it.
>=20
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  hw/arm/virt.c         | 2 --
>  include/hw/arm/virt.h | 1 -
>  2 files changed, 3 deletions(-)
>=20
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 0069fa1298..ea24b576c6 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1820,8 +1820,6 @@ static void machvirt_init(MachineState *machine)
>          exit(1);
>      }
>=20
> -    vms->smp_cpus =3D smp_cpus;
> -
>      if (vms->virt && kvm_enabled()) {
>          error_report("mach-virt: KVM does not support providing "
>                       "Virtualization extensions to the guest CPU");
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 953d94acc0..010f24f580 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -151,7 +151,6 @@ struct VirtMachineState {
>      MemMapEntry *memmap;
>      char *pciehb_nodename;
>      const int *irqmap;
> -    int smp_cpus;
>      void *fdt;
>      int fdt_size;
>      uint32_t clock_phandle;
> --
> 2.23.0


