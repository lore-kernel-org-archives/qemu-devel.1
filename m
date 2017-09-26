Received: from eggs.gnu.org ([2001:4830:134:3::10]:42652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dwmp1-0000zM-Ia
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 06:10:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dwmox-0006ms-EK
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 06:10:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dwmox-0006mL-8O
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 06:10:31 -0400
Date: Tue, 26 Sep 2017 12:10:27 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170926121027.735e5126.cohuck@redhat.com>
In-Reply-To: <7e694ed6-7b40-c895-9542-e445489cda18@linux.vnet.ibm.com>
References: <20170921180841.24490-1-pasic@linux.vnet.ibm.com>
	<20170921180841.24490-4-pasic@linux.vnet.ibm.com>
	<7e694ed6-7b40-c895-9542-e445489cda18@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 3/5] virtio-ccw: use ccw data stream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Fri, 22 Sep 2017 17:39:35 +0200
Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

> On 21/09/2017 20:08, Halil Pasic wrote:
> > Replace direct access which implicitly assumes no IDA
> > or MIDA with the new ccw data stream interface which should
> > cope with these transparently in the future.
> > 
> > Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> > Reviewed-by: Pierre Morel<pmorel@linux.vnet.ibm.com>
> > Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> > ---
> >   hw/s390x/virtio-ccw.c | 155 +++++++++++++++-----------------------------------
> >   1 file changed, 46 insertions(+), 109 deletions(-)

> LGTM.
> Not testing the return value for ccw_dstream_read/write_buf() bother me 
> but I can understand that you will modify this later.
> May be a comment?
> Not a strong opinion.

I can add "Note that checking the return code for ccw_dstream_* will be
done in a follow-on patch."

> 
> Reviewed-by: Pierre Morel<pmorel@linux.vnet.ibm.com>
> 
> 
