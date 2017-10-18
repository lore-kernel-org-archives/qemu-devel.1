Received: from eggs.gnu.org ([2001:4830:134:3::10]:60091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e4kmT-0005tb-4k
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 05:36:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e4kmO-0003ay-I8
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 05:36:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56134)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1e4kmO-0003a3-CS
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 05:36:48 -0400
References: <20171017140453.51099-1-pasic@linux.vnet.ibm.com>
	<20171017140453.51099-6-pasic@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d9d522d4-b2f5-5a9a-236d-27506f9f1a11@redhat.com>
Date: Wed, 18 Oct 2017 11:36:45 +0200
MIME-Version: 1.0
In-Reply-To: <20171017140453.51099-6-pasic@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 5/7] s390x: refactor error handling for
 CSCH handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On 17.10.2017 16:04, Halil Pasic wrote:
> Simplify the error handling of the cSCH.  Let the code detecting the
> condition tell (in a less ambiguous way) how it's to be handled. No
> changes in behavior.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
>  hw/s390x/css.c         | 12 +++---------
>  include/hw/s390x/css.h |  2 +-
>  target/s390x/ioinst.c  | 14 ++++----------
>  3 files changed, 8 insertions(+), 20 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
