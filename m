Received: from eggs.gnu.org ([2001:4830:134:3::10]:58624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1et7Ib-0007Cs-CW
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 02:46:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1et7IX-0004ag-Hf
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 02:46:13 -0500
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:38083)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1et7IX-0004aK-Bc
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 02:46:09 -0500
Received: by mail-io0-x244.google.com with SMTP id g21so20999072ioj.5
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 23:46:09 -0800 (PST)
References: <20180305083655.6186-1-pbonzini@redhat.com>
	<20180305083655.6186-2-pbonzini@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <2f17e439-e7b0-b7b5-6f21-d0b346ea6738@ozlabs.ru>
Date: Tue, 6 Mar 2018 18:46:03 +1100
MIME-Version: 1.0
In-Reply-To: <20180305083655.6186-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/7] openpic_kvm: drop
 address_space_to_flatview call
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-stable@nongnu.org

On 05/03/18 19:36, Paolo Bonzini wrote:
> The MemoryListener is registered on address_space_memory, there is
> not much to assert.  This currently works because the callback
> is invoked only once when the listener is registered, but section->fv
> is the _new_ FlatView, not the old one on later calls and that
> would break.
> 
> This confines address_space_to_flatview to exec.c and memory.c.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>

> ---
>  hw/intc/openpic_kvm.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/hw/intc/openpic_kvm.c b/hw/intc/openpic_kvm.c
> index fa83420254..39a6f369c5 100644
> --- a/hw/intc/openpic_kvm.c
> +++ b/hw/intc/openpic_kvm.c
> @@ -124,10 +124,6 @@ static void kvm_openpic_region_add(MemoryListener *listener,
>      uint64_t reg_base;
>      int ret;
>  
> -    if (section->fv != address_space_to_flatview(&address_space_memory)) {
> -        abort();
> -    }
> -
>      /* Ignore events on regions that are not us */
>      if (section->mr != &opp->mem) {
>          return;
> 


-- 
Alexey
