Received: from eggs.gnu.org ([209.51.188.92]:52180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gxDqy-0005G3-Tk
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 11:39:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gxDqx-0006iH-6R
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 11:39:12 -0500
Date: Fri, 22 Feb 2019 16:38:27 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190222163827.GF25234@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190220145819.30969-1-berrange@redhat.com>
	<20190220145819.30969-2-berrange@redhat.com>
	<1b7cca35-0764-c365-169e-f46c033bd2e2@redhat.com>
	<20190222151655.GD25234@redhat.com>
	<54c5e3ea-c6cc-b705-b247-647d355e6607@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <54c5e3ea-c6cc-b705-b247-647d355e6607@redhat.com>
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
To: Eric Blake <eblake@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On Fri, Feb 22, 2019 at 09:54:25AM -0600, Eric Blake wrote:
> On 2/22/19 9:16 AM, Daniel P. Berrang=C3=A9 wrote:
> > On Fri, Feb 22, 2019 at 04:06:32PM +0100, Max Reitz wrote:
> >> On 20.02.19 15:58, Daniel P. Berrang=C3=A9 wrote:
> >>> If we abort the iotest early the server.log file might contain usef=
ul
> >>> information for diagnosing the problem. Ensure its contents are
> >>> displayed in this case.
> >>>
> >>> Reviewed-by: Eric Blake <eblake@redhat.com>
> >>> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>=20
> >>> @@ -120,6 +122,7 @@ $QEMU_IO -f $IMGFMT -r -U -c 'r -P 0x22 1m 1m' =
"$TEST_IMG" | _filter_qemu_io
> >>>  echo
> >>>  echo "=3D=3D final server log =3D=3D"
> >>>  cat "$TEST_DIR/server.log"
> >>> +rm -f $TEST_DIR/server.log
> >>
> >> I'm not sure how well the iotests currently cope with spaced dir nam=
es
> >> anyway, but it looks weird to not use quotes here right after a line
> >> that does.
> >=20
> > Yes, that is a mistake since we tried quoting throughout the file
>=20
> Can fix that while staging through my NBD queue. I'll probably send a P=
R
> on Monday.

Great, thanks.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
