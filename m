Received: from eggs.gnu.org ([209.51.188.92]:33466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hL6Vz-0005Rs-HW
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:40:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hL6Vy-00019E-MO
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:40:15 -0400
Date: Mon, 29 Apr 2019 15:40:03 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190429154003.7f8fc423.cohuck@redhat.com>
In-Reply-To: <1556543381-12671-1-git-send-email-jjherne@linux.ibm.com>
References: <1556543381-12671-1-git-send-email-jjherne@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390-bios: Skip bootmap signature entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On Mon, 29 Apr 2019 09:09:41 -0400
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> Newer versions of zipl have the ability to write signature entries to the boot
> script for secure boot. We don't yet support secure boot, but we need to skip
> over signature entries while reading the boot script in order to maintain our
> ability to boot guest operating systems that have a secure bootloader.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/bootmap.c | 19 +++++++++++++++++--
>  pc-bios/s390-ccw/bootmap.h | 10 ++++++----
>  2 files changed, 23 insertions(+), 6 deletions(-)

Skipping something that we don't have support for yet, but that doesn't
hinder normal operation sounds reasonable; but can you point me to the
relevant commit implementing this in zipl or some documentation? I
haven't been able to find something like that in the s390-tools git
tree.
