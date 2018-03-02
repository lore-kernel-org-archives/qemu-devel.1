Received: from eggs.gnu.org ([2001:4830:134:3::10]:52665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1erh2Z-0002oq-Ra
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 04:31:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1erh2X-0001j8-9N
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 04:31:47 -0500
Date: Fri, 2 Mar 2018 10:31:41 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180302103141.6b3edb52.cohuck@redhat.com>
In-Reply-To: <1519760121-24594-1-git-send-email-walling@linux.vnet.ibm.com>
References: <1519760121-24594-1-git-send-email-walling@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] s390/ipl: only print boot menu error if
 -boot menu=on was specified
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, thuth@redhat.com, mihajlov@linux.vnet.ibm.com

On Tue, 27 Feb 2018 14:35:21 -0500
"Collin L. Walling" <walling@linux.vnet.ibm.com> wrote:

> It is possible that certain QEMU configurations may not
> create an IPLB (such as when -kernel is provided). In
> this case, a misleading error message will be printed
> stating that the "boot menu is not supported for this
> device type".
> 
> To amend this, only print this message iff boot menu=on
> was provided on the commandline. Otherwise, return silently.
> 
> While we're at it, remove trailing periods from error
> messages.
> 
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> ---
>  hw/s390x/ipl.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Thanks, applied.
