Received: from eggs.gnu.org ([2001:4830:134:3::10]:59829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eZHVo-0003UL-99
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 09:37:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eZHVl-0002Ia-55
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 09:37:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eZHVk-0002Hq-Uy
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 09:37:49 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DA872776C0
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 14:37:47 +0000 (UTC)
Date: Wed, 10 Jan 2018 14:37:42 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180110143742.GD2450@work-vm>
References: <20180110142515.13242-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180110142515.13242-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] find_ram_offset cleanups and
 alignment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, eblake@redhat.com

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> These are basically David's patches, with a couple changes for clarity
> and robustness.

Yes, those look fine to me.
(Patchew seems to be annoyed at the Tracing - I can't see why)

Dave

> Dr. David Alan Gilbert (2):
>   find_ram_offset: Add comments and tracing
>   find_ram_offset: Align ram_addr_t allocation on long boundaries
> 
>  exec.c       | 33 ++++++++++++++++++++++++++-------
>  trace-events |  4 ++++
>  2 files changed, 30 insertions(+), 7 deletions(-)
> 
> -- 
> 2.14.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
