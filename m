Received: from eggs.gnu.org ([2001:4830:134:3::10]:38744)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dcC1p-0003F1-R1
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 10:50:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dcC1m-0003KT-Ju
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 10:50:41 -0400
Received: from mout.gmx.net ([212.227.15.15]:50999)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1dcC1m-0003JJ-1n
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 10:50:38 -0400
Received: from [192.168.1.3] ([185.58.161.191]) by mail.gmx.com (mrgmx001
	[212.227.17.184]) with ESMTPSA (Nemesis) id 0Lmb2Z-1eAhQm3c8J-00aCEN
	for <qemu-devel@nongnu.org>; Mon, 31 Jul 2017 16:50:35 +0200
References: <07010a2ad79559c412949f0005dbe3cb03d8416e.1498504812.git.ps@pks.im>
	<CAKmqyKPZ3+ohCvpzbw=MyLpgB5cFKQosBJNsaWcoT=yWp1c9Mw@mail.gmail.com>
	<cf854184-8bc0-4a9c-b97f-8274abf538bc@amsat.org>
	<20170729135042.GA1139@pks-xps>
	<CAFEAcA_gG=pukiHmhW5kMDu0sUxRL8Yp5H5=XA0gKbTSVuNBpQ@mail.gmail.com>
	<192810b2-02a2-fbbc-fc1e-7e9d3d80d7fa@gmx.com>
	<CAFEAcA9dvAnkKhKq03VccO1MLgg-4g20Mt2=85TZ1jF9XxHPRw@mail.gmail.com>
	<20170731142308.GB3206@lemon.lan>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <7cdd0f0a-c260-ecf7-42ea-a385df815334@gmx.com>
Date: Mon, 31 Jul 2017 16:52:52 +0200
MIME-Version: 1.0
In-Reply-To: <20170731142308.GB3206@lemon.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wL6eUMLG0oE5gmx7MAVeGIOw5UJdPnlAC"
Subject: Re: [Qemu-devel] [PATCH] 9pfs: include <linux/limits.h> for
 XATTR_SIZE_MAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wL6eUMLG0oE5gmx7MAVeGIOw5UJdPnlAC
From: Kamil Rytarowski <n54@gmx.com>
To: qemu-devel@nongnu.org
Message-ID: <7cdd0f0a-c260-ecf7-42ea-a385df815334@gmx.com>
Subject: Re: [Qemu-devel] [PATCH] 9pfs: include <linux/limits.h> for
 XATTR_SIZE_MAX
References: <07010a2ad79559c412949f0005dbe3cb03d8416e.1498504812.git.ps@pks.im>
 <CAKmqyKPZ3+ohCvpzbw=MyLpgB5cFKQosBJNsaWcoT=yWp1c9Mw@mail.gmail.com>
 <cf854184-8bc0-4a9c-b97f-8274abf538bc@amsat.org>
 <20170729135042.GA1139@pks-xps>
 <CAFEAcA_gG=pukiHmhW5kMDu0sUxRL8Yp5H5=XA0gKbTSVuNBpQ@mail.gmail.com>
 <192810b2-02a2-fbbc-fc1e-7e9d3d80d7fa@gmx.com>
 <CAFEAcA9dvAnkKhKq03VccO1MLgg-4g20Mt2=85TZ1jF9XxHPRw@mail.gmail.com>
 <20170731142308.GB3206@lemon.lan>
In-Reply-To: <20170731142308.GB3206@lemon.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 31.07.2017 16:23, Fam Zheng wrote:
> On Sun, 07/30 19:23, Peter Maydell wrote:
>> On 30 July 2017 at 17:51, Kamil Rytarowski <n54@gmx.com> wrote:
>>> On 29.07.2017 21:34, Peter Maydell wrote:
>>>> On 29 July 2017 at 14:50, Patrick Steinhardt <ps@pks.im> wrote:
>>>>> On Fri, Jul 28, 2017 at 02:20:49PM -0300, Philippe Mathieu-Daud=C3=A9=
 wrote:
>>>>>> This is likely to break on BSD, but now than patchew has a NetBSD =
job
>>>>>> you can trigger a build RESENDing this patch.
>>>>
>>>
>>> I just checked patchew, and there is FreeBSD job. How far are we from=

>>> adding more BSDs?
>>
>> I now test OpenBSD and NetBSD as well in my pre-merge
>> test setup. Patchew could add them as well if desired.
>> (vm setup instructions at http://wiki.qemu.org/Hosts/BSD)
>=20
> No objection to adding more BSDs to patchew as long as I can find a few=
 more
> gigabytes RAM to run the VM (BTW I'm also thinking about converting lon=
g running
> VMs to boot/shutdown on demand, to support more types of guests). But s=
till want
> to ask this: how likely it is for a patch to compile on one BSD flavor =
but fail
> on the other?
>=20

High probability.

These systems (FreeBSD, NetBSD, OpenBSD) diverged over 20 years ago and
are developed by different teams and for different use-cases.

We should assume that these systems are completely different POSIX-like
systems, with shared ancestors (AT&T UNIX -> BSD UNIX).

Thought, DragonflyBSD & FreeBSD are relatively similar, FreeBSD fixes
should work for DragonflyBSD in most cases.

Right now there are no other modern BSDs with a vibrant community,
everything else is retro-computing, remix with preconfigured desktop,
hobby, 1-man-show etc.

> Fam
>=20



--wL6eUMLG0oE5gmx7MAVeGIOw5UJdPnlAC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZf0RKAAoJEEuzCOmwLnZsmZQP/2LytCuozkf5OgB2/ISxdQIH
lSjaG3tDg2Jpi37qkp9xkxsSXOYvKuvkCNWBmC2TRU6NQS4Biu9ljRoF5b2z5o4K
Dp1/Y++aHL/akT/XuEfgusufb9H8FbDju6WgtVq0KtuxcD/qhzIQ6R/yTYtQS6M8
JCqlH5kKDJ1obD5sWqy36jq5XzVZMfIbClBQVeTDVkZ2r+PzWEZykxmEvUOSpKlx
2P8R6m06o1cNn9mpllQj9eBjiBnKJM6e1S/ZsH6+b5dlE6xw6BvBZTyckOFh7PXD
M8fOL9QkK5GIvGdAvJVoqdaO0vLHim1/7CPPqMgDnnV1iTK5B+sn35IYWYWq45zQ
ogbKe9X+J4lJUxzfpi+15Db+Yf0HhrkKGxtDBSztTWCP4n/2/LP0D++NhtkMwCkw
NZiibPkZ/Loq6khA2vMfjYqyUDAlZKMsrv9G+TV+5fLR+pLMrJdMbSqiQjUpguz1
ntBgk6jVoFPOB3QkHDhiAXqF2Be+VhahFOQweOwqOA1FUsJj/kKEgwBzhSvM1aJi
1zDpxbLgb+J1Npln0EBJUGTxZPAdOHY5epT49YmggQMO/Yn9L9qv+O9BB4Jxo9Di
J7GmveVlHB1qFplCfp/GHcehNrXpFsndw20qZ/VS9ZAsrpGNNQkoc0DrLccj7i3A
tqN17aVpxHDiwLCwFkpF
=+ygO
-----END PGP SIGNATURE-----

--wL6eUMLG0oE5gmx7MAVeGIOw5UJdPnlAC--
