Received: from eggs.gnu.org ([2001:4830:134:3::10]:36887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1etDjZ-0004Vw-Gk
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 09:38:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1etDjW-0001PH-Ue
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 09:38:29 -0500
Date: Tue, 6 Mar 2018 15:38:15 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180306153815.57bce6a8.cohuck@redhat.com>
In-Reply-To: <20180306100721.19419-1-nia.alarie@gmail.com>
References: <20180306100721.19419-1-nia.alarie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/2] s390x/sclpconsole: Remove dead code
 - remove exit handlers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nia Alarie <nia.alarie@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, borntraeger@de.ibm.com, rth@twiddle.net, stefanha@gmail.com, jim@groklearning.com, joel@jms.id.au

On Tue,  6 Mar 2018 10:07:20 +0000
Nia Alarie <nia.alarie@gmail.com> wrote:

> The other event handlers (quiesce and cpu) do not define these
> handlers, and this one does nothing, so it can be removed.
> 
> Signed-off-by: Nia Alarie <nia.alarie@gmail.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  hw/char/sclpconsole-lm.c          |  6 ------
>  hw/char/sclpconsole.c             |  6 ------
>  hw/s390x/event-facility.c         | 14 --------------
>  include/hw/s390x/event-facility.h |  1 -
>  4 files changed, 27 deletions(-)

Thanks, applied.
