Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE5AC47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 08:08:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FD372190F
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 08:08:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FD372190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIpy0-0007T8-An
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 04:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40019)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iIpxG-0006qF-VV
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 04:07:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iIpxF-0000Je-SR
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 04:07:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38910)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iIpxF-0000IE-MU
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 04:07:17 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 309BD8E582;
 Fri, 11 Oct 2019 08:07:14 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-177.rdu2.redhat.com
 [10.10.120.177])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8FABF60BE1;
 Fri, 11 Oct 2019 08:07:04 +0000 (UTC)
Subject: Re: [RFC 3/3] acpi: cpuhp: add CPHP_GET_CPU_ID_CMD command
To: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>
References: <20191009132252.17860-1-imammedo@redhat.com>
 <20191009132252.17860-4-imammedo@redhat.com>
 <802d0d69-d478-76f5-2bd6-5ad2f1ac4474@redhat.com>
 <20191010110533-mutt-send-email-mst@kernel.org>
 <20191010192649.GF4084@habkost.net>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <91fa8359-d3f7-a28e-f8ce-e08637dea429@redhat.com>
Date: Fri, 11 Oct 2019 10:07:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191010192649.GF4084@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Fri, 11 Oct 2019 08:07:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/10/19 21:26, Eduardo Habkost wrote:

> Topology info is already available on CPUID.

Independently of everything else, thanks for pointing this out.

The edk2 library called "LocalApicLib" has two relevant functions:

> /**
>   Get Package ID/Core ID/Thread ID of a processor.
>
>   The algorithm assumes the target system has symmetry across physical
>   package  boundaries with respect to the number of logical processors
>   per package,  number of cores per package.
>
>   @param[in]  InitialApicId  Initial APIC ID of the target logical processor.
>   @param[out]  Package       Returns the processor package ID.
>   @param[out]  Core          Returns the processor core ID.
>   @param[out]  Thread        Returns the processor thread ID.
> **/
> VOID
> EFIAPI
> GetProcessorLocationByApicId (
>   IN  UINT32  InitialApicId,
>   OUT UINT32  *Package  OPTIONAL,
>   OUT UINT32  *Core    OPTIONAL,
>   OUT UINT32  *Thread  OPTIONAL
>   );
>
> /**
>   Get Package ID/Module ID/Tile ID/Die ID/Core ID/Thread ID of a processor.
>
>   The algorithm assumes the target system has symmetry across physical
>   package boundaries with respect to the number of threads per core, number of
>   cores per module, number of modules per tile, number of tiles per die, number
>   of dies per package.
>
>   @param[in]   InitialApicId Initial APIC ID of the target logical processor.
>   @param[out]  Package       Returns the processor package ID.
>   @param[out]  Die           Returns the processor die ID.
>   @param[out]  Tile          Returns the processor tile ID.
>   @param[out]  Module        Returns the processor module ID.
>   @param[out]  Core          Returns the processor core ID.
>   @param[out]  Thread        Returns the processor thread ID.
> **/
> VOID
> EFIAPI
> GetProcessorLocation2ByApicId (
>   IN  UINT32  InitialApicId,
>   OUT UINT32  *Package  OPTIONAL,
>   OUT UINT32  *Die      OPTIONAL,
>   OUT UINT32  *Tile     OPTIONAL,
>   OUT UINT32  *Module   OPTIONAL,
>   OUT UINT32  *Core     OPTIONAL,
>   OUT UINT32  *Thread   OPTIONAL
>   );

They are implemented with heavy CPUID usage.

So... just give me the APIC-ID. That's the primary key in edk2 for identifying
x86 processors.

Thanks
Laszlo

