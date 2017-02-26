Received: from eggs.gnu.org ([2001:4830:134:3::10]:53099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ci5WZ-0000Rm-GC
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 15:34:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ci5WY-0001bT-58
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 15:34:31 -0500
Received: from hera.aquilenet.fr ([2a01:474::1]:56851)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ci5WX-0001bI-Ue
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 15:34:30 -0500
Date: Sun, 26 Feb 2017 21:34:27 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170226203427.6xjmuvt6okc356e5@var.youpi.perso.aquilenet.fr>
References: <20170220185020.774-1-dgilbert@redhat.com>
	<20170220185020.774-5-dgilbert@redhat.com>
	<8760k3od2r.fsf@emacs.mitica> <20170223105155.GA2383@work-vm>
	<20170223110433.GL10047@redhat.com> <20170223114045.GB2383@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170223114045.GB2383@work-vm>
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

Hello,

Dr. David Alan Gilbert, on jeu. 23 f=E9vr. 2017 11:40:45 +0000, wrote:
> * Daniel P. Berrange (berrange@redhat.com) wrote:
> > IOW if we transmit this data on the wire, we've effectively said that
> > our migration data format is *not* portable across different host OS
> > platforms. At that point, sending different sized types on BSD vs
> > Linux is no big deal since we're already incompatible semantically.
>=20
> This is a relatively recent error; it comes from eae303ff which added
> ss_family to allow IPv6.
>=20
> I suspect the right fix here is to populate a temporary for ss_family
> on the wire; if we make it conveniently match Linux's AF_INET6 values
> it might work.

So this issue is actually not new, so I asked to pull your patch series,
thanks!

Now we should indeed fix the issue. Making the values match Linux'
AF_INET6, why not (better have some known values than arbitrary values),
but I don't think we'd want to rely on this: we'll have to introduce a
versioned difference, since we'll want to change the size of the field
as well as its value on other OSes (and I don't think we want to manage
different versioning on different OSes).

Samuel
