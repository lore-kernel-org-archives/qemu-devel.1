Received: from eggs.gnu.org ([2001:4830:134:3::10]:36726)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1d9fSX-0007oS-KT
	for qemu-devel@nongnu.org; Sat, 13 May 2017 18:24:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1d9fSU-0005Yi-HS
	for qemu-devel@nongnu.org; Sat, 13 May 2017 18:24:21 -0400
Received: from mout.gmx.net ([212.227.15.19]:51626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1d9fSU-0005WM-5f
	for qemu-devel@nongnu.org; Sat, 13 May 2017 18:24:18 -0400
References: <20170513015449.24061-1-n54@gmx.com>
	<91e1cbd3-88e6-2b7a-c4e4-824c54f34c52@amsat.org>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <d322706d-02e0-14a3-552b-df8201a5689a@gmx.com>
Date: Sun, 14 May 2017 00:15:40 +0200
MIME-Version: 1.0
In-Reply-To: <91e1cbd3-88e6-2b7a-c4e4-824c54f34c52@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EgQnaunUtxmbn3fmhWvhTEUt6dUHliMV7"
Subject: Re: [Qemu-devel] [PATCH] libvixl: Correct ordering of includes and
 fix NetBSD build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, claudio.fontana@huawei.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EgQnaunUtxmbn3fmhWvhTEUt6dUHliMV7
From: Kamil Rytarowski <n54@gmx.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, claudio.fontana@huawei.com
Message-ID: <d322706d-02e0-14a3-552b-df8201a5689a@gmx.com>
Subject: Re: [Qemu-devel] [PATCH] libvixl: Correct ordering of includes and
 fix NetBSD build
References: <20170513015449.24061-1-n54@gmx.com>
 <91e1cbd3-88e6-2b7a-c4e4-824c54f34c52@amsat.org>
In-Reply-To: <91e1cbd3-88e6-2b7a-c4e4-824c54f34c52@amsat.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hello,

I will give it a try and submit as a new patch.

On 14.05.2017 00:04, Philippe Mathieu-Daud=E9 wrote:
> Hi Kamil,
>=20
> I think it is safer to add it in disas/libvixl/Makefile.objs where
> QEMU_CFLAGS are tuned for libvixl.
> This way you don't need to modify upstream libvixl.
>=20
> Regards,
>=20
> Phil.
>=20
> On 05/12/2017 10:54 PM, Kamil Rytarowski wrote:
>> The __STDC_CONSTANT_MACROS symbol must be defined before including
>> directly or indirectly <stdint.h> in order to get support for macros
>> for integer constants like INT8_C().
>>
>> The vixl/globals.h headers defines __STDC_CONSTANT_MACROS and must be
>> included before other system headers.
>>
>> This change fixes build failures on NetBSD.
>>
>> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
>> ---
>>  disas/libvixl/vixl/a64/disasm-a64.cc | 2 +-
>>  disas/libvixl/vixl/utils.h           | 4 ++--
>>  2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/disas/libvixl/vixl/a64/disasm-a64.cc
>> b/disas/libvixl/vixl/a64/disasm-a64.cc
>> index 7a58a5c087..fc87306893 100644
>> --- a/disas/libvixl/vixl/a64/disasm-a64.cc
>> +++ b/disas/libvixl/vixl/a64/disasm-a64.cc
>> @@ -24,8 +24,8 @@
>>  // OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT=

>> OF THE USE
>>  // OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAG=
E.
>>
>> -#include <cstdlib>
>>  #include "vixl/a64/disasm-a64.h"
>> +#include <cstdlib>
>>
>>  namespace vixl {
>>
>> diff --git a/disas/libvixl/vixl/utils.h b/disas/libvixl/vixl/utils.h
>> index 5ab134e240..17034addbc 100644
>> --- a/disas/libvixl/vixl/utils.h
>> +++ b/disas/libvixl/vixl/utils.h
>> @@ -27,10 +27,10 @@
>>  #ifndef VIXL_UTILS_H
>>  #define VIXL_UTILS_H
>>
>> -#include <string.h>
>> -#include <cmath>
>>  #include "vixl/globals.h"
>>  #include "vixl/compiler-intrinsics.h"
>> +#include <string.h>
>> +#include <cmath>
>>
>>  namespace vixl {
>>
>>
>=20



--EgQnaunUtxmbn3fmhWvhTEUt6dUHliMV7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZF4WcAAoJEEuzCOmwLnZsBCYQAMUkBOjXYGUEpoSiSSGhipNZ
QPoxw/ow1mrLssH/E6YxGNdwRpYKDtK1H0Efb6vr+c+FjYt/R7RhvtuUzCmGXhXE
H/t8mIwZnZKb2b56KXxaWXvm+lr7ZWXbgjATQjRmZMzKA9lSgr8GDGeoJhvGvA/T
oJ5+h2g/RRvMNd3Bykuj+PZ//xCt2IYzmcWRAoYEOnbqpsNj3MbZ6Ao6CmP8UMrE
TFSr1ekHJdxppEPtIye7kQmUj1JaAnBYT0TQJLIHnzIlKdoCkzgbBJ/LCPj1czRX
8kDk9nabXg0Blu4OhcJHm45HrLe35BhPFLC6MvfNkRn+BJ5QGj5X7kgMJ+kRjO5K
obS34HVOEWme7gUgWkWu0uSyt9PZFQLEPqKEaoaiz/NtbSURLrYYwLE0QQbGVa6a
X0fQ38vvUv7O1j1jfZ6Fe+L6fEU++jU8WCFUB2qVicrXm8QNmaab0MD0CQhSfS4a
ag14d5aTuI1mICD45UnjhL2ikSgOIgBIw4IhEIBRpShpzwkhtrgYjQDd8X/Ifrft
4RPrbqscdWd1AFL9Wu/ziN4jMnrE3y1e1vYy7xwKayggqB0d+PdMSGfi+n5Q+bVs
OZNxOKP2JJkeyupq7uuPaPpAdBkDQ6MuiUMoX3A98gukd3h8nOu6u2TK8/+dC+8/
Nu6KH2PurSANx4e8wpmh
=BX91
-----END PGP SIGNATURE-----

--EgQnaunUtxmbn3fmhWvhTEUt6dUHliMV7--
