Received: from eggs.gnu.org ([209.51.188.92]:47542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gj82F-0005Yz-Lg
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 14:36:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gj82D-0000gF-1q
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 14:36:34 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44378
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1gj82B-0000ee-5Q
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 14:36:31 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x0EJYWYr068932
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 14:36:24 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2q0xh3wqag-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 14:36:23 -0500
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Mon, 14 Jan 2019 19:36:22 -0000
Date: Mon, 14 Jan 2019 20:36:13 +0100
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <154724057022.525985.2498693456915341883.stgit@bahia.lan>
References: <154724039526.525985.3172545257507998890.stgit@bahia.lan>
	<154724057022.525985.2498693456915341883.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190114203613.64273080@oc2783563651>
Subject: Re: [Qemu-devel] [PATCH v2 07/13] qdev: pass an Object * to
 qbus_set_hotplug_handler()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, "Michael S.
	Tsirkin" <mst@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-ppc@nongnu.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On Fri, 11 Jan 2019 22:02:50 +0100
Greg Kurz <groug@kaod.org> wrote:

> From: Michael Roth <mdroth@linux.vnet.ibm.com>
> 
> Certain devices types, like memory/CPU, are now being handled using a
> hotplug interface provided by a top-level MachineClass. Hotpluggable
> host bridges are another such device where it makes sense to use a
> machine-level hotplug handler. However, unlike those devices,
> host-bridges have a parent bus (the main system bus), and devices with
> a parent bus use a different mechanism for registering their hotplug
> handlers: qbus_set_hotplug_handler(). This interface currently expects
> a handler to be a subclass of DeviceClass, but this is not the case
> for MachineClass, which derives directly from ObjectClass.
> 
> Internally, the interface only requires an ObjectClass, so expose that
> in qbus_set_hotplug_handler().
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Acked-by: Halil Pasic <pasic@linux.ibm.com>
