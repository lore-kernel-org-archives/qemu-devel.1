Received: from eggs.gnu.org ([2001:4830:134:3::10]:40806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dhWfM-0006kv-6I
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 03:53:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dhWfL-0001y7-G7
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 03:53:32 -0400
Date: Tue, 15 Aug 2017 10:52:48 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170815075248.jannlmluiknk7onp@postretch>
References: <20170815061921.31596-1-el13635@mail.ntua.gr>
	<20170815061921.31596-2-el13635@mail.ntua.gr>
	<3b7fc9da-ac71-8a37-ed3d-34428021e4d3@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vogrbufdhnjwg5fy"
Content-Disposition: inline
In-Reply-To: <3b7fc9da-ac71-8a37-ed3d-34428021e4d3@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] block: use internal filter node in
 backup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>


--vogrbufdhnjwg5fy
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15, 2017 at 10:44:15AM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
>15.08.2017 09:19, Manos Pitsidianakis wrote:
>>block/backup.c currently uses before write notifiers on the targeted
>>node. We can create a filter node instead to intercept write requests
>>for the backup job on the BDS level, instead of the BlockBackend level.
>>
>
>Hi Manos!
>
>Looks interesting but what is the real benefit of it? It doesn't look=20
>like it simplifies the code.. Also, is it affect performance?
>I think it worth describing in commit message.

The goal is to refactor the block layer into being more modular instead=20
of having hard coded features. I don't suspect this will have any kind=20
of performance gains, this is a minor change. Before write notifiers are=20
not needed if you can intercept the write requests on the way.

--vogrbufdhnjwg5fy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlmSqFAACgkQc2J8L2kN
9xCYIRAAhn/i5Km65X/OFLL0+oaUCmeHDQRuO8+KctKQ5A6l6Ljgcjh6zvSHFAVj
B2MTSi9U0J+LI5JXot6b5KGliu30zffQHrlibajyB8dhcLezYBMIc6iaLzX7Li2O
m/wDzPeXEGscan5avUdiO7f5Y2M7xIHrIrFou35zQqRtgd4ayJht/8fcTgsfg0Ih
clsNWAX5kmWyw60CpT3ZJwyKdxujWoEmFNsL/PU9yJxMWKZHpRj5liTk9QTvaDTV
0ozFJeTysb4+Y2HMS/R/Dg1krYVZ8nUXt4Ah2zeeruZbQVt5oefqcGSJTdgwigym
2unpsV40c+bEUDZnFuxYo8v44DVg1dGbnaa2avNJ9hylGj79ZP1N/x76gfteGEU2
bON++bkve7c16BGtDQ/OJ8cdHCdZ2IG19vkjW8fofyCE9vovdEYIH7SwOUi6BDon
CoEjFaRJ8LNidYstog7F2tBqKT5rUP1MH0Ji/uDhio7fPoiLNcbdZg2ab5EWBHHo
KUV2B8kQJWiehNFkdIqrdX9qno2CLtK35Do3VMlrLKQZoTp/wJ+yvkcx2ir+zLYh
vVXpxj+BcRy0sU80DLqZWIWG1TGny//PpUQoco2LAKQV4RckCyNKyeRuc6rswTuE
KmJBKAHK+cjAxzt7chq8qvNcPL7mSIceHG7v1F9dK/1I0Y0wXQE=
=TkYG
-----END PGP SIGNATURE-----

--vogrbufdhnjwg5fy--
