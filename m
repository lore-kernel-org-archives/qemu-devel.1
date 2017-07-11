Received: from eggs.gnu.org ([2001:4830:134:3::10]:43333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUtQ8-0000LV-9E
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 07:33:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUtQ5-0006y2-6E
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 07:33:36 -0400
References: <1499674503-21551-1-git-send-email-kchamart@redhat.com>
	<1499674503-21551-2-git-send-email-kchamart@redhat.com>
	<251c3898-8d5f-a799-318e-5ab0545220a3@redhat.com>
	<20170711075839.wgp64avrkzyo6d6t@eukaryote>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5215f15d-9d8b-698f-30a0-b2f569cbc59a@redhat.com>
Date: Tue, 11 Jul 2017 06:33:22 -0500
MIME-Version: 1.0
In-Reply-To: <20170711075839.wgp64avrkzyo6d6t@eukaryote>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VDl9ar8107d7LN0JDaDQUumHaGXNvQpFe"
Subject: Re: [Qemu-devel] [PATCH v6 1/2] bitmaps.md: Convert to rST;
 move it into 'interop' dir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, berto@igalia.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VDl9ar8107d7LN0JDaDQUumHaGXNvQpFe
From: Eric Blake <eblake@redhat.com>
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com,
 mreitz@redhat.com, jsnow@redhat.com, berto@igalia.com
Message-ID: <5215f15d-9d8b-698f-30a0-b2f569cbc59a@redhat.com>
Subject: Re: [PATCH v6 1/2] bitmaps.md: Convert to rST; move it into 'interop'
 dir
References: <1499674503-21551-1-git-send-email-kchamart@redhat.com>
 <1499674503-21551-2-git-send-email-kchamart@redhat.com>
 <251c3898-8d5f-a799-318e-5ab0545220a3@redhat.com>
 <20170711075839.wgp64avrkzyo6d6t@eukaryote>
In-Reply-To: <20170711075839.wgp64avrkzyo6d6t@eukaryote>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/11/2017 02:58 AM, Kashyap Chamarthy wrote:
> On Mon, Jul 10, 2017 at 09:36:50PM -0500, Eric Blake wrote:
>> On 07/10/2017 03:15 AM, Kashyap Chamarthy wrote:
>=20
> [...]
>=20
>>> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
>>> Reviewed-by: John Snow <jsnow@redhat.com>
>>> ---
>>
>>> ---
>>>  docs/devel/bitmaps.md    | 505 -------------------------------------=
-----
>>>  docs/interop/bitmaps.rst | 555 +++++++++++++++++++++++++++++++++++++=
++++++++++
>>
>> A shame that git rename detection doesn't see these as the same rough
>> contents, but not too bad.=20
>=20
> _Should_ it detect?

It depends on the similarities between the file, and on whether you have
'git config diff.renames true' set (there are some other parameters you
can set to fine-tune how much effort git expends on detecting file
renames, but the defaults are usually good enough).

>=20
>> I'll just review the new text; if I point out
>> something that was pre-existing in the old text, it may be nicer to
>> split the cleanups into a separate followup patch, but I'm also okay i=
f
>> they go in as part of this patch.
>=20
> Indeed -- the things you point out further below were already
> pre-existing. =20
>=20
> Asking out of curiosity: You say it is nicer split because we'll retain=

> the `git-bisect`-ability?  Or just to keep text motion and actual
> changes separate?  (I think both.)

bisect-ability is important on code, but less so on docs. If you were
doing code motion, I'd absolutely insist that cleanups be separate from
the motion; but here I don't have a strong preference (separating the
cleanups DOES make it easier to perform a backport of the cleanup
without having to backport the rename, but backporting docs tends to be
less of a priority than backporting code functionality).


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--VDl9ar8107d7LN0JDaDQUumHaGXNvQpFe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZZLeCAAoJEKeha0olJ0NqcDwIAJ80tKMr64/s9jh/3W2lb62u
dJyonBys74xv+pxgJWwNjPVYN7EvK+T1wmcY4BWWw2Eat50DH/4m9VDr15dd4DOd
2L56iMfipG3QRSh6hEZgShUfTNDtAZQ1OZ1AopGTtf9Ui6+qARf2gcARFYn9mVPx
Z+382ryksXCHC55YuL1U7CGaIgFTxJ5D9gtX3LckLs3H4jOqnD0J1qva6yAluWT4
iH+cLzQ6Phi5aQUKfUk9Q/1+RZ/9oEEpU4UvF/4lkf5EBQ82DvQGdcJR4r3yd6T5
i8fQ6JxieJaTpWuPc1c2BtcHDPVMByAj7ZWZ389G23TB2y06AmyPyJrMs/bSKaM=
=529K
-----END PGP SIGNATURE-----

--VDl9ar8107d7LN0JDaDQUumHaGXNvQpFe--
