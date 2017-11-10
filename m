Received: from eggs.gnu.org ([2001:4830:134:3::10]:36799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eDAFI-0005qI-8S
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 09:25:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eDAFD-0006f1-Qi
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 09:25:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1eDAFD-0006dH-CQ
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 09:25:19 -0500
Date: Fri, 10 Nov 2017 15:25:06 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171110142506.GE5466@localhost.localdomain>
References: <cover.1505737465.git.maozy.fnst@cn.fujitsu.com>
	<7f98890b-ee32-d539-0823-06544849457a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f98890b-ee32-d539-0823-06544849457a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/6] Convert to realize and improve
 error handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Keith Busch <keith.busch@intel.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Am 19.09.2017 um 01:59 hat John Snow geschrieben:
> On 09/18/2017 10:05 AM, Mao Zhongyi wrote:
> > This series mainly implements the conversions of ide, floppy and nvme
> > device to realize. Add some error handling messages and remove the local
> > variable local_err, use errp to propagate the error directly. Also
> > fix the unusual function name.
> 
> I've staged patches one and two here for my IDE pull request.
> 
> I think patches 3-6 here would belong to Kevin.

Sorry, I completely missed this.

Thanks, applied patch 3 (nvme) to the block-next branch. I did not take
patches 4 and 5 because patch 5 doesn't apply cleanly any more, and
honestly I think the result is uglier than before.

Patch 6 is for Gerd.

Kevin
