Received: from eggs.gnu.org ([2001:4830:134:3::10]:55560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d47V8-0000DV-PF
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 11:08:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d47V7-0003Ta-Pk
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 11:08:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51236)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d47V7-0003Sc-JA
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 11:08:05 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 857A73DBE2
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 15:08:04 +0000 (UTC)
Date: Fri, 28 Apr 2017 16:07:58 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170428150758.GC3276@work-vm>
References: <20170425102446.4008-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170425102446.4008-1-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/6] Move snapshots commands to hmp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> Hi
> 
> This series:
> - Move snapshots commands to hmp.c, as they don't have code for migration
> - Make them work with errors in a modern way instead of writting to the monitor
> - make paolo happy and use hmp_handle_error
> 
> Later, Juan.

I'm happy with 1-5, 6 though, see comments.

If you want I can merge 1-5 via my next HMP pull, otherwise
if you want to do them via migration I agree with Laurent's Rb's so

Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> 
> Juan Quintela (6):
>   monitor: Remove monitor parameter from save_vmstate
>   monitor: Move hmp_loadvm from monitor.c to hmp.c
>   monitor: Move hmp_savevm from savevm.c to hmp.c
>   monitor: Move hmp_delvm from savevm.c to hmp.c
>   monitor: Move hmp_info_snapshots from savevm.c to hmp.c
>   migration: Pass Error ** argument to {save,load}_vmstate
> 
>  hmp.c                    | 179 +++++++++++++++++++++++++++++++++++++++
>  hmp.h                    |   4 +
>  include/sysemu/sysemu.h  |   7 +-
>  migration/savevm.c       | 216 ++++++-----------------------------------------
>  monitor.c                |  13 ---
>  replay/replay-snapshot.c |   6 +-
>  vl.c                     |   4 +-
>  7 files changed, 217 insertions(+), 212 deletions(-)
> 
> -- 
> 2.9.3
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
