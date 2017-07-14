Received: from eggs.gnu.org ([2001:4830:134:3::10]:37775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVvUk-0000vY-Ru
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 03:58:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVvUh-0000Br-SX
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 03:58:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33528)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dVvUh-0000B1-L5
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 03:58:35 -0400
Date: Fri, 14 Jul 2017 09:58:31 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170714095831.78dccce1@gondolin>
In-Reply-To: <1499961789-127874-5-git-send-email-borntraeger@de.ibm.com>
References: <1499961789-127874-1-git-send-email-borntraeger@de.ibm.com>
	<1499961789-127874-5-git-send-email-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/7] s390x/kvm: Enable KSS facility for
 nested virtualization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Farhan Ali <alifm@linux.vnet.ibm.com>

On Thu, 13 Jul 2017 18:03:06 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: Farhan Ali <alifm@linux.vnet.ibm.com>
> 
> If the host supports keyless subset (KSS) then first level
> guest (G2) should enable KSS facility as well.
> 
> Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
> Reviewed-by: Eric Farman <farman@linux.vnet.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  target/s390x/kvm.c | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Cornelia Huck <cohuck@redhat.com>
