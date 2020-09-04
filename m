Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41A0C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:56:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CEC42074D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:56:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CEC42074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEE4o-0005Cp-Nd
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 11:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsuvorov@redhat.com>)
 id 1kEDxL-0008Vi-4F
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 11:48:51 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37143
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsuvorov@redhat.com>)
 id 1kEDxI-0008FG-Jq
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 11:48:50 -0400
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-kcYLyhCyPeC9_AvD2eQr1g-1; Fri, 04 Sep 2020 11:48:46 -0400
X-MC-Unique: kcYLyhCyPeC9_AvD2eQr1g-1
Received: by mail-yb1-f199.google.com with SMTP id b127so6519036ybh.21
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 08:48:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5S5h+CEUALHPXVW1OEpQyPdAdtqJpgsXAt28NEzalJ4=;
 b=HCZG77tp4brwZXT/1XSqQRihDuKQg3/wIaFqD/wMX3Q15OYk62eOlz2bLmSiFUXLFd
 7YSduVokirltEJWe+hisQejXmIGcm/ly9+2VTTndMDdgRQNXWHwI7N1iuNsaIYvDBwi8
 KTCPn6RyyBqeppeY6/xV3nXjrWx3Nb8AW55QaX9NpGgpgbRHEtldFV8SAdXdFOwXGE6F
 Q4agjLk7yRsqgMbA+V70zJxt9B2BJjcl52U72n08DZKc/oUdbUjqlq43JtMYd6OoRjJU
 /uvDEh8HQpT0zph6HTXUy+uNklXdme/Mm4q/6cGG6usHuw4UlbPeN1hJxD4hBVrvvHWl
 ileA==
X-Gm-Message-State: AOAM533facjMp5VyeCZkrg5xCLngEjcHUutUu/BYZefiPg3xfO4tvzsi
 5znGjoiPbieJRbPEP6C2fFpoHWMv/1YPU9mO2dHkPETdVPOZ3NRixhvJuj7ze/kizGj1+hAxu5g
 F6AFtw7lu0Srt0no3YQXZNHyuxLFhYVo=
X-Received: by 2002:a5b:b05:: with SMTP id z5mr11025124ybp.321.1599234526121; 
 Fri, 04 Sep 2020 08:48:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBymKp+xJPUXt2zoC9mwCJSDvMnIcPmD6CeRkP40EKmz8+0cotgM320u/Tyr9+qbqdsA6YhkWa9fIgakIyDaU=
X-Received: by 2002:a5b:b05:: with SMTP id z5mr11025099ybp.321.1599234525903; 
 Fri, 04 Sep 2020 08:48:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200904082451.1043-1-ani@anisinha.ca>
 <20200904082451.1043-2-ani@anisinha.ca>
In-Reply-To: <20200904082451.1043-2-ani@anisinha.ca>
From: Julia Suvorova <jusual@redhat.com>
Date: Fri, 4 Sep 2020 17:48:34 +0200
Message-ID: <CAMDeoFUVoJ9hN7DaMBZ2RyS5jLNJACB-Uq6C6XXih8-9RDCj_g@mail.gmail.com>
Subject: Re: [PATCH v1] i440fx/acpi: don't hot-unplug cold plugged bridges
 when their hotplug switch is off
To: Ani Sinha <ani@anisinha.ca>
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jsuvorov@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 03:57:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 4, 2020 at 10:25 AM Ani Sinha <ani@anisinha.ca> wrote:
>
> Cold plugged bridges should not be hot unpluggable, even when their hotplug property
> (acpi-pci-hotplug-with-bridge-support) is turned off.

Unplugging a cold-plugged bridge is impossible already, see
acpi_pcihp_pc_no_hotplug().

Best regards, Julia Suvorova.

> However, with the current
> implementaton, windows would try to hot-unplug a pci bridge when it's hotplug switch
> is off. This is regardless of whether there are devices attached to the bridge. When
> devices are attached to the bridge, the bridge is ultimately not hot-unpluggable. We
> have a demo video here: https://youtu.be/pME2sjyQweo
>
> In this fix, we identify a cold plugged bridge and for cold plugged bridges, we do not
> add the appropriate amls and acpi methods that are used by the OS to identify a hot-
> unpluggable pci device. After this change, Windows does not show an option to eject the
> PCI bridge. A demo video is here:  https://youtu.be/kbgej5B9Hgs
>
> While at it, I have also updated a stale comment.
>
> This change is tested with a Windows 2012R2 guest image running on Ubuntu host. This
> change is based off of upstream qemu master branch tag v5.1.0.
>
> Signed-off-by: Ani Sinha <ani@anisinha.ca>
> ---
>  hw/i386/acpi-build.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index b7bcbbbb2a..90b863f4ec 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -359,6 +359,7 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
>          int slot = PCI_SLOT(i);
>          bool hotplug_enabled_dev;
>          bool bridge_in_acpi;
> +        bool cold_plugged_bridge;
>
>          if (!pdev) {
>              if (bsel) { /* add hotplug slots for non present devices */
> @@ -380,15 +381,14 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
>          pc = PCI_DEVICE_GET_CLASS(pdev);
>          dc = DEVICE_GET_CLASS(pdev);
>
> -        /* When hotplug for bridges is enabled, bridges are
> -         * described in ACPI separately (see build_pci_bus_end).
> -         * In this case they aren't themselves hot-pluggable.
> +        /*
> +         * Cold plugged bridges aren't themselves hot-pluggable.
>           * Hotplugged bridges *are* hot-pluggable.
>           */
> -        bridge_in_acpi = pc->is_bridge && pcihp_bridge_en &&
> -            !DEVICE(pdev)->hotplugged;
> +        cold_plugged_bridge = pc->is_bridge && !DEVICE(pdev)->hotplugged;
> +        bridge_in_acpi =  cold_plugged_bridge && pcihp_bridge_en;
>
> -        hotplug_enabled_dev = bsel && dc->hotpluggable && !bridge_in_acpi;
> +        hotplug_enabled_dev = bsel && dc->hotpluggable && !cold_plugged_bridge;
>
>          if (pc->class_id == PCI_CLASS_BRIDGE_ISA) {
>              continue;
> --
> 2.17.1
>


