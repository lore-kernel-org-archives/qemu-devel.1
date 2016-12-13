Received: from eggs.gnu.org ([2001:4830:134:3::10]:49397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cGnp8-0003Hj-Df
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 09:12:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cGnp4-0001MZ-GJ
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 09:12:54 -0500
Received: from mail.avalus.com ([2001:41c8:10:1dd::10]:46048)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cGnp4-0001MO-6s
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 09:12:50 -0500
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed;
	boundary="Apple-Mail=_44581609-1067-4B62-8EAF-14BE67594A67";
	protocol="application/pgp-signature"; micalg=pgp-sha512
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <20161212204313.anhjire2gkwd6gzi@grep.be>
Date: Tue, 13 Dec 2016 14:12:48 +0000
Message-Id: <4B4EF198-ABE9-4517-A19D-8058AB117342@alex.org.uk>
References: <20161212204313.anhjire2gkwd6gzi@grep.be>
Subject: Re: [Qemu-devel] [Nbd] [PATCH v5] doc: Add NBD_CMD_BLOCK_STATUS
 extension (part 2)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wouter Verhelst <w@uter.be>
Cc: Alex Bligh <alex@alex.org.uk>, Eric Blake <eblake@redhat.com>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Pavel Borzenkov <pborzenkov@virtuozzo.com>, "Stefan stefanha@redhat. com" <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Markus Pargmann <mpa@pengutronix.de>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>


--Apple-Mail=_44581609-1067-4B62-8EAF-14BE67594A67
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii


> On 12 Dec 2016, at 20:43, Wouter Verhelst <w@uter.be> wrote:
> 
> +- `NBD_OPT_SET_META_CONTEXT` (11)
> +
> +    Change the set of active metadata contexts. Issuing this command
> +    replaces all previously-set metadata contexts; clients must ensure
> +    that all metadata contexts they're interested in are selected with
> +    the final query that they sent.
> +
> +    Data:
> +    - 32 bits, length of query
> +    - String, query to select metadata contexts. The syntax of this
> +      query is implementation-defined, except that it MUST start with a
> +      namespace. This namespace may be one of the following:
> +        - `base:`, for metadata contexts defined by this document;
> +        - `nbd-server:`, for metadata contexts defined by the
> +          implementation that accompanies this document (none
> +          currently);
> +        - `x-*:`, where `*` can be replaced by any random string not
> +          containing colons, for local experiments. This SHOULD NOT be
> +          used by metadata contexts that are expected to e widely used.
> +        - third-party implementations can register additional
> +          namespaces by simple request to the mailinglist.

Surely also we need to specify multiple queries?


--
Alex Bligh





--Apple-Mail=_44581609-1067-4B62-8EAF-14BE67594A67
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJYUAHgAAoJEBPm5K7i9iOR7kYP/3nVau9uaazGa0pNkwgDJ94t
nrFwpw4+NMSAQwm2gilkgMQ8vrdB0V5/LIsNAxhNNlrS64KxdH4tZon87HZlzEaG
hAH4N6JQjxDqNEPX5hHyWeGZl5FqS/WlrtmednsW6o2HcujjBqZkPKMY5xjLb+If
gQpyc+UOX9kLv0FzyxNmw8t3Ibg875QwPjAAdrvS5khJN2uu8aBbv8nD4vkfQAs8
m0Hfe5U5l0DBkgxWo/tciaIYjjm9eR7cS+r26WFHOugsVsQo/hJ8csK5HWMRtrU3
7ijDUJNtt2x0EL/B6QQ3DwDh4j8C02aU5IfX+zYA3iANc748B+3Xoa2WkcsQAv/M
zPbw2yj6pCNwWiKHHknnrt3NhfXYLhZJd9dkE+eybcsm8gvQ6TUcCkiewtnpmvCR
BuNUX4JAYKgqsfO6W2cNu2e3EJFmFYo+Diedj02Xz6xPA+XJmJNTURfA3+PFKC8O
av7wBwQz7Is3PaxfDUb/jtEWxpBWyzOEoVJl1EZ8ntQrnaH7gQdyRAzHzvQAkIyM
SziVKDwNPnwKBCBpFX7D51yMRkovs/nYtP4ciamO4WxFZoEaIWrdIwLWLGMrKTVD
dEhzE0gTOqQVz2sg37Tithcr+omnf8jkWTVPtVcgzbydUjgs+D/Y8amTptubhHwC
f9Yj/IB7jHOufNPH9w2N
=O4zE
-----END PGP SIGNATURE-----

--Apple-Mail=_44581609-1067-4B62-8EAF-14BE67594A67--
