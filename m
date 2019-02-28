Received: from eggs.gnu.org ([209.51.188.92]:34114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gzPTD-0000dz-I3
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 12:27:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gzPJr-0004JS-Q7
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 12:18:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gzPJr-0004HN-Jx
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 12:18:03 -0500
Date: Thu, 28 Feb 2019 14:17:58 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190228171758.GE4925@habkost.net>
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
Cc: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, armbru@redhat.com

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

Queued on machine-next, thanks!

-- 
Eduardo
