Received: from eggs.gnu.org ([2001:4830:134:3::10]:36565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1fqZWq-0006Z0-6h
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 03:50:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1fqZWl-0000MB-5x
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 03:50:40 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:56113)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <simon@ruderich.org>) id 1fqZWk-0000C0-Vf
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 03:50:35 -0400
Date: Fri, 17 Aug 2018 09:50:29 +0200
From: Simon Ruderich <simon@ruderich.org>
Message-ID: <20180817075029.GA14678@ruderich.org>
References: <0e59c79ddc01e195ddc59d77d9df2b95bf89b600.1523395243.git.simon@ruderich.org>
	<cover.1534409363.git.simon@ruderich.org>
	<82b093e763e784aea8f8a4e589318b25146a3a24.1534409363.git.simon@ruderich.org>
	<abbc398b-0ded-5531-aba5-bd95200c937c@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="=_zucker.schokokeks.org-12280-1534492229-0001-2"
Content-Disposition: inline
In-Reply-To: <abbc398b-0ded-5531-aba5-bd95200c937c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 6/7] qmp: add pmemload command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, David Alan Gilbert <dgilbert@redhat.com>, Peter Crosthwaite <crosthwaitepeter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Markus Armbruster <armbru@redhat.com>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_zucker.schokokeks.org-12280-1534492229-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 16, 2018 at 03:01:31PM -0500, Eric Blake wrote:
>> +    }
>> +    if (!has_size) {
>> +        struct stat s;
>> +        if (fstat(fd, &s)) {
>> +            error_setg_errno(errp, errno, "could not fstat fd to get si=
ze");
>> +            goto exit;
>> +        }
>> +        size =3D s.st_size;
>> +    }
>
> This works for regular files, but not for block devices.
>
> Do we have a helper function for easily determining the size of an arbitr=
ary
> fd (whether file or block device)?  If not, should we?  As there are
> multiple spots in the code that grab this sort of information.

I found raw_getlength() in block/file-posix.c, but its static and
it takes a BlockDriverState* as argument. For most systems it
could be extracted without too much trouble, but some (e.g
__sun__ and BSD) are quite entangled with BlockDriverState code.

> Otherwise looks okay to me.

Should I check for S_ISCHR() and S_ISBLK() and abort with an
error? I don't think it's a common use case for pmemload anyway.

Regards
Simon
--=20
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9

--=_zucker.schokokeks.org-12280-1534492229-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO7rfWMMObpFkF3n0kv79t+RMMvkFAlt2fjsACgkQkv79t+RM
MvlJug/+K+wsVdV9QWLTbIcIG+4IjCo8YBG29ji6IqFcjhk6SPfszy4H/uwNTbA2
3nZ+rj+BN08FoisbTqdei+L/A5Y4rP/92q0R+r+T5F13o8qsy9v6bgIsaWKO+MOn
kjs0fvm1iSX1uCj/wcWG/uwHbxK/6Ea46jGw2/hVC5t1rj5dF2yIfD7ZkDBC08OS
h8Gcbk2/LdjTk8rBjELsw8W5DxDet1FXP3ifpdv/U2lr3nDAlPmQXjB+grTRiA5r
rn2jz8JJS4utA06CTgaJGlizSTNciWlWfHy64j2OyvcXnAAyuHfQRI7nXKFaEhyE
lAq64opWSOxdiH5Ldd6QFwQufyyEd/r6Vm+S/GRWtkbtaAEXTEcfE2wz+C1t9fxi
OxrvjK/DHaGNfNWeKDg3OIEYQsfd/NupHe4H68tvTPT0+HVYy5hFSDYkYofqUoCJ
QPXzaMj3TTfixUDm78MtleCGgZcGTgrzkXG7nny8lZBDbspjYd/egRO1GGxwOq7D
Q2U2dovjOseWsPylqOGhe9WQY6lsrnRwVBE5PJW46lLp2ekdrkXTP+BGNKm/m1r0
okgkEJkPPat9q4Vy9il/I+vOck+ICcdqUVWkkBtUORZPoDe6JApGPxz3rSjU++U3
FfpPYa4NBnveuztltavS2duYZunfhme1qTQsgSOTQ/k3eq4ljpc=
=4Ukd
-----END PGP SIGNATURE-----

--=_zucker.schokokeks.org-12280-1534492229-0001-2--
