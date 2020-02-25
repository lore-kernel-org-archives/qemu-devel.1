Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE96C35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 18:43:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C0702084E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 18:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DzpaY9ne"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C0702084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6fB7-0001z3-64
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 13:43:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48194)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j6fAQ-0001Zu-M5
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 13:42:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j6fAP-0001VS-9h
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 13:42:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34411
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j6fAP-0001Tw-4N
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 13:42:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582656168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pDENqNXBCqquoRnfO7UMpOahY9kW55dueOlHtH2GEVI=;
 b=DzpaY9neTtP5QPHi/ltLu/3PlwshIYEGeGOBLPoeZozh0alBWGKHjW4T59KTorwNHafLBq
 Rw0TyDeeZCvwy2zhUN4ww/25b40qxk2+KQgzalLVSyCSV7D5AQgGHDS8Yoq1h/hqTa4/Pi
 NHKUPy5RRogLEE5MkfcKgzn+PT3QEbE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-kB-I4ZTuO4eVm6KHCsyUIA-1; Tue, 25 Feb 2020 13:42:46 -0500
X-MC-Unique: kB-I4ZTuO4eVm6KHCsyUIA-1
Received: by mail-wr1-f69.google.com with SMTP id n23so187941wra.20
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 10:42:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=E9jiqWrV+BroJ0AsCugLYkidKDGjbDWO7FL/A0O8ZJk=;
 b=j/BhsBVfE7+HMdoUZpB/YlJP+CQScXuYGImiJhT7n/jZ1et2a4tdsu8X8ryC8r/S26
 95EiiWroh0FKnzBulHkxUcMBSitegQCKf6rLffsggEWTYoLQwZniDY2y3TVp2Ahe5Ppc
 dTa4x+1KqYfxZzx2UHA6yHoVbO4KsHT3LVrApuoMmhlwE/SpD20WpiVXnMsOrsMd3GXL
 01N65M4oFd0nRd2lKVUSimdDekRu2GpRc+J079IF9XWwPdBY+MAALv37dAWrTHffkxEa
 dsXQ3v0YNwIKRjuVhqDON1swXeuULD37O+f8QpoCd7rrDR/te8c+nZAggM2MRFzkxoLs
 c+Cg==
X-Gm-Message-State: APjAAAXsPyiUBdHHFLR9NX0I8GLV7VN7ysH4BywAwl2TjwH02iYGWRJJ
 NzDbmM92fNryrDT1w3ob/JlJeAAGzrWucbyhjOCriRiHOZspeGgN4I7xK0cgC0uHtzC70zI1uhg
 AA555SI9VofweXpo=
X-Received: by 2002:a05:600c:2503:: with SMTP id
 d3mr565904wma.84.1582656165172; 
 Tue, 25 Feb 2020 10:42:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqw2lLli9pypAYOdCQSODHvtjOYXqt353cSYtdOWTxsjoF0GKhuVzlLsAQTIafuSF/RiJJFo1Q==
X-Received: by 2002:a05:600c:2503:: with SMTP id
 d3mr565890wma.84.1582656164939; 
 Tue, 25 Feb 2020 10:42:44 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id z21sm5071529wml.5.2020.02.25.10.42.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2020 10:42:44 -0800 (PST)
Subject: Re: [PATCH] hw/intc/arm_gic_kvm: Don't assume kernel can provide a
 GICv2
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200225182435.1131-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c0f6d435-050e-0e2f-6e81-15d50e72c19c@redhat.com>
Date: Tue, 25 Feb 2020 19:42:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200225182435.1131-1-peter.maydell@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Marc Zyngier <maz@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/25/20 7:24 PM, Peter Maydell wrote:
> In our KVM GICv2 realize function, we try to cope with old kernels
> that don't provide the device control API (KVM_CAP_DEVICE_CTRL): we
> try to use the device control, and if that fails we fall back to
> assuming that the kernel has the old style KVM_CREATE_IRQCHIP and
> that it will provide a GICv2.
>=20
> This doesn't cater for the possibility of a kernel and hardware which
> only provide a GICv3, which is very common now.  On that setup we
> will abort() later on in kvm_arm_pmu_set_irq() when we try to wire up
> an interrupt to the GIC we failed to create:
>=20
> qemu-system-aarch64: PMU: KVM_SET_DEVICE_ATTR: Invalid argument
> qemu-system-aarch64: failed to set irq for PMU
> Aborted
>=20
> If the kernel advertises KVM_CAP_DEVICE_CTRL we should trust it if it
> says it can't create a GICv2, rather than assuming it has one.  We
> can then produce a more helpful error message including a hint about
> the most probable reason for the failure.
>=20
> If the kernel doesn't advertise KVM_CAP_DEVICE_CTRL then it is truly
> ancient by this point but we might as well still fall back to a
> KVM_CREATE_IRQCHIP GICv2.
>=20
> With this patch then the user misconfiguration which previously
> caused an abort now prints:
> qemu-system-aarch64: Initialization of device kvm-arm-gic failed: error c=
reating in-kernel VGIC: No such device
> Perhaps the host CPU does not support GICv2?
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I spent a while wondering if the PMU code was broken before Marc
> put me on the right track about what was going wrong (ie that
> I hadn't put "-machine gic-version=3Dhost" on the commandline).
>=20
>   hw/intc/arm_gic_kvm.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>=20
> diff --git a/hw/intc/arm_gic_kvm.c b/hw/intc/arm_gic_kvm.c
> index 9deb15e7e69..d7df423a7a3 100644
> --- a/hw/intc/arm_gic_kvm.c
> +++ b/hw/intc/arm_gic_kvm.c
> @@ -551,7 +551,16 @@ static void kvm_arm_gic_realize(DeviceState *dev, Er=
ror **errp)
>                                 KVM_DEV_ARM_VGIC_CTRL_INIT, NULL, true,
>                                 &error_abort);
>           }
> +    } else if (kvm_check_extension(kvm_state, KVM_CAP_DEVICE_CTRL)) {
> +        error_setg_errno(errp, -ret, "error creating in-kernel VGIC");
> +        error_append_hint(errp,
> +                          "Perhaps the host CPU does not support GICv2?\=
n");
>       } else if (ret !=3D -ENODEV && ret !=3D -ENOTSUP) {
> +        /*
> +         * Very ancient kernel without KVM_CAP_DEVICE_CTRL: assume that
> +         * ENODEV or ENOTSUP mean "can't create GICv2 with KVM_CREATE_DE=
VICE",
> +         * and that we will get a GICv2 via KVM_CREATE_IRQCHIP.
> +         */
>           error_setg_errno(errp, -ret, "error creating in-kernel VGIC");
>           return;
>       }
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


