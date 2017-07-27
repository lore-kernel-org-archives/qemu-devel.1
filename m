Received: from eggs.gnu.org ([2001:4830:134:3::10]:47334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dahF6-0003x6-4J
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 07:46:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dahF1-0005Fp-V1
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 07:46:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1dahF1-0005DA-LM
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 07:46:07 -0400
References: <1499952476-3454-1-git-send-email-armbru@redhat.com>
	<1499952476-3454-7-git-send-email-armbru@redhat.com>
	<20170717101906.GC5301@noname.redhat.com>
	<87a842b9yo.fsf@dusky.pond.sub.org>
	<87bmoauz2s.fsf@dusky.pond.sub.org>
	<5b194736-15ba-7f62-cc8b-46cf03777644@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <aac1e2cd-6d0a-f09f-7bcd-c701607b01a3@redhat.com>
Date: Thu, 27 Jul 2017 13:45:25 +0200
MIME-Version: 1.0
In-Reply-To: <5b194736-15ba-7f62-cc8b-46cf03777644@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bfJWOdx4rueH3gKMxGOVAdbT2xc55VwDQ"
Subject: Re: [Qemu-devel] [PULL 6/9] Convert error_report() to warn_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Marcelo Tosatti <mtosatti@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Rob Herring <robh@kernel.org>, Josh Durgin <jdurgin@redhat.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Marcel Apfelbaum <marcel@redhat.com>, Richard Henderson <rth@twiddle.net>, Jeff Cody <jcody@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Peter Lieven <pl@kamp.de>, Greg Kurz <groug@kaod.org>, Alistair Francis <alistair.francis@xilinx.com>, Peter Chubb <peter.chubb@nicta.com.au>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Cornelia Huck <cohuck@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, "An eesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bfJWOdx4rueH3gKMxGOVAdbT2xc55VwDQ
From: Max Reitz <mreitz@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Rob Herring <robh@kernel.org>, Josh Durgin <jdurgin@redhat.com>,
 Alexander Graf <agraf@suse.de>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Marcel Apfelbaum <marcel@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Jeff Cody <jcody@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Peter Lieven <pl@kamp.de>, Greg Kurz <groug@kaod.org>,
 Alistair Francis <alistair.francis@xilinx.com>,
 Peter Chubb <peter.chubb@nicta.com.au>, Stefan Hajnoczi
 <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Peter Crosthwaite <crosthwaite.peter@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>,
 "An eesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Message-ID: <aac1e2cd-6d0a-f09f-7bcd-c701607b01a3@redhat.com>
Subject: Re: [Qemu-devel] [PULL 6/9] Convert error_report() to warn_report()
References: <1499952476-3454-1-git-send-email-armbru@redhat.com>
 <1499952476-3454-7-git-send-email-armbru@redhat.com>
 <20170717101906.GC5301@noname.redhat.com> <87a842b9yo.fsf@dusky.pond.sub.org>
 <87bmoauz2s.fsf@dusky.pond.sub.org>
 <5b194736-15ba-7f62-cc8b-46cf03777644@redhat.com>
In-Reply-To: <5b194736-15ba-7f62-cc8b-46cf03777644@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-07-24 09:30, Paolo Bonzini wrote:

[...]

> * it only runs the "quick" group, but I think we should reverse the
> direction and mark slow tests specifically (that would cut about 10
> minutes out of the 20).
Side note: tmpfs speeds things up quite a bit.  Running all qcow2 tests
(except for 142 which requires writethrough caching) takes 5:27 min for
me there.

(And since I usually run nbd and raw tests concurrently, it's not too
bad...)

Max


--bfJWOdx4rueH3gKMxGOVAdbT2xc55VwDQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZedJVEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQOcc
CACUNFlUWbUN2bxtaes0Dm53Uk/kMJhmJQ2M6WFoPdNMSUoEPTK0cMZ2Lm2j8nN+
Px9vCAPY0Gvo6ZT7VWjSVqhqp92Q8OsOaFJUZYAS8IIowa0B6uV8ZY29JBhHBvWC
2VaJ1/kiErbJAjIRN3HvoSLSBZoraZavn2uaxH9Ci6jAjjqskwjemm/fBLz6vU5q
9V5/eVF3Q9GG8OBLpyn7N17YPItBUjUir1LyYFqnTCm1Ll7Sqy5CH/h1aB4ycxWp
JQiURcexFxHdrU5P5GsGK0gOz/GpQsqE64vl8RbMXC8nzh71QkCnRzZMT6GQhfjK
whuCFUFlWW+XAKqF+awQ2dY7
=g59r
-----END PGP SIGNATURE-----

--bfJWOdx4rueH3gKMxGOVAdbT2xc55VwDQ--
