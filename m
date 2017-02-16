Received: from eggs.gnu.org ([2001:4830:134:3::10]:44013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ceBsE-0000YQ-MV
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 21:32:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ceBsB-0006p5-Id
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 21:32:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52882)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ceBsB-0006oF-CL
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 21:32:43 -0500
Date: Thu, 16 Feb 2017 10:32:36 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170216023236.GD15985@pxdev.xzpeter.org>
References: <1487058692-2789-1-git-send-email-peterx@redhat.com>
	<58A50BD8.3070506@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <58A50BD8.3070506@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH] pcie: simplify pcie_add_capability()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Thu, Feb 16, 2017 at 10:18:00AM +0800, Cao jin wrote:
> Hi peter
> 
> On 02/14/2017 03:51 PM, Peter Xu wrote:
> > When we add PCIe extended capabilities, we should be following the rule
> > that we add the head extended cap (at offset 0x100) first, then the rest
> > of them. Meanwhile, we are always adding new capability bits at the end
> > of the list. Here the "next" looks meaningless in all cases since it
> > should always be zero (along with the "header").
> > 
> > Simplify the function a bit, and it looks more readable now.
> > 
> 
> See if this suggestion could be incorporated into your patch:)
> http://lists.nongnu.org/archive/html/qemu-devel/2017-01/msg01418.html

Sure. But imho that's really trivial and as long as the assertions are
working correctly (no matter in which order) I can live with both. :)

Anyway, thanks for the pointer!

-- peterx
