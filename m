Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E61C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 10:07:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93E75206D5
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 10:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCQJdrRI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93E75206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdA0f-0000Oy-RE
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 06:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1jd9zt-0007ys-5y
 for qemu-devel@nongnu.org; Mon, 25 May 2020 06:06:17 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34465)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1jd9zr-0003jn-I4
 for qemu-devel@nongnu.org; Mon, 25 May 2020 06:06:16 -0400
Received: by mail-wr1-x441.google.com with SMTP id g12so15355893wrw.1
 for <qemu-devel@nongnu.org>; Mon, 25 May 2020 03:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4ECex7a3pREVmz3n9zj3FhwlmFlQyQqb4gXMJEdhA8A=;
 b=UCQJdrRITS2rqXQEcZdbVZAF6fzaJ1Bt/JOq61cg4wznoRKSCgCcGX1iTAUScAy5x7
 K4DmAAZyenE5u1H/emmKP1spWptq51Xhlwbgg22MYD8rhINf3lz/E7KlzLQQf5VAFcNQ
 K6b3CSiyZfAklaZWGFA+nBnoRoih8QdJubTcgozLIRTq1TP69Z/7hBd3JnrnvELzcECl
 M8OBVozaLxnk+EB9bU7c+s3kGeNnOyGyEUQOA5UKZDXxYX3X3Bt5ptm9A+vOXiH7PcuC
 ohUW00+/xMD7coUh88c6ejIyUSHfYuaTrfi7dPjCWhQIMO+ZAIXv0UmDwOOtSAVUf5n/
 4VWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4ECex7a3pREVmz3n9zj3FhwlmFlQyQqb4gXMJEdhA8A=;
 b=gU3wffRyC6lbeWD2zLaZ1grZDrH9BqRhX58exQf+tmhYqbU4HKnNagVBi1w94DvdvM
 90nxK/r1XvtQ9LFgrZ9wLAQNj5Q336gCn7f2kr8AFf6KR4G2QqBguUaRdBmX7/Ofn5zy
 ZwJSgq73k2veyojCpm+gMRXZzpsy7XuZ+k5geS1oQzExL5KtG2C99FESPlXpnz+NImsF
 sxdISA1U774GdfgD0XgkZrPsqIkZ8k1BwDd6fHlnLhk0hzgjheLV9LS9qa7cbj5BSJzR
 rNgCUPxcLJVfWDYTL8YwIoxmaDGhN6M1rWiIUNcUz91H3qDl9q1wohGmVUCeH0AK6ksq
 7jOw==
X-Gm-Message-State: AOAM530+w4Rf3KyLWHyw5fes3cE4Ch4wUCyesWtebwa0VaciEXdHaa5u
 adeI+Cy5nKPti4ohIfUqV2kNNqwcCNqSrpCTSZU=
X-Google-Smtp-Source: ABdhPJz3YWnHfcHlkKR3DU4QcEivTUYPBgamETPPjZPWo4CM7UKfoM6FmQESQdAWeK54KNrNJdA4+VswGHsQufPMZjg=
X-Received: by 2002:adf:9166:: with SMTP id j93mr13698503wrj.289.1590401173318; 
 Mon, 25 May 2020 03:06:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200525084511.51379-1-david@redhat.com>
In-Reply-To: <20200525084511.51379-1-david@redhat.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Mon, 25 May 2020 12:06:02 +0200
Message-ID: <CAM9Jb+jvpe1dT7egt1zKjCBg5yuM5nH0nQUV2wBaPRGqsWjDkQ@mail.gmail.com>
Subject: Re: [PATCH v1] pc: Support coldplugging of virtio-pmem-pci devices on
 all buses
To: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=pankaj.gupta.linux@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> E.g., with "pc-q35-4.2", trying to coldplug a virtio-pmem-pci devices
> results in
>     "virtio-pmem-pci not supported on this bus"
>
> Reasons is, that the bus does not support hotplug and, therefore, does
> not have a hotplug handler. Let's allow coldplugging virtio-pmem devices
> on such buses. The hotplug order is only relevant for virtio-pmem-pci
> when the guest is already alive and the device is visible before
> memory_device_plug() wired up the memory device bits.
>
> Hotplug attempts will still fail with:
>     "Error: Bus 'pcie.0' does not support hotplugging"
>
> Hotunplug attempts will still fail with:
>     "Error: Bus 'pcie.0' does not support hotplugging"
>
> Reported-by: Vivek Goyal <vgoyal@redhat.com>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/i386/pc.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 2128f3d6fe..c740495eb6 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1663,13 +1663,13 @@ static void pc_virtio_pmem_pci_pre_plug(HotplugHandler *hotplug_dev,
>      HotplugHandler *hotplug_dev2 = qdev_get_bus_hotplug_handler(dev);
>      Error *local_err = NULL;
>
> -    if (!hotplug_dev2) {
> +    if (!hotplug_dev2 && dev->hotplugged) {
>          /*
>           * Without a bus hotplug handler, we cannot control the plug/unplug
> -         * order. This should never be the case on x86, however better add
> -         * a safety net.
> +         * order. We should never reach this point when hotplugging on x86,
> +         * however, better add a safety net.
>           */
> -        error_setg(errp, "virtio-pmem-pci not supported on this bus.");
> +        error_setg(errp, "virtio-pmem-pci hotplug not supported on this bus.");
>          return;
>      }
>      /*
> @@ -1678,7 +1678,7 @@ static void pc_virtio_pmem_pci_pre_plug(HotplugHandler *hotplug_dev,
>       */
>      memory_device_pre_plug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev), NULL,
>                             &local_err);
> -    if (!local_err) {
> +    if (!local_err && hotplug_dev2) {
>          hotplug_handler_pre_plug(hotplug_dev2, dev, &local_err);
>      }
>      error_propagate(errp, local_err);
> @@ -1696,9 +1696,11 @@ static void pc_virtio_pmem_pci_plug(HotplugHandler *hotplug_dev,
>       * device bits.
>       */
>      memory_device_plug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev));
> -    hotplug_handler_plug(hotplug_dev2, dev, &local_err);
> -    if (local_err) {
> -        memory_device_unplug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev));
> +    if (hotplug_dev2) {
> +        hotplug_handler_plug(hotplug_dev2, dev, &local_err);
> +        if (local_err) {
> +            memory_device_unplug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev));
> +        }
>      }
>      error_propagate(errp, local_err);
>  }
This looks good to me & will allow to cold-plug the virtio-pmem device
on bus if they don't support hot-plug.

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>

