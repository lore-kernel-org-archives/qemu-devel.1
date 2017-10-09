Received: from eggs.gnu.org ([2001:4830:134:3::10]:47903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1e1dM1-0003P6-ND
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 15:04:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1e1dLy-0006yA-JB
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 15:04:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60278
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1e1dLy-0006xr-Cu
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 15:04:38 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v99J4XMj118315
	for <qemu-devel@nongnu.org>; Mon, 9 Oct 2017 15:04:33 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dg9jbb2n7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 15:04:33 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 9 Oct 2017 13:04:28 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <a31e42ae-f9d2-0bfc-04f9-6e6c2e35c9f8@redhat.com>
References: <20171009170607.4155-1-mdroth@linux.vnet.ibm.com>
	<20171009170607.4155-2-mdroth@linux.vnet.ibm.com>
	<a31e42ae-f9d2-0bfc-04f9-6e6c2e35c9f8@redhat.com>
Date: Mon, 09 Oct 2017 14:04:15 -0500
Message-Id: <150757585588.11829.8041044493563314894@sif>
Subject: Re: [Qemu-devel] [PATCH v2 1/3] qdev: store DeviceState's canonical
 path to use when unparenting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, "Michael S . Tsirkin" <mst@redhat.com>, groug@kaod.org, armbru@redhat.com, alex.williamson@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au

Quoting Eric Blake (2017-10-09 13:11:28)
> On 10/09/2017 12:06 PM, Michael Roth wrote:
> > device_unparent(dev, ...) is called when a device is unparented,
> > either directly, or as a result of a parent device being
> > finalized, and handles some final cleanup for the device. Part
> > of this includes emiting a DEVICE_DELETED QMP event to notify
> > management, which includes the device's path in the composition
> > tree as provided by object_get_canonical_path().
> > =

> =

> > +++ b/hw/core/qdev.c
> > @@ -928,6 +928,13 @@ static void device_set_realized(Object *obj, bool =
value, Error **errp)
> >              goto post_realize_fail;
> >          }
> >  =

> > +        /*
> > +         * always free/re-initialize here since the value cannot be cl=
eaned up
> > +         * in device_unrealize due to it's usage later on in the unplu=
g path
> =

> s/it's/its/ (remember, "it's" is only appropriate if "it is" or "it has"
> can be substituted in its place; otherwise you meant the possessive "its")

Thanks, just inattentiveness on my part. Will send a v3 soon if there are
no other comments.

> =

> -- =

> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>=20
