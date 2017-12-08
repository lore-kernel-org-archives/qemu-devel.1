Received: from eggs.gnu.org ([2001:4830:134:3::10]:41385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eNG0Y-0003eQ-Gm
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:35:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eNG0U-0004al-Ix
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:35:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eNG0U-0004Zz-CM
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:35:50 -0500
Date: Fri, 8 Dec 2017 10:35:45 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171208103545.GE11767@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CAO1xR-zb6Eni1LD0PB80hGRKU8PCqxjbfHtVM4aUt9i+3Utq3w@mail.gmail.com>
	<20171207184104.GA2489@work-vm>
	<CAN05THQcpCXpckxAymH00G96XdJ30RsnGAgXOA+F98vaaKWgHA@mail.gmail.com>
	<CAO1xR-yCeF9NBBLL_fr7D3CoSq924r+kP_DA+vmg41acUF0Ehw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAO1xR-yCeF9NBBLL_fr7D3CoSq924r+kP_DA+vmg41acUF0Ehw@mail.gmail.com>
Subject: Re: [Qemu-devel] iSER transport name is not good
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Charles Kelimod <lichstor@gmail.com>
Cc: ronnie sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On Fri, Dec 08, 2017 at 03:27:27PM +0800, Charles Kelimod wrote:
> Hi Dave and Sahlberg,
> 
> for this type of name:iser://<host>/<iqn>/<lun>, I completely agree with
> you.
> my issue is when I create an vm from libvirt, the qemu command line should
> be:
> -drive
> file.driver=iser,file.portal=xx.xx.xx.xx:3260,file.target=iqn.xxx,file.lun=0,file.transport=iser
> 
> Actually "iser" is added by me in libvirt, which can work by a little
> modification. But I think file.transport=rdma would be better, as I think
> iser is protocol, and rdma is transport, and libvirt defined it, if I added
> a new transport name (iser) in libvirt, it will be confusable.

If libvirt already supports this, then we won't change it, as that just creates
needless backcompatibility problems. There's many cases where we have wierd or
undesirable names for things, but at a low level we just accept them and carry
on, as wierd names don't have any negative functional impact. At the higher
app user interface, it can be renamed as desired, since UI has no backcompat
problems, as long as the low level stays the same.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
