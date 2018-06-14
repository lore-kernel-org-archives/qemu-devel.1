Received: from eggs.gnu.org ([2001:4830:134:3::10]:41117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fTPw6-00087x-Ie
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 06:57:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fTPw2-0001v1-Nl
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 06:57:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38750 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fTPw2-0001u7-Im
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 06:56:58 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0E9F9401EF39
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 10:56:58 +0000 (UTC)
Date: Thu, 14 Jun 2018 18:56:53 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180614105653.GC14019@xz-mi>
References: <20180613102642.23995-1-dgilbert@redhat.com>
	<20180613102642.23995-4-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180613102642.23995-4-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] migration/postcopy: Wake rate limit
 sleep on postcopy request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, jdenemar@redhat.com

On Wed, Jun 13, 2018 at 11:26:42AM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Use the 'urgent request' mechanism added in the previous patch
> for entries added to the postcopy request queue for RAM.  Ignore
> the rate limiting while we have requests.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
