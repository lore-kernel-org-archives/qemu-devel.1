Received: from eggs.gnu.org ([209.51.188.92]:49880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gj66M-0007FD-Pc
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 12:32:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gj66L-00011c-LS
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 12:32:42 -0500
Date: Mon, 14 Jan 2019 18:32:26 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190114183226.28ab6ffc.cohuck@redhat.com>
In-Reply-To: <20190111113657.66195-3-frankja@linux.ibm.com>
References: <20190111113657.66195-1-frankja@linux.ibm.com>
	<20190111113657.66195-3-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] s390x: Return specification exception
 for unimplemented diag 308 subcodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, david@redhat.com, qemu-s390x@nongnu.org, qemu-stable@nongnu.org

On Fri, 11 Jan 2019 12:36:57 +0100
Janosch Frank <frankja@linux.ibm.com> wrote:

> The architecture specifies specification exceptions for all
> unavailable subcodes.
> 
> The presence of subcodes is indicated by checking some query subcode.
> For example 6 will indicate that 3-6 are available. So future systems
> might call new subcodes to check for new features. This should not
> trigger a hw error, instead we return the architectured specification
> exception.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Cc: qemu-stable@nongnu.org
> ---
>  target/s390x/diag.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied.
