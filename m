Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33339C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 21:41:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E96AD2173E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 21:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zo1TzElz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E96AD2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idLMJ-0001Be-UX
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 16:41:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51244)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1idLJ4-0006ZR-NG
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 16:38:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1idLJ2-0004u2-9H
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 16:38:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24435
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1idLIw-0004oL-I7
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 16:38:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575668303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JME4s5DMIdIuluftYBRBfK2aF2qYIeP7sChgOKD74vQ=;
 b=Zo1TzElzS3QVzwYYlWA5QuvywWgwD8A9adi0v1fFtJ9XlXpYUfHwHp7NihAQcsS2HHvY9S
 0h6f3RI8YsIvki4zUdCGVvY6duLlZro9RXlpbZV8KuEsMbjDJOx34qpRmVZNmrIaTOWMKx
 jy8Ih9OYv9Rsyh0RPa99N/WH/nWMH6k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-OxFYk0IQP6uujediADCz-g-1; Fri, 06 Dec 2019 16:38:21 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24AD4183B71C
 for <qemu-devel@nongnu.org>; Fri,  6 Dec 2019 21:38:20 +0000 (UTC)
Received: from x1.home (ovpn-116-56.phx2.redhat.com [10.3.116.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2752819C7F;
 Fri,  6 Dec 2019 21:38:10 +0000 (UTC)
Date: Fri, 6 Dec 2019 14:38:10 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.0 v2 6/6] hw/pci-host: Add Kconfig entry to select
 the IGD Passthrough Host Bridge
Message-ID: <20191206143810.3500e0a9@x1.home>
In-Reply-To: <20191206172514.21268-7-philmd@redhat.com>
References: <20191206172514.21268-1-philmd@redhat.com>
 <20191206172514.21268-7-philmd@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: OxFYk0IQP6uujediADCz-g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, "Michael S.
 Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri,  6 Dec 2019 18:25:14 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> Add the INTEL_IGD_PASSTHROUGH Kconfig option.
>=20
> Since it is implied by the PCI_I440FX option, this does not change
> the default selection. However users are now able to deselelect it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/pci-host/Kconfig       | 4 ++++
>  hw/pci-host/Makefile.objs | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
> index b0aa8351c4..8c88a7b9dd 100644
> --- a/hw/pci-host/Kconfig
> +++ b/hw/pci-host/Kconfig
> @@ -1,6 +1,9 @@
>  config PAM
>      bool
> =20
> +config INTEL_IGD_PASSTHROUGH
> +    bool

I'd be tempted to suggest a 'depends on XEN' here and maybe use XEN in
the config name and perhaps the file name in patch 5/6 as well.
There's already confusion as to the extent that this is used
generically between both Xen and vfio assignment (it's not), so might as
well take this opportunity.  Thanks,

Alex

> +
>  config PREP_PCI
>      bool
>      select PCI
> @@ -32,6 +35,7 @@ config PCI_I440FX
>      bool
>      select PCI
>      select PAM
> +    imply INTEL_IGD_PASSTHROUGH
> =20
>  config PCI_EXPRESS_Q35
>      bool
> diff --git a/hw/pci-host/Makefile.objs b/hw/pci-host/Makefile.objs
> index 5affd21899..9dbd0f9042 100644
> --- a/hw/pci-host/Makefile.objs
> +++ b/hw/pci-host/Makefile.objs
> @@ -14,7 +14,7 @@ common-obj-$(CONFIG_VERSATILE_PCI) +=3D versatile.o
>  common-obj-$(CONFIG_PCI_SABRE) +=3D sabre.o
>  common-obj-$(CONFIG_FULONG) +=3D bonito.o
>  common-obj-$(CONFIG_PCI_I440FX) +=3D i440fx.o
> -common-obj-$(CONFIG_PCI_I440FX) +=3D igd_pt.o
> +common-obj-$(CONFIG_INTEL_IGD_PASSTHROUGH) +=3D igd_pt.o
>  common-obj-$(CONFIG_PCI_EXPRESS_Q35) +=3D q35.o
>  common-obj-$(CONFIG_PCI_EXPRESS_GENERIC_BRIDGE) +=3D gpex.o
>  common-obj-$(CONFIG_PCI_EXPRESS_XILINX) +=3D xilinx-pcie.o


