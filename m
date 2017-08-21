Received: from eggs.gnu.org ([2001:4830:134:3::10]:39139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1djmZh-0007GM-RC
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 09:17:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1djmZc-0008NM-Rt
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 09:17:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1djmZc-0008NC-LU
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 09:16:56 -0400
Date: Mon, 21 Aug 2017 15:16:50 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170821151650.35050b3e.cohuck@redhat.com>
In-Reply-To: <700d1722-baf1-163e-6764-179f1340cc22@linux.vnet.ibm.com>
References: <20170821091614.28251-1-cohuck@redhat.com>
	<20170821091614.28251-8-cohuck@redhat.com>
	<700d1722-baf1-163e-6764-179f1340cc22@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 07/10] s390x/sclp: properly guard
 pci-specific functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, zyimin@linux.vnet.ibm.com, david@redhat.com, pmorel@linux.vnet.ibm.com, agraf@suse.de, borntraeger@de.ibm.com

On Mon, 21 Aug 2017 13:41:53 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 08/21/2017 11:16 AM, Cornelia Huck wrote:
> > If we do not provide zpci, pci reconfiguration via sclp is not available
> > either. Don't indicate it in the sclp facilities and return an invalid
> > command if the guest tries to issue pci configure/deconfigure.
> > 
> > Reviewed-by: Thomas Huth <thuth@redhat.com>
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >  hw/s390x/sclp.c | 19 +++++++++++++++----
> >  1 file changed, 15 insertions(+), 4 deletions(-)

(...)

> LGTM

Is that an Acked-by:? Or a Reviewed-by:? :)
