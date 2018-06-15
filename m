Received: from eggs.gnu.org ([2001:4830:134:3::10]:44899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fTmnT-0006DE-0f
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 07:21:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fTmnP-0007YD-SV
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 07:21:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44950 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fTmnP-0007Y6-No
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 07:21:35 -0400
Date: Fri, 15 Jun 2018 12:21:32 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180615112131.GB13796@work-vm>
References: <20180605162545.80778-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180605162545.80778-1-dgilbert@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/2] Fixups for non-migratable RAMBlocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peterx@redhat.com, clg@kaod.org
Cc: quintela@redhat.com

* Dr. David Alan Gilbert (git) (dgilbert@redhat.com) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> Hi,
>   C=E9dric's b895de50 got merged at about the same
> time as some of Peter's changes and there's a rdma
> case as well; so tidy up those cases that were looping
> over all (rather than just migratable) RAMBlocks
> and poison it so we don't end up doing the same thing
> again.

Queued.

> Dave
>=20
> Dr. David Alan Gilbert (2):
>   migration: Fixes for non-migratable RAMBlocks
>   migration: Poison ramblock loops in migration
>=20
>  include/exec/ramlist.h | 4 +++-
>  migration/migration.h  | 3 +++
>  migration/ram.c        | 8 +++++---
>  migration/rdma.c       | 2 +-
>  4 files changed, 12 insertions(+), 5 deletions(-)
>=20
> --=20
> 2.17.0
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
