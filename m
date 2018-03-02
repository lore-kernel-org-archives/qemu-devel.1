Received: from eggs.gnu.org ([2001:4830:134:3::10]:54659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1erf8l-0003rq-Dp
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 02:30:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1erf8h-00075D-Fh
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 02:30:03 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42860 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1erf8h-00074Y-Ax
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 02:29:59 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C27354022905
	for <qemu-devel@nongnu.org>; Fri,  2 Mar 2018 07:29:48 +0000 (UTC)
Date: Fri, 2 Mar 2018 15:29:37 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180302072937.GK27381@xz-mi>
References: <20180216131625.9639-1-dgilbert@redhat.com>
	<20180216131625.9639-19-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180216131625.9639-19-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 18/29] vhost+postcopy: Resolve client
 address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, marcandre.lureau@redhat.com, imammedo@redhat.com, mst@redhat.com, quintela@redhat.com, aarcange@redhat.com

On Fri, Feb 16, 2018 at 01:16:14PM +0000, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Resolve fault addresses read off the clients UFD into RAMBlock
> and offset, and call back to the postcopy code to ask for the page.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
