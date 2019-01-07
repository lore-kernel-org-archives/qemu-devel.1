Received: from eggs.gnu.org ([209.51.188.92]:44922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ggTnF-0000Xu-Bx
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 07:14:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ggTnE-0005t9-Gk
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 07:14:09 -0500
References: <20181212091623.16950-1-david@redhat.com>
	<20181212091623.16950-5-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <2527cf5c-983b-e4df-2c26-c47df87e6bf0@redhat.com>
Date: Mon, 7 Jan 2019 13:13:58 +0100
MIME-Version: 1.0
In-Reply-To: <20181212091623.16950-5-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 04/11] pci/pcie: stop plug/unplug if the
 slot is locked
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>, Collin Walling <walling@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, qemu-ppc@nongnu.org

On 12.12.18 10:16, David Hildenbrand wrote:
> We better stop right away. For now, errors would be partially ignored
> (so the guest might get informed or the device might get unplugged),
> although actual plug/unplug will be reported as failed to the user.
> 
> While at it, properly move the check to the pre_plug handler for the plug
> case, as we can test the slot state before the device will be realized.
> 
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: David Hildenbrand <david@redhat.com>

@MST, looks like you missed this one.


-- 

Thanks,

David / dhildenb
