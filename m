Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529E9C76195
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 12:15:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 282702173B
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 12:15:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 282702173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoRn3-0007JW-Du
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 08:15:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47553)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1hoRmp-0006pZ-Pg
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 08:14:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1hoRmo-0006IC-U2
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 08:14:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60882)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hoRmo-0006Ha-OY
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 08:14:54 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D246C30A7C52;
 Fri, 19 Jul 2019 12:14:52 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C5A651A8EA;
 Fri, 19 Jul 2019 12:14:49 +0000 (UTC)
Date: Fri, 19 Jul 2019 14:14:48 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Evgeny Yakovlev <wrfsh@yandex-team.ru>
Message-ID: <20190719141448.3e1f334c@redhat.com>
In-Reply-To: <1563526469-15588-1-git-send-email-wrfsh@yandex-team.ru>
References: <1563526469-15588-1-git-send-email-wrfsh@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Fri, 19 Jul 2019 12:14:53 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] i386/acpi: show PCI Express bus on
 pxb-pcie expanders
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
Cc: qemu-devel@nongnu.org, yc-core@yandex-team.ru, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 19 Jul 2019 11:54:29 +0300
Evgeny Yakovlev <wrfsh@yandex-team.ru> wrote:

> Show PCIe host bridge PNP id with PCI host bridge as a compatible id
> when expanding a pcie bus.
> 
> Signed-off-by: Evgeny Yakovlev <wrfsh@yandex-team.ru>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/i386/acpi-build.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index d281ffa..0675952 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1908,10 +1908,13 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>              scope = aml_scope("\\_SB");
>              dev = aml_device("PC%.02X", bus_num);
>              aml_append(dev, aml_name_decl("_UID", aml_int(bus_num)));
> -            aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A03")));
>              aml_append(dev, aml_name_decl("_BBN", aml_int(bus_num)));
>              if (pci_bus_is_express(bus)) {
> +                aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
> +                aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
>                  aml_append(dev, build_q35_osc_method());
> +            } else {
> +                aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A03")));
>              }
>  
>              if (numa_node != NUMA_NODE_UNASSIGNED) {


