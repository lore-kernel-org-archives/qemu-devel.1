Received: from eggs.gnu.org ([209.51.188.92]:39705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1guZOt-0007Il-Pb
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 04:03:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1guZOp-0004BG-5a
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 04:03:15 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41206)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1guZOo-00048m-83
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 04:03:10 -0500
Received: by mail-wr1-f66.google.com with SMTP id x10so9449939wrs.8
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 01:03:08 -0800 (PST)
Date: Fri, 15 Feb 2019 10:02:55 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190215090255.p53uy3cfbwm2qeb3@steredhat>
References: <20190214105733.25643-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214105733.25643-1-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] hostmem: fix crash when querying empty
 host-nodes property via QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, mdroth@linux.vnet.ibm.com, ehabkost@redhat.com

On Thu, Feb 14, 2019 at 05:57:33AM -0500, Igor Mammedov wrote:
> QEMU will crashes with
>  qapi/qobject-output-visitor.c:210: qobject_output_complete: Assertion `qov->root && ((&qov->stack)->slh_first == ((void *)0))' failed
> when trying to get value of not set hostmem's "host-nodes"
> property, HostMemoryBackend::host_nodes bitmap doesn't have
> any bits set in it, which leads to find_first_bit() returning
> MAX_NODES and consequently to an early return from
> host_memory_backend_get_host_nodes() without calling visitor.
> 
> Fix it by calling visitor even if "host-nodes" property wasn't
> set before exiting from property getter to return valid empty
> list.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v2:
>   * fixup commit message to put emphasis on property instead
>     local variable host_nodes and make explanation more hopefully
>     more clear. (Markus Armbruster <armbru@redhat.com>)
> ---
>  backends/hostmem.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
