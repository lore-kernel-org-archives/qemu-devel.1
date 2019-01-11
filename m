Received: from eggs.gnu.org ([209.51.188.92]:37684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ghvFG-0002Nk-Ng
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 06:45:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ghvFG-0003Ys-1G
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 06:45:02 -0500
Date: Fri, 11 Jan 2019 12:44:55 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190111124455.4ad73520.cohuck@redhat.com>
In-Reply-To: <1547123559-30476-1-git-send-email-thuth@redhat.com>
References: <1547123559-30476-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] pc-bios/s390-ccw: Use proper register
 names for Clang
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On Thu, 10 Jan 2019 13:32:39 +0100
Thomas Huth <thuth@redhat.com> wrote:

> When compiling the s390-ccw firmware with Clang 7.0.1, I get the
> following errors:
> 
> pc-bios/s390-ccw/start.S:62:19: error: invalid use of length addressing
>         stctg 0,0,0(15)
>                   ^
> pc-bios/s390-ccw/start.S:63:12: error: invalid use of length addressing
>         oi 6(15), 0x2
>            ^
> pc-bios/s390-ccw/start.S:64:19: error: invalid use of length addressing
>         lctlg 0,0,0(15)
>                   ^
> pc-bios/s390-ccw/start.S:76:19: error: invalid use of length addressing
>         stctg 0,0,0(15)
>                   ^
> pc-bios/s390-ccw/start.S:77:12: error: invalid use of length addressing
>         ni 6(15), 0xfd
>            ^
> pc-bios/s390-ccw/start.S:78:19: error: invalid use of length addressing
>         lctlg 0,0,0(15)
>                   ^
> pc-bios/s390-ccw/start.S:79:12: error: invalid operand for instruction
>         br 14
>            ^
> 
> Let's use proper register names like in the rest of this file to fix it.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  pc-bios/s390-ccw/start.S | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Thanks, applied.
