Received: from eggs.gnu.org ([209.51.188.92]:54928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gqpqz-0000mq-Gm
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 20:48:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gqpqr-0004I9-No
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 20:48:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42818)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gqpqi-0004Fb-IU
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 20:48:35 -0500
Date: Mon, 4 Feb 2019 20:48:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190204204804-mutt-send-email-mst@kernel.org>
References: <20190204142638.27021-1-mst@redhat.com>
	<20190204142638.27021-16-mst@redhat.com>
	<20190204150748.GP1905@redhat.com>
	<20190204101130-mutt-send-email-mst@kernel.org>
	<20190204152921.GQ1905@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190204152921.GQ1905@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 15/25] contrib: compile vhost-user-blk tool
 by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Changpeng Liu <changpeng.liu@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>

On Mon, Feb 04, 2019 at 03:29:21PM +0000, Daniel P. Berrang=E9 wrote:
> On Mon, Feb 04, 2019 at 10:19:42AM -0500, Michael S. Tsirkin wrote:
> > Hmm I do think we want to build the contrib tools,
> > otherwise they bitrot too quickly, witness follow-up
> > patches that fix the compilation.
> >=20
> > And I think we need tests that actually use them.
> >=20
> > However I agree adding them to tools and installing
> > is probably rushing things, e.g. there's no
> > manpage even.
>=20
> Yes, if we build, but do not install, the binary that would be ok
>=20
>=20
> Regards,
> Daniel

OK I reverted this for now.

> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
