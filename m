Received: from eggs.gnu.org ([2001:4830:134:3::10]:48467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1fq26Q-0007Eg-J4
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 16:09:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1fq26L-0000Zb-LU
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 16:09:10 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:53569)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <simon@ruderich.org>) id 1fpy6K-00028V-LX
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 11:53:27 -0400
Date: Wed, 15 Aug 2018 17:46:26 +0200
From: Simon Ruderich <simon@ruderich.org>
Message-ID: <20180815154626.GA23638@ruderich.org>
References: <cover.1526916378.git.simon@ruderich.org>
	<851d095cd457109e4a22a2e5ecd36ccbdacbf48b.1526916378.git.simon@ruderich.org>
	<20180810103650.GA2391@work-vm>
	<20180814141826.GA26558@ruderich.org>
	<871sb1t0cn.fsf@dusky.pond.sub.org>
	<20180814190329.GA13798@ruderich.org>
	<87pnykqmw4.fsf@dusky.pond.sub.org>
	<20180815124154.GA1116@ruderich.org>
	<87bma3ityy.fsf@dusky.pond.sub.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="=_zucker.schokokeks.org-3487-1534347986-0001-2"
Content-Disposition: inline
In-Reply-To: <87bma3ityy.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v3 5/5] qmp: add pmemload command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaitepeter@gmail.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_zucker.schokokeks.org-3487-1534347986-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 15, 2018 at 04:29:25PM +0200, Markus Armbruster wrote:
>> For the HMP or the QMP interface?
>
> Both.

Ok.

>> If you think 'offset' is not necessary I can also drop it
>> completely.
>
> I think it's a reasonable feature, and since you already coded it up...

In that case, should size also become optional? As already
suggested in this thread (and similar for QMP):

On Fri, Aug 10, 2018 at 11:36:51AM +0100, Dr. David Alan Gilbert wrote:
> Also, had you considered rearranging and making them optional,
> for example if you do:
>
> val:l,filename:F,offset:i?,size:i?
>
> I think that would mean you can do the fairly obvious:
>   pmemload addr "myfile"
>
> with the assumption that loads the whole file.

This would deviate from pmemsave/memsave, but feels more natural.

How are multiple optional parameters handled? Filled from
left-to-right?

Regards
Simon
--=20
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9

--=_zucker.schokokeks.org-3487-1534347986-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO7rfWMMObpFkF3n0kv79t+RMMvkFAlt0Ss4ACgkQkv79t+RM
MvmBGxAAkhnc7ERUTAqXUULFbkPqk0dLV6/W4RLt2PO+y6Csw9EjKvz1yA8qwaa5
0+sWY+dEqUo1w18chd3RFQoAv6WkVADvt048H9w2Vyru6Frzr/M83l6inOKleCdA
ZGHNyVLfoIM85qusNu1FB2BtHF8JT1/IyRQhMOOwm+214hyVHZfVkdpB/KArQ16R
soboPq6RlwHDkCx1q3/pFJTaS9Wfz2OxJ+lMcEIovKJv98Ssdfv99eAJt0raV2tX
CoS7YhSxH+Kg29nLrswY7lHMCLJfYVPKoeZG/nnR4K1/2AFeblV79+fBKk0YzEV4
JnvqJO1O0G+UtrrzolUIljL9WXxy+wJ51B/FikhRid5Q6WZIaSLIeVoCh0t164Pa
dQxfYxb60l/AKkEHFIwSxvFDVx0z9QBTzjCAv4q4rHUWkesNzhIw2N489irj4Igd
ApbaLce1h8J+W9Xuw7zG5YR7b1DZqeQ3a8I+pMBG+t7AuYXZKeuPYbLSHolFzr6s
NHLJHhzzqXxd+N/UgFlivc6UcJ3kGzaHIezmfSb7sJvYMn9TxozX8bxrYrc0+kuT
Mr1GJYlOb3G6sc3TULXPgNt/FnJ3eNZUn3hjAIo9kIkM16/km108cVeMzgl0yBLE
/quImyu8r9EqtQRjydNROd8U4hZskCdE7ScY2IkoQ/cfRMMzzjo=
=/Ux3
-----END PGP SIGNATURE-----

--=_zucker.schokokeks.org-3487-1534347986-0001-2--
