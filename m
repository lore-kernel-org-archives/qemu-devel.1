Received: from eggs.gnu.org ([2001:4830:134:3::10]:36559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evQEX-0006b7-BF
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:23:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evQEW-0001Uo-Jw
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:23:33 -0400
Date: Mon, 12 Mar 2018 17:23:19 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180312162319.GH31537@localhost.localdomain>
References: <20180310082746.24198-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180310082746.24198-1-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 00/21] blockjobs: add explicit job
 management
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org

Am 10.03.2018 um 09:27 hat John Snow geschrieben:
> This series seeks to address two distinct but closely related issues
> concerning the job management API.
> 
> (1) For jobs that complete when a monitor is not attached and receiving
>     events or notifications, there's no way to discern the job's final
>     return code. Jobs must remain in the query list until dismissed
>     for reliable management.
> 
> (2) Jobs that change the block graph structure at an indeterminate point
>     after the job starts compete with the management layer that relies
>     on that graph structure to issue meaningful commands.
> 
>     This structure should change only at the behest of the management
>     API, and not asynchronously at unknown points in time. Before a job
>     issues such changes, it must rely on explicit and synchronous
>     confirmation from the management API.
> 
> These changes are implemented by formalizing a State Transition Machine
> for the BlockJob subsystem.

Thanks, applied to the block branch.

Kevin
