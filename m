Received: from eggs.gnu.org ([2001:4830:134:3::10]:50580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dQFfp-0004ks-Ti
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 12:18:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dQFfo-000304-W7
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 12:18:37 -0400
Date: Wed, 28 Jun 2017 18:18:25 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170628161825.GL5378@noname.redhat.com>
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
	<20170623124700.1389-6-el13635@mail.ntua.gr>
	<20170628155042.GJ5378@noname.redhat.com>
	<61521682-b70e-0690-0005-4e05cce821fd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pyE8wggRBhVBcj8z"
Content-Disposition: inline
In-Reply-To: <61521682-b70e-0690-0005-4e05cce821fd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC v3 5/8] block: add
 BlockDevOptionsThrottle to QAPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Manos Pitsidianakis <el13635@mail.ntua.gr>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>


--pyE8wggRBhVBcj8z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 28.06.2017 um 18:02 hat Eric Blake geschrieben:
> On 06/28/2017 10:50 AM, Kevin Wolf wrote:
> > Am 23.06.2017 um 14:46 hat Manos Pitsidianakis geschrieben:
> >> This is needed to configure throttle filter driver nodes with QAPI.
> >>
> >> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> >> ---
> >>  qapi/block-core.json | 19 ++++++++++++++++++-
> >>  1 file changed, 18 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/qapi/block-core.json b/qapi/block-core.json
> >> index f85c2235c7..1d4afafe8c 100644
> >> --- a/qapi/block-core.json
> >> +++ b/qapi/block-core.json
> >> @@ -2119,7 +2119,7 @@
> >>              'host_device', 'http', 'https', 'iscsi', 'luks', 'nbd', '=
nfs',
> >>              'null-aio', 'null-co', 'parallels', 'qcow', 'qcow2', 'qed=
',
> >>              'quorum', 'raw', 'rbd', 'replication', 'sheepdog', 'ssh',
> >> -            'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat', 'vxhs' ] }
> >> +            'throttle', 'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat', 'vxhs'=
 ] }
> >> =20
> >>  ##
> >>  # @BlockdevOptionsFile:
> >> @@ -2984,6 +2984,7 @@
> >>        'replication':'BlockdevOptionsReplication',
> >>        'sheepdog':   'BlockdevOptionsSheepdog',
> >>        'ssh':        'BlockdevOptionsSsh',
> >> +      'throttle':   'BlockdevOptionsThrottle',
> >>        'vdi':        'BlockdevOptionsGenericFormat',
> >>        'vhdx':       'BlockdevOptionsGenericFormat',
> >>        'vmdk':       'BlockdevOptionsGenericCOWFormat',
> >> @@ -3723,3 +3724,19 @@
> >>    'data' : { 'parent': 'str',
> >>               '*child': 'str',
> >>               '*node': 'str' } }
> >> +
> >> +##
> >> +# @BlockdevOptionsThrottle:
> >> +#
> >> +# Driver specific block device options for Throttle
> >> +#
> >> +# @throttling-group: the name of the throttling group to use
> >> +#
> >> +# @options:        BlockIOThrottle options
> >=20
> > Missing #optional marker.
>=20
> The marker is now auto-generated based solely on the '*options' below,
> so we don't need a redundant thing here.

Oh nice, progress!

Kevin

--pyE8wggRBhVBcj8z
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZU9bRAAoJEH8JsnLIjy/W0t8QAMUgxnR4fc5XrVkWs1Z1e24C
3x770ihO7RXvNpMAaQEtOgOR3R1s0Bgv0RQGyr69bKKE7Jvn79DhtyPhPkAiDOQb
KDnBkztY8a7UH30wOK2IzczR5p3WiCdlnAxguvyxWUV2BAAdQoRICZhoKl/1YODw
jdgxYo4kxDIB7s+f5qo3WEMsUWnsQQTj9rOCgLcpLrUkqVIRN2Ol3L1DdQyBGnkB
thWZZxVzNdbU8RjLPuWf9f0vIvkyuAzf9q3VGV3r+74YxKUpZfmzwqPpT8FupV3M
dhpnrDwXWlrDoQs3i0VgypharWxiak7H70KtejmzwE7lwSGBT0SWfSiAKX+MThsi
K609uNsapSDa8Y3I1BgHWmtHRTwhQXNaUJk6knlqsPi9jCuIaiudZEpOhUTypoRb
En9C8wxdpdQPC/8ZEDGOtNG1xyD85kfPQrg+YrNpXsIiTpaakxUdGa5YpQDKyNq3
zk5Xb7gVZp+OunSqFtInCdypbTtWDKd9O/69EVQ+WFAahaNN4gtEuGiO5A28nWHf
1gj4RtIBUZJ9FoyAY5bqMX92h+D06cZl0MPVZhID20lHJjNADSsodzvzV5uS0KvR
d+icA4CfGgRo68J7rvXS2J8m6pR9t8mQQRuvAKneorZnW/Rknu4EGN1N+zC22Avc
ojdmWCnP5I6BaJ1sCWDt
=IsdK
-----END PGP SIGNATURE-----

--pyE8wggRBhVBcj8z--
