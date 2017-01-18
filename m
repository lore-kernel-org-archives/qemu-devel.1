Received: from eggs.gnu.org ([2001:4830:134:3::10]:46759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mtosatti@redhat.com>) id 1cUWMS-00087L-OS
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 05:24:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mtosatti@redhat.com>) id 1cUWMO-0006s9-QO
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 05:24:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mtosatti@redhat.com>) id 1cUWMO-0006rW-K7
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 05:23:56 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C9F7761BA8
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 10:23:55 +0000 (UTC)
Date: Wed, 18 Jan 2017 15:54:03 -0200
From: Marcelo Tosatti <mtosatti@redhat.com>
Message-ID: <20170118175359.GA6631@amt.cnet>
References: <20170118160308.GC2085@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170118160308.GC2085@work-vm>
Subject: Re: [Qemu-devel] kvmclock in wrong compat macro?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org

On Wed, Jan 18, 2017 at 04:03:08PM +0000, Dr. David Alan Gilbert wrote:
> Hi Marcelo,
>    In commit 6053a86 'kvmclock: reduce kvmclock differences on migration'
> you add a 'x-mach-use-reliable-get-clock' and a compatibility entry
> that turns it off; if I'm reading it right though it got merged
> after 2.8.0 was released but the entry has gone into PC_COMPAT_2_7
> where I guess it should have gone into PC_COMPAT_2_8.

Hi David, 

Thats right: there was a merge/time conflict (patch was written when 
PC_COMPAT_2_8 made sense). Patch sent.

> Also, why is it x86 specific?

Because kvmclock is.
