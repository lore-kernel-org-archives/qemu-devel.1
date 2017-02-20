Received: from eggs.gnu.org ([2001:4830:134:3::10]:36821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cfkWQ-0008Ai-RF
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:44:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cfkWO-0002Oz-1Q
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:44:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47736)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cfkWN-0002OM-R3
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:44:39 -0500
Date: Mon, 20 Feb 2017 09:44:26 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170220094426.GB15874@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CAAo6VWOAnGQeDwc_bJ4M=FQsu7rOhAv=1Qk6PdzG+0pcVnku=A@mail.gmail.com>
	<20170217214215.GK19045@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170217214215.GK19045@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH v8 1/2] block/vxhs.c: Add support for a new
 block device type called "vxhs"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: ashish mittal <ashmit602@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <famz@redhat.com>, Ashish Mittal <ashish.mittal@veritas.com>, Stefan Hajnoczi <stefanha@gmail.com>, John Ferlan <jferlan@redhat.com>, Buddhi Madhav <Buddhi.Madhav@veritas.com>, Suraj Singh <Suraj.Singh@veritas.com>, Nitin Jerath <Nitin.Jerath@veritas.com>, Peter Maydell <peter.maydell@linaro.org>, Ketan Nilangekar <Ketan.Nilangekar@veritas.com>, Abhijit Dey <Abhijit.Dey@veritas.com>, "Venkatesha M.G." <Venkatesha.Mg@veritas.com>, Rakesh Ranjan <Rakesh.Ranjan@veritas.com>

On Fri, Feb 17, 2017 at 04:42:15PM -0500, Jeff Cody wrote:
> On Thu, Feb 16, 2017 at 02:24:19PM -0800, ashish mittal wrote:
> > Hi,
> > 
> > I am getting the following error with checkpatch.pl
> > 
> > ERROR: externs should be avoided in .c files
> > #78: FILE: block/vxhs.c:28:
> > +QemuUUID qemu_uuid __attribute__ ((weak));
> > 
> > Is there any way to get around this, or does it mean that I would have
> > to add a vxhs.h just for this one entry?
> >
> 
> I remain skeptical on the use of the qemu_uuid as a way to select the TLS
> cert.

Yes, we should not be hardcoding arbitrary path lookup policies like that
in QEMU. The libqnio API should allow QEMU to specify what paths it wants
to use for certs directly. That allows the admin the flexibility to decide
their own policy for where to put certs and the policy on which certs are
used for which purpose.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
