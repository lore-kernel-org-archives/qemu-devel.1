Received: from eggs.gnu.org ([2001:4830:134:3::10]:45949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dVcFn-0003Hn-BZ
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:25:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dVcFm-0001pm-Mb
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:25:55 -0400
Date: Thu, 13 Jul 2017 13:25:43 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170713112543.GC4139@noname.redhat.com>
References: <1499864249-26305-1-git-send-email-kwolf@redhat.com>
	<1499864249-26305-6-git-send-email-kwolf@redhat.com>
	<266aa00c-27cd-2f18-f756-844a9a321de7@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i0/AhcQY5QxfSsSZ"
Content-Disposition: inline
In-Reply-To: <266aa00c-27cd-2f18-f756-844a9a321de7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/9] block: List anonymous device BBs in
 query-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org


--i0/AhcQY5QxfSsSZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 12.07.2017 um 17:47 hat Eric Blake geschrieben:
> On 07/12/2017 07:57 AM, Kevin Wolf wrote:
> > Instead of listing only monitor-owned BlockBackends in query-block, also
> > add those anonymous BlockBackends that are owned by a qdev device and as
> > such under the control of the user.
> >=20
> > This allows to use query-block to inspect BlockBackends for the modern
>=20
> "allows to VERB" is not idiomatic; better is "allows VERBing" (as in
> "allows using query-block"); or "allows SUBJECT to VERB" (as in the
> verbose "allows the client to use query-block").

Is this inconsistency a known problem in English or should we file a new
bug report against it? But as long as this isn't fixed yet, I'll apply
your workaround.

Kevin

--i0/AhcQY5QxfSsSZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZZ1i3AAoJEH8JsnLIjy/WYzEP/1q3KqJLAfJlbrvrqwYVJr+O
ls17a4yh+6/Z3e1Zeehjzi3L1lMqBDLtYsxgmyTqd9NEsfpq6mxmS8Z6rQOy5R2H
cF8PVnop2GB4Ja39cZBgK88xNTMe54L+2tSZNfme/qQWM5Jt5eLnmmgMgTvnzP0v
RP5qn66T/uY9d9PDFNHpK1QAG/QWnra/hmV+pnreFdcwtsXJ8nnPCcrJXcLeTzEP
KehHJy6iizaGZrkuOE7gTiu/YP2V8N5gHAFwA10HOpvoE6aZE28MS9IOac7JDGD1
T9XOeZvxbzZ3k5cm7udSZHgOii1gbn+X/J96Aj7H+ebS/+k/BYwI4umQJW5GC3g/
PRqj2I97LBTGB4qH6TuWWXXLDcopmneeFelnk6HandPQYSPic3nJVzGhV3pf3+3b
5BiO9xj4QnW4sKG7F3ye3vjOgNYq6Pvs+ng3I3g6dl+jqZuzibUHYnq9etG/0OLJ
uMBuStKAGEWQ6k2wXrVtw6NZVVMb6QjKuwvbqZjpt+LV3PCpB9mosGOESm3jtxp3
NIbmA7Ggrg8vIJ2w9ThH9sushQDa+Kcj6K5WPxsmSyJDrpRThSR4Gy0UNOPUzP4I
G2hA4y99d7q5ZHYXuF8K+zUF8rhjAIo2ZKWU6cu865B4E1ZNYR6z+FU17A25iLkV
cCTl+opqg+ZrneoHCn3K
=qvuv
-----END PGP SIGNATURE-----

--i0/AhcQY5QxfSsSZ--
