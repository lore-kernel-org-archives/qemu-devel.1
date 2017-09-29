Received: from eggs.gnu.org ([2001:4830:134:3::10]:44472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxsbx-0005Er-Gd
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 06:33:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxsbt-0004pT-I9
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 06:33:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dxsbt-0004pD-BR
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 06:33:33 -0400
Date: Fri, 29 Sep 2017 11:33:25 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170929103325.GA11930@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1506437019-17946-1-git-send-email-owen.smith@citrix.com>
	<1506680812.6902.22.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1506680812.6902.22.camel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/3 v4] xenfb: Enablement for Windows PV
 HID frontend
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Owen Smith <owen.smith@citrix.com>, sstabellini@kernel.org, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org
List-ID: <qemu-devel.nongnu.org>

On Fri, Sep 29, 2017 at 12:26:52PM +0200, Gerd Hoffmann wrote:
> On Tue, 2017-09-26 at 14:43 +0000, Owen Smith wrote:
> > Improve the input device model in xenfb, by updating the
> > Qemu input handlers and adding a feature to allow for
> > raw (unscaled) absolute coordinates to be represented.
> > 
> > By using a reverse mapping call, the Linux input.h #defines
> > are not pulled into xenfb, and so should remove the compiler
> > warnings reported.
> 
> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> What is the plan with this?  Merge through xen queue?  I can merge it
> via ui queue too, but in that case I'd like to get an review from the
> xen guys.
> 
> Note: conflicts with keycodemapdb patch series, might need a rebase
> depending on merge order.

I don't mind rebasing against this if it merges first.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
