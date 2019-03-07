Received: from eggs.gnu.org ([209.51.188.92]:55130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1h1wA4-0003Sn-Ec
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:46:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1h1wA3-0001CB-Fh
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:46:24 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44342)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1h1wA3-0001Bx-AV
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:46:23 -0500
Received: by mail-qk1-f194.google.com with SMTP id u22so520186qkj.11
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 08:46:23 -0800 (PST)
Date: Thu, 7 Mar 2019 11:46:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190307113538-mutt-send-email-mst@kernel.org>
References: <20190307072253.9868-1-elena.ufimtseva@oracle.com>
	<20190307142609.GF2843@stefanha-x1.localdomain>
	<20190307145120.GF32268@redhat.com>
	<20190307110441-mutt-send-email-mst@kernel.org>
	<20190307161944.GH32268@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190307161944.GH32268@redhat.com>
Subject: Re: [Qemu-devel] [multiprocess RFC PATCH 36/37] multi-process: add
 the concept description to docs/devel/qemu-multiprocess
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, elena.ufimtseva@oracle.com, john.g.johnson@oracle.com, sstabellini@kernel.org, jag.raman@oracle.com, konrad.wilk@oracle.com, qemu-devel@nongnu.org, ross.lagerwall@citrix.com, liran.alon@oracle.com, stefanha@redhat.com, kanth.ghatraju@oracle.com

On Thu, Mar 07, 2019 at 04:19:44PM +0000, Daniel P. Berrangé wrote:
> On Thu, Mar 07, 2019 at 11:05:36AM -0500, Michael S. Tsirkin wrote:
> > On Thu, Mar 07, 2019 at 02:51:20PM +0000, Daniel P. Berrangé wrote:
> > > The broadening of vhost-user support is useful with that in much the
> > > same way I imagine.
> > 
> > vhost user has more of an impact but is also a bigger maintainance
> > burden as clients are packaged, can be restarted etc individually.
> 
> It feels like we're having/accepted that cost already though since
> vhostuser exists today & has been expanding to cover more backends.
> 
> Regards,
> Daniel

What I am trying to say is that we could eaily add support for
extensions just for in-tree code since these don't create an API that
needs to be maintained.

So e.g. we do not need feature negotiation.

But yes, this could be an extension of vhost-user in some way.

> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
