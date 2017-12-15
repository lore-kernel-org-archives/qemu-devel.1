Received: from eggs.gnu.org ([2001:4830:134:3::10]:41173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ePmN8-0001Pt-OY
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 04:33:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ePmN5-0004Jc-8V
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 04:33:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ePmN4-0004DL-TN
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 04:33:35 -0500
Date: Fri, 15 Dec 2017 09:33:24 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171215093324.GB11724@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171212141044.2582-1-berrange@redhat.com>
	<20171212141044.2582-5-berrange@redhat.com>
	<20171213150151.GF2216@perard.uk.xensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171213150151.GF2216@perard.uk.xensource.com>
Subject: Re: [Qemu-devel] [PATCH v6 4/4] hw: convert XenInput keyboard to
 keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org

On Wed, Dec 13, 2017 at 03:01:51PM +0000, Anthony PERARD wrote:
> On Tue, Dec 12, 2017 at 02:10:44PM +0000, Daniel P. Berrange wrote:
> > Replace the scancode2linux table with an automatically
> > generated table. In doing so, the XenFB keyboard
> > handler is also converted to the modern InputEvent
> > framework.
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> 
> FYI, I think that is done by <20171103115631.15175-3-owen.smith@citrix.com>.
> ([PATCH v5 2/4] xenfb: Use Input Handlers directly)

Thanks, I see Stefano has posted a PULL for those patches, so I'll drop
my duplicates.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
