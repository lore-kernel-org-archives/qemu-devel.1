Received: from eggs.gnu.org ([2001:4830:134:3::10]:34407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cDvjv-0006Af-K5
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:03:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cDvjr-0006bR-OY
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:03:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41170
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cDvjr-0006bE-HV
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:03:35 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB5G0krQ144660
	for <qemu-devel@nongnu.org>; Mon, 5 Dec 2016 11:03:34 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2756v9sef5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 05 Dec 2016 11:03:34 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Mon, 5 Dec 2016 16:03:32 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com
	(d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
	by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id C73F1219004D
	for <qemu-devel@nongnu.org>; Mon,  5 Dec 2016 16:02:39 +0000 (GMT)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com
	[9.149.37.229])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id uB5G3S837012794
	for <qemu-devel@nongnu.org>; Mon, 5 Dec 2016 16:03:28 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id uB5G3SeN025332
	for <qemu-devel@nongnu.org>; Mon, 5 Dec 2016 09:03:28 -0700
Date: Mon, 5 Dec 2016 17:03:27 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <2f5f20a1-920f-6381-8402-81df697d61d3@redhat.com>
References: <1479777133-23567-1-git-send-email-ehabkost@redhat.com>
	<1479777133-23567-12-git-send-email-ehabkost@redhat.com>
	<2f5f20a1-920f-6381-8402-81df697d61d3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20161205170327.42c21c03.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [RFC 11/15] s390x: Initialize default bus lists
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Mon, 5 Dec 2016 16:24:00 +0100
David Hildenbrand <david@redhat.com> wrote:

> Am 22.11.2016 um 02:12 schrieb Eduardo Habkost:
> > Populate the default_bus_types list for the s390x machines. This
> > will allow qmp-machine-info.py to run in strict mode for s390x.
> >
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  hw/s390x/s390-virtio-ccw.c | 6 ++++++
> >  tests/qmp-machine-info.py  | 2 +-
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> > index e340eab..2532fcb 100644
> > --- a/hw/s390x/s390-virtio-ccw.c
> > +++ b/hw/s390x/s390-virtio-ccw.c
> > @@ -206,6 +206,12 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
> >      mc->use_sclp = 1;
> >      mc->max_cpus = 248;
> >      mc->get_hotplug_handler = s390_get_hotplug_handler;
> > +    machine_class_add_default_bus(mc, TYPE_VIRTUAL_CSS_BUS);
> > +    machine_class_add_default_bus(mc, TYPE_PCI_BUS);
> > +    machine_class_add_default_bus(mc, TYPE_S390_PCI_BUS);
> > +    machine_class_add_default_bus(mc, "s390-sclp-events-bus");
> > +    machine_class_add_default_bus(mc, TYPE_VIRTIO_BUS);
> > +
> 
> Maybe move and use
> #define TYPE_SCLP_EVENTS_BUS "s390-sclp-events-bus"
> 
> (maybe this should then become TYPE_S390_SCLP_EVENTS_BUS ...)
> 
> ?
> 

I'd ack/take such a patch.
