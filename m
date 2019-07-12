Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A47C742A8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 06:10:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DD4C21530
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 06:10:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DD4C21530
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlokz-00035f-3H
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 02:10:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44238)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hloko-0002g6-AL
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 02:09:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hlokn-0006ao-90
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 02:09:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58014)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hlokn-0006ZU-1P
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 02:09:57 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A08625AFE9
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 06:09:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-111.ams2.redhat.com
 [10.36.116.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 113165D9C5;
 Fri, 12 Jul 2019 06:09:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7482F1138648; Fri, 12 Jul 2019 08:09:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
References: <1562865736-3546-1-git-send-email-pbonzini@redhat.com>
 <1562865736-3546-2-git-send-email-pbonzini@redhat.com>
Date: Fri, 12 Jul 2019 08:09:51 +0200
In-Reply-To: <1562865736-3546-2-git-send-email-pbonzini@redhat.com> (Paolo
 Bonzini's message of "Thu, 11 Jul 2019 19:22:15 +0200")
Message-ID: <87o91zhjgw.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Fri, 12 Jul 2019 06:09:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/2] Makefile: do not repeat
 $(CONFIG_SOFTMMU) in hw/Makefile.objs
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
Cc: philmd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> The device directories must be included only for softmmu builds.
> Instead of repeating $(CONFIG_SOFTMMU), use an "ifeq".
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/Makefile.objs | 61 +++++++++++++++++++++++++++++---------------------------
>  1 file changed, 32 insertions(+), 29 deletions(-)
>
> diff --git a/hw/Makefile.objs b/hw/Makefile.objs
> index d770926..ece6cc3 100644
> --- a/hw/Makefile.objs
> +++ b/hw/Makefile.objs
> @@ -1,42 +1,45 @@
> +devices-dirs-y = core/
> +ifeq ($(CONFIG_SOFTMMU), y)
>  devices-dirs-$(call lor,$(CONFIG_VIRTIO_9P),$(call land,$(CONFIG_VIRTFS),$(CONFIG_XEN))) += 9pfs/
> -devices-dirs-$(CONFIG_SOFTMMU) += acpi/
> -devices-dirs-$(CONFIG_SOFTMMU) += adc/
> -devices-dirs-$(CONFIG_SOFTMMU) += audio/
> -devices-dirs-$(CONFIG_SOFTMMU) += block/
> -devices-dirs-$(CONFIG_SOFTMMU) += bt/
> -devices-dirs-$(CONFIG_SOFTMMU) += char/
> -devices-dirs-$(CONFIG_SOFTMMU) += cpu/
> -devices-dirs-$(CONFIG_SOFTMMU) += display/
> -devices-dirs-$(CONFIG_SOFTMMU) += dma/
> -devices-dirs-$(CONFIG_SOFTMMU) += gpio/
> +devices-dirs-y += acpi/
> +devices-dirs-y += adc/
> +devices-dirs-y += audio/
> +devices-dirs-y += block/
> +devices-dirs-y += bt/
> +devices-dirs-y += char/
> +devices-dirs-y += cpu/
> +devices-dirs-y += display/
> +devices-dirs-y += dma/
> +devices-dirs-y += gpio/
>  devices-dirs-$(CONFIG_HYPERV) += hyperv/
>  devices-dirs-$(CONFIG_I2C) += i2c/
> -devices-dirs-$(CONFIG_SOFTMMU) += ide/
> -devices-dirs-$(CONFIG_SOFTMMU) += input/
> -devices-dirs-$(CONFIG_SOFTMMU) += intc/
> +devices-dirs-y += ide/
> +devices-dirs-y += input/
> +devices-dirs-y += intc/
>  devices-dirs-$(CONFIG_IPACK) += ipack/
>  devices-dirs-$(CONFIG_IPMI) += ipmi/
> -devices-dirs-$(CONFIG_SOFTMMU) += isa/
> -devices-dirs-$(CONFIG_SOFTMMU) += misc/
> -devices-dirs-$(CONFIG_SOFTMMU) += net/
> -devices-dirs-$(CONFIG_SOFTMMU) += rdma/
> -devices-dirs-$(CONFIG_SOFTMMU) += nvram/
> -devices-dirs-$(CONFIG_SOFTMMU) += pci/
> +devices-dirs-y += isa/
> +devices-dirs-y += misc/
> +devices-dirs-y += net/
> +devices-dirs-y += rdma/
> +devices-dirs-y += nvram/
> +devices-dirs-y += pci/
>  devices-dirs-$(CONFIG_PCI) += pci-bridge/ pci-host/
> -devices-dirs-$(CONFIG_SOFTMMU) += pcmcia/
> +devices-dirs-y += pcmcia/
>  devices-dirs-$(CONFIG_SCSI) += scsi/
> -devices-dirs-$(CONFIG_SOFTMMU) += sd/
> -devices-dirs-$(CONFIG_SOFTMMU) += ssi/
> -devices-dirs-$(CONFIG_SOFTMMU) += timer/
> +devices-dirs-y += sd/
> +devices-dirs-y += ssi/
> +devices-dirs-y += timer/
>  devices-dirs-$(CONFIG_TPM) += tpm/
> -devices-dirs-$(CONFIG_SOFTMMU) += usb/
> +devices-dirs-y += usb/
>  devices-dirs-$(CONFIG_VFIO) += vfio/
> -devices-dirs-$(CONFIG_SOFTMMU) += virtio/
> -devices-dirs-$(CONFIG_SOFTMMU) += watchdog/
> -devices-dirs-$(CONFIG_SOFTMMU) += xen/
> +devices-dirs-y += virtio/
> +devices-dirs-y += watchdog/
> +devices-dirs-y += xen/
>  devices-dirs-$(CONFIG_MEM_DEVICE) += mem/
> -devices-dirs-$(CONFIG_SOFTMMU) += smbios/
>  devices-dirs-y += semihosting/

This one is now conditional on CONFIG_SOFTMMU.  Intentional?

> -devices-dirs-y += core/
> +devices-dirs-y += smbios/
> +endif
> +
>  common-obj-y += $(devices-dirs-y)
>  obj-y += $(devices-dirs-y)

