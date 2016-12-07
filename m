Received: from eggs.gnu.org ([2001:4830:134:3::10]:32997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cEZ9O-0001Ig-5X
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 05:08:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cEZ9N-0002l8-4g
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 05:08:34 -0500
Date: Wed, 7 Dec 2016 11:08:24 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20161207100824.GB4773@noname.str.redhat.com>
References: <1480973521-28945-1-git-send-email-jcody@redhat.com>
	<20161206100457.GI12630@stefanha-x1.localdomain>
	<f8b4793b-9125-289b-43f4-ac2a98086ae8@redhat.com>
	<9f10d665-2fc4-8804-a620-f9433b9e524a@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <9f10d665-2fc4-8804-a620-f9433b9e524a@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PULL for-2.8 0/3] Block patches for
 -rc3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Jeff Cody <jcody@redhat.com>, stefanha@redhat.com, peter.maydell@linaro.org, Prasanna Kumar Kalever <prasanna.kalever@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 06.12.2016 um 16:43 hat Eric Blake geschrieben:
> On 12/06/2016 09:11 AM, Eric Blake wrote:
>=20
> >> BlockdevOptionsGluster.debug(-level) does not have "Added in 2.8" so I
> >> had to dig through git-blame(1) to verify that it was indeed added in
> >> the current release cycle.
> >=20
> > Then that implies we should add yet one more patch that adds the
> > appropriate versioning information to all the gluster fields added for
> > 2.8.  My reviewed-by was given on the assumption that debug was in 2.7
> > and that this was a break from 2.7 behavior, but that we already KNOW
> > we're breaking blockdev-add between 2.7 and 2.8; while your argument is
> > that there is no backwards incompatibility because it was not in 2.7 to
> > begin with.  I think both reasons are indeed acceptable, but it also
> > means that my reason was flawed because of the incomplete documentation.
>=20
> I checked again.  'git diff v2.7.0..origin qapi/*.json' shows:
>=20
>  ##
> -# @BlockdevOptionsGluster
> +# @BlockdevOptionsGluster:
>  #
>  # Driver specific block device options for Gluster
>  #
> @@ -2140,7 +2195,9 @@
>  #
>  # @server:      gluster servers description
>  #
> -# @debug-level: #optional libgfapi log level (default '4' which is Error)
> +# @debug:       #optional libgfapi log level (default '4' which is Error)
> +#
> +# @logfile:     #optional libgfapi log file (default /dev/stderr)
> (Since 2.8)
>  #
>  # Since: 2.7
>  ##
> @@ -2148,25 +2205,163 @@
>    'data': { 'volume': 'str',
>              'path': 'str',
>              'server': ['GlusterServer'],
> -            '*debug-level': 'int' } }
> +            '*debug': 'int',
> +            '*logfile': 'str' } }
>=20
> So I was right after all - this IS a backwards-incompatible change (and
> NOT something that was introduced only in 2.8) - but I still argue that
> the change is appropriate NOW (but not later) because blockdev-add is
> the only client of this type in QMP, and that command changed
> backwards-incompatibly at the same time.

I don't completely understand the change anyway. 'debug-level' is the
better name, and if the command line doesn't agree, change that one or
grudgingly accept both. But I think we can just change the command line,
it's only a debug option.

Kevin

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYR9+YAAoJEH8JsnLIjy/WjNUP/16w6I1RwHb/GTutEYCbI6u0
xpsv7cwaXb6v+WygEjCCJeRRYBCTPAk0y18HMq6AFzoTxGdWsVH+a2AhqP3Ue6rv
xAkcrozNM8J4N02UY9B9cF+hi+Q/yM8BAUPQJ0hBhsiFdsBY8IAR/P0aK2iiA1Ib
cy+/BqhE1ThmP710+DpeM4WnLvTo/LsuANF1oyNjnJo7KbiSfyZu/RKcJUmWKj0Z
SjVHr7l5942k8xifJ+GpW1jLkhmIiEQrDSeHpy/9eVgFh1nQJ//8RpVNTY1XuGWG
tQ1XnNJxftUosMnry/l3aDfDjgvt7GxjkTa8NQp0gLBJ3VhmW3nEDBtqVgR0n5Qh
udzVT8cbY1Gg3aE814LSlQ6/akhNlDE4LgEBwdH0LSFLYYvibqPBtMrC02bba5tG
aOtjwrM08RkfmTdyVt1o/m2cu0rOR4A33P5A9YLUsXpXkA1BThx0PabW8ZBdbDal
Re8Of+vTCkHmTEYMjKnJMYxELs89EO3oumGgUW4FlJzVtaiKjIWYYVhRCJqpbcG3
48ASKUZZ4IfXnjreyHaOjhXqZRN1Co1igSicA7SjNFZrrfGOcbLjZ5LyJ8KCsE0H
pCQoDchiT8S+h67/eKUfg6I5CozSdCifdQGsrCv7Vg+NpuCQ/L9cK2WokOC9IBvR
m5Me6s9TiDJG3pMgwqV7
=5k/A
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
