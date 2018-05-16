Received: from eggs.gnu.org ([2001:4830:134:3::10]:54919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIz59-00069N-KQ
	for qemu-devel@nongnu.org; Wed, 16 May 2018 12:15:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIz58-00008d-Or
	for qemu-devel@nongnu.org; Wed, 16 May 2018 12:15:15 -0400
Date: Wed, 16 May 2018 18:15:04 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180516161504.GE4435@localhost.localdomain>
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-39-kwolf@redhat.com>
	<3b126693-5a80-9265-acd7-944ef0984a30@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fba/0zbH8Xs+Fj9o"
Content-Disposition: inline
In-Reply-To: <3b126693-5a80-9265-acd7-944ef0984a30@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 38/42] job: Add JOB_STATUS_CHANGE QMP event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Am 15.05.2018 um 00:11 hat Max Reitz geschrieben:
> You forgot to adjust 094, and although I cannot prove it (I don't have
> an nfs setup handy right now), I have a hunch that this patch breaks 173
> as well.

NFS qemu-iotests look completely broken. And the block driver, too. I've
sent a fix for the block driver at least...

Not sure how the qemu-iotests are supposed to work, but I get messages
like these:

+mkdir: cannot create directory 'nfs://127.0.0.1//home/kwolf/source/qemu/tests/qemu-iotests/scratch': No such file or directory
+common.config: Error: $TEST_DIR (nfs://127.0.0.1//home/kwolf/source/qemu/tests/qemu-iotests/scratch) is not a directory

I guess I'm okay with breaking 173 in this series when the NFS tests are
in this state...

Kevin

--Fba/0zbH8Xs+Fj9o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJa/FkIAAoJEH8JsnLIjy/WOa8QALOrZ/aMIksGnDmVuSvuY9ag
bhfdwLqAtX5fpNGBTgPcf2AiZChniYfJP8DwqdRObXYzTGbmpwkewdsge06s/vm7
mpnRZlp6kp+A/khc0RF6/wb7CFECNZ1d720NHWbhM0kyj5j84FljbDW4cdht2+4+
THmoq2xmpCgyXdUiYRy4DdolmoDnOrJuGepGPbmwLErISBnKwBGMeISSCX/wWewq
BXxwdgYjv4l9/M72B1ky5rudbRFXX7goXxIAS6fcIr703idO5UkjyZSe+mPrHKZI
fWxl6XECwYsU1F9Bk8O3ixcgUXdK4xvGDzJAiR6FwXduOK/Rh3wn7WQ6jivhcAcU
KTMdkb0sFaNqWOrgZRtBscjzt5O6zymxqC4Y3qcbRwEF2MWs9Ah3fpYvFtbKZmA9
xCJobaD+4v5woFEdQqSG68KVTL416OwOwHJA4eefM7dUx0mct4R/2vlb4kvQWQ2r
pXSEUtXOcU7+fNAnIhEbH7BL+oThoF7EI5Lrnls1eaivjp4b2ZnAx5XMNozGCq7Z
OgpGEMG4qb7XYmfjvd6MsaIb9h+QBSmB0IqfXAQwXjRmRjuh64kBAOGIHpHedyVV
SE6+cEF3C6XGcuxoLVB7LhOE3G1dsL+5/hQDxr/fqVCpGou0Yo+XLUBYBwwAm8kv
AszN8VSgwpfUWucXIy3A
=vwIV
-----END PGP SIGNATURE-----

--Fba/0zbH8Xs+Fj9o--
