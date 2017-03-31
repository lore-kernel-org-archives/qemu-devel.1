Received: from eggs.gnu.org ([2001:4830:134:3::10]:50731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carpeddiem@gmail.com>) id 1cu0gD-0003nV-FL
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 13:49:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carpeddiem@gmail.com>) id 1cu0gC-0003ow-Nw
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 13:49:45 -0400
MIME-Version: 1.0
Sender: carpeddiem@gmail.com
In-Reply-To: <8e26dbca-d2be-01bc-bfa3-a73fcb9d1498@redhat.com>
References: <1490970783-29231-1-git-send-email-minyard@acm.org>
	<8e26dbca-d2be-01bc-bfa3-a73fcb9d1498@redhat.com>
From: Ed Maste <emaste@freebsd.org>
Date: Fri, 31 Mar 2017 13:49:23 -0400
Message-ID: <CAPyFy2C3rQOK_AeyPLWji4LgHS2UdJCa1DFQEG51SGe7D0VR7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH for-2.9? v4] ipmi: Fix macro issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Corey Minyard <minyard@acm.org>, qemu-devel <qemu-devel@nongnu.org>, "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>, Corey Minyard <cminyard@mvista.com>

On 31 March 2017 at 11:04, Eric Blake <eblake@redhat.com> wrote:
>
> Might also be worth adding that an audit of the code finds no semantic
> change, that this is just cleaning up the compiler warning.

We should include core detail of your detailed analysis in such a
statement I think, because I it's more than just cleaning up a
warning. For me at least the warning pointed out that the expression
is not parsed would be expected (if this were a function and not a
macro), and it's just because of constraints on the inputs that
there's no functional change.

>> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Ed Maste <emaste@freebsd.org>
