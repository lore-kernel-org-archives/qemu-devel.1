Received: from eggs.gnu.org ([2001:4830:134:3::10]:51485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dwrjo-00083i-FV
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 11:25:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dwrjk-0001Wn-HD
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 11:25:32 -0400
Date: Tue, 26 Sep 2017 17:25:14 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170926152514.GB14717@localhost.localdomain>
References: <20170926142133.2498-1-kwolf@redhat.com>
	<20170926142133.2498-9-kwolf@redhat.com>
	<88194ed0-b5ea-2eef-8294-6557739ae605@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <88194ed0-b5ea-2eef-8294-6557739ae605@redhat.com>
Subject: Re: [Qemu-devel] [PULL 08/24] iotests: Print full path of bad
 output if mismatch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, peter.maydell@linaro.org, qemu-devel@nongnu.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 26.09.2017 um 16:56 hat Eric Blake geschrieben:
> On 09/26/2017 09:21 AM, Kevin Wolf wrote:
> > From: Fam Zheng <famz@redhat.com>
> >=20
> > So it is easier to copy paste the path.
> >=20
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  tests/qemu-iotests/check | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> > index d504b6e455..4583a0c269 100755
> > --- a/tests/qemu-iotests/check
> > +++ b/tests/qemu-iotests/check
> > @@ -353,7 +353,7 @@ do
> >                  else
> >                      echo " - output mismatch (see $seq.out.bad)"
> >                      mv $tmp.out $seq.out.bad
> > -                    $diff -w "$reference" $seq.out.bad
> > +                    $diff -w "$reference" $(realpath $seq.out.bad)
>=20
> This missed my review comments about being unsafe if $PWD contains spaces:
> https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg04241.html

Sorry for missing this. Please send a follow-up patch to fix it.

Kevin

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZynFaAAoJEH8JsnLIjy/WsPoP/0cWG9vRn/E0wtmN2CKz/EKk
0gRgyqvTyyosrEaZ9Zj5+6MsV2XpZsveG+yuRtoZMi3uLLXPzr5kAGph13zk8u2T
SYVwWXdj3jtHB72zPnSXg+v6yWWL7OyzEBOoObz6IY9wiE5NEUODiofxhvcpLQzz
4jLKi3Nlh8dPpLgNt3reAxnZCWL7uRVn+hmrvOZ3hYJeOzjlc+gjT8aDSh+7wsji
oViKGO03lztt3zpTjLHSXIqUjr+HuqmWhIGcMEkSH6yTkPvx1A+XbeE7Rv49wDJ9
YUbe6MJ/uFy6PyrhJv9UUI0Vj3uCLpWWavGd5bVzD7eLPZyHVYneKgxguK8FXn7o
KLQ64CHG0HaMFe/iX2ak3dMDZgLbfXvrg3uWXfCj751cMz8KrWko6bkV4ZeHOq+G
VkSGnnq1ubgPZ5pkmToLI0liJ+EXyohg4iAA+7Nlu+iZChobxWBQ2YzZ2rBRO2VK
XAiAXpDkP6+KP4iHCH/n11syGyDzXxlW+sE+9B5OcwLEee+xPrgMAKjyyTIvoEjm
VvD6EM6UbcwHqmLTqXjdmwgdSGGN3NmlwopZsRde/gZPvFasOK3EDqcXZp29q/7n
o5/B+RQd4+yhq+NK92es+0KHZDrd0SrC370O6hhucbv9kHm4qikQn84l77Jc1j7q
ubMBt6Ciht9XAdLRKmd7
=NlpH
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
