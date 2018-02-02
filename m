Received: from eggs.gnu.org ([2001:4830:134:3::10]:40516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ehd7n-0006OH-RE
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:19:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ehd7j-0004Y0-RN
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:19:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ehd7j-0004Xc-KT
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:19:31 -0500
Date: Fri, 2 Feb 2018 15:07:18 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180202150718.GL15403@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180201125441.2f5b4fdd@redhat.com> <20180201201514.GB660@flask>
	<20180201202649.GG26425@localhost.localdomain>
	<edc27e9a-9660-eed0-dd03-016fa2e966b7@linux.vnet.ibm.com>
	<20180202141554.GH26425@localhost.localdomain>
	<20180202141938.GJ15403@redhat.com>
	<20180202092159.48d9bd4c@redhat.com>
	<20180202145014.GI26425@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180202145014.GI26425@localhost.localdomain>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC] kvm: x86: export vCPU halted state to sysfs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Luiz Capitulino <lcapitulino@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, kvm@vger.kernel.org, pbonzini@redhat.com, Peter Krempa <pkrempa@redhat.com>, John Ferlan <jferlan@redhat.com>, libvir-list@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>

On Fri, Feb 02, 2018 at 12:50:14PM -0200, Eduardo Habkost wrote:
> (CCing qemu-devel)
>=20
> On Fri, Feb 02, 2018 at 09:21:59AM -0500, Luiz Capitulino wrote:
> > On Fri, 2 Feb 2018 14:19:38 +0000
> > Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> > > On Fri, Feb 02, 2018 at 12:15:54PM -0200, Eduardo Habkost wrote:
> [...]
> > > > It would be also interesting to update QEMU QMP documentation to
> > > > clarify the arch-specific semantics of "halted". =20
> > >=20
> > > Any also especially clarify the awful performance implications of r=
unning
> > > this particular query command. In general I would not expect query-=
xxx
> > > monitor commands to interrupt all vcpus, so we should clearly warn =
about
> > > this !
> >=20
> > Or deprecate it...
>=20
> We could deprecate the expensive fields on query-cpus, and move
> them to a more expensive query-cpu-state command.  I believe most
> users of query-cpus are only interested in qom_path, thread_id,
> and topology info.
>=20
> Markus, Eric: from the QAPI point of view, is it OK to remove
> fields between QEMU versions, as long as we follow our
> deprecation policy?

I would expect that to not be OK.  A fully backwards compatible way to
deal with this would just be to add a flag to the query-cpus command
eg something like

    query-cpus arch-specific=3Dfalse

to turn off all this arch specific state, and just report the cheap
generic info. If it defaults to arch-specific=3Dtrue when omitted, then
there's no compat problems.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
