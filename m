Received: from eggs.gnu.org ([2001:4830:134:3::10]:58205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=353c7c5a0=Paul.Durrant@citrix.com>)
	id 1dT3R4-00023G-Ks
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 05:50:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=353c7c5a0=Paul.Durrant@citrix.com>)
	id 1dT3R0-0001j0-Q1
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 05:50:58 -0400
Received: from smtp.eu.citrix.com ([185.25.65.24]:31016)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=353c7c5a0=Paul.Durrant@citrix.com>)
	id 1dT3R0-0001fV-Dn
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 05:50:54 -0400
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Thu, 6 Jul 2017 09:50:51 +0000
Message-ID: <2f658ac9137a47f7a56cd16868e097ca@AMSPEX02CL01.citrite.net>
References: <1499183267-28623-1-git-send-email-igor.druzhinin@citrix.com>
	<1499183267-28623-4-git-send-email-igor.druzhinin@citrix.com>
	<5e854d8a0df0401eba375f959ee5de8c@AMSPEX02CL01.citrite.net>
	<7833d6fb-b930-6890-b679-afc1ad8cde9e@citrix.com>
	<449552367f194ec5bc0a0ac5f0646fb0@AMSPEX02CL01.citrite.net>
	<cc600f1b-2849-5dc6-b896-345d65648b5a@citrix.com>
	<efb0e09d9b2e491180a4966ecaf3ada7@AMSPEX02CL01.citrite.net>
	<alpine.DEB.2.10.1707051539000.2919@sstabellini-ThinkPad-X260>
In-Reply-To: <alpine.DEB.2.10.1707051539000.2919@sstabellini-ThinkPad-X260>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 3/4] xen/mapcache: introduce
 xen_replace_cache_entry()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Stefano Stabellini' <sstabellini@kernel.org>
Cc: Igor Druzhinin <igor.druzhinin@citrix.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Anthony Perard <anthony.perard@citrix.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>

> -----Original Message-----
> > > >
> > > > The problem really comes down to defining
> xenforeignmemory_map2() in
> > > terms of xenforeignmemory_map(). It basically can't be safely done.
> Could
> > > you define xenforeignmemory_map2() as abort() in the compat case
> > > instead?
> > > >
> > >
> > > xen_replace_cache_entry() is not called in patch #3. Which means it's
> > > safe to use a fallback version (xenforeignmemory_map) in
> > > xen_remap_bucket here.
> >
> > I still don't like the fact that the compat definition of
> xenforeignmemory_map2() loses the extra argument. That's going to catch
> someone out one day. Is there any way you could re-work it so that
> xenforeignmemory_map() is uses in the cases where the memory
> placement does not matter?
>=20
> We could assert(vaddr =3D=3D NULL) in the compat implementation of
> xenforeignmemory_map2. Would that work?
>=20

Yes, if the patch was changed from being a straight #define as it is now to=
 an inline that had such an assertion then that would be ok.

  Cheers,

    Paul
