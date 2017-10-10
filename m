Received: from eggs.gnu.org ([2001:4830:134:3::10]:56417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e1uXp-0004IY-BJ
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:26:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e1uXj-0005fG-Fy
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:26:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e1uXj-0005ej-9t
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:25:55 -0400
Date: Tue, 10 Oct 2017 15:25:51 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171010152551.33ab63f3.cohuck@redhat.com>
In-Reply-To: <20171004154144.88995-2-pasic@linux.vnet.ibm.com>
References: <20171004154144.88995-1-pasic@linux.vnet.ibm.com>
	<20171004154144.88995-2-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/8] s390x/css: be more consistent if
 broken beyond repair
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Wed,  4 Oct 2017 17:41:37 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> Calling do_subchannel_work with no function control flags set in SCSW is
> a programming error. Currently the handle this differently in
> do_subchannel_work_virtual and do_subchannel_work_passthrough. Let's be
> consistent and guard with a common assert against this programming error.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
>  hw/s390x/css.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)

Thanks, applied.
