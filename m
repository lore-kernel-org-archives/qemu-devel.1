Received: from eggs.gnu.org ([2001:4830:134:3::10]:59271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1cEp1M-0001w1-AA
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 22:05:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1cEp1H-00065y-Ci
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 22:05:20 -0500
Received: from mga02.intel.com ([134.134.136.20]:65463)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tianyu.lan@intel.com>)
	id 1cEp1H-00065H-5L
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 22:05:15 -0500
References: <1481020588-4245-1-git-send-email-peterx@redhat.com>
	<1481020588-4245-12-git-send-email-peterx@redhat.com>
From: Lan Tianyu <tianyu.lan@intel.com>
Message-ID: <f8541994-4a68-add3-6378-36dc9e37219f@intel.com>
Date: Thu, 8 Dec 2016 11:01:53 +0800
MIME-Version: 1.0
In-Reply-To: <1481020588-4245-12-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 11/13] intel_iommu: provide its own
 replay() callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, bd.aviv@gmail.com, alex.williamson@redhat.com, jasowang@redhat.com

On 2016年12月06日 18:36, Peter Xu wrote:
> +/**
> + * vtd_page_walk - walk specific IOVA range, and call the hook
> + *
> + * @ce: context entry to walk upon
> + * @start: IOVA address to start the walk
> + * @end: size of the IOVA range to walk over


*·@end:·IOVA·range·end·address·(start·<=·addr·<·end)
This comment for vtd_page_walk_level() maybe more accurate here?


-- 
Best regards
Tianyu Lan
