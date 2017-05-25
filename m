Received: from eggs.gnu.org ([2001:4830:134:3::10]:37151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dDwS3-0004g4-Vy
	for qemu-devel@nongnu.org; Thu, 25 May 2017 13:21:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dDwS0-0004KI-Sf
	for qemu-devel@nongnu.org; Thu, 25 May 2017 13:21:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dDwS0-0004K0-M7
	for qemu-devel@nongnu.org; Thu, 25 May 2017 13:21:28 -0400
Date: Thu, 25 May 2017 20:21:16 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170525202109-mutt-send-email-mst@kernel.org>
References: <20170524090520.321-1-maxime.coquelin@redhat.com>
	<20170525005724-mutt-send-email-mst@kernel.org>
	<3f613ef1-0d8b-3d68-ac9d-a3a5c019df26@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f613ef1-0d8b-3d68-ac9d-a3a5c019df26@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] vhost-user: pass message as a pointer
 to process_message_reply()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: zhiyong.yang@intel.com, qemu-devel@nongnu.org, jfreiman@redhat.com, marcandre.lureau@redhat.com

On Thu, May 25, 2017 at 05:57:43PM +0200, Maxime Coquelin wrote:
> 
> 
> On 05/24/2017 11:58 PM, Michael S. Tsirkin wrote:
> > On Wed, May 24, 2017 at 11:05:20AM +0200, Maxime Coquelin wrote:
> > > process_message_reply() was recently updated to get full message
> > > content instead of only its request field.
> > > 
> > > There is no need to copy all the struct content into the stack,
> > > so just pass its pointer as const.
> > > 
> > > Cc: Zhiyong Yang <zhiyong.yang@intel.com>
> > > Fixes: 60cd11024f41 ("hw/virtio: fix vhost user fails to startup when MQ")
> > > Reviewed-by: Jens Freimann <jfreiman@redhat.com>
> > > Reviewed-by: Zhiyong Yang <zhiyong.yang@intel.com>
> > > Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> > 
> > Why "Fixes"? It's not a bugfix, is it? Passing a pointer is
> > slightly cleaner but it's not a big deal IMHO. I'll apply
> > but would like to get clarification on this tag.
> 
> Right, this is not a bug fix.
> I noticed this while rebasing my Vhost-user IOMMU series,
> which will call this function much more often than currently.
> That said, I haven't done any measurements, and I don't believe it
> will have a noticeable impact.
> 
> Feel free to remove the "Fixes:" line when applying, or I can resend
> if you prefer.
> 
> Maxime

Applied no need to resend.
