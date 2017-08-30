Received: from eggs.gnu.org ([2001:4830:134:3::10]:39158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dn0P9-0004nt-H5
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 06:39:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dn0P8-0002f9-My
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 06:39:27 -0400
Received: from mail-vk0-x242.google.com ([2607:f8b0:400c:c05::242]:35203)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dn0P8-0002ew-I3
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 06:39:26 -0400
Received: by mail-vk0-x242.google.com with SMTP id s199so2275545vke.2
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 03:39:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170824192730.8440-29-dgilbert@redhat.com>
References: <20170824192730.8440-1-dgilbert@redhat.com>
	<20170824192730.8440-29-dgilbert@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 30 Aug 2017 03:39:25 -0700
Message-ID: <CAJ+F1CLnEb-V4aTMThiC0pQqLFKY1JRGFxM9R6Cpq5kW_1Qb=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 28/32] postcopy: Allow shared memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Maxime Coquelin <maxime.coquelin@redhat.com>, a.perevalov@samsung.com, "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, aarcange@redhat.com, Felipe Franciosi <felipe@nutanix.com>, Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>

Hi

On Thu, Aug 24, 2017 at 12:27 PM, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Now that we have the mechanisms in here, allow shared memory in a
> postcopy.
>
> Note that QEMU can't tell who all the users of shared regions are
> and thus can't tell whether all the users of the shared regions
> have appropriate support for postcopy.  Those devices that explicitly
> support shared memory (e.g. vhost-user) must check, but it doesn't
> stop weirder configurations causing problems.
>

Other users should have their own migration blocker, I guess.

> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  migration/postcopy-ram.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 28791cf1f1..89c3aadda1 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -138,12 +138,6 @@ static int test_ramblock_postcopiable(const char *bl=
ock_name, void *host_addr,
>      RAMBlock *rb =3D qemu_ram_block_by_name(block_name);
>      size_t pagesize =3D qemu_ram_pagesize(rb);
>
> -    if (qemu_ram_is_shared(rb)) {
> -        error_report("Postcopy on shared RAM (%s) is not yet supported",
> -                     block_name);
> -        return 1;
> -    }
> -
>      if (length % pagesize) {
>          error_report("Postcopy requires RAM blocks to be a page size mul=
tiple,"
>                       " block %s is 0x" RAM_ADDR_FMT " bytes with a "
> --
> 2.13.5
>
>



--=20
Marc-Andr=C3=A9 Lureau
