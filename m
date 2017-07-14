Received: from eggs.gnu.org ([2001:4830:134:3::10]:34918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVvL3-0004wY-5T
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 03:48:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVvL0-00045N-5C
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 03:48:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53716)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dVvKz-00044j-US
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 03:48:34 -0400
Date: Fri, 14 Jul 2017 09:48:29 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170714094829.7bffecee@gondolin>
In-Reply-To: <1499961789-127874-2-git-send-email-borntraeger@de.ibm.com>
References: <1499961789-127874-1-git-send-email-borntraeger@de.ibm.com>
	<1499961789-127874-2-git-send-email-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/7] s390x/cpumodel: wire up new hardware
 features
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

On Thu, 13 Jul 2017 18:03:03 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
> 
> Some new guest features have been introduced recently. Lets wire

s/Lets/Let's/

:)

> them up in the CPU model.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> [split patch]
> ---
>  include/hw/s390x/sclp.h         |  3 +--
>  target/s390x/cpu_features.c     | 41 +++++++++++++++++++++++++++++++++++++++++
>  target/s390x/cpu_features.h     |  4 ++++
>  target/s390x/cpu_features_def.h | 41 ++++++++++++++++++++++++++++++++++++++++-
>  target/s390x/cpu_models.c       | 25 +++++++++++++++++++++++++
>  target/s390x/gen-features.c     | 39 +++++++++++++++++++++++++++++++++++++++
>  target/s390x/kvm.c              | 10 ++++++++++
>  7 files changed, 160 insertions(+), 3 deletions(-)

AFAICS, this should be fine.

Acked-by: Cornelia Huck <cohuck@redhat.com>
