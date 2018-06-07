Received: from eggs.gnu.org ([2001:4830:134:3::10]:60846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fQrXF-0001if-05
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 05:48:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fQrXB-00044G-V8
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 05:48:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60536 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fQrXB-00043p-Q4
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 05:48:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5A36E818BAF1
	for <qemu-devel@nongnu.org>; Thu,  7 Jun 2018 09:48:45 +0000 (UTC)
Date: Thu, 7 Jun 2018 11:48:43 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180607114843.1d7508d3@redhat.com>
In-Reply-To: <20180605122636.33654-1-dgilbert@redhat.com>
References: <20180605122636.33654-1-dgilbert@redhat.com>
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
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com

On Tue,  5 Jun 2018 13:26:30 +0100
"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Reenable HMP in preconfig mode; it's pretty
> easy and anyway I want to do a similar thing for OOB eventually.
> We'll want to enable more commands in preconfig mode to make it
> useful at some point.
> 
> Dave
> 
> 
> Dr. David Alan Gilbert (6):
>   hmp: Add flag for preconfig commands
>   hmp: Allow help on preconfig commands
>   hmp: Restrict auto-complete in preconfig
>   hmp: Add info commands for preconfig
>   hmp: add exit_preconfig
>   hmp: Allow HMP in preconfig state again
> 
>  hmp-commands-info.hx |  9 +++++++++
>  hmp-commands.hx      | 17 +++++++++++++++++
>  hmp.c                |  7 +++++++
>  hmp.h                |  1 +
>  monitor.c            | 42 +++++++++++++++++++++++++++++++++---------
>  5 files changed, 67 insertions(+), 9 deletions(-)
> 

I was trying to find out way to use QMP schema info with HMP
without manual commands flagging but this looks so much simpler,
so that if it is acceptable I'm all in for this version.

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
except 4/6 which needs a little bit amended.
