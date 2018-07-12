Received: from eggs.gnu.org ([2001:4830:134:3::10]:44114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fdXWR-00087z-8M
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 05:04:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fdXWQ-0002Po-Gp
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 05:04:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37804 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fdXWQ-0002P9-Bp
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 05:04:22 -0400
Date: Thu, 12 Jul 2018 11:04:19 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180712110419.685f0d04@redhat.com>
In-Reply-To: <759f6dde-7350-70b9-1867-d2d1781df16b@redhat.com>
References: <20180710155037.16834-1-stefanha@redhat.com>
	<20180710155037.16834-2-stefanha@redhat.com>
	<20180711172208.288fc0bb@redhat.com>
	<759f6dde-7350-70b9-1867-d2d1781df16b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] qdev: add HotplugHandler->post_plug()
 callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, l00284672 <lizhengui@huawei.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

On Wed, 11 Jul 2018 18:48:21 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 11/07/2018 17:22, Igor Mammedov wrote:
> > It also seems wrong to call _plug handler on maybe partially
> > initialized device so perhaps we should first finish devices/children
> > realization then do reset and only after that call _plug() handler  
> 
> I agree but this is too dangerous until we look at plug() handlers and
I'll put on my TODO list for 3.1

> remove the usage of Error **.
considering we have _per_plug now with all checks, we probably
would be able to remove Error** from _plug but only after splitting/auditing
existing _plug callbacks.

>  Introducing a new callback helps the
> transition.
sure, we can drop it later

> Paolo
> 
