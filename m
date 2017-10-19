Received: from eggs.gnu.org ([2001:4830:134:3::10]:35448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e52XV-0001Fy-9G
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 00:34:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e52XR-0005Xa-5P
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 00:34:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1e52XQ-0005W8-V2
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 00:34:33 -0400
Date: Thu, 19 Oct 2017 12:34:26 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171019043426.GB7850@pxdev.xzpeter.org>
References: <20171018174013.22709-1-dgilbert@redhat.com>
	<20171018174013.22709-3-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171018174013.22709-3-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/7] migration: Add 'pre-switchover' and
 'device' statuses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jdenemar@redhat.com, wangjie88@huawei.com, quintela@redhat.com, mreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, fuweiwei2@huawei.com

On Wed, Oct 18, 2017 at 06:40:08PM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Add two statuses for use when the 'pause-before-switchover'
> capability is enabled.
> 
> 'pre-switchover' is the state that we wait in for management
> to allow us to continue.
> 'device' is the state we enter while serialising the devices
> after management gives us the OK.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

I proposed another naming in cover letter, but this one is ok to me as
well.  For either case:

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
