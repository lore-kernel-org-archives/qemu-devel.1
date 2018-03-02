Received: from eggs.gnu.org ([2001:4830:134:3::10]:46902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1erggL-0008Np-FB
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 04:08:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1erggH-00014Q-CG
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 04:08:49 -0500
Date: Fri, 2 Mar 2018 10:08:23 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180302100823.15ece9ee.cohuck@redhat.com>
In-Reply-To: <1519725913-24852-1-git-send-email-thuth@redhat.com>
References: <1519725913-24852-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/s390x/ipl: Bail out if the network
 bootloader can not be found
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>

On Tue, 27 Feb 2018 11:05:13 +0100
Thomas Huth <thuth@redhat.com> wrote:

> If QEMU fails to load 's390-netboot.img', the guest firmware currently
> loops forever and just floods the console with "Network boot device
> detected" messages. The code in ipl.c apparently already tried to stop
> the VM with vm_stop() in this case, but this is in vain since the run
> state is later reset due to a call to vm_start() from vl.c again.
> To avoid the ugly firmware loop, let's simply exit QEMU directly instead
> since it just does not make sense to continue if the required firmware
> image can not be loaded. While we're at it, also add the file name of
> the netboot binary to the error message, so that the user has a better
> hint about what is missing.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/s390x/ipl.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Thanks, applied.
