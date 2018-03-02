Received: from eggs.gnu.org ([2001:4830:134:3::10]:39496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1erow5-0007Jm-GO
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 12:57:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1erow4-0003xE-Dc
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 12:57:37 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:51515)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1erow4-0003wB-2d
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 12:57:36 -0500
Received: by mail-wm0-x243.google.com with SMTP id h21so4700962wmd.1
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 09:57:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180302105709.GD26972@redhat.com>
References: <20180302083720.25137-1-idgar@virtualoco.com>
	<20180302105709.GD26972@redhat.com>
From: Benjamin Warren <ben@skyportsystems.com>
Date: Fri, 2 Mar 2018 09:57:33 -0800
Message-ID: <CAFtH1GUd3Y5wBYQBf6W2xn3_sC1jBHwZXPBYmsaFRc48nSPSPA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] vmgenid: allow VM Generation ID
 modification via QMP/HMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Or Idgar <idgar@virtualoco.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu devel list <qemu-devel@nongnu.org>, Gal Hammer <ghammer@redhat.com>, Or Idgar <oridgar@gmail.com>

On Fri, Mar 2, 2018 at 2:57 AM, Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m>
wrote:

> On Fri, Mar 02, 2018 at 10:37:20AM +0200, Or Idgar wrote:
> > From: Or Idgar <oridgar@gmail.com>
> >
> > This patch allow changing the Virtual Machine Generation
> > ID through QMP/HMP while the vm guest is running.
> > the spec (http://go.microsoft.com/fwlink/?LinkId=3D260709)
> > mentions that "when the generation ID changes, execute an
> > ACPI Notify operation on the generation ID device".
> > To test it we need the ability to set the generation ID
> > online. QMP/HMP allows that.
>
> If we want to test vmgenid, why don't we simply trigger one of
> the mgmt actions that are required to change vmgenid. eg do a
> savevm, followed by a loadvm to restore from snapshot. This would
> be better testing of the real world usage of this feature.
>
> I agree.  Verifying functionality in a Windows guest is tricky, but in
Linux you can build and load this (old and badly written) device driver:

https://github.com/ben-skyportsystems/vmgenid-test

You should see the 'notices' number increment after restoring a snapshot.

Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/
> dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/
> dberrange :|
>

regards,
Ben
