Received: from eggs.gnu.org ([2001:4830:134:3::10]:52073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fQqmh-00018q-4z
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 05:00:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fQqmc-0001bY-BY
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 05:00:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33464 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fQqmb-0001av-Uz
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 05:00:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E0E65CB9D1
	for <qemu-devel@nongnu.org>; Thu,  7 Jun 2018 09:00:36 +0000 (UTC)
Date: Thu, 7 Jun 2018 10:00:30 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180607090030.GC2522@work-vm>
References: <20180605122636.33654-1-dgilbert@redhat.com>
	<20180607085444.GM750@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607085444.GM750@xz-mi>
Subject: Re: [Qemu-devel] [PATCH 0/6] Reenable hmp for preconfig mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, imammedo@redhat.com

* Peter Xu (peterx@redhat.com) wrote:
> On Tue, Jun 05, 2018 at 01:26:30PM +0100, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > Reenable HMP in preconfig mode; it's pretty
> > easy and anyway I want to do a similar thing for OOB eventually.
> > We'll want to enable more commands in preconfig mode to make it
> > useful at some point.
> > 
> > Dave
> 
> Wanna add "quit" into the preconfig-allowed list for HMP as well?

I tried; quit triggers a disallowed state transition!

> Tested-by: Peter Xu <peterx@redhat.com>
> 
> -- 
> Peter Xu
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
