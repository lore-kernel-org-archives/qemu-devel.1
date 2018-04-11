Received: from eggs.gnu.org ([2001:4830:134:3::10]:49307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f6Agl-000809-8W
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 04:01:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f6AgW-0007CC-H9
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 04:01:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60246 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f6AgW-00079A-8L
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 04:00:52 -0400
Date: Wed, 11 Apr 2018 16:00:36 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180411080036.GD13887@xz-mi>
References: <20180411072027.5656-1-tiwei.bie@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180411072027.5656-1-tiwei.bie@intel.com>
Subject: Re: [Qemu-devel] [RFC] vhost-user: introduce F_NEED_ALL_IOTLB
 protocol feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com

On Wed, Apr 11, 2018 at 03:20:27PM +0800, Tiwei Bie wrote:

[...]

> This is just a RFC for now. It seems that, it doesn't work
> as expected when guest is using kernel driver (To handle
> this case, it seems that some RAM regions' events also need
> to be listened). Any comments would be appreciated! Thanks!

Hi, Tiwei,

What's your kernel command line in the guest?  Is iommu=pt there?

-- 
Peter Xu
