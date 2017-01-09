Received: from eggs.gnu.org ([2001:4830:134:3::10]:45236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cQcl3-0000Mg-UK
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:25:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cQcl0-00046f-9E
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:25:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cQcl0-000464-35
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:25:14 -0500
Date: Mon, 9 Jan 2017 16:25:04 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170109162504.GH29989@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <58733617.3050503@huawei.com>
	<20170109134310.GE30228@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170109134310.GE30228@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] Question about add AF_ALG backend for virtio-crypto
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Longpeng (Mike)" <longpeng2@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU-DEV <qemu-devel@nongnu.org>, "Wubin (H)" <wu.wubin@huawei.com>, "Zhoujian (jay, Euler)" <jianjay.zhou@huawei.com>, Gonglei <arei.gonglei@huawei.com>

On Mon, Jan 09, 2017 at 01:43:10PM +0000, Stefan Hajnoczi wrote:
> On Mon, Jan 09, 2017 at 03:04:55PM +0800, Longpeng (Mike) wrote:
> > I'm one of Gonglei's virtio-crypto project members, and we plan to add a AF_ALG
> > backend for virtio-crypto(there's only builtin-backend currently).
> > 
> > I found that Catalin, Paolo and Stefan had discussed about this in 2015
> > (http://www.spinics.net/lists/kvm/msg115457.html), but it seems that Catalin
> > didn't do it, so I'm confuse about wether it is need to add a AF_ALG backend.
> > 
> > Do you have any suggestion? Thanks :)
> 
> I have no objections to an AF_ALG backend in QEMU.

Rather than do another backend for virtio-crypto, IMHO, we should have
an AF_ALG impl of the crypto/ APIs. That way any potential performance
benefits will enhance our LUKS encryption code too.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
