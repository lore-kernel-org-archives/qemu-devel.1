Received: from eggs.gnu.org ([2001:4830:134:3::10]:37283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eKsIl-0005xG-Ka
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 15:52:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eKsIk-0007li-IE
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 15:52:51 -0500
References: <20171116173810.16457-1-crosa@redhat.com>
	<20171116173810.16457-8-crosa@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c3240848-42bd-4806-2a2d-ac01d28de2a7@redhat.com>
Date: Fri, 1 Dec 2017 21:52:38 +0100
MIME-Version: 1.0
In-Reply-To: <20171116173810.16457-8-crosa@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Gl95q4G8Vdd6WcQ2bkDfDUftv1FFqXR7J"
Subject: Re: [Qemu-devel] [PATCH 07/10] qemu-iotests: remove the concept of
 $seq.full (and boiler plate code)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Gl95q4G8Vdd6WcQ2bkDfDUftv1FFqXR7J
From: Max Reitz <mreitz@redhat.com>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <c3240848-42bd-4806-2a2d-ac01d28de2a7@redhat.com>
Subject: Re: [PATCH 07/10] qemu-iotests: remove the concept of $seq.full (and
 boiler plate code)
References: <20171116173810.16457-1-crosa@redhat.com>
 <20171116173810.16457-8-crosa@redhat.com>
In-Reply-To: <20171116173810.16457-8-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-16 18:38, Cleber Rosa wrote:
> The $seq.full file, in theory, should contain the full output of a
> test error.  In practice, it's only used on a single test, and the
> boiler plate code to clean it up plagues all other tests.
>=20
> Let's remove the concept altogether, and record the failure in the
> output itself for the one test using this function.
>=20
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  tests/qemu-iotests/001 | 1 -
>  tests/qemu-iotests/002 | 1 -
>  tests/qemu-iotests/003 | 1 -
>  tests/qemu-iotests/004 | 1 -
>  tests/qemu-iotests/005 | 1 -
>  tests/qemu-iotests/007 | 1 -
>  tests/qemu-iotests/008 | 1 -
>  tests/qemu-iotests/009 | 1 -
>  tests/qemu-iotests/010 | 1 -
>  tests/qemu-iotests/011 | 1 -
>  tests/qemu-iotests/012 | 1 -
>  tests/qemu-iotests/013 | 1 -
>  tests/qemu-iotests/014 | 1 -
>  tests/qemu-iotests/015 | 1 -
>  tests/qemu-iotests/017 | 1 -
>  tests/qemu-iotests/018 | 1 -
>  tests/qemu-iotests/019 | 1 -
>  tests/qemu-iotests/020 | 1 -
>  tests/qemu-iotests/021 | 1 -
>  tests/qemu-iotests/022 | 1 -
>  tests/qemu-iotests/023 | 1 -
>  tests/qemu-iotests/024 | 1 -
>  tests/qemu-iotests/025 | 1 -
>  tests/qemu-iotests/026 | 1 -
>  tests/qemu-iotests/027 | 1 -
>  tests/qemu-iotests/028 | 1 -
>  tests/qemu-iotests/029 | 1 -
>  tests/qemu-iotests/031 | 1 -
>  tests/qemu-iotests/032 | 1 -
>  tests/qemu-iotests/033 | 1 -
>  tests/qemu-iotests/034 | 1 -
>  tests/qemu-iotests/035 | 1 -
>  tests/qemu-iotests/036 | 1 -
>  tests/qemu-iotests/037 | 1 -
>  tests/qemu-iotests/038 | 1 -
>  tests/qemu-iotests/039 | 1 -
>  tests/qemu-iotests/042 | 1 -
>  tests/qemu-iotests/043 | 1 -
>  tests/qemu-iotests/046 | 1 -
>  tests/qemu-iotests/047 | 1 -
>  tests/qemu-iotests/049 | 1 -
>  tests/qemu-iotests/050 | 1 -
>  tests/qemu-iotests/051 | 1 -
>  tests/qemu-iotests/052 | 1 -
>  tests/qemu-iotests/053 | 1 -
>  tests/qemu-iotests/054 | 1 -
>  tests/qemu-iotests/058 | 1 -
>  tests/qemu-iotests/059 | 1 -
>  tests/qemu-iotests/060 | 1 -
>  tests/qemu-iotests/061 | 1 -
>  tests/qemu-iotests/062 | 1 -
>  tests/qemu-iotests/063 | 1 -
>  tests/qemu-iotests/064 | 1 -
>  tests/qemu-iotests/066 | 1 -
>  tests/qemu-iotests/067 | 1 -
>  tests/qemu-iotests/068 | 1 -
>  tests/qemu-iotests/069 | 1 -
>  tests/qemu-iotests/070 | 1 -
>  tests/qemu-iotests/071 | 1 -
>  tests/qemu-iotests/072 | 1 -
>  tests/qemu-iotests/073 | 1 -
>  tests/qemu-iotests/075 | 1 -
>  tests/qemu-iotests/076 | 1 -
>  tests/qemu-iotests/077 | 1 -
>  tests/qemu-iotests/078 | 1 -
>  tests/qemu-iotests/079 | 1 -
>  tests/qemu-iotests/080 | 1 -
>  tests/qemu-iotests/081 | 1 -
>  tests/qemu-iotests/082 | 1 -
>  tests/qemu-iotests/083 | 1 -
>  tests/qemu-iotests/084 | 1 -
>  tests/qemu-iotests/085 | 1 -
>  tests/qemu-iotests/086 | 1 -
>  tests/qemu-iotests/087 | 1 -
>  tests/qemu-iotests/088 | 1 -
>  tests/qemu-iotests/089 | 1 -
>  tests/qemu-iotests/090 | 1 -
>  tests/qemu-iotests/091 | 1 -
>  tests/qemu-iotests/092 | 1 -
>  tests/qemu-iotests/094 | 1 -
>  tests/qemu-iotests/095 | 1 -
>  tests/qemu-iotests/097 | 1 -
>  tests/qemu-iotests/098 | 1 -
>  tests/qemu-iotests/099 | 1 -
>  tests/qemu-iotests/101 | 1 -
>  tests/qemu-iotests/102 | 1 -
>  tests/qemu-iotests/103 | 1 -
>  tests/qemu-iotests/104 | 1 -
>  tests/qemu-iotests/105 | 1 -
>  tests/qemu-iotests/106 | 1 -
>  tests/qemu-iotests/107 | 1 -
>  tests/qemu-iotests/108 | 1 -
>  tests/qemu-iotests/109 | 1 -
>  tests/qemu-iotests/110 | 1 -
>  tests/qemu-iotests/111 | 1 -
>  tests/qemu-iotests/112 | 1 -
>  tests/qemu-iotests/113 | 1 -
>  tests/qemu-iotests/114 | 1 -
>  tests/qemu-iotests/115 | 1 -
>  tests/qemu-iotests/116 | 1 -
>  tests/qemu-iotests/117 | 1 -
>  tests/qemu-iotests/119 | 1 -
>  tests/qemu-iotests/120 | 1 -
>  tests/qemu-iotests/121 | 1 -
>  tests/qemu-iotests/122 | 1 -
>  tests/qemu-iotests/123 | 1 -
>  tests/qemu-iotests/125 | 1 -
>  tests/qemu-iotests/126 | 1 -
>  tests/qemu-iotests/127 | 1 -
>  tests/qemu-iotests/128 | 1 -
>  tests/qemu-iotests/130 | 1 -
>  tests/qemu-iotests/131 | 1 -
>  tests/qemu-iotests/133 | 1 -
>  tests/qemu-iotests/134 | 1 -
>  tests/qemu-iotests/135 | 1 -
>  tests/qemu-iotests/137 | 1 -
>  tests/qemu-iotests/138 | 1 -
>  tests/qemu-iotests/140 | 1 -
>  tests/qemu-iotests/141 | 1 -
>  tests/qemu-iotests/142 | 1 -
>  tests/qemu-iotests/143 | 1 -
>  tests/qemu-iotests/144 | 1 -
>  tests/qemu-iotests/145 | 1 -
>  tests/qemu-iotests/146 | 1 -
>  tests/qemu-iotests/150 | 1 -
>  tests/qemu-iotests/153 | 1 -
>  tests/qemu-iotests/154 | 1 -
>  tests/qemu-iotests/156 | 1 -
>  tests/qemu-iotests/157 | 1 -
>  tests/qemu-iotests/158 | 1 -
>  tests/qemu-iotests/162 | 1 -
>  tests/qemu-iotests/171 | 1 -
>  tests/qemu-iotests/172 | 1 -
>  tests/qemu-iotests/173 | 1 -
>  tests/qemu-iotests/174 | 9 +++++++--
>  tests/qemu-iotests/175 | 1 -
>  tests/qemu-iotests/176 | 1 -
>  tests/qemu-iotests/178 | 1 -
>  tests/qemu-iotests/181 | 1 -
>  tests/qemu-iotests/182 | 1 -
>  tests/qemu-iotests/183 | 1 -
>  tests/qemu-iotests/184 | 1 -
>  tests/qemu-iotests/185 | 1 -
>  tests/qemu-iotests/186 | 1 -
>  tests/qemu-iotests/187 | 1 -
>  tests/qemu-iotests/188 | 1 -
>  tests/qemu-iotests/189 | 1 -
>  tests/qemu-iotests/190 | 1 -
>  tests/qemu-iotests/191 | 1 -
>  tests/qemu-iotests/192 | 1 -
>  tests/qemu-iotests/195 | 1 -
>  151 files changed, 7 insertions(+), 152 deletions(-)

Looks good, but I guess it would make sense to drop the _fail function
from common.rc then, too.

Another thought: Seeing the status=3D1...  I think besides the _fail
thing, 174 is also the only test that makes use of $status.  How about a
patch that removes that variable and simply performs "exit 1" in the
trap line?  I think all tests just do an immediate "exit 1" on error anyw=
ay.

Max


--Gl95q4G8Vdd6WcQ2bkDfDUftv1FFqXR7J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlohwRYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AeWwH/iZ3snlreom134y4UMUNLSMLpiDspi/J
WMDP/ran0dOsPMWCR5t4jIRT2ZL49h2pd3B9bGmF1ZpWBnd1LdTbgzdF6eQe1oxF
vfPY1rLscBkX0q/MqFbDw38cqp8duQbERnd7cF8Ol0I7ZWp9+JlJvt0nT8Ukm7Qy
V8f3roJtLcOBbeUZ4TxSCK5E4uUfScmb7serVTXUeBzOn+KC7dW/TaW98N4Ig6oh
y3JtcsSrARFi3MPcw9PahiWCS+BD6zWKAOhNogXiEc0LDlZ9B/QUdGzUjaSc2P/U
IIAcIZ/0GAHKpWWIFMxtsY5KK8lf1q8dHMHwXuWkxs1Lnxg5LDs1zHY=
=Ps5r
-----END PGP SIGNATURE-----

--Gl95q4G8Vdd6WcQ2bkDfDUftv1FFqXR7J--
