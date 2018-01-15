Received: from eggs.gnu.org ([2001:4830:134:3::10]:56794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eb6Q9-0000R0-TN
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 10:11:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eb6Q8-00073h-Uy
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 10:11:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eb6Q8-000739-P6
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 10:11:32 -0500
Date: Mon, 15 Jan 2018 16:11:26 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180115151126.zeam752zql7kdi7b@sirius.home.kraxel.org>
References: <20171212141044.2582-1-berrange@redhat.com>
	<20171212141044.2582-5-berrange@redhat.com>
	<20171213150151.GF2216@perard.uk.xensource.com>
	<20171215093324.GB11724@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171215093324.GB11724@redhat.com>
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Anthony PERARD <anthony.perard@citrix.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org

On Fri, Dec 15, 2017 at 09:33:24AM +0000, Daniel P. Berrange wrote:
> On Wed, Dec 13, 2017 at 03:01:51PM +0000, Anthony PERARD wrote:
> > On Tue, Dec 12, 2017 at 02:10:44PM +0000, Daniel P. Berrange wrote:
> > > Replace the scancode2linux table with an automatically
> > > generated table. In doing so, the XenFB keyboard
> > > handler is also converted to the modern InputEvent
> > > framework.
> > > 
> > > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > 
> > FYI, I think that is done by <20171103115631.15175-3-owen.smith@citrix.com>.
> > ([PATCH v5 2/4] xenfb: Use Input Handlers directly)
> 
> Thanks, I see Stefano has posted a PULL for those patches, so I'll drop
> my duplicates.

Can you send a updated series?  Also ordering virtio-input-hid to the
end of the series would be great.

thanks,
  Gerd
