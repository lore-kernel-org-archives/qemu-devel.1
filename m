Received: from eggs.gnu.org ([2001:4830:134:3::10]:40730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dQDdQ-0000m0-Gk
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 10:08:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dQDdP-0007fp-ML
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 10:08:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1dQDdP-0007fX-FW
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 10:07:59 -0400
Date: Wed, 28 Jun 2017 16:07:52 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170628140752.GG5378@noname.redhat.com>
References: <20170615163813.7255-1-stefanha@redhat.com>
	<20170615163813.7255-4-stefanha@redhat.com>
	<b1a33e94-b32b-c6ca-c526-6dbb201a25b1@redhat.com>
	<20170628125704.GF5378@noname.redhat.com>
	<4065d2bb-0960-e3fe-c703-692db091aa62@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XMCwj5IQnwKtuyBG"
Content-Disposition: inline
In-Reply-To: <4065d2bb-0960-e3fe-c703-692db091aa62@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/5] qemu-iotests: 068: extract _qemu()
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Pavel Butsykin <pbutsykin@virtuozzo.com>


--XMCwj5IQnwKtuyBG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 28.06.2017 um 16:02 hat Eric Blake geschrieben:
> On 06/28/2017 07:57 AM, Kevin Wolf wrote:
> > Am 27.06.2017 um 13:40 hat Eric Blake geschrieben:
> >> On 06/15/2017 11:38 AM, Stefan Hajnoczi wrote:
> >>> Avoid duplicating the QEMU command-line.
> >>>
> >>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> >>> ---
> >>>  tests/qemu-iotests/068 | 13 ++++++++-----
> >>>  1 file changed, 8 insertions(+), 5 deletions(-)
> >>>
> >>
> >>> +# Give qemu some time to boot before saving the VM state
> >>> +bash -c 'sleep 1; echo -e "savevm 0\nquit"' | _qemu
> >>
> >> Are we sure that 'bash' on PATH is the same as the /bin/bash running t=
he
> >> script?
> >=20
> > Do we even need to explicitly call bash here? Doesn't this do the same
> > as far as this test case is concerned?
> >=20
> >     ( sleep 1; echo "..." ) | _qemu
>=20
> Or save a process:
>=20
> { sleep 1; echo "..."; } | _qemu

Ah, I knew that something like this must work. I missed the semicolon...

Kevin

--XMCwj5IQnwKtuyBG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZU7g4AAoJEH8JsnLIjy/WV7wP/AxSQ/XNaaZllGFbQQRCJcCe
+b9DHPO7KcaBO3tVtvM+YWQoYmK+WBbbU5eF4pb7KZ25k89+0GPdU3boRpGcnnVO
kWMzs4asHInBYtfF8iuQKNjl4LoXnVO5CnSUXszdJEkMtALKgSpG/VqsriRrGXl1
ysEavoPOxrkL91DAwfRVokDrh59g1CcXa60Mh+5YGBW5r/QPla3IXBQQsiEnotCK
2zXEWS8sYLEaj74elvkn/rlqNDwjdU+v1tF9fCmUg9P60BLStR/BdbVirYuBA4Vk
RtSb5OEGtwXWEH1UYfZ9FVtTslhSMI46iV/qUuGp2jshyXf51Xe+07uoVsB/uuzF
mSv93fSXaMUr36sD+qWGtBAc+oYHdPKuEvRmyPuj7CtgI5u/8uPCmCSpxGNUEcRq
uyfz3GOVDC9kUaM/mX8Q1ICABR2HLe09xnkAzBQ+MNTOIdBeepkGaTQ2uKBwVgPC
98812sz72ZNBTPO34FxfxE5sr2/FCgsMW6kyy32TYVe+LxMo/bNfIPpRGfRkp6Wa
WejEvM8eolPdM2Sy/hx6pOhDxVA3A2FNehbzziCpLcf2t86a16o/53l9LapMPccO
CzpuXXcMtTwBfq9bXPvU/zzXDj4Hx71Xm/BH3wT8jysFG9wVd+5fzObbpTj4AfaE
j2STUgl0fu9UlmhqsUtU
=H3FR
-----END PGP SIGNATURE-----

--XMCwj5IQnwKtuyBG--
