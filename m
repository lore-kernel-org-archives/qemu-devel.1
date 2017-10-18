Received: from eggs.gnu.org ([2001:4830:134:3::10]:38243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e4l4E-0001PP-50
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 05:55:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e4l4A-0007GV-QT
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 05:55:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43596)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1e4l4A-0007Eg-Jw
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 05:55:10 -0400
References: <20171017140453.51099-1-pasic@linux.vnet.ibm.com>
	<20171017140453.51099-7-pasic@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f6af32ed-025a-3673-7726-ae938c28ad8c@redhat.com>
Date: Wed, 18 Oct 2017 11:55:05 +0200
MIME-Version: 1.0
In-Reply-To: <20171017140453.51099-7-pasic@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 6/7] s390x: refactor error handling for
 HSCH handler
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
> Simplify the error handling of the HSCH.  Let the code detecting the
> condition tell (in a less ambiguous way) how it's to be handled. No
> changes in behavior.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
>  hw/s390x/css.c         | 18 +++++-------------
>  include/hw/s390x/css.h |  2 +-
>  target/s390x/ioinst.c  | 23 ++++-------------------
>  3 files changed, 10 insertions(+), 33 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
