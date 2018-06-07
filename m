Received: from eggs.gnu.org ([2001:4830:134:3::10]:60007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fQrTx-0000OH-Mt
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 05:45:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fQrTu-0001E0-Fn
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 05:45:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34134 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fQrTu-0001DT-BS
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 05:45:22 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CC187401EF14
	for <qemu-devel@nongnu.org>; Thu,  7 Jun 2018 09:45:21 +0000 (UTC)
Date: Thu, 7 Jun 2018 11:45:17 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180607114517.0148aa75@redhat.com>
In-Reply-To: <20180607085444.GM750@xz-mi>
References: <20180605122636.33654-1-dgilbert@redhat.com>
	<20180607085444.GM750@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, armbru@redhat.com

On Thu, 7 Jun 2018 16:54:44 +0800
Peter Xu <peterx@redhat.com> wrote:

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
There is exit-preconfig, but yeah it just forwards us to the next state

But for human users that just want to play with HMP 'quit'
might be useful, but only to the extent of trying out things out.
 
> Tested-by: Peter Xu <peterx@redhat.com>
> 
