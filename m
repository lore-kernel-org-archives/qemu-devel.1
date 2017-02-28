Received: from eggs.gnu.org ([2001:4830:134:3::10]:54387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1cipxR-0005S8-Up
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:09:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1cipxR-0001Iw-5c
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:09:21 -0500
Received: from hera.aquilenet.fr ([2a01:474::1]:33788)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1cipxQ-0001Ia-Vq
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:09:21 -0500
Date: Tue, 28 Feb 2017 23:09:18 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170228220918.24xob7ee7nxdfx5l@var.youpi.perso.aquilenet.fr>
References: <20170223110433.GL10047@redhat.com> <20170223114045.GB2383@work-vm>
	<20170226203427.6xjmuvt6okc356e5@var.youpi.perso.aquilenet.fr>
	<20170228165445.GG2773@work-vm>
	<20170228165730.ovdh4k6psrd3qv33@var.youpi.perso.aquilenet.fr>
	<20170228170017.GH2773@work-vm>
	<20170228170235.4xtrld37c6ymj5ko@var.youpi.perso.aquilenet.fr>
	<20170228170925.GI2773@work-vm>
	<20170228171219.ndea2aouukv4tivr@var.youpi.perso.aquilenet.fr>
	<20170228174018.GJ2773@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170228174018.GJ2773@work-vm>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 4/5] slirp: VMStatify socket level
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, jan.kiszka@siemens.com, maethor@subiron.org

Dr. David Alan Gilbert, on mar. 28 f=E9vr. 2017 17:40:19 +0000, wrote:
> * Samuel Thibault (samuel.thibault@gnu.org) wrote:
> > Dr. David Alan Gilbert, on mar. 28 f=E9vr. 2017 17:09:26 +0000, wrote=
:
> > > but only for Linux.
> >=20
> > That's what I was referring to.
>=20
> Yes I think that's OK because:
>    a) The alternative breaks all backwards migration
>    b) This doesn't casuse any problem for forward migration
>=20
> There is another way, we could add a subsection that's sent whenever
> we use non-IPv4; that would (probably) fail noisily on a backwards
> migration to an old setup.  But IMHO it's not worth it in this case
> given how rare a backwards migration of an IPv6 slirp connection on
> something other than Linux is.

Alright.

Samuel
