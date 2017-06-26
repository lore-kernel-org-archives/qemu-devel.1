Received: from eggs.gnu.org ([2001:4830:134:3::10]:43794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dPV63-0005ax-FN
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 10:34:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dPV60-0001z7-8O
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 10:34:35 -0400
Date: Mon, 26 Jun 2017 15:34:28 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170626143428.GD29664@stefanha-x1.localdomain>
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
	<20170623124700.1389-4-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/unnNtmY43mpUSKx"
Content-Disposition: inline
In-Reply-To: <20170623124700.1389-4-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH RFC v3 3/8] block: add
 throttle block filter driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>


--/unnNtmY43mpUSKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 23, 2017 at 03:46:55PM +0300, Manos Pitsidianakis wrote:
> +    qemu_co_queue_init(&tgm->throttled_reqs[0]);
> +    qemu_co_queue_init(&tgm->throttled_reqs[1]);

Where is reqs_lock initialized?

It would be cleaner to move the throttled_reqs[] and reqs_lock
initialization into the tgm registration function.  That way it's done
in a single place.

--/unnNtmY43mpUSKx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZURt0AAoJEJykq7OBq3PI7KwIAMhCyq4bTVo/+Kp+yJT+7CJE
Y4VnNcEhm3g4SUvMMtJLlUxcWpZm9AfjU5zjpKm9SO8ckPzH7qmZcJhYX1smnc1G
fHfDwVf9pm/bnJ+2GHocaoYjbSZEmyNOEHl3JV/Gbbube58HYbPLvV1BvEjVmRY9
H/w4gdGrjqqMCUtjwsmrPQWW9IX5rQiUmKD4ulQlkM9LGagVOfPbtCsOT7HpklvW
W/CMsr2tUzAt0Cc1+M+jTSr6Y8kbCQ2zQwzOq/xwfFPU15/tBSB/GvpczrUIxCRD
2lAEMG+tbmahT4oLjqkoDontTfMPxOXsEF1H1JxO7PwuWgeJkyeRrFdL6VcG8XE=
=iYbU
-----END PGP SIGNATURE-----

--/unnNtmY43mpUSKx--
