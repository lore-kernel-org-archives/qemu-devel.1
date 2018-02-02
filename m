Received: from eggs.gnu.org ([2001:4830:134:3::10]:45290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ehcfd-0006OJ-D0
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:50:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ehcfW-0006mt-Qe
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:50:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ehcfW-0006kx-90
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:50:22 -0500
Date: Fri, 2 Feb 2018 12:50:14 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180202145014.GI26425@localhost.localdomain>
References: <20180201125441.2f5b4fdd@redhat.com> <20180201201514.GB660@flask>
	<20180201202649.GG26425@localhost.localdomain>
	<edc27e9a-9660-eed0-dd03-016fa2e966b7@linux.vnet.ibm.com>
	<20180202141554.GH26425@localhost.localdomain>
	<20180202141938.GJ15403@redhat.com>
	<20180202092159.48d9bd4c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180202092159.48d9bd4c@redhat.com>
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
To: Luiz Capitulino <lcapitulino@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, kvm@vger.kernel.org, pbonzini@redhat.com, Peter Krempa <pkrempa@redhat.com>, John Ferlan <jferlan@redhat.com>, libvir-list@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>

(CCing qemu-devel)

On Fri, Feb 02, 2018 at 09:21:59AM -0500, Luiz Capitulino wrote:
> On Fri, 2 Feb 2018 14:19:38 +0000
> Daniel P. Berrang=E9 <berrange@redhat.com> wrote:
> > On Fri, Feb 02, 2018 at 12:15:54PM -0200, Eduardo Habkost wrote:
[...]
> > > It would be also interesting to update QEMU QMP documentation to
> > > clarify the arch-specific semantics of "halted". =20
> >=20
> > Any also especially clarify the awful performance implications of run=
ning
> > this particular query command. In general I would not expect query-xx=
x
> > monitor commands to interrupt all vcpus, so we should clearly warn ab=
out
> > this !
>=20
> Or deprecate it...

We could deprecate the expensive fields on query-cpus, and move
them to a more expensive query-cpu-state command.  I believe most
users of query-cpus are only interested in qom_path, thread_id,
and topology info.

Markus, Eric: from the QAPI point of view, is it OK to remove
fields between QEMU versions, as long as we follow our
deprecation policy?

--=20
Eduardo
