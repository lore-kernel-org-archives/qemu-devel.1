Received: from eggs.gnu.org ([209.51.188.92]:51750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gh3wt-0004EY-Kp
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 21:50:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gh3wk-00066P-Nv
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 21:50:29 -0500
References: <20181221093529.23855-1-jsnow@redhat.com>
	<20181221093529.23855-12-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <75df53be-82e9-dd50-1275-66c3d966257e@redhat.com>
Date: Tue, 8 Jan 2019 20:50:08 -0600
MIME-Version: 1.0
In-Reply-To: <20181221093529.23855-12-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iSCrzOEAu35GJmQI7LFatx4oqglBglyOX"
Subject: Re: [Qemu-devel] [PATCH v6 11/11] iotests: add iotest 236 for
 testing bitmap merge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Fam Zheng <fam@euphon.net>, vsementsov@virtuozzo.com, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iSCrzOEAu35GJmQI7LFatx4oqglBglyOX
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 vsementsov@virtuozzo.com, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <75df53be-82e9-dd50-1275-66c3d966257e@redhat.com>
Subject: Re: [PATCH v6 11/11] iotests: add iotest 236 for testing bitmap merge
References: <20181221093529.23855-1-jsnow@redhat.com>
 <20181221093529.23855-12-jsnow@redhat.com>
In-Reply-To: <20181221093529.23855-12-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/21/18 3:35 AM, John Snow wrote:
> New interface, new smoke test.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/qemu-iotests/236     | 161 +++++++++++++++++
>  tests/qemu-iotests/236.out | 351 +++++++++++++++++++++++++++++++++++++=

>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 513 insertions(+)
>  create mode 100755 tests/qemu-iotests/236
>  create mode 100644 tests/qemu-iotests/236.out
>=20
> diff --git a/tests/qemu-iotests/236 b/tests/qemu-iotests/236
> new file mode 100755
> index 0000000000..79a6381f8e
> --- /dev/null
> +++ b/tests/qemu-iotests/236

> +    log('\n--- Submitting & Aborting Merge Transaction ---\n')

You updated the test but forgot to update 236.out:

236         - output mismatch (see 236.out.bad)
--- /home/eblake/qemu/tests/qemu-iotests/236.out	2019-01-08
17:16:10.938311529 -0600
+++ /home/eblake/qemu/tests/qemu-iotests/236.out.bad	2019-01-08
20:46:21.240645478 -0600
@@ -37,7 +37,7 @@
   }
 }

---- Submitting Bad Transaction ---
+--- Submitting & Aborting Transaction ---

 {
   "execute": "transaction",
@@ -201,7 +201,7 @@
   }
 }

---- Submitting Bad Merge ---
+--- Submitting & Aborting Merge Transaction ---

 {
   "execute": "transaction",


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--iSCrzOEAu35GJmQI7LFatx4oqglBglyOX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlw1YWAACgkQ3g5py3or
ov3sRwgAnD523Q/PfW2rlgnZ6i24nYG2ZYMd55V4jgKOaHekKNpGnGTOzw3fiB6u
dcspjzGEuvxmu6IloaYV7AwWDbK8hsEgxp1SvkoPqpBhkKJLilIyhhSR0adlNBNC
9dV2SSBF9shY5dxa9ILjJB28zHsd8HGRqYo5nF/jshfNdwoc7ypSjokW75TzIyhR
K70Ptm3nEC38P3c/CR0vssDYPIpvxpXteC303UBUKBNmyY9VFyzdXmIWjW6jmSy1
/tZeOFwnDaIdATDH50yOq1W+Ln3JxCx6VK742HgkDMmj2YfTg2BNGVM3X7KBqQWU
wWY4nefauOW0yxcwKlbhLp+BdGaEFA==
=QSPZ
-----END PGP SIGNATURE-----

--iSCrzOEAu35GJmQI7LFatx4oqglBglyOX--
