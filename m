Received: from eggs.gnu.org ([2001:4830:134:3::10]:40363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drspl-0004ui-4w
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 17:35:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drspk-0005OP-5x
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 17:35:05 -0400
References: <20170912144459.11359-1-pbonzini@redhat.com>
	<20170912144459.11359-5-pbonzini@redhat.com>
	<7d63b366-37a4-bfbe-790b-9a1ceb0d2893@redhat.com>
	<1767007484.5449466.1505251616671.JavaMail.zimbra@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <732c98f0-a771-ef6f-e674-a11366653162@redhat.com>
Date: Tue, 12 Sep 2017 16:34:55 -0500
MIME-Version: 1.0
In-Reply-To: <1767007484.5449466.1505251616671.JavaMail.zimbra@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KKkSQiAhkoV5KTGhTl84ogu1KNxDTxI3f"
Subject: Re: [Qemu-devel] [PATCH 04/10] qemu-iotests: cleanup and fix search
 for programs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KKkSQiAhkoV5KTGhTl84ogu1KNxDTxI3f
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <732c98f0-a771-ef6f-e674-a11366653162@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/10] qemu-iotests: cleanup and fix search
 for programs
References: <20170912144459.11359-1-pbonzini@redhat.com>
 <20170912144459.11359-5-pbonzini@redhat.com>
 <7d63b366-37a4-bfbe-790b-9a1ceb0d2893@redhat.com>
 <1767007484.5449466.1505251616671.JavaMail.zimbra@redhat.com>
In-Reply-To: <1767007484.5449466.1505251616671.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/12/2017 04:26 PM, Paolo Bonzini wrote:
>=20
>=20
>>> +then
>>> +    if [ -x "$build_iotests/qemu" ]; then
>>> +        export QEMU_PROG=3D"$build_iotests/qemu"
>>> +    elif [ -x "$build_root/$arch-softmmu/qemu-system-$arch" ]; then
>>> +        export QEMU_PROG=3D"$build_root/$arch-softmmu/qemu-system-$a=
rch"
>>> +    else
>>> +        pushd "$build_root" > /dev/null
>>
>> Shouldn't you check for failure to change directories?
>> =20
>>>  export PWD=3D`pwd`
>>> =20
>>> @@ -30,28 +31,6 @@ export _QEMU_HANDLE=3D0
>>>  # make sure we have a standard umask
>>>  umask 022
>>> =20
>>> -# $1 =3D prog to look for, $2* =3D default pathnames if not found in=
 $PATH
>>> -set_prog_path()
>>> -{
>>> -    p=3D`command -v $1 2> /dev/null`
>>> -    if [ -n "$p" -a -x "$p" ]; then
>>
>> Urrgh - your use of [ -a ] was pre-existing, and you just moved it.
>=20
> And same for pushd...

True - since this patch is just code motion, we can do the cleanups in a
different patch, so you can have:
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--KKkSQiAhkoV5KTGhTl84ogu1KNxDTxI3f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm4Uv8ACgkQp6FrSiUn
Q2qmYAf/ZF/HJ6r5uJFewQY8pL/udpLaxQKiR05g/YsmA+08BEMcsbYp/Gmynr2S
cWP10bQJlxPrwXI5GcWSOujkpzff3dlDxwkViuzboBWI7o0W9FfpgrM229lgUYrH
L1I3QoNSZJs4m5Fj3h3GnOddMIMsXYGYsfHzxism7Oq6kVlxoBSF7Fv23y+FEjvt
91+awpoxoe11NgiGvUnDNyyoxHKKWFBHCCeyDri9RCILx5KeFO1k4PmmaKEFBlDN
QZUicrG0vIRl1BUyb1PI6pY8JlMRf0Fb7TbtztZS60jOUG6hpH/LAu+Mce2x9f2D
OmgcfR1aYiIXh5VA+48a5SrayvdsKA==
=ph6Z
-----END PGP SIGNATURE-----

--KKkSQiAhkoV5KTGhTl84ogu1KNxDTxI3f--
