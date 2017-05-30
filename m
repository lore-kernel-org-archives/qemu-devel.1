Received: from eggs.gnu.org ([2001:4830:134:3::10]:34664)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dFgu5-0006T7-N3
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:09:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dFgu1-0001vW-N4
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:09:41 -0400
Received: from mout.gmx.net ([212.227.15.18]:50383)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1dFgu1-0001vL-A9
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:09:37 -0400
References: <20170526054013.299-1-n54@gmx.com>
	<20170530062022.5841-1-n54@gmx.com>
	<58d04e43-1caa-f623-44fe-749dd351fad9@redhat.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <42633e66-7ef4-c4ef-18d3-d2be588b816c@gmx.com>
Date: Tue, 30 May 2017 15:11:25 +0200
MIME-Version: 1.0
In-Reply-To: <58d04e43-1caa-f623-44fe-749dd351fad9@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GNRanclUi6IWTKL7rOnutXbLLxuLLhDR6"
Subject: Re: [Qemu-devel] [PATCH] ivshmem-server: ivshmem-client: Build when
 eventfd() is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, marcandre.lureau@gmail.com, armbru@redhat.com, f4bug@amsat.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GNRanclUi6IWTKL7rOnutXbLLxuLLhDR6
From: Kamil Rytarowski <n54@gmx.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, marcandre.lureau@gmail.com, armbru@redhat.com,
 f4bug@amsat.org
Message-ID: <42633e66-7ef4-c4ef-18d3-d2be588b816c@gmx.com>
Subject: Re: [Qemu-devel] [PATCH] ivshmem-server: ivshmem-client: Build when
 eventfd() is available
References: <20170526054013.299-1-n54@gmx.com>
 <20170530062022.5841-1-n54@gmx.com>
 <58d04e43-1caa-f623-44fe-749dd351fad9@redhat.com>
In-Reply-To: <58d04e43-1caa-f623-44fe-749dd351fad9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 30.05.2017 14:53, Eric Blake wrote:
> On 05/30/2017 01:20 AM, Kamil Rytarowski wrote:
>> Currently ivshmem requires eventfd() which is Linux specific.
>> Do not and build it unconditionally on every Linux/BSD/Solaris.
>>
>> This patch indirectly fixes build failure on NetBSD, where these tools=

>> additionally require -lrt for shm_open(3). In future there should be
>> added support for NetBSD and the linking addressed appropriately.
>=20
> Is this a v2 patch? If so, it's best to repost it as a new top-level
> thread rather than buried in reply to your v1 patch.  Also, be sure to
> include v2 in the subject line ('git send-email -v2' works wonders for
> that).
>=20

I reworked it, fixed title and it's more like v3.

>>
>> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>> ---
>=20
> It also helps in a v2 submission to list here, after the --- separator,=

> how it differs from v1.
>=20
> More submission hints at http://wiki.qemu.org/Contribute/SubmitAPatch
>=20

Do I still need to resend it?


--GNRanclUi6IWTKL7rOnutXbLLxuLLhDR6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZLW+LAAoJEEuzCOmwLnZs79QP/1jD0oseT0GjmF2v2UazGckf
qbZvuzqyAxxGyN7aNj7EFFzuSnAxe0oa8bppdg3cJ8sNpEviDJxGzqVWGTljHY6t
+fRjRtwG+0Qk+3HU+62CGX7+AQGLnnqDJ9JSBBLW9lU2dvg7CrgnbvPsJKx738gH
9u7z+U3lMPTlTqJxc5JOx7Lz94OGvQOpdsfIsyLf+GrKBFGGbohekropHHWByO60
mXCzm5pyImObIIEGu5XQ1y8bhu8IagG8y+GsJpp+6lYMvZHbWoBG+VAkq9d0rl0r
GTVf0h5Mn7N8hrn3+NMrnHI6zEhhS8f3LgLI7Al4sHiwYN5Eg6I36z3XZh332bKe
uogiIH0IaoiWGZ2ZcA4Rl8PtRBDi/0627tEwIJ7AnJGhZ8rrQ5fwO0DwKnfeAZTD
Psa8RFZPGGddD940MAfMPumzSSI3gCliu+Ectf6n0VaqaUkavsz42zbA3il3Nlmt
uI0dUp+yOu6R2Fngj0krV3+Nf/crstSqEiAo2SKzk6+wlCEocmNtgmLYTcnMssF5
R0095jcuUBrnq39N8xonI41Ad5xNPh8h6wHZ3lMvlyFIikzrFIanByo2yVrk0L+H
nXQeQulPP6RfDe6fuH4MQqkFIFuGxPReLYNr5De2PN2yT4uEwFllvWwWWE3Qa5Mi
bHrVciI7y6wZFC9HFzoM
=VqCq
-----END PGP SIGNATURE-----

--GNRanclUi6IWTKL7rOnutXbLLxuLLhDR6--
