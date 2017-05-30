Received: from eggs.gnu.org ([2001:4830:134:3::10]:58331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFmlD-0002L7-HC
	for qemu-devel@nongnu.org; Tue, 30 May 2017 15:24:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFmlB-0002DT-GZ
	for qemu-devel@nongnu.org; Tue, 30 May 2017 15:24:55 -0400
References: <1496158724-2809-1-git-send-email-kchamart@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <df3d406e-d9e2-73e0-4943-23fac349c1b3@redhat.com>
Date: Tue, 30 May 2017 14:24:40 -0500
MIME-Version: 1.0
In-Reply-To: <1496158724-2809-1-git-send-email-kchamart@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LuisDbvvuMXoCqKHQcMRDhRuWIVAKRc3W"
Subject: Re: [Qemu-devel] [PATCH] live-block-ops.txt: Rewrite and improve it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LuisDbvvuMXoCqKHQcMRDhRuWIVAKRc3W
From: Eric Blake <eblake@redhat.com>
To: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com,
 qemu-block@nongnu.org
Message-ID: <df3d406e-d9e2-73e0-4943-23fac349c1b3@redhat.com>
Subject: Re: [PATCH] live-block-ops.txt: Rewrite and improve it
References: <1496158724-2809-1-git-send-email-kchamart@redhat.com>
In-Reply-To: <1496158724-2809-1-git-send-email-kchamart@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/30/2017 10:38 AM, Kashyap Chamarthy wrote:
> This edition documents all four operations:
>=20
>   - `block-stream`
>   - `block-commit`
>   - `drive-mirror` (& `blockdev-mirror`)
>   - `drive-backup` (& `blockdev-backup`)
>=20
> Things considered while writing this document:
>=20
>   - Use reStructuredText format.  It is gentler on the eye, and can be
>     trivially converted to different formats.  (Another reason: upstrea=
m
>     QEMU is considering to switch to Sphinx, which uses reStructuredTex=
t
>     as its markup language.)
>=20
>   - Raw QMP JSON output vs. 'qmp-shell'.  I debated with myself whether=

>     to only show raw QMP JSON output (as that is the canonical
>     representation), or use 'qmp-shell', which takes key-value pairs.  =
I
>     settled on the approach of: for the first occurance of a command,

s/occurance/occurrence/

>     use raw JSON; for subsequent occurances, use 'qmp-shell', with an

s/occurances/occurrences/

>     occasional exception.
>=20
>   - Using 'node-name' vs. file path to refer to disks.  While we have
>     `blockdev-{mirror, backup}` as 'node-name'-alternatives for
>     `drive-{mirror, backup}`, the `block-{stream, commit}` commands
>     still operate on file names for parameters 'base' and 'top'.  So I
>     added a caveat at the beginning to that effect.
>=20
>     Refer this related thread that I started:
>     https://lists.nongnu.org/archive/html/qemu-devel/2017-05/msg06466.h=
tml
>     "[RFC] Making 'block-stream', and 'block-commit' accept node-name"
>=20
> All commands showed in this document were tested while documenting.
>=20
> Thanks: Eric Blake for the section: "A note on points-in-time vs file
> names".  This useful bit was originally articulated by Eric in his
> KVMForum 2015 presentation, so I included that specific bit in this
> document.
>=20
> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
> ---
> * An HTML rendered version is here:
>   https://kashyapc.fedorapeople.org/virt/qemu/live-block-operations.htm=
l

Helpful; thanks!

> diff --git a/docs/live-block-operations.rst b/docs/live-block-operation=
s.rst
> new file mode 100644
> index 0000000000000000000000000000000000000000..19107776cd1edd20fac17dd=
da192d677199190d9
> --- /dev/null
> +++ b/docs/live-block-operations.rst
> @@ -0,0 +1,757 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +Live Block Device Operations
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

Is it worth mentioning a copyright/license in this prologue?  It's not
mandatory (you get the default of GPLv2+ based on the top-level if you
don't do it), but being explicit never hurts.

> +
> +Table of Contents
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +(1) `Disk image backing chain notation`_
> +(2) `Brief overview of live block QMP primitives`_
> +(3) `Interacting with a QEMU instance`_
> +(4) `Example disk image chain`_
> +(5) `A note on points-in-time vs file names`_
> +(6) `Live block streaming -- `block-stream``_
> +(7) `QMP invocation for `block-stream``_
> +(8) `Live block commit -- `block-commit``_
> +(9) `QMP invocation for `block-commit``_
> +(10) `Live disk synchronization -- `drive-mirror`&`blockdev-mirror``_
> +(11) `QMP invocation for `drive-mirror``_
> +(12) `Notes on `blockdev-mirror``_
> +(13) `Live disk backup -- `drive-backup`&`blockdev-backup``_
> +(14) `QMP invocation for `drive-backup``_
> +(15) `Notes on `blockdev-backup``_
> +

Does .rst have any mechanisms for ensuring the ToC doesn't get out of
sync if we later change sections around?

> +
> +.. _`Disk image backing chain notation`:
> +

> +
> +Arrow to be read as: Image [A] is the backing file of disk image [B].

Maybe: "The arrow can be read as:"

> +And live QEMU is currently writing to image [B], consequently, it is
> +also referred to as the "active layer".
> +
> +There are two kinds of terminology that is common when referring to

s/that is common/that are common/

> +files in a disk image backing chain:
> +

> +
> +.. _`Brief overview of live block QMP primitives`:
> +
> +Brief overview of live block QMP primitives
> +-------------------------------------------
> +
> +The following are the four different kinds of live block operations th=
at
> +QEMU block layer supports.
> +
> +- `block-stream`: Live copy data from overlay files into backing image=
s.

Backwards.  This is a live copy of data from backing images into
overlays (with the optional goal of removing the backing image from the
chain).

> +
> +- `block-commit`: Live merge data from backing files into overlay
> +  images.  Since QEMU 2.0, this includes "active `block-commit`" (i.e.=

> +  merge the current active layer into the base image).

Backwards.  This is live merge of data from overlay images into backing
images (with the optional goal of removing the overlay image from the
chain).

> +
> +- `drive-mirror` (and `blockdev-mirror`): Synchronize running disk to
> +  another image.
> +
> +- `drive-backup` (and `blockdev-backup`): Point-in-time (live) copy of=
 a
> +  block device to a destination.

These are okay.

> +
> +
> +.. _`Interacting with a QEMU instance`:
> +
> +Interacting with a QEMU instance
> +--------------------------------
> +
> +To show some example invocations of command-line, we shall use the

'shall' is okay, but sounds rather formal; using 'will' sounds more typic=
al.

> +following invocation of QEMU, with a QMP server running over UNIX
> +socket:
> +
> +.. code-block::
> +
> +    $ ./x86_64-softmmu/qemu-system-x86_64 -display none -nodefconfig \=

> +        -M q35 -nodefaults -m 512 \
> +        -blockdev node-name=3Dnode-A,driver=3Dqcow2,file.driver=3Dfile=
,file.filename=3D./a.qcow2 \
> +        -device virtio-blk,drive=3Dnode-A,id=3Dvirtio0 \
> +        -monitor stdio -qmp unix:/tmp/qmp-sock,server,nowait

Nice use of -blockdev! Is it worth also giving file.node-name for a
non-generated node name on the protocol layer?

> +
> +The `-blockdev` command-line option, used above, is available from QEM=
U
> +2.9 onwards.  In the above invocation, notice the 'node-name' paramete=
r
> +that is used to refer to the disk image a.qcow2 ('node-A') -- this is =
a
> +cleaner way to refer to a disk image (as opposed to referring to it by=

> +spelling out file paths).  So, we shall continue to designate a
> +'node-name' to each further disk image created (either via
> +`blockdev-snapshot-sync`, or `blockdev-add`) as part of the disk image=

> +chain, and continue to refer to the disks using their 'node-name' (whe=
re
> +possible, because `block-stream`, and `block-commit` do not yet, as of=

> +QEMU 2.9, take 'node-name' parameters) when performing various block
> +operations.
> +
> +To interact with the QEMU instance launched above, we shall use the

Again, shall vs. will.  Probably a recurring comment.

> +`qmp-shell` (located at: `qemu/scripts/qmp`, as part of the QEMU sourc=
e
> +directory) utility, which takes key-value pairs for QMP commands.
> +Invoke it as below (which will also print out the complete raw JSON
> +syntax for reference -- examples in the following sections).
> +
> +.. code-block::
> +
> +    $ ./qmp-shell -v -p /tmp/qmp-sock
> +    (QEMU)
> +


> +
> +.. _`Live block commit -- `block-commit``:
> +
> +Live block commit (`block-commit`)
> +----------------------------------
> +
> +The `block-commit` command lets you to live merge data from overlay

s/to live/do a live/

> +images into backing file(s).  Since QEMU 2.0, this includes "live acti=
ve
> +commit" (i.e. it is possible to merge the "active layer", the right-mo=
st
> +image in a disk image chain where live QEMU will be writing to, into t=
he
> +base image).  This is analogous to `block-stream`, but in opposite
> +direction.
> +
> +Continuing with our example disk image chain, where live QEMU is writi=
ng

Is it really continuing with the example, or re-starting from the
original setup? (Continuing sort of implies that you run the previous
section first, then this section on the result of the previous section -
but then you no longer have the 4-image chain that you get by re-starting=
).

> +to the right-most image in the chain, [D]:
> +
> +.. code-block::
> +
> +    [A] <-- [B] <-- [C] <-- [D]
> +
> +The disk image chain can be shortened in one of the following ways:
> +
> +(1) Commit content from only image [B] into image [A].  The resulting
> +    chain is the following, where the backing file for [D] is adjusted=

> +    to point at [C]:

Image [D] had no adjustment. Rather, image [C] now points at [A] as its
new backing.

> +
> +    .. code-block::
> +
> +        [A] <-- [C] <-- [D]
> +
> +(2) Commit content from images [B] and [C] into image [A].  The
> +    resulting chain:
> +
> +    .. code-block::
> +
> +        [A] <-- [D]

Now image [D] is updated to point to [A].

> +QMP invocation for `block-commit`
> +---------------------------------
> +
> +For case (1), from the previous section -- merge contents only from
> +image [B] into image [A], the invocation is as following:
> +
> +.. code-block::
> +
> +    (QEMU) block-commit device=3Dnode-D base=3Da.qcow2 top=3Db.qcow2 j=
ob-id=3Djob0
> +    {
> +        "execute": "block-commit",
> +        "arguments": {
> +            "device": "node-D",
> +            "job-id": "job0",
> +            "top": "b.qcow2",
> +            "base": "a.qcow2"
> +        }
> +    }
> +
> +Once the above `block-commit` operation has completed, a
> +`BLOCK_JOB_COMPLETED` event will be issued, and no further action is
> +required.  The end result being, the backing file of image [D] is
> +adjusted to point to image [B], and the original disk image chain will=

> +end up being transformed to:
> +
> +.. code-block::
> +
> +    [A] <-- [B] <-- [D]

Doesn't match your description of bullet 1) above.  You are committing B
into A, which means the overlay of B (in this case C) gets rewritten to
point to the new base, and your end chain is [A] <-- [C] <-- [D]

> +
> +NB: The intermdiate image [C] is invalid (as in: no more further
> +overlays based on it can be created) and, therefore, should be dropped=
=2E

You are correct that the image dropped in this manner no longer
corresponds to actual guest contents - but it should be [B] that is
invalidated.

> +However, case (3), the "active `block-commit`", is a *two-phase*
> +operation: in the first phase, the content from the active overlay,
> +along with the intermediate overlays, is copied into the backing file
> +(also called, the base image); in the second phase, adjust the said
> +backing file as the current active image -- possible via issuing the
> +command `block-job-complete`.  [Optionally, the operation can be
> +cancelled, by issuing the command `block-job-cancel`, but be careful
> +when doing this.]
> +

Stupid US vs. UK spelling of canceled/cancelled.  I honestly don't care
which variant you pick.


> +
> +    (QEMU) block-commit device=3Dnode-D base=3Da.qcow2 top=3Dd.qcow2 j=
ob-id=3Djob0
> +    {

> +
> +Once the synchronization has completed, the event `BLOCK_JOB_READY` wi=
ll
> +be emitted

Trailing '.'?


> +Finally, once the above job is completed, an event `BLOCK_JOB_COMPLETE=
D`
> +will be emitted.
> +
> +[The invocation for rest of all the cases, discussed in the previous
> +setion, is omitted for brevity.]

s/setion/section/

> +
> +
> +.. _`Live disk synchronization -- `drive-mirror`&`blockdev-mirror``:
> +

You show the sync=3Dfull version, but not a shallow mirror (only the
active layer is mirrored; the destination must already have the contents
of the backing chain visible via other means, whether by 'cp' or by some
storage-array-specific command).  Since libvirt storage migration uses
NBD disks on the destination with shallow drive-mirror on the source,
that is a common enough setup that it is worth documenting.

> +.. _`Live disk backup -- `drive-backup`&`blockdev-backup``:
> +
> +Live disk backup (`drive-backup` & `blockdev-backup`)
> +-----------------------------------------------------
> +

It may be worth documenting incremental backup policies here (I'm not
sure if we have it documented elsewhere in the tree).  John may have
better pointers to material on that.

Several things to fix, but it looks nice overall.  Looking forward to v2.=


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--LuisDbvvuMXoCqKHQcMRDhRuWIVAKRc3W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZLcb5AAoJEKeha0olJ0Nq8xgH/jceSiO7c4bqTpH5C3OHfXHR
y1VtNx0+9YkKCV4TppyiEwOkJpc65Rodm1PiYj8+UgvPtAo/4BPu1zvll8/oDKjr
Z9E6R0DY1kcLmwrUISiCK4/KsUdgpVUrGmrSt3FYhqe8mlS6kAG7RdcWP9bp2XVJ
LrSyKmMNhyCDkmReHDmNi/IuJEF7O/fnuAIxi1Q/Q5PUtlU3IBpoDOHFih02aDrC
CwKaou7jpxW9jjVHVZTIXLyWPAm0ZwvOtEa7jXiAtMbaLmb9SAUzzjWrqHV2UEIp
K/X/hxheQwckY+sRGv+efQuL8y+ncFey00BXhOtUNP0EtnRrRyyFyLW0521ONGU=
=/ItH
-----END PGP SIGNATURE-----

--LuisDbvvuMXoCqKHQcMRDhRuWIVAKRc3W--
