Received: from eggs.gnu.org ([2001:4830:134:3::10]:38534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eTLZt-0002uA-LA
	for qemu-devel@nongnu.org; Mon, 25 Dec 2017 00:45:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eTLZq-0003tX-6c
	for qemu-devel@nongnu.org; Mon, 25 Dec 2017 00:45:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eTLZp-0003sf-RL
	for qemu-devel@nongnu.org; Mon, 25 Dec 2017 00:45:30 -0500
Date: Mon, 25 Dec 2017 13:45:22 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171225054522.GI2443@xz-mi>
References: <1513836919-13458-1-git-send-email-yi.l.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1513836919-13458-1-git-send-email-yi.l.liu@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH] intel_iommu: a fix to
 vtd_dev_get_trans_type()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, yi.l.liu@intel.com

On Thu, Dec 21, 2017 at 02:15:19PM +0800, Liu, Yi L wrote:
> vtd_ce_get_type() returns uin32_t and vtd_dev_get_trans_type() returns
> the value from vtd_ce_get_type(). However, vtd_dev_get_trans_type()
> returns int. This patch switchs to return the translation type by
> parameter. It avoids unsigned to int transfer and also avoid potential
> reading confusion.

Frankly speaking I would still prefer the old way to do it: return
type when >=0 and error when <0.  After all we have a comment for
vtd_dev_get_trans_type() already:

/*
 * Fetch translation type for specific device. Returns <0 if error
 * happens, otherwise return the shifted type to check against
 * VTD_CONTEXT_TT_*.
 */

Thanks,

-- 
Peter Xu
