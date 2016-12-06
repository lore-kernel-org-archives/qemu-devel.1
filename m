Received: from eggs.gnu.org ([2001:4830:134:3::10]:44542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cEBOt-0008EO-KQ
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 03:47:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cEBOs-0006rG-MW
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 03:46:59 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <20161205234235.5728-1-eblake@redhat.com>
Date: Tue, 6 Dec 2016 08:46:43 +0000
Content-Transfer-Encoding: quoted-printable
Message-Id: <35E2FCDC-462E-4EC2-940E-B37247C69E24@alex.org.uk>
References: <20161205234235.5728-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [Nbd] [PATCH] doc: Propose NBD_FLAG_INIT_ZEROES
 extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Alex Bligh <alex@alex.org.uk>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, xieyingtai@huawei.com, subo7@huawei.com, qemu block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>


> On 5 Dec 2016, at 23:42, Eric Blake <eblake@redhat.com> wrote:
>=20
> While not directly related to NBD_CMD_WRITE_ZEROES, the qemu
> team discovered that it is useful if a server can advertise
> whether an export is in a known-all-zeroes state at the time
> the client connects.

I think this is good to go, and ...

> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> doc/proto.md | 5 +++++
> 1 file changed, 5 insertions(+)
>=20
> This replaces the following qemu patch attempt:
> https://lists.gnu.org/archive/html/qemu-devel/2016-12/msg00357.html
> which tried to add NBD_CMD_HAS_ZERO_INIT with poor semantics. The
> semantics in this proposal should be much better.
>=20
> Patch is to the merge of the master branch and the
> extension-write-zeroes branch.  By the way, qemu 2.8 is due
> to be released "real soon now", and implements NBD_CMD_WRITE_ZEROES,
> so maybe it is time to consider promoting the extension-write-zeroes
> branch into master.

I would support this.

In fact the patch is sufficiently simple I think I'd merge this
into extension-write-zeroes then merge that into master.

Wouter?

Alex

> diff --git a/doc/proto.md b/doc/proto.md
> index afe71fc..7e4ec7f 100644
> --- a/doc/proto.md
> +++ b/doc/proto.md
> @@ -697,6 +697,11 @@ The field has the following format:
>   the export.
> - bit 9, `NBD_FLAG_SEND_BLOCK_STATUS`: defined by the experimental
>   `BLOCK_STATUS` =
[extension](https://github.com/NetworkBlockDevice/nbd/blob/extension-block=
status/doc/proto.md).
> +- bit 10, `NBD_FLAG_INIT_ZEROES`: Indicates that the server =
guarantees
> +  that at the time transmission phase begins, all offsets within the
> +  export read as zero bytes.  Clients MAY use this information to
> +  avoid writing to sections of the export that should still read as
> +  zero after the client is done writing.
>=20
> Clients SHOULD ignore unknown flags.
>=20
> --=20
> 2.9.3
>=20
>=20
> =
--------------------------------------------------------------------------=
----
> Developer Access Program for Intel Xeon Phi Processors
> Access to Intel Xeon Phi processor-based developer platforms.
> With one year of Intel Parallel Studio XE.
> Training and support from Colfax.
> Order your platform today.http://sdm.link/xeonphi
> _______________________________________________
> Nbd-general mailing list
> Nbd-general@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/nbd-general
>=20

--=20
Alex Bligh
