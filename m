Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B41C2D0D1
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 10:11:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F3EA2072C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 10:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QgbV+C64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F3EA2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioPLr-0004i5-61
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 05:11:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34289)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1ioPLD-0004Ca-Hs
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 05:10:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1ioPLB-0003EX-S2
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 05:10:30 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29861
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ioPLB-0003Df-NY
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 05:10:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578305428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d/RgZQmWxgsyWyFU5QbiVh27b9eIJBdjXyfyGybOuzQ=;
 b=QgbV+C64/oPOAZOJcMUPOvYjxJKZLkpS/mEmtJyNOR+NRu/eQZX65qHovXEq0nVDeHnpRu
 6ZtktSo9FOSzMH3b6WhgmJGsOmWBCeGzd/3Rsxk3R4J/Lm+qdHllAjgHumWk94g0RZqnWD
 tzjOcjr9+ofWlDQgPsghxafS+tXf7aI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-WGz1YudJP7OgoSFVyNvMHw-1; Mon, 06 Jan 2020 05:10:26 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FA88107ACCA
 for <qemu-devel@nongnu.org>; Mon,  6 Jan 2020 10:10:26 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CD92A101F942;
 Mon,  6 Jan 2020 10:10:22 +0000 (UTC)
Date: Mon, 6 Jan 2020 11:10:20 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org, mst@redhat.com
Subject: Re: [PATCH for-5.0 v2 0/9] q35: CPU hotplug with secure boot, part 1+2
Message-ID: <20200106111020.68e746da@redhat.com>
In-Reply-To: <1575896942-331151-1-git-send-email-imammedo@redhat.com>
References: <1575896942-331151-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: WGz1YudJP7OgoSFVyNvMHw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon,  9 Dec 2019 14:08:53 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

> ChangeLog:
>   * since v1:
>       - include "hw: add compat machines for 5.0" to provide
>         compat context for 4.2 machine types
>       - add comment that SMRAM at SMBASE is QEMU hack
>         and why it was used
>       - split command data 2 into a separate patch
>           "acpi: cpuhp: introduce 'Command data 2' field"
>       - rewrite enabling/detecting modern CPU hotplug interface
>         to use existing CPHP_GET_NEXT_CPU_WITH_EVENT_CMD and
>         squash it into "acpi: cpuhp: spec: add typical usecases" patch
>       - "acpi: cpuhp: add CPHP_GET_CPU_ID_CMD command"
>         modulo 'Command data 2' being moved out into separate patch,
>         rewrite commit message to explain better why new command is needed.
>   
> 
> Series consists of 2 parts: 1st is lockable SMRAM at SMBASE
> and the 2nd better documents interface and adds means to
> enumerate APIC IDs for possible CPUs.
> 
> 1st part [1-2/9]:
>  In order to support CPU hotplug in secure boot mode,
>  UEFI firmware needs to relocate SMI handler of hotplugged CPU,
>  in a way that won't allow ring 0 user to break in priveleged
>  SMM mode that firmware maintains during runtime.
>  Used approach allows to hide RAM at default SMBASE to make it
>  accessible only to SMM mode, which lets us to make sure that
>  SMI handler installed by firmware can not be hijacked by
>  unpriveleged user (similar to TSEG behavior). 
> 
> 2nd part:
>  mostly fixes and extra documentation on how to detect and use
>  modern CPU hotplug interface (MMIO block).
>  So firmware could reuse it for enumerating possible CPUs and
>  detecting hotplugged CPU(s). It also adds support for
>  CPHP_GET_CPU_ID_CMD command [7/8], which should allow firmware
>  to fetch APIC IDs for possible CPUs which is necessary for
>  initializing internal structures for possible CPUs on boot.

ping,

Michael,
could you merge series via your tree?

(PS: series still applies fine to today's master)

> 
> CC: mst@redhat.com
> CC: pbonzini@redhat.com
> CC: lersek@redhat.com
> CC: philmd@redhat.com
> 
> 
> Cornelia Huck (1):
>   hw: add compat machines for 5.0
> 
> Igor Mammedov (8):
>   q35: implement 128K SMRAM at default SMBASE address
>   tests: q35: MCH: add default SMBASE SMRAM lock test
>   acpi: cpuhp: spec: clarify 'CPU selector' register usage and
>     endianness
>   acpi: cpuhp: spec: fix 'Command data' description
>   acpi: cpuhp: spec: clarify store into 'Command data' when 'Command
>     field' == 0
>   acpi: cpuhp: introduce 'Command data 2' field
>   acpi: cpuhp: spec: add typical usecases
>   acpi: cpuhp: add CPHP_GET_CPU_ID_CMD command
> 
>  include/hw/boards.h             |   3 ++
>  include/hw/i386/pc.h            |   3 ++
>  include/hw/pci-host/q35.h       |  10 ++++
>  docs/specs/acpi_cpu_hotplug.txt |  89 +++++++++++++++++++++++++++-------
>  hw/acpi/cpu.c                   |  18 +++++++
>  hw/acpi/trace-events            |   1 +
>  hw/arm/virt.c                   |   7 ++-
>  hw/core/machine.c               |   3 ++
>  hw/i386/pc.c                    |   5 ++
>  hw/i386/pc_piix.c               |  14 +++++-
>  hw/i386/pc_q35.c                |  13 ++++-
>  hw/pci-host/q35.c               |  84 +++++++++++++++++++++++++++++---
>  hw/ppc/spapr.c                  |  15 +++++-
>  hw/s390x/s390-virtio-ccw.c      |  14 +++++-
>  tests/q35-test.c                | 105 ++++++++++++++++++++++++++++++++++++++++
>  15 files changed, 354 insertions(+), 30 deletions(-)
> 


