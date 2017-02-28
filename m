Received: from eggs.gnu.org ([2001:4830:134:3::10]:50495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cillD-0004ck-RN
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:40:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cillA-0005mI-Q1
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:40:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cillA-0005lM-Jf
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:40:24 -0500
Date: Tue, 28 Feb 2017 17:40:19 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170228174018.GJ2773@work-vm>
References: <20170223105155.GA2383@work-vm> <20170223110433.GL10047@redhat.com>
	<20170223114045.GB2383@work-vm>
	<20170226203427.6xjmuvt6okc356e5@var.youpi.perso.aquilenet.fr>
	<20170228165445.GG2773@work-vm>
	<20170228165730.ovdh4k6psrd3qv33@var.youpi.perso.aquilenet.fr>
	<20170228170017.GH2773@work-vm>
	<20170228170235.4xtrld37c6ymj5ko@var.youpi.perso.aquilenet.fr>
	<20170228170925.GI2773@work-vm>
	<20170228171219.ndea2aouukv4tivr@var.youpi.perso.aquilenet.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170228171219.ndea2aouukv4tivr@var.youpi.perso.aquilenet.fr>
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
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, jan.kiszka@siemens.com, maethor@subiron.org

* Samuel Thibault (samuel.thibault@gnu.org) wrote:
> Dr. David Alan Gilbert, on mar. 28 f=E9vr. 2017 17:09:26 +0000, wrote:
> > but only for Linux.
>=20
> That's what I was referring to.

Yes I think that's OK because:
   a) The alternative breaks all backwards migration
   b) This doesn't casuse any problem for forward migration

There is another way, we could add a subsection that's sent whenever
we use non-IPv4; that would (probably) fail noisily on a backwards
migration to an old setup.  But IMHO it's not worth it in this case
given how rare a backwards migration of an IPv6 slirp connection on
something other than Linux is.

Dave

> Samuel
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
