Received: from eggs.gnu.org ([2001:4830:134:3::10]:57002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dVSHe-0004lI-Qp
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 20:47:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dVSHb-0006JM-PV
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 20:47:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dVSHb-0006In-J9
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 20:47:07 -0400
Date: Thu, 13 Jul 2017 03:47:01 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170713034617-mutt-send-email-mst@kernel.org>
References: <1499847753-8513-1-git-send-email-thuth@redhat.com>
	<c737365b-61bc-3983-f923-7ee0737012e8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c737365b-61bc-3983-f923-7ee0737012e8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] hw/i386: Deprecate the machines pc-0.10
 to pc-1.2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu, Jul 13, 2017 at 02:30:06AM +0200, Laszlo Ersek wrote:
> On 07/12/17 10:22, Thomas Huth wrote:
> > We don't want to carry along old machine types forever. If we are able to
> > remove the pc machines up to 0.13 one day for example, this would allow
> > us to eventually kill the code for rombar=0 (i.e. where QEMU copies ROM
> > BARs directly to low memory). Everything up to pc-1.2 is also known to
> > have issues with migration.  So let's start with a deprecation message
> > for the old machine types so that the (hopefully) few users of these old
> > systems start switching over to newer machine types instead.
> > 
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >  Note: Even if we mark all these old machines as deprecated, this ofcourse
> >  doesn't mean that we also have to remove them all at once later when we
> >  decide to finally really remove some. We could then also start by removing
> >  0.10 and 0.11 only, for example (since there should really be no users left
> >  for these), or only up to 0.13 (to be able to kill rombar=0).
> 
> On a tangent: "rombar=0" shouldn't be killed before the libvirt domain
> XML regains the ability to say, "don't load any oprom for this device".
> Please see <https://bugzilla.redhat.com/show_bug.cgi?id=1425058>.
> 
> (Please note that it is not lost on me that rombar=0 is a poor
> substitute for romfile='', but currently rombar=0 is the only fallback
> through libvirt. See the BZ pls.)
> 
> Thanks
> Laszlo

rombar=0 would start meaning "no ROM", not "no BAR but still add a
rom".
