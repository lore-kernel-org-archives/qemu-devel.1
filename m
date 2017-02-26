Received: from eggs.gnu.org ([2001:4830:134:3::10]:53133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ci7me-0002xN-5g
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 17:59:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ci7mb-0007CI-53
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 17:59:16 -0500
Received: from hera.aquilenet.fr ([141.255.128.1]:52601)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ci7ma-0007Bu-VF
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 17:59:13 -0500
Date: Sun, 26 Feb 2017 23:59:10 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170226225910.n54cp32odmj6jb45@var.youpi.perso.aquilenet.fr>
References: <20170220185020.774-1-dgilbert@redhat.com>
	<20170220185020.774-5-dgilbert@redhat.com>
	<8760k3od2r.fsf@emacs.mitica> <20170223105155.GA2383@work-vm>
	<20170223110433.GL10047@redhat.com> <20170223114045.GB2383@work-vm>
	<20170226203427.6xjmuvt6okc356e5@var.youpi.perso.aquilenet.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170226203427.6xjmuvt6okc356e5@var.youpi.perso.aquilenet.fr>
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

Samuel Thibault, on dim. 26 f=E9vr. 2017 21:34:27 +0100, wrote:
> since we'll want to change the size of the field

Ah, no, sorry, it was forced to be 16bit, so at least the size is fine.

But I guess we don't want to change the values to have cross-OS
compatibility without changing the version.

Samuel
