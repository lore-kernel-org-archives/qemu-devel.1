Received: from eggs.gnu.org ([209.51.188.92]:54962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gjgTO-0002my-CJ
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 03:22:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gjgTN-0004fr-Ej
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 03:22:54 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54556)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gjgTL-0004T0-F2
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 03:22:53 -0500
Received: by mail-wm1-f67.google.com with SMTP id a62so974511wmh.4
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 00:22:41 -0800 (PST)
Date: Wed, 16 Jan 2019 09:22:37 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190116082237.hqftqcgm56wtzovr@steredhat>
References: <20190115100058.44712-1-sgarzare@redhat.com>
	<20190115100058.44712-5-sgarzare@redhat.com>
	<20190115135548-mutt-send-email-mst@kernel.org>
	<3db58f6f-44fc-da64-2cfb-41404a9b2319@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3db58f6f-44fc-da64-2cfb-41404a9b2319@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/4] hw/i386/pc: use PVH option rom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, George Kennedy <george.kennedy@oracle.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Marc-Andre Lureau <marcandre.lureau@redhat.com>, Richard Henderson <rth@twiddle.net>, Stefan Hajnoczi <stefanha@redhat.com>, Liam Merwick <liam.merwick@oracle.com>, Maran Wilson <maran.wilson@oracle.com>

Hi Eric,

On Tue, Jan 15, 2019 at 01:12:21PM -0600, Eric Blake wrote:
> On 1/15/19 12:57 PM, Michael S. Tsirkin wrote:
> > On Tue, Jan 15, 2019 at 11:00:58AM +0100, Stefano Garzarella wrote:
> >> Use pvh.bin option rom when we are booting an uncompressed
> >> kernel using the x86/HVM direct boot ABI.
> >>
> >> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> >> Based-on: <1545422632-24444-5-git-send-email-liam.merwick@oracle.com>
> > 
> > I don't think this is a great way to give attribution.
> > Can you pls include the author name and the S.O.B from there as well?
> > 
> > 
> >> ---
> 
> Patchew understands Based-on: tags as meaning a prerequisite patch on
> the list that must be applied first before this patch can apply (and NOT
> in the sense that this patch is an updated revision to replace an
> earlier revision posted by someone else) - but when using the annotation
> to keep Patchew happy, it should either be in a 0/N cover letter, or for
> a single patch, after the --- separator, as the condition of a
> prerequisite patch not being applied is a transient condition relevant
> to the current build but not something that needs to be recorded in
> long-term git history.
> 

Thank you very much for the explanation! I'll move the Based-on tag in
the cover letter.

Cheers,
Stefano
