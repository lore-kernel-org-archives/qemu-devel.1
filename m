Received: from eggs.gnu.org ([209.51.188.92]:44645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gxCZW-00080d-3u
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 10:17:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gxCZU-0004Oc-R0
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 10:17:06 -0500
Date: Fri, 22 Feb 2019 15:16:55 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190222151655.GD25234@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190220145819.30969-1-berrange@redhat.com>
	<20190220145819.30969-2-berrange@redhat.com>
	<1b7cca35-0764-c365-169e-f46c033bd2e2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1b7cca35-0764-c365-169e-f46c033bd2e2@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/2] iotests: ensure we print nbd server
 log on error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

On Fri, Feb 22, 2019 at 04:06:32PM +0100, Max Reitz wrote:
> On 20.02.19 15:58, Daniel P. Berrang=C3=A9 wrote:
> > If we abort the iotest early the server.log file might contain useful
> > information for diagnosing the problem. Ensure its contents are
> > displayed in this case.
> >=20
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >  tests/qemu-iotests/233 | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git a/tests/qemu-iotests/233 b/tests/qemu-iotests/233
> > index fc345a1a46..27932df075 100755
> > --- a/tests/qemu-iotests/233
> > +++ b/tests/qemu-iotests/233
> > @@ -30,6 +30,8 @@ _cleanup()
> >  {
> >      nbd_server_stop
> >      _cleanup_test_img
> > +    # If we aborted early we want to see this log for diagnosis
> > +    test -f "$TEST_DIR/server.log" && cat "$TEST_DIR/server.log"
> >      rm -f "$TEST_DIR/server.log"
> >      tls_x509_cleanup
> >  }
> > @@ -120,6 +122,7 @@ $QEMU_IO -f $IMGFMT -r -U -c 'r -P 0x22 1m 1m' "$=
TEST_IMG" | _filter_qemu_io
> >  echo
> >  echo "=3D=3D final server log =3D=3D"
> >  cat "$TEST_DIR/server.log"
> > +rm -f $TEST_DIR/server.log
>=20
> I'm not sure how well the iotests currently cope with spaced dir names
> anyway, but it looks weird to not use quotes here right after a line
> that does.

Yes, that is a mistake since we tried quoting throughout the file


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
