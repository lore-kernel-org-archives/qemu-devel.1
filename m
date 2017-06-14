Received: from eggs.gnu.org ([2001:4830:134:3::10]:42048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dL0Nv-0003JX-BF
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 00:58:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dL0Np-0007lL-GW
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 00:58:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dL0Np-0007h7-As
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 00:58:21 -0400
Date: Wed, 14 Jun 2017 12:58:15 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170614045815.GG11751@pxdev.xzpeter.org>
References: <1497346593-8791-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170613093801eucas1p1e2b34c1a72b7150a28007d5b187da82e@eucas1p1.samsung.com>
	<1497346593-8791-3-git-send-email-a.perevalov@samsung.com>
	<87tw3kjer9.fsf@secure.mitica>
	<154a8295-381a-b7dd-41b9-d9f720b790f6@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <154a8295-381a-b7dd-41b9-d9f720b790f6@samsung.com>
Subject: Re: [Qemu-devel] [PATCH v1 2/2] migration: add bitmap for copied
 page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>
Cc: quintela@redhat.com, qemu-devel@nongnu.org, i.maximets@samsung.com, dgilbert@redhat.com

On Tue, Jun 13, 2017 at 03:00:28PM +0300, Alexey Perevalov wrote:
> On 06/13/2017 02:42 PM, Juan Quintela wrote:

[...]

> >>Bitmap is placed into RAMBlock as another postcopy/precopy
> >>related bitmaps.
> >Why are we not using the TARGET_PAGE_SIZE as units of the bitmap?
> Page size per ram block can be different, just to
> reduce whole size of bitmap.

I think one reason that we should use TARGET_PAGE_SIZE not
per-ramblock page size bitmap is that we need to let this
copied_bitmap/recved_bitmap work even during precopy phase, and in
precopy phase we are migrating pages in target page size, not host
page size.

Thanks,

-- 
Peter Xu
