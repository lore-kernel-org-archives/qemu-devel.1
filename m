Received: from eggs.gnu.org ([2001:4830:134:3::10]:39825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e1YI5-0007f6-0n
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 09:40:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e1YI1-0006g2-In
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 09:40:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e1YI1-0006fX-Cc
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 09:40:13 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 55DC98765E
	for <qemu-devel@nongnu.org>; Mon,  9 Oct 2017 13:40:12 +0000 (UTC)
References: <20171006215244.27104-1-ehabkost@redhat.com>
	<20171006215244.27104-2-ehabkost@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f4bd17b9-42ca-0e2a-1a84-57b17510bb30@redhat.com>
Date: Mon, 9 Oct 2017 15:40:02 +0200
MIME-Version: 1.0
In-Reply-To: <20171006215244.27104-2-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/7] qemu-doc: Document minimum kernel
 version for KVM in x86_64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On 06/10/2017 23:52, Eduardo Habkost wrote:
> The default set of KVM CPU features require the host kernel to
> support them.  KVM_PV_EOI is the newest one, and was included on
> Linux v3.6 (Linux commit ae7a2a3f).
> 
> Running on an old host might break management software
> expectations because the latest machine-type won't be runnable
> while older machine-types might be runnable.  Document v3.6 as
> the minimum kernel version for KVM on x86_64.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  qemu-doc.texi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index ecd186a159..be45b6b6f6 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -37,6 +37,7 @@
>  * QEMU System emulator for non PC targets::
>  * QEMU Guest Agent::
>  * QEMU User space emulator::
> +* System requirements::
>  * Implementation notes::
>  * Deprecated features::
>  * License::
> @@ -2348,6 +2349,14 @@ Act as if the host page size was 'pagesize' bytes
>  Run the emulation in single step mode.
>  @end table
>  
> +@node System requirements
> +@chapter System requirements
> +
> +@section KVM kernel module
> +
> +On x86_64 hosts, the default set of CPU features enabled by the KVM accelerator
> +require the host to be running Linux v3.6 or newer.
> +
>  
>  @include qemu-tech.texi
>  
> 

Maybe we should expand on the consequences of running on older versions?

Paolo
