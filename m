Received: from eggs.gnu.org ([2001:4830:134:3::10]:37725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cil8U-0000Kt-Sc
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:00:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cil8R-0005Tl-16
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:00:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cil8Q-0005T0-S6
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:00:22 -0500
Date: Tue, 28 Feb 2017 17:00:17 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170228170017.GH2773@work-vm>
References: <20170220185020.774-1-dgilbert@redhat.com>
	<20170220185020.774-5-dgilbert@redhat.com>
	<8760k3od2r.fsf@emacs.mitica> <20170223105155.GA2383@work-vm>
	<20170223110433.GL10047@redhat.com> <20170223114045.GB2383@work-vm>
	<20170226203427.6xjmuvt6okc356e5@var.youpi.perso.aquilenet.fr>
	<20170228165445.GG2773@work-vm>
	<20170228165730.ovdh4k6psrd3qv33@var.youpi.perso.aquilenet.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170228165730.ovdh4k6psrd3qv33@var.youpi.perso.aquilenet.fr>
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
> Dr. David Alan Gilbert, on mar. 28 f=E9vr. 2017 16:54:46 +0000, wrote:
> > I'm thinking one way to do it without changing the version would
> > be to use the existing value for IPv4, and on reading allow any other
> > value for IPv6 (or just the ones we know about); that would make
> > it inwards migration compatible.
>=20
> Right. I don't know if that's enough for QEMU requirements.

If you change the version number you break backwards migration anyway;
but doing what I suggested would keep backwards working in most cases.

Dave

> Samuel
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
