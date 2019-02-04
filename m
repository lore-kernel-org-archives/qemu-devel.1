Received: from eggs.gnu.org ([209.51.188.92]:36465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gqbZQ-0005R1-HF
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 05:33:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gqbZO-0007Q2-Gw
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 05:33:44 -0500
Date: Mon, 4 Feb 2019 11:33:13 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190204113313.642ab87f.cohuck@redhat.com>
In-Reply-To: <1548768562-20007-5-git-send-email-jjherne@linux.ibm.com>
References: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
	<1548768562-20007-5-git-send-email-jjherne@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/15] s390-bios: Extend find_dev() for
 non-virtio devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On Tue, 29 Jan 2019 08:29:11 -0500
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> We need a method for finding the subchannel of a dasd device. Let's
> modify find_dev to handle this since it mostly does what we need. Up to
> this point find_dev has been specific to only virtio devices.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
>  pc-bios/s390-ccw/main.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
