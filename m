Received: from eggs.gnu.org ([209.51.188.92]:34563)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1gmFZQ-0001PY-BX
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 05:15:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1gmFZN-0007EN-CM
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 05:15:44 -0500
Received: from mout.gmx.net ([212.227.17.21]:52863)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1gmFZM-0007Ad-73
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 05:15:40 -0500
References: <20190123080005.31078-1-kraxel@redhat.com>
	<20190123080005.31078-5-kraxel@redhat.com>
	<484e921f-7cee-755d-12a9-02e8bf182fa4@redhat.com>
	<20190123093657.GC27270@redhat.com>
	<d7c274a7-00ac-d767-69fc-238b88cfd61b@redhat.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <89dd8fa4-c5f6-4362-55fa-115422b57b9a@gmx.com>
Date: Wed, 23 Jan 2019 11:16:35 +0100
MIME-Version: 1.0
In-Reply-To: <d7c274a7-00ac-d767-69fc-238b88cfd61b@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="k3kzvBzWAWRzNTjinu7Dsvo4Ii7A8Ylxb"
Subject: Re: [Qemu-devel] [PATCH 4/4] [RfC] audio: probe audio drivers by
 default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: Kamil Rytarowski <kamil@netbsd.org>, Brad Smith <brad@comstyle.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--k3kzvBzWAWRzNTjinu7Dsvo4Ii7A8Ylxb
From: Kamil Rytarowski <n54@gmx.com>
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P._Berrang=c3=a9?=
 <berrange@redhat.com>
Cc: Kamil Rytarowski <kamil@netbsd.org>, Brad Smith <brad@comstyle.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Message-ID: <89dd8fa4-c5f6-4362-55fa-115422b57b9a@gmx.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] [RfC] audio: probe audio drivers by
 default
References: <20190123080005.31078-1-kraxel@redhat.com>
 <20190123080005.31078-5-kraxel@redhat.com>
 <484e921f-7cee-755d-12a9-02e8bf182fa4@redhat.com>
 <20190123093657.GC27270@redhat.com>
 <d7c274a7-00ac-d767-69fc-238b88cfd61b@redhat.com>
In-Reply-To: <d7c274a7-00ac-d767-69fc-238b88cfd61b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23.01.2019 10:50, Thomas Huth wrote:
> On 2019-01-23 10:36, Daniel P. Berrang=C3=A9 wrote:
>> On Wed, Jan 23, 2019 at 09:27:48AM +0100, Thomas Huth wrote:
>>> On 2019-01-23 09:00, Gerd Hoffmann wrote:
>>>>
>>>> This is RfC because we might look at the ordering.  On linux we prob=
ably
>>>> want prefer alsa over oss.
>>> Yes, please! I've run into the trap a couple of times already: OSS
>>> headers were available, but these days the OSS compatibility kernel
>>> modules are not loaded anymore by default. So you compile QEMU with O=
SS
>>> support and then wonder why you do not get any audio output at all...=

>>>
>>> IMHO we should put OSS as last item in the list on Linux nowadays.
>>
>> Given our targetted platform list[1], are there even any platforms
>> where we would *not* have alsa, but still have OSS ?  If not, then
>> we could just drop the OSS driver entirely on the ground that it is
>> obsolete.
>=20
> We likely could drop OSS on Linux, but it is still required on FreeBSD
> and NetBSD, isn't it? So unless we can drop it there, too, we can also
> simply keep it as last option in the list on Linux as well.
>=20
>  Thomas
>=20

NetBSD supports OSS compat without plans for abandoning it as it's a
good enough solution for desktop applications. Porting to our native
audio (SunOS) backend does not win much/anything as of now.


--k3kzvBzWAWRzNTjinu7Dsvo4Ii7A8Ylxb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCAAqFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlxIPwMMHG41NEBnbXgu
Y29tAAoJEEuzCOmwLnZswZkP/2oUm1Mg6rl/BOtnL8ELilrTbv8LppEDcGkKBNXp
Bcd58T5tM4LrrMfMRZwbv6cnp3fMDCl5Qxurwb3MEmr4hoHCrQdBpVvpJMxX/pry
ti9Jp/t97kLykOwlZc+E3BcG5jLdwN0mHvvo4jyNfw/uHOJGrz4qPg8T8+hSQXuL
1ylUId5Inw2YN3iBVyPw3NfH6IAjDTzsMoDdOqkRqnW2mP91xNYVvZEvCrGILvBR
jam5t7z7VdUmGnSjjToqKcRrYSNUGVJEGO4eRn7AGf1BLmJ+HO+jUqW4L8B1crak
UQnm5XcP/vpK900h2gY2JtcQ81imF/QwmausHMGNnRLnHho7V8xI/V5j8pKqBvlu
Km83jYxWBwh0wPSU/Z/5UheB0bvrth2+VGPK9sGZORBeaEpnD8hcuE90npkA99mA
2YQ4PbW8f53fscrH8UP/UGrfmbi3bl/WIa+XACqO8wKuJwfKxFeVSabrfmWJReIU
3vctJjkH7b53WpJc3kJB7TB2L5BoldxxMrkXoYwlW/mJfbID77PmqFwkSA5Antaa
qyqKqWEvQTBpz+qJVT9IGnMZhWFUXWCFI+Bo/OYi36YYpOjCY/YNHFaP546m1dGu
+DjNKPQGmNfPO5le3ZphV18w/CrMKiShLo3fFjyekgUcLTWmwoqtUznLesen6aNZ
rNk0
=N+LJ
-----END PGP SIGNATURE-----

--k3kzvBzWAWRzNTjinu7Dsvo4Ii7A8Ylxb--
