Received: from eggs.gnu.org ([2001:4830:134:3::10]:32865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eZA6J-0004fa-Sj
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 01:43:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eZA6F-0005Pq-0Y
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 01:43:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eZA6E-0005On-Q7
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 01:42:58 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 96BE249039
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 06:42:57 +0000 (UTC)
Date: Wed, 10 Jan 2018 14:42:52 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180110064252.GE5984@xz-mi>
References: <20180105215246.908-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180105215246.908-1-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 00/11] Add make check tests for Migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com

On Fri, Jan 05, 2018 at 10:52:35PM +0100, Juan Quintela wrote:
> 
> Hi
> 
> In v4:
> 
> Based-on: 20180105205109.683-1-quintela@redhat.com
> 
> Changes:
> - rebase on top on v4 info_migrate patches
> - Tune sleeps to make patches fast
> - Create a deprecated test for deprecated commands (i.e. make peterxu happy)
> - create migrate_start_postcopy function
> - fix naming/sizes between power and x86
> - cleanup comments to match code
> 
> Please, review.

I left some comments on specific patches, for the rest I think the
series looks good to me.  Thanks,

-- 
Peter Xu
