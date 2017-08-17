Received: from eggs.gnu.org ([2001:4830:134:3::10]:33776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1diG7o-0006HQ-Oy
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 04:25:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1diG7j-0007Ro-RV
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 04:25:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36608)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1diG7j-0007Oe-Kw
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 04:25:51 -0400
Date: Thu, 17 Aug 2017 10:25:37 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170817102537.4a0fb826.cohuck@redhat.com>
In-Reply-To: <1502951113-4246-2-git-send-email-thuth@redhat.com>
References: <1502951113-4246-1-git-send-email-thuth@redhat.com>
	<1502951113-4246-2-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/6] tests: Run filter-redirector and
 -mirror test only on POSIX systems
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Eric Farman <farman@linux.vnet.ibm.com>, Fan Zhang <zhangfan@linux.vnet.ibm.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Fei Li <sherrylf@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Jason J Herne <jjherne@linux.vnet.ibm.com>, Jing Liu <liujbjl@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, QingFeng Hao <haoqf@linux.vnet.ibm.com>, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>, Yang Chen <bjcyang@linux.vnet.ibm.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Marc Mari <markmb@redhat.com>, Cleber Rosa <crosa@redhat.com>, Michael S Tsirkin <mst@redhat.com>

On Thu, 17 Aug 2017 08:25:08 +0200
Thomas Huth <thuth@redhat.com> wrote:

> This way we can get rid of the ugly #ifdefs in the code which makes
> it easier to extend later.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/Makefile.include         |  8 ++++----
>  tests/test-filter-mirror.c     |  5 -----
>  tests/test-filter-redirector.c | 10 ----------
>  3 files changed, 4 insertions(+), 19 deletions(-)

Yes, that is much nicer.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
