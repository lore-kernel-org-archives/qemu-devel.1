Received: from eggs.gnu.org ([2001:4830:134:3::10]:51675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fNyNE-0007H6-Ig
	for qemu-devel@nongnu.org; Wed, 30 May 2018 06:30:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fNyN9-0008PZ-NI
	for qemu-devel@nongnu.org; Wed, 30 May 2018 06:30:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37294 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fNyN9-0008PP-IO
	for qemu-devel@nongnu.org; Wed, 30 May 2018 06:30:27 -0400
References: <20180430062536.49077-1-aik@ozlabs.ru>
	<20180430062536.49077-2-aik@ozlabs.ru>
	<00093926-1d43-0213-34ba-68f72e4057ac@redhat.com>
	<d15375ef-2a6a-9a72-d0ef-0394c8e6832c@ozlabs.ru>
	<c3558bb9-3e13-3fcf-61f2-2925ce16c14e@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7f91c216-447d-4a24-2d75-d94acd19ba95@redhat.com>
Date: Wed, 30 May 2018 12:30:24 +0200
MIME-Version: 1.0
In-Reply-To: <c3558bb9-3e13-3fcf-61f2-2925ce16c14e@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v2 1/2] memory/hmp: Print
 owners/parents in "info mtree"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On 30/05/2018 06:57, Alexey Kardashevskiy wrote:
> hw/intc/apic_common.c|489| object_property_add(obj, "id", "uint32",
> hw/ppc/spapr_drc.c|557| object_property_add_uint32_ptr(obj, "id", &drc->id,
> NULL);
> 
> This does not look like "remove the "id" property altogether" :) Does this
> mean we still rather want to print QOM's "id"? spapr_drc does not own MRs
> and APIC seems not to either.

No, those properties are specific to some devices (and in fact they are
integers rather than strings).  The id property that mirrors the path
component is gone.

Paolo
