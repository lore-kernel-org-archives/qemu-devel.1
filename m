Received: from eggs.gnu.org ([209.51.188.92]:41036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gjklH-0007oQ-BD
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 07:57:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gjklF-0008E8-8b
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 07:57:39 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20190111191401.18317-2-armbru@redhat.com>
References: <20190111191401.18317-1-armbru@redhat.com>
	<20190111191401.18317-2-armbru@redhat.com>
Date: Wed, 16 Jan 2019 13:57:26 +0100
Message-ID: <w5136psyd3d.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/1] block: Eliminate the
 S_1KiB, S_2KiB, ... macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, lbloch@janustech.com, qemu-block@nongnu.org

On Fri 11 Jan 2019 08:14:01 PM CET, Markus Armbruster wrote:
> We define 54 macros for the powers of two >= 1024.  We use six, in six
> macro definitions.  Four of them could just as well use the common MiB
> macro, so do that.  The remaining two can't, because they get passed
> to stringify.  Replace the macro by the literal number there.
> Slightly harder to read in one instance (1048576 vs. S_1MiB), so add a
> comment there.  The other instance is a wash: 65536 vs S_64KiB.  65536
> has been good enough for more than seven years there.
>
> This effectively reverts commit 540b8492618 and 1240ac558d3.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
