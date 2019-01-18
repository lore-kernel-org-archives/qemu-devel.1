Received: from eggs.gnu.org ([209.51.188.92]:33734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkWhj-0005oQ-6D
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 11:09:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkWhZ-0007Hg-4m
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 11:09:03 -0500
References: <20190117193658.16413-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <39599bab-cf0f-80d1-a9f4-d7735da2fe28@redhat.com>
Date: Fri, 18 Jan 2019 10:08:26 -0600
MIME-Version: 1.0
In-Reply-To: <20190117193658.16413-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kAT7CinLnBqX9yGLPTCnDN9vtEqDtjKs8"
Subject: Re: [Qemu-devel] [PATCH v4 00/21] nbd: add qemu-nbd --list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: nsoffer@redhat.com, vsementsov@virtuozzo.com, jsnow@redhat.com, rjones@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kAT7CinLnBqX9yGLPTCnDN9vtEqDtjKs8
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: nsoffer@redhat.com, vsementsov@virtuozzo.com, jsnow@redhat.com,
 rjones@redhat.com, qemu-block@nongnu.org
Message-ID: <39599bab-cf0f-80d1-a9f4-d7735da2fe28@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 00/21] nbd: add qemu-nbd --list
References: <20190117193658.16413-1-eblake@redhat.com>
In-Reply-To: <20190117193658.16413-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/17/19 1:36 PM, Eric Blake wrote:
> I got tired of debugging whether a server was advertising the
> correct things during negotiation by inspecting the trace
> logs of qemu-io as client - not to mention that without SOME
> sort of client tracing particular commands, we can't easily
> regression test the server for correct behavior.  The final
> straw was at KVM Forum, when Nir asked me to make sure there
> was a way to easily determine if an NBD server is exposing what
> we really want (and fixing x-dirty-bitmap to behave saner fell
> out as a result of answering that question).
>=20
> I note that upstream NBD has 'nbd-client -l $host' for querying
> just export names (with no quoting, so you have to know that
> a blank line means the default export), but it wasn't powerful
> enough, so I implemented 'qemu-nbd -L' to document everything.
> Upstream NBD has separate 'nbd-client' and 'nbd-server' binaries,
> while we only have 'qemu-nbd' (which is normally just a server,
> but 'qemu-nbd -c' also operates a second thread as a client).
> Our other uses of qemu as NBD client are for consuming a block
> device (as in qemu-io, qemu-img, or a drive to qemu) - but those
> binaries are less suited to something so specific to the NBD
> protocol.
>=20
> Bonus: As a result of my work on this series, nbdkit now supports
> NBD_OPT_INFO (my interoperability testing between server
> implementations has been paying off, both at fixing server bugs,
> and at making this code more reliable across difference in valid
> servers).
>=20
> Also available at:
> https://repo.or.cz/qemu/ericb.git qemu-nbd-list-v4

Vladimir spotted a few more tweaks to make, but they all look
sufficiently minor that I'll go ahead and queue this on my NBD tree for
a pull request on Monday, rather than posting a v5, if there aren't any
other major comments in the meantime.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--kAT7CinLnBqX9yGLPTCnDN9vtEqDtjKs8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxB+foACgkQp6FrSiUn
Q2rNnwf/Q2FTN1gBYq97WnN/MGCqElADDyGCZqP2oAjy8GOobm5ZIZjqioOCfyjz
y0R48BkzXidJ0u9OQKXIsq321YmUYbGpWs2Kh2/0ZXrHKNSWm87TjHQ2wDTlhOKf
FL2ekVXbtMY7WLjsRp9TxTWwcXB04ZNNeZ+jdavcDoDapLe/iPbt3IN0C+V3wJ05
hYMJtvghLnKbeM9z8kIBClfd1Xch6EAjBj1DC2dLXoycoCJdAcZuN8YfrDpzCgkg
xmiAhvhDXA5ncAUQH86lNNVhK9afc/ipsSXptntdFPIXBGZNLz5zdLn5ELuhwG3h
ngwZeCOtVGxi4unH4n2d9KGBWJcjZQ==
=8qP/
-----END PGP SIGNATURE-----

--kAT7CinLnBqX9yGLPTCnDN9vtEqDtjKs8--
