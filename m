Received: from eggs.gnu.org ([2001:4830:134:3::10]:58959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1evhPy-0001Q8-Jt
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 06:44:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1evhPv-0004vd-Dd
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 06:44:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54488 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1evhPv-0004uR-6k
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 06:44:27 -0400
Date: Tue, 13 Mar 2018 10:44:21 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180313104421.GD16582@stefanha-x1.localdomain>
References: <20180228072558.7434-1-haozhong.zhang@intel.com>
	<20180312153954.GA24440@stefanha-x1.localdomain>
	<20180313001150.gtbs4jz4degeblba@hz-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2iBwrppp/7QCDedR"
Content-Disposition: inline
In-Reply-To: <20180313001150.gtbs4jz4degeblba@hz-desktop>
Subject: Re: [Qemu-devel] [PATCH v4 0/8] nvdimm: guarantee persistence of
 QEMU writes to persistent memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, mst@redhat.com, Juan Quintela <quintela@redhat.com>, dgilbert@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Eduardo Habkost <ehabkost@redhat.com>


--2iBwrppp/7QCDedR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 13, 2018 at 08:11:50AM +0800, Haozhong Zhang wrote:
> On 03/12/18 15:39 +0000, Stefan Hajnoczi wrote:
> > On Wed, Feb 28, 2018 at 03:25:50PM +0800, Haozhong Zhang wrote:
> > > QEMU writes to vNVDIMM backends in the vNVDIMM label emulation and
> > > live migration. If the backend is on the persistent memory, QEMU needs
> > > to take proper operations to ensure its writes persistent on the
> > > persistent memory. Otherwise, a host power failure may result in the
> > > loss the guest data on the persistent memory.
> > >=20
> > > This v3 patch series is based on Marcel's patch "mem: add share
> > > parameter to memory-backend-ram" [1] because of the changes in patch =
1.
> > >=20
> > > [1] https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg03858.ht=
ml
> > >=20
> > > Previous versions can be found at
> > > v3: https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg04365.ht=
ml
> > > v2: https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg01579.ht=
ml
> > > v1: https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg05040.ht=
ml
> > >=20
> > > Changes in v4:
> > >  * (Patch 2) Fix compilation errors found by patchew.
> > >=20
> > > Changes in v3:
> > >  * (Patch 5) Add a is_pmem flag to ram_handle_compressed() and handle
> > >    PMEM writes in it, so we don't need the _common function.
> > >  * (Patch 6) Expose qemu_get_buffer_common so we can remove the
> > >    unnecessary qemu_get_buffer_to_pmem wrapper.
> > >  * (Patch 8) Add a is_pmem flag to xbzrle_decode_buffer() and handle
> > >    PMEM writes in it, so we can remove the unnecessary
> > >    xbzrle_decode_buffer_{common, to_pmem}.
> > >  * Move libpmem stubs to stubs/pmem.c and fix the compilation failures
> > >    of test-{xbzrle,vmstate}.c.
> > >=20
> > > Changes in v2:
> > >  * (Patch 1) Use a flags parameter in file ram allocation functions.
> > >  * (Patch 2) Add a new option 'pmem' to hostmem-file.
> > >  * (Patch 3) Use libpmem to operate on the persistent memory, rather
> > >    than re-implementing those operations in QEMU.
> > >  * (Patch 5-8) Consider the write persistence in the migration path.
> > >=20
> > > Haozhong Zhang (8):
> > >   [1/8] memory, exec: switch file ram allocation functions to 'flags'=
 parameters
> > >   [2/8] hostmem-file: add the 'pmem' option
> > >   [3/8] configure: add libpmem support
> > >   [4/8] mem/nvdimm: ensure write persistence to PMEM in label emulati=
on
> > >   [5/8] migration/ram: ensure write persistence on loading zero pages=
 to PMEM
> > >   [6/8] migration/ram: ensure write persistence on loading normal pag=
es to PMEM
> > >   [7/8] migration/ram: ensure write persistence on loading compressed=
 pages to PMEM
> > >   [8/8] migration/ram: ensure write persistence on loading xbzrle pag=
es to PMEM
> > >=20
> > >  backends/hostmem-file.c             | 27 +++++++++++++++++++-
> > >  configure                           | 35 ++++++++++++++++++++++++++
> > >  docs/nvdimm.txt                     | 14 +++++++++++
> > >  exec.c                              | 20 ++++++++++++---
> > >  hw/mem/nvdimm.c                     |  9 ++++++-
> > >  include/exec/memory.h               | 12 +++++++--
> > >  include/exec/ram_addr.h             | 28 +++++++++++++++++++--
> > >  include/migration/qemu-file-types.h |  2 ++
> > >  include/qemu/pmem.h                 | 27 ++++++++++++++++++++
> > >  memory.c                            |  8 +++---
> > >  migration/qemu-file.c               | 29 ++++++++++++++--------
> > >  migration/ram.c                     | 49 +++++++++++++++++++++++++++=
----------
> > >  migration/ram.h                     |  2 +-
> > >  migration/rdma.c                    |  2 +-
> > >  migration/xbzrle.c                  |  8 ++++--
> > >  migration/xbzrle.h                  |  3 ++-
> > >  numa.c                              |  2 +-
> > >  qemu-options.hx                     |  9 ++++++-
> > >  stubs/Makefile.objs                 |  1 +
> > >  stubs/pmem.c                        | 37 ++++++++++++++++++++++++++++
> > >  tests/Makefile.include              |  4 +--
> > >  tests/test-xbzrle.c                 |  4 +--
> > >  22 files changed, 285 insertions(+), 47 deletions(-)
> > >  create mode 100644 include/qemu/pmem.h
> > >  create mode 100644 stubs/pmem.c
> >=20
> > A few thoughts:
> >=20
> > 1. Can you use pmem_is_pmem() to auto-detect the pmem=3Don|off value?
>=20
> The manpage [1] of pmem_is_pmem says:
>=20
>  "The result of pmem_is_pmem() query is only valid for the mappings
>   created using pmem_map_file().  For other memory regions, in
>   particular those created by a direct call to mmap(2), pmem_is_pmem()
>   always returns false, even if the queried range is entirely
>   persistent memory."
>=20
> QEMU is using mmap for NVDIMM mapping, so pmem_is_pmem does not work.
>=20
> [1] http://pmem.io/pmdk/manpages/linux/master/libpmem/pmem_is_pmem.3#cave=
ats

Now that the PMDK library dependency is being added to QEMU,
pmem_map_file() could be used too.

> > 3. This is independent of this patch series and can be done later.
> >    NVDIMM seems incompatible with post-copy live migration.  It would be
> >    good to have a postcopy_add_blocker() API so that a nice error
> >    message is printed if post-copy live migration is attempted.
>=20
> Post-copy with NVDIMM currently fails with message "Postcopy on shared
> RAM (...) is not yet supported". Is it enough?

Yes, that's better than I expected!

Stefan

--2iBwrppp/7QCDedR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJap6uFAAoJEJykq7OBq3PIcugH/0jJGwkXhMWX0Z2pk+3YkrE7
3J/A6ey+PHE3S6+Ze3GXvYHigCxDiJHzNuwqY4DAsTjlri5ivpcOCUMrCLUXJhI2
lw7c/p6F/gGUweBWLGKqVHsrxyWN6KjEcORKZCPA2w0tUQL9zrEOINm8AsKJes7S
v+buir4UOR6QjdiOdqjSNinGBJCjCwU440nSRvGI0QAWOEhN39nCU1+4hWdYvPKp
KYGwzNS093HHMtQFlhZcZVSLka0lOf8d6k9t7Y5Nh8fflEuaaItboHka9eWBuof3
RVvkFW8K+KJN/2FM5fx+iARmJ+pI4uBP7JbuAGmKyJxnWzHOMlYNY/HMjjkFJXg=
=BH/M
-----END PGP SIGNATURE-----

--2iBwrppp/7QCDedR--
