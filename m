Received: from eggs.gnu.org ([2001:4830:134:3::10]:37060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVvS9-0008MJ-9P
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 03:55:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVvS6-0007kI-9l
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 03:55:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54310)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dVvS6-0007iZ-2S
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 03:55:54 -0400
Date: Fri, 14 Jul 2017 09:55:49 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170714095549.1c6e709e@gondolin>
In-Reply-To: <1499961789-127874-4-git-send-email-borntraeger@de.ibm.com>
References: <1499961789-127874-1-git-send-email-borntraeger@de.ibm.com>
	<1499961789-127874-4-git-send-email-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/7] s390x/cpumodel: add esop/esop2 to z12
 model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>

On Thu, 13 Jul 2017 18:03:05 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
> 
> Add esop and esop2 features to z12 model where esop2 was originally introduced.
> Provide a mechanism to disable features in compatibility machines and use this
> method to disable esop and esop2 when using compatibility machine v2.9 or
> earlier.

The patch description does not quite fit anymore due to patch
reordering. What about:

"Add esop and esop2 features to z12 model where esop2 was originally introduced.
Disable esop and esop2 when using compatibility machine v2.9 or earlier."

> 
> Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  hw/s390x/s390-virtio-ccw.c  | 3 +++
>  target/s390x/gen-features.c | 3 +++
>  2 files changed, 6 insertions(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
