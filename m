Received: from eggs.gnu.org ([2001:4830:134:3::10]:59784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEHRc-0006gM-U7
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 11:18:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEHRc-0001yb-6r
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 11:18:44 -0500
References: <20171110172545.32609-1-mreitz@redhat.com>
	<e4501a6c-3643-d0cb-4b6f-a6569646edad@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f5de0e4f-e561-c03a-d793-d205d6015ed0@redhat.com>
Date: Mon, 13 Nov 2017 17:18:27 +0100
MIME-Version: 1.0
In-Reply-To: <e4501a6c-3643-d0cb-4b6f-a6569646edad@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WEdnkHkbOD4mLUFg7US9oIgEc61tNlD4b"
Subject: Re: [Qemu-devel] [PATCH v2 for-2.11] block: Make bdrv_next() keep
 strong references
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WEdnkHkbOD4mLUFg7US9oIgEc61tNlD4b
From: Max Reitz <mreitz@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <f5de0e4f-e561-c03a-d793-d205d6015ed0@redhat.com>
Subject: Re: [PATCH v2 for-2.11] block: Make bdrv_next() keep strong
 references
References: <20171110172545.32609-1-mreitz@redhat.com>
 <e4501a6c-3643-d0cb-4b6f-a6569646edad@redhat.com>
In-Reply-To: <e4501a6c-3643-d0cb-4b6f-a6569646edad@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-11 01:08, Paolo Bonzini wrote:
> On 10/11/2017 18:25, Max Reitz wrote:
>>          if (bs) {
>> +            bdrv_ref(bs);
>> +            bdrv_unref(old_bs);
>>              return bs;
>>          }
>=20
> Maybe instead goto...
>=20
>>          it->phase =3D BDRV_NEXT_MONITOR_OWNED;
>> +    } else {
>> +        old_bs =3D it->bs;
>>      }
>> =20
>>      /* Then return the monitor-owned BDSes without a BB attached. Ign=
ore all
>> @@ -467,18 +483,46 @@ BlockDriverState *bdrv_next(BdrvNextIterator *it=
)
>>          bs =3D it->bs;
>>      } while (bs && bdrv_has_blk(bs));
>=20
> ... here?

I wouldn't mind too much, but I don't think a goto there makes the code
easier to read.

Max

> Paolo
>=20
>> +    if (bs) {
>> +        bdrv_ref(bs);
>> +    }
>> +    bdrv_unref(old_bs);
>> +
>>      return bs;
>=20



--WEdnkHkbOD4mLUFg7US9oIgEc61tNlD4b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloJxdMSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ApbkH/0DDxm365b5Tss2Y4PxyzAko3TlnOsjd
xSyieIec5iuQY3ptZKglLnix6oj79z1sDd5czu//slFQ1iMKNQfuK9Xx/fTCFtOV
wGG7Y7n0sbHKX7QohGOBW8IU1fzB0d5Gj4cG/EnbsfUFF2XcLTnv097gp9ZzO1L6
57UxS4J0VogI226k2WAVVTPpP2cZWzf977s0R4ljf0fw/hTF/cA/fnucjgAtC0bz
qK6Z3FCS5ciqUp1CYtGqtip+s1XDQB66Xuu+h3/UWKy92Chzdc+jVmSe3oaaK9MF
lo6dpIfRhB9ASIOut8yIoUXEWeucwYzeJYfghAw1YMfn3FgHAGR4bsM=
=cFeF
-----END PGP SIGNATURE-----

--WEdnkHkbOD4mLUFg7US9oIgEc61tNlD4b--
