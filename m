Received: from eggs.gnu.org ([209.51.188.92]:50361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gw8NM-0004JG-9l
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 11:36:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gw8NL-0003bE-En
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 11:36:08 -0500
References: <20190219161321.15012-1-berrange@redhat.com>
	<20190219161321.15012-2-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7093505b-0719-a3e5-e104-dcc41c2fbc3e@redhat.com>
Date: Tue, 19 Feb 2019 10:35:58 -0600
MIME-Version: 1.0
In-Reply-To: <20190219161321.15012-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] iotests: ensure we print nbd server
 log on error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 2/19/19 10:13 AM, Daniel P. Berrang=C3=A9 wrote:
> If we abort the iotest early the server.log file might contain useful
> information for diagnosing the problem. Ensure its contents are
> displayed in this case.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  tests/qemu-iotests/233 | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/tests/qemu-iotests/233 b/tests/qemu-iotests/233
> index fc345a1a46..27932df075 100755
> --- a/tests/qemu-iotests/233
> +++ b/tests/qemu-iotests/233
> @@ -30,6 +30,8 @@ _cleanup()
>  {
>      nbd_server_stop
>      _cleanup_test_img
> +    # If we aborted early we want to see this log for diagnosis
> +    test -f "$TEST_DIR/server.log" && cat "$TEST_DIR/server.log"
>      rm -f "$TEST_DIR/server.log"
>      tls_x509_cleanup
>  }
> @@ -120,6 +122,7 @@ $QEMU_IO -f $IMGFMT -r -U -c 'r -P 0x22 1m 1m' "$TE=
ST_IMG" | _filter_qemu_io
>  echo
>  echo "=3D=3D final server log =3D=3D"
>  cat "$TEST_DIR/server.log"
> +rm -f $TEST_DIR/server.log
> =20
>  # success, all done
>  echo "*** done"
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
