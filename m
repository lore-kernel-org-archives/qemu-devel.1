Received: from eggs.gnu.org ([2001:4830:134:3::10]:51813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eSNkV-0003DT-VZ
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 08:52:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eSNkQ-0007cs-P0
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 08:52:32 -0500
Date: Fri, 22 Dec 2017 14:52:08 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171222135208.GI3763@localhost.localdomain>
References: <1513901496-13538-1-git-send-email-jack.schwartz@oracle.com>
	<1513901496-13538-2-git-send-email-jack.schwartz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1513901496-13538-2-git-send-email-jack.schwartz@oracle.com>
Subject: Re: [Qemu-devel] [PATCH v1 1/1] block: Add numeric errno field to
 BLOCK_IO_ERROR events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jack Schwartz <jack.schwartz@oracle.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com, karl.heubaum@oracle.com, konrad.wilk@oracle.com

Am 22.12.2017 um 01:11 hat Jack Schwartz geschrieben:
> BLOCK_IO_ERROR events currently contain a "reason" string which is
> strerror(errno) of the error.  This enhancement provides those events with
> the numeric errno value as well, since it is easier to parse for error type
> than a string.
> 
> Signed-off-by: Jack Schwartz <jack.schwartz@oracle.com>
> Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>

Apart from the technical details that Eric mentioed, I wonder what is
your use case for this?

Exposing errors in a machine readable form was discussed earlier, and
the result was that nobody had an actual use for error codes other than
presenting the right error message to the user - which the error string
already achieves.

The only exception so far was ENOSPC, which some management tools like
oVirt respond to by increasing the volume size, so this was mapped into
a bool.

Kevin
