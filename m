Received: from eggs.gnu.org ([2001:4830:134:3::10]:50702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQqh3-0004OU-DJ
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 04:54:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQqh0-0006Gi-Bj
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 04:54:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49652 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fQqh0-0006Gc-5H
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 04:54:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6E804402243B
	for <qemu-devel@nongnu.org>; Thu,  7 Jun 2018 08:54:49 +0000 (UTC)
Date: Thu, 7 Jun 2018 16:54:44 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180607085444.GM750@xz-mi>
References: <20180605122636.33654-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180605122636.33654-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/6] Reenable hmp for preconfig mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, imammedo@redhat.com

On Tue, Jun 05, 2018 at 01:26:30PM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Reenable HMP in preconfig mode; it's pretty
> easy and anyway I want to do a similar thing for OOB eventually.
> We'll want to enable more commands in preconfig mode to make it
> useful at some point.
> 
> Dave

Wanna add "quit" into the preconfig-allowed list for HMP as well?

Tested-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
