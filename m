Received: from eggs.gnu.org ([2001:4830:134:3::10]:47136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjuQc-0001xI-Qe
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 16:07:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjuQY-0005wG-Ny
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 16:07:54 -0500
References: <20170303202227.1950-1-shah.suramya@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b55f5d8d-ea27-86fd-87c4-1243945c7ac5@redhat.com>
Date: Fri, 3 Mar 2017 15:07:47 -0600
MIME-Version: 1.0
In-Reply-To: <20170303202227.1950-1-shah.suramya@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ai33qcLNWXicS1wIsa6hshaaQsAfU8xM5"
Subject: Re: [Qemu-devel] [PATCH v2]util:Removed header qemu-common.h from
 path.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suramya Shah <shah.suramya@gmail.com>, qemu-devel@nongnu.org
Cc: marcel@redhat.com, armbru@redhat.com, qemu-trivial@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ai33qcLNWXicS1wIsa6hshaaQsAfU8xM5
From: Eric Blake <eblake@redhat.com>
To: Suramya Shah <shah.suramya@gmail.com>, qemu-devel@nongnu.org
Cc: marcel@redhat.com, armbru@redhat.com, qemu-trivial@nongnu.org
Message-ID: <b55f5d8d-ea27-86fd-87c4-1243945c7ac5@redhat.com>
Subject: Re: [PATCH v2]util:Removed header qemu-common.h from path.c
References: <20170303202227.1950-1-shah.suramya@gmail.com>
In-Reply-To: <20170303202227.1950-1-shah.suramya@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/03/2017 02:22 PM, Suramya Shah wrote:
> Signed-off-by: Suramya Shah <shah.suramya@gmail.com>

Technically, this is v3 now (and your next submission will be v4).
Also, if you use 'git send-email -v4' to send your patch, it would
automatically put a space after the closing ] of the subject prefix (I
think 'git am' does the right thing even without the space, but when
most submissions look consistent in the archives, the ones that are
different stand out)

In the subject, put a space after the colon.

It's also fine that your subject says 'what' was done, but there is no
'why'; that's what the commit body is good for.  It's also good to write
patches in the imperative sense (present tense command form) rather than
past tense.  Visualize it as "this patch does something" (or even "apply
this patch for these results"), not "I wrote this patch to do something"
or "this patch did something".

Another tip: if you can easily identify a patch where a particular
situation started that you are now fixing, calling it out may help
reviewers.  In this case, looking at 'git log util/path.c', it looks
like commit f348b6d was the one that got rid of the need for using
qemu-common.h, when it moved declarations into other headers.  Showing
that you've researched the history gives more weight to your patch being
valid.

> --- fix of typo in v1 that broke compilation

'git am' requires '---' to be on a line of its own.  You want the
changelog description to occur on its own line, after the --- separator.

Also, since I gave a Reviewed-by: on your last mail, you can add it here
to mark that the patch body is unchanged since it was last reviewed.

Since this appears to be your first contribution, the maintainer that
incorporates your patch can probably clean up these (minor) mistakes, so
you may not need to resubmit (on the other hand, resubmitting makes it
less work for the maintainer, so feel free to do it if you'd like). If
you'd like more tips for successful submissions, there's a lot of
resources at http://wiki.qemu-project.org/Contribute/SubmitAPatch

Putting this all together, I suggest the following header if you want to
resubmit as a v4:


util: Remove unneeded header from path.c

qemu-common.h is no longer necessary, as of the refactoring done in
commit f348b6d.

Signed-off-by:...
Reviewed-by: Eric Blake <eblake@redhat.com>

---
v4: rewrite commit log based on Eric's hints

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--ai33qcLNWXicS1wIsa6hshaaQsAfU8xM5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYudsjAAoJEKeha0olJ0NqF54H/R5cb/uIL3vAQZ3VsvQKdmR0
W2DYbLskbWH8GUa3TiGAU4Si0bNG8mQX1UsywMh6EWmqs7VaPUfpGN7pvUlqKLcU
p5XzcGsNnYpctXUDFvz7y2s3POne0/NvxyxiDDfLTzCMocMWtf5SeKd5NqwqqBEi
AjWfvjnuLjVbLXMawhXWIepfRw5FB0Xej8vLRWGXgKVfe60w84qXZNPhf1slDExb
+gx2sI7F7ElAn9SJ9wmGqcfL/ikoJuZ0b+Al0uxNpbku/uek1KWBkEfTmtmSPmfM
bwn3t0Wl6KEZn0oNVK5v9Z3ivTuzafxyqxjFYNNc1S2yoKMbHugKxGyIhSqr2Tk=
=p6tR
-----END PGP SIGNATURE-----

--ai33qcLNWXicS1wIsa6hshaaQsAfU8xM5--
