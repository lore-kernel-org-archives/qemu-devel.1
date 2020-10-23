Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE146C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 18:50:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19F3A20BED
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 18:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hTvM2WO5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19F3A20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW28d-0007cP-Ue
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 14:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kW21U-0008FL-Ly
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 14:42:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49445)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kW21S-0002ID-BS
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 14:42:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603478561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FKzAJ9cio/CHBVAHtGITZZUxgmtUDJZjL1YlJzT+koQ=;
 b=hTvM2WO53WfFmMdiI5/imjG4acTqSlzq/Vy9xabFlbJtYUBnT1LM6a3MF1V1HLvk/GDq0V
 oZGpOp+Ku3Wqmuh91vtUq2b4+0ZhBjnfjnUgxQZFO+0s9dVsGzdf8gxog/3hEaXUHCw7Ue
 I6XipU/xdOOvRNeZapKAcJlPtLEMS38=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-4v52SPACMFGRjWlGCLyUAA-1; Fri, 23 Oct 2020 14:42:39 -0400
X-MC-Unique: 4v52SPACMFGRjWlGCLyUAA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82F8B1087D6F;
 Fri, 23 Oct 2020 18:42:38 +0000 (UTC)
Received: from localhost (unknown [10.40.208.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 67AFB5C1CF;
 Fri, 23 Oct 2020 18:42:25 +0000 (UTC)
Date: Fri, 23 Oct 2020 20:42:24 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 0/7] microvm: fix PCIe IRQs in APIC table.
Message-ID: <20201023204224.77766447@redhat.com>
In-Reply-To: <20201016113835.17465-1-kraxel@redhat.com>
References: <20201016113835.17465-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 01:44:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 16 Oct 2020 13:38:28 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> Gerd Hoffmann (7):
>   tests/acpi: allow changes for microvm/APIC.pcie
>   tests/acpi: add empty microvm/APIC.pcie
>   x86: make pci irqs runtime configurable
>   microvm: set pci_irq_mask
>   apci: drop has_pci arg for acpi_build_madt
>   tests/acpi: update expected data files
>   tests/acpi: disallow changes for microvm/APIC.pcie
> 
>  hw/i386/acpi-common.h             |   3 +--
>  include/hw/i386/x86.h             |   2 ++
>  hw/i386/acpi-build.c              |   2 +-
>  hw/i386/acpi-common.c             |  26 +++++++++++---------------
>  hw/i386/acpi-microvm.c            |   2 +-
>  hw/i386/microvm.c                 |   6 ++++++
>  hw/i386/x86.c                     |   1 +
>  tests/data/acpi/microvm/APIC.pcie | Bin 0 -> 110 bytes
>  8 files changed, 23 insertions(+), 19 deletions(-)
>  create mode 100644 tests/data/acpi/microvm/APIC.pcie
> 

for series:

Reviewed-by: Igor Mammedov <imammedo@redhat.com>


