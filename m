Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3016C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:55:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25D6823977
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SexcOXNs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25D6823977
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLOu5-0000tI-Tt
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 06:55:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kLOtC-0000PP-1n
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 06:54:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25703)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kLOtA-0000ue-J3
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 06:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600944851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lCpgYMXYW59cQ/LkQ2BNrEud9pHUZ9PVwMwu6RDI2hk=;
 b=SexcOXNsLTk1T9BHdWbAtFMc1KuFmZagy6VDMkDGNZpZdnbzbLehsvNgHmAXmeF+zuS16N
 JEve+jZe8kSLR8fX+qxGfuIUrRg11LkP8oQCqUr45ih2y28IP6+iZF5ae9lKh8p3H3rz1T
 +jUk0jX2z2hi2G2Xc86WWJLJkhdT/E4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-KzVMydDrMU6lpRTMkOOY9A-1; Thu, 24 Sep 2020 06:54:10 -0400
X-MC-Unique: KzVMydDrMU6lpRTMkOOY9A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28AD7425E6;
 Thu, 24 Sep 2020 10:54:09 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5F6295D993;
 Thu, 24 Sep 2020 10:54:00 +0000 (UTC)
Date: Thu, 24 Sep 2020 12:53:58 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Julia Suvorova <jusual@redhat.com>
Subject: Re: [RFC PATCH v3 1/7] hw/acpi/pcihp: Enhance
 acpi_pcihp_disable_root_bus() to support Q35
Message-ID: <20200924125358.04daff5c@redhat.com>
In-Reply-To: <20200924070013.165026-2-jusual@redhat.com>
References: <20200924070013.165026-1-jusual@redhat.com>
 <20200924070013.165026-2-jusual@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Ani Sinha <ani@anisinha.ca>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 24 Sep 2020 09:00:07 +0200
Julia Suvorova <jusual@redhat.com> wrote:

> PCI Express does not allow hot-plug on pcie.0. Check for Q35 in
> acpi_pcihp_disable_root_bus() to be able to forbid hot-plug using the
> 'acpi-root-pci-hotplug' flag.
> 
> Signed-off-by: Julia Suvorova <jusual@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/pcihp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> index 39b1f74442..ff23104aea 100644
> --- a/hw/acpi/pcihp.c
> +++ b/hw/acpi/pcihp.c
> @@ -107,13 +107,14 @@ static void acpi_set_pci_info(void)
>  static void acpi_pcihp_disable_root_bus(void)
>  {
>      static bool root_hp_disabled;
> +    Object *host = acpi_get_i386_pci_host();
>      PCIBus *bus;
>  
>      if (root_hp_disabled) {
>          return;
>      }
>  
> -    bus = find_i440fx();
> +    bus = PCI_HOST_BRIDGE(host)->bus;
>      if (bus) {
>          /* setting the hotplug handler to NULL makes the bus non-hotpluggable */
>          qbus_set_hotplug_handler(BUS(bus), NULL);


