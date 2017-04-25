Received: from eggs.gnu.org ([2001:4830:134:3::10]:49405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d30vJ-0002a7-0n
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:54:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d30vF-0007Zg-VY
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:54:33 -0400
References: <20170425131828.22480-1-n54@gmx.com>
	<CAFEAcA-PmbjRYb2EDDp60pKNnUQ8Rkdx79TTLgUMf_VRe2JT+w@mail.gmail.com>
	<f4837473-2112-fe0c-862c-ae4b77dc0bc8@gmx.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0855b5b6-0aab-7f3a-33ce-8f289de3454f@redhat.com>
Date: Tue, 25 Apr 2017 08:54:27 -0500
MIME-Version: 1.0
In-Reply-To: <f4837473-2112-fe0c-862c-ae4b77dc0bc8@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4evGgwtJrnws3rRlg0tD9A6RkwExOBHew"
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH]
 scripts/qemu-binfmt-conf.sh: Fix shell portability issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4evGgwtJrnws3rRlg0tD9A6RkwExOBHew
From: Eric Blake <eblake@redhat.com>
To: Kamil Rytarowski <n54@gmx.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <0855b5b6-0aab-7f3a-33ce-8f289de3454f@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] scripts/qemu-binfmt-conf.sh:
 Fix shell portability issue
References: <20170425131828.22480-1-n54@gmx.com>
 <CAFEAcA-PmbjRYb2EDDp60pKNnUQ8Rkdx79TTLgUMf_VRe2JT+w@mail.gmail.com>
 <f4837473-2112-fe0c-862c-ae4b77dc0bc8@gmx.com>
In-Reply-To: <f4837473-2112-fe0c-862c-ae4b77dc0bc8@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/25/2017 08:50 AM, Kamil Rytarowski wrote:
> On 25.04.2017 15:33, Peter Maydell wrote:
>> On 25 April 2017 at 14:18, Kamil Rytarowski <n54@gmx.com> wrote:
>>> Appease pkgsrc and use portable shell variable comparison.
>>> This switches "=3D=3D" to "=3D". It should not be a functional change=
=2E
>>>
>>> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
>>> ---
>>
>> Thanks for this patch; it's an easy bug to let slip in
>> if your /bin/sh happens to be bash.
>>
>> PS: you forgot to cc qemu-devel@ on this patch.
>>
>=20
> I assumed that qemu-trivial@ don't need to go to qemu-devel@. Thank you=

> for pointing it out.

ALL patches need to go to qemu-devel (so we have a one-stop-shop for all
pending patches), but some patches need to additionally go to secondary
lists for catching the attention of the right maintainers.

scripts/get_maintainer.pl is your friend, and it should always list
qemu-devel in its answer.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--4evGgwtJrnws3rRlg0tD9A6RkwExOBHew
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY/1UTAAoJEKeha0olJ0NqIr4H/A/rkuxPp7StqgIaniTwDk+y
6kMEHIu8wW/rCogMtWzyxziK5CM9fwpEGw/hyoHTRENUS0lTboWdtGqhiKLmFtrM
DgedUfB78d5IIv8lbNvWJrSUIa0JMz+Rybc8DUqMy7wxerRAfybVGzGitxrh6R1s
Lm+A0RpLXi1iOUWhCOI7RDvTtZFEMUCR+3s2gFjsw7TZ266pxiEwgg6OkxzpRoUr
BbCBC/nyo97tDn41qPhLc+Q9sJr91Y0740bQ1/N57JIH2PDrccdkfYwQFF2WCIpf
Z7N61y2zSKFzLrM+Fo6tG5z/AwAl1PDMGoqi9QTxnRu8fJe74iwDvTnEcqAScsw=
=t4d+
-----END PGP SIGNATURE-----

--4evGgwtJrnws3rRlg0tD9A6RkwExOBHew--
