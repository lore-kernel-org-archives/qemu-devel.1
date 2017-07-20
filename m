Received: from eggs.gnu.org ([2001:4830:134:3::10]:46849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chugh.ishani@research.iiit.ac.in>)
	id 1dYIXN-0006Jv-1m
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 16:59:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chugh.ishani@research.iiit.ac.in>)
	id 1dYIXJ-00028D-Oy
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 16:59:09 -0400
Received: from research.iiit.ac.in ([196.12.53.8]:52572)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chugh.ishani@research.iiit.ac.in>)
	id 1dYIXJ-000241-3k
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 16:59:05 -0400
Date: Fri, 21 Jul 2017 02:28:54 +0530 (IST)
From: Ishani <chugh.ishani@research.iiit.ac.in>
Message-ID: <739348374.292427.1500584334946.JavaMail.zimbra@research.iiit.ac.in>
In-Reply-To: <20170720124618.GD32383@stefanha-x1.localdomain>
References: <1500318936-14106-1-git-send-email-chugh.ishani@research.iiit.ac.in>
	<20170720124618.GD32383@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6] Add manpage for QEMU Backup Tool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow <jsnow@redhat.com>


----- On Jul 20, 2017, at 6:16 PM, stefanha stefanha@redhat.com wrote:

> On Tue, Jul 18, 2017 at 12:45:36AM +0530, Ishani Chugh wrote:
> 
> This looks good.  I think it makes sense to include this patch with the
> patch series that adds the qemu-backup command.  That way the command
> and its man page will be merged together.

Thanks. I will include the patch for qemu-backup in same patch series.
 
>> +@item qemu-backup guest add --guest guestname --qmp socketpath [--tcp]
> 
> For consistency I suggest following QEMU chardev syntax for the socket
> path.  This also allows you to drop --tcp.
> 
> UNIX domain sockets look like this:
> 
>  unix:/path/to/socket
> 
> TCP addresses look like this:
> 
>   tcp:127.0.0.1:1234
Okay. Will fix it in next revision.Thanks.
