Received: from eggs.gnu.org ([2001:4830:134:3::10]:47637)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1d30px-0000OX-Fo
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:49:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1d30pu-0004kY-DV
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:49:01 -0400
References: <20170425131828.22480-1-n54@gmx.com>
	<CAFEAcA-PmbjRYb2EDDp60pKNnUQ8Rkdx79TTLgUMf_VRe2JT+w@mail.gmail.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <f4837473-2112-fe0c-862c-ae4b77dc0bc8@gmx.com>
Date: Tue, 25 Apr 2017 15:50:46 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-PmbjRYb2EDDp60pKNnUQ8Rkdx79TTLgUMf_VRe2JT+w@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9aku9c902OxXrjs8oMtSGPxhXbQGCEsB0"
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9aku9c902OxXrjs8oMtSGPxhXbQGCEsB0
From: Kamil Rytarowski <n54@gmx.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <f4837473-2112-fe0c-862c-ae4b77dc0bc8@gmx.com>
Subject: Re: [Qemu-trivial] [PATCH] scripts/qemu-binfmt-conf.sh: Fix shell
 portability issue
References: <20170425131828.22480-1-n54@gmx.com>
 <CAFEAcA-PmbjRYb2EDDp60pKNnUQ8Rkdx79TTLgUMf_VRe2JT+w@mail.gmail.com>
In-Reply-To: <CAFEAcA-PmbjRYb2EDDp60pKNnUQ8Rkdx79TTLgUMf_VRe2JT+w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 25.04.2017 15:33, Peter Maydell wrote:
> On 25 April 2017 at 14:18, Kamil Rytarowski <n54@gmx.com> wrote:
>> Appease pkgsrc and use portable shell variable comparison.
>> This switches "=3D=3D" to "=3D". It should not be a functional change.=

>>
>> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
>> ---
>=20
> Thanks for this patch; it's an easy bug to let slip in
> if your /bin/sh happens to be bash.
>=20
> PS: you forgot to cc qemu-devel@ on this patch.
>=20

I assumed that qemu-trivial@ don't need to go to qemu-devel@. Thank you
for pointing it out.

>>  scripts/qemu-binfmt-conf.sh | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh=

>> index 0f1aa63872..8afc3eb5bb 100755
>> --- a/scripts/qemu-binfmt-conf.sh
>> +++ b/scripts/qemu-binfmt-conf.sh
>> @@ -284,12 +284,12 @@ while true ; do
>>          shift
>>          # check given cpu is in the supported CPU list
>>          for cpu in ${qemu_target_list} ; do
>> -            if [ "$cpu" =3D=3D "$1" ] ; then
>> +            if [ "$cpu" =3D "$1" ] ; then
>>                  break
>>              fi
>>          done
>>
>> -        if [ "$cpu" =3D=3D "$1" ] ; then
>> +        if [ "$cpu" =3D "$1" ] ; then
>>              qemu_target_list=3D"$1"
>>          else
>>              echo "ERROR: unknown CPU \"$1\"" 1>&2
>> --
>> 2.12.2
>=20
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>=20
> thanks
> -- PMM
>=20



--9aku9c902OxXrjs8oMtSGPxhXbQGCEsB0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY/1Q2AAoJEEuzCOmwLnZsrWEP/iDVdXKf17n91y8hq0DqWpym
y1pfx5A5HZvbKjgDwTXK0xhgvym+69pRfLHuiRF6Icz2/Qa2niuUBn78lZACMEcm
hRtnftezW6rFdLQ8lwjCnnt7z1aEJSAqiIXbHM8xP/qUDn5GIQ1bme94/4RdGkPY
sKOjwYQYnvn0djPggM8I0+r1AUTMj75A/mdItq+ax54ndoGoGru0YuBY2sB1n+jc
UrcqQqDEeVeHY4rP4g1UthY5Gf4rCmzJU+4y44EOpBwQf7G9/mKYtZAnFdxbsMkV
zso9y5TA/78TzQnPXFuOL+16uEhsWahL/BzMFONg1nbMhP2b4sBcLLfR4MrOV6FN
pKaOMj2KEjCQX5tt51Nqkt3QQuXBfKRObnSCZSacadGnxWKicB/Fni45381C+bM0
3o4GNykkPnTax3ZphJ7lsl3mziyK4B+KCDXajx+tz1T7Jxs9R0reW1DCfqC6jNc4
Dsl0lxPmJfRLki4p0JUZA44QesfOqgpM38hyjXAg3v4MAsR7ATe7UsiXZO63DhcV
HvMOGFi2JcayicKDK8Sgz45oIQ6afjs5b6BPW+bvihrQ7+nDNLYBN0FciBsjyKCM
2MkYmPI4fftVp7FZHeq74qop24GzJ5Zl42OYe0PFUfWMVXzqO0zDJ/ynNGUu1V8S
wJ5mrAYbBEDK245RvKJY
=iTJj
-----END PGP SIGNATURE-----

--9aku9c902OxXrjs8oMtSGPxhXbQGCEsB0--
