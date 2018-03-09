Received: from eggs.gnu.org ([2001:4830:134:3::10]:32994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1euH4Q-0005wb-AE
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 07:24:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1euH4N-0000jR-3V
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 07:24:22 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54878 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1euH4M-0000jH-U5
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 07:24:19 -0500
Date: Fri, 9 Mar 2018 12:24:06 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180309122405.GC3213@work-vm>
References: <20180308124901.83533-1-brijesh.singh@amd.com>
	<20180308124901.83533-11-brijesh.singh@amd.com>
	<20180308165413.GH4718@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180308165413.GH4718@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v12 10/28] include: add psp-sev.h header
 file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>, qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Alexander Graf <agraf@suse.de>, Bruce Rogers <brogers@suse.com>, Richard Henderson <rth@twiddle.net>

* Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> On Thu, Mar 08, 2018 at 06:48:43AM -0600, Brijesh Singh wrote:
> > The header file provide the ioctl command and structure to communicat=
e
> > with /dev/sev device.
> >=20
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Richard Henderson <rth@twiddle.net>
> > Cc: Eduardo Habkost <ehabkost@redhat.com>
> > Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> > ---
> >  linux-headers/linux/psp-sev.h | 142 ++++++++++++++++++++++++++++++++=
++++++++++
> >  1 file changed, 142 insertions(+)
> >  create mode 100644 linux-headers/linux/psp-sev.h
> >=20
> > diff --git a/linux-headers/linux/psp-sev.h b/linux-headers/linux/psp-=
sev.h
> > new file mode 100644
> > index 000000000000..33e247471ae0
> > --- /dev/null
> > +++ b/linux-headers/linux/psp-sev.h
> > @@ -0,0 +1,142 @@
> > +/*
> > + * Userspace interface for AMD Secure Encrypted Virtualization (SEV)
> > + * platform management commands.
> > + *
> > + * Copyright (C) 2016-2017 Advanced Micro Devices, Inc.
> > + *
> > + * Author: Brijesh Singh <brijesh.singh@amd.com>
> > + *
> > + * SEV spec 0.14 is available at:
> > + * http://support.amd.com/TechDocs/55766_SEV-KM%20API_Specification.=
pdf
> > + *
> > + * This program is free software; you can redistribute it and/or mod=
ify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
>=20
> Most of the files you've added are GPLv2-or-later. Is this one intentio=
nally
> GPLv2-only instead ?

This is just a sync'd kernel header (which should just get sync'd with
the sync script).

Dave

> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
