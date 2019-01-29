Received: from eggs.gnu.org ([209.51.188.92]:56055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gob3p-0004TJ-Dn
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 16:36:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gob3o-0005rI-KV
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 16:36:49 -0500
References: <20190123144610.8842-1-mreitz@redhat.com>
	<20190123144610.8842-8-mreitz@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <d06c8c6b-0123-01b3-7bb2-cf7c119cd7fe@redhat.com>
Date: Tue, 29 Jan 2019 16:36:25 -0500
MIME-Version: 1.0
In-Reply-To: <20190123144610.8842-8-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 7/9] iotests.py: Filter filename in any
 string value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org



On 1/23/19 9:46 AM, Max Reitz wrote:
> filter_qmp_testfiles() currently filters the filename only for specific
> keys.  However, there are more keys that take filenames (such as
> block-commit's @top and @base, or ssh's @path), and it does not make
> sense to list them all here.  "$TEST_DIR/$PID-" should have enough
> entropy not to appear anywhere randomly.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>

There might be a more aggressive fix we can apply if we don't care about
the keys, but maybe some other filters do still care about the keys.

Ah, either way, this is obviously fine.

Reviewed-by: John Snow <jsnow@redhat.com>

> ---
>  tests/qemu-iotests/iotests.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests=
.py
> index 29e4e3306f..b6cb73e108 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -274,7 +274,7 @@ def filter_testfiles(msg):
> =20
>  def filter_qmp_testfiles(qmsg):
>      def _filter(key, value):
> -        if key =3D=3D 'filename' or key =3D=3D 'backing-file':
> +        if is_str(value):
>              return filter_testfiles(value)
>          return value
>      return filter_qmp(qmsg, _filter)
>=20

--=20
=E2=80=94js
