Received: from eggs.gnu.org ([2001:4830:134:3::10]:56471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1egCmZ-0006SL-Rp
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:59:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1egCmZ-0002XK-2b
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:59:47 -0500
Date: Mon, 29 Jan 2018 17:59:29 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180129165929.GK6141@localhost.localdomain>
References: <20180127020515.27137-1-jsnow@redhat.com>
	<20180127020515.27137-2-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180127020515.27137-2-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [RFC v3 01/14] blockjobs: add manual property
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

Am 27.01.2018 um 03:05 hat John Snow geschrieben:
> This property will be used to opt-in to the new BlockJobs workflow
> that allows a tighter, more explicit control over transitions from
> one runstate to another.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>

> diff --git a/include/block/blockjob.h b/include/block/blockjob.h
> index 00403d9482..b94d0c9fa6 100644
> --- a/include/block/blockjob.h
> +++ b/include/block/blockjob.h
> @@ -141,6 +141,11 @@ typedef struct BlockJob {
>       */
>      QEMUTimer sleep_timer;
>  
> +    /* Set to true when management API has requested 2.12+ job lifetime
> +     * management semantics.
> +     */
> +    bool manual;

Wouldn't it make more sense to describe what "2.12+ job lifetime
management semantics" actually are? Maybe then it would be easy to find
a more specific name, too, like manual_completion.

In fact, I wonder if the opposite flag wouldn't be nicer, i.e. having a
bool auto_completion (or finalization or whatever that extra step was
called in the final draft), defaulting to true.

Also, the comment style in this header is already pretty messed up, but
I think the styles that were originally meant to be used there, are

    /** this one for single lines */

    /**
     * and this one if things get a bit longer
     * and you need multiple lines.
     */

Kevin
