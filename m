Received: from eggs.gnu.org ([2001:4830:134:3::10]:38146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cDv7f-0004D6-QT
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 10:24:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cDv7c-0002CC-Op
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 10:24:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1cDv7c-0002BD-Jk
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 10:24:04 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 91D2E486DA
	for <qemu-devel@nongnu.org>; Mon,  5 Dec 2016 15:24:03 +0000 (UTC)
References: <1479777133-23567-1-git-send-email-ehabkost@redhat.com>
	<1479777133-23567-12-git-send-email-ehabkost@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <2f5f20a1-920f-6381-8402-81df697d61d3@redhat.com>
Date: Mon, 5 Dec 2016 16:24:00 +0100
MIME-Version: 1.0
In-Reply-To: <1479777133-23567-12-git-send-email-ehabkost@redhat.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 11/15] s390x: Initialize default bus lists
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

Am 22.11.2016 um 02:12 schrieb Eduardo Habkost:
> Populate the default_bus_types list for the s390x machines. This
> will allow qmp-machine-info.py to run in strict mode for s390x.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  hw/s390x/s390-virtio-ccw.c | 6 ++++++
>  tests/qmp-machine-info.py  | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index e340eab..2532fcb 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -206,6 +206,12 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
>      mc->use_sclp = 1;
>      mc->max_cpus = 248;
>      mc->get_hotplug_handler = s390_get_hotplug_handler;
> +    machine_class_add_default_bus(mc, TYPE_VIRTUAL_CSS_BUS);
> +    machine_class_add_default_bus(mc, TYPE_PCI_BUS);
> +    machine_class_add_default_bus(mc, TYPE_S390_PCI_BUS);
> +    machine_class_add_default_bus(mc, "s390-sclp-events-bus");
> +    machine_class_add_default_bus(mc, TYPE_VIRTIO_BUS);
> +

Maybe move and use
#define TYPE_SCLP_EVENTS_BUS "s390-sclp-events-bus"

(maybe this should then become TYPE_S390_SCLP_EVENTS_BUS ...)

?

-- 

David
