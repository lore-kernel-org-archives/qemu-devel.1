Received: from eggs.gnu.org ([2001:4830:134:3::10]:56015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e5RB6-0007vG-JF
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 02:53:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e5RB2-00017v-M7
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 02:53:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1e5RB2-00017j-Ca
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 02:53:04 -0400
References: <20171016131644.9565-1-kraxel@redhat.com>
	<20171016131644.9565-8-kraxel@redhat.com>
	<e41b2fbc-98ed-cabb-4236-2126b887626c@redhat.com>
	<58a70aa2-c318-b9de-de07-540b7c19d423@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c10f4e46-1e65-496d-4450-a5462973cc23@redhat.com>
Date: Fri, 20 Oct 2017 08:52:51 +0200
MIME-Version: 1.0
In-Reply-To: <58a70aa2-c318-b9de-de07-540b7c19d423@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="g6cICkiMnb3N6VMPa2t3lWRovVruFhdmN"
Subject: Re: [Qemu-devel] [PULL 07/11] tools: add qemu-keymap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--g6cICkiMnb3N6VMPa2t3lWRovVruFhdmN
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 20.10.2017 00:12, Eric Blake wrote:
> On 10/19/2017 05:09 PM, Eric Blake wrote:
>> On 10/16/2017 08:16 AM, Gerd Hoffmann wrote:
>>> qemu-keymap generates qemu reverse keymaps from xkb keymaps,
>>> which can be used with the qemu "-k" command line switch.
>>>
>>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>>> Message-id: 20171005153330.19210-2-kraxel@redhat.com
>>> ---
>>>  configure     |  23 ++++++
>>>  Makefile      |   5 ++
>>>  qemu-keymap.c | 258 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++
>>>  3 files changed, 286 insertions(+)
>>>  create mode 100644 qemu-keymap.c
>>
>> For in-tree builds, this forgot to update .gitignore so that
>> 'qemu-keymap' isn't accidentally checked in via 'git add -a'.
>=20
> And on a related note, commit 2e1d70b pollutes the tree with a new
> ui/shader/texture-blit-flip-vert.h, that should also be mentioned in
> .gitignore.

Since this seems to happen regularly: I wonder whether we could add a
check to patchew that tests whether the output of "git status" is clean
at the end of an in-tree compilation process?

 Thomas


--g6cICkiMnb3N6VMPa2t3lWRovVruFhdmN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZ6Z1IAAoJEC7Z13T+cC21+XYQAJUZ6VFB3LOWOT1hk79UfEuT
hdj2p/pwONV0UBQTh85nS2yFvOr1GQL0XeDULLVbNF0VZUGhYolcjQ8nXp7SBGPi
nWYShGNRSd1M1lyXMfdeztlLhcUEN0YsnMCGDcJIJpHW4r1/sgaVfkf0EXwocAEt
reJNl+M/y3IAbNkAOWBuzjEX/ZxBX0GNY5/4/sKoN56kaDkhEQxEsukdHVPC3hxo
syZC75J+9+rXwghSIJNUYyLIgS5Rc392ZOElrg7qZ2y+9I1qSnHXTFcrAtqc8dPD
sKLWC6nNDAiKr/BMdKLIbyIpOKAHn1Y+tcNcWlhQHyNmUJjpVKLge/ourkAJ0Cu6
JtU8wi4SoQ0kGLeU7wAUzTVhtpmrBcjvBTpJ/1UuEjLAYcAccXIzMFwK6DXYk7xS
ufrJJOaj2VEXmF3RaT3iUs/on1argVJL97jlpJk0Jlt0ts81TRnEF/MdQ1yzh61s
9S7Qz7b9ZgQ+XL5G9Z4VU5lyHMJWTpaNXOJOMbRFUQYkN5RgWyyZW7vW+TE5SM9m
Xkdo1bIuBdwpLUE0mg2ub8nGARVTdlOY6bIgrJVe0gXUIzAzgNVvKGB0FulWaiSX
Utn+gQhxQKQ65HLjchZu5eqVy96qhP7S7uoEjUi2Ajt9U0F8UKGKF8+JxEwT69iD
KQXlBIA7+QRzbqlkxzkt
=HCuF
-----END PGP SIGNATURE-----

--g6cICkiMnb3N6VMPa2t3lWRovVruFhdmN--
