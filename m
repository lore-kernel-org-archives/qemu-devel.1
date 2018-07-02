Received: from eggs.gnu.org ([2001:4830:134:3::10]:34702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fZw8N-0002HT-Nk
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:32:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fZw8I-0001vR-OF
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:32:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44484 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fZw8I-0001v7-JC
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:32:34 -0400
Date: Mon, 2 Jul 2018 12:32:30 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180702123230.17efcc84@redhat.com>
In-Reply-To: <20180702094152.7882-1-david@redhat.com>
References: <20180702094152.7882-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] machine: properly free device_memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

On Mon,  2 Jul 2018 11:41:52 +0200
David Hildenbrand <david@redhat.com> wrote:

> Machines might have inititalized device_memory if they support memory
> devices, so let's properly free it.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/core/machine.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 617e5f8d75..ae3e713e90 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -674,6 +674,7 @@ static void machine_finalize(Object *obj)
>      g_free(ms->dumpdtb);
>      g_free(ms->dt_compatible);
>      g_free(ms->firmware);
> +    g_free(ms->device_memory);
>  }
>  
>  bool machine_usb(MachineState *machine)

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
