Received: from eggs.gnu.org ([2001:4830:134:3::10]:49130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dsAwL-00023D-HV
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 12:55:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dsAwI-0006hO-DB
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 12:55:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39934)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dsAwI-0006fc-6n
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 12:55:02 -0400
Date: Wed, 13 Sep 2017 18:54:53 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170913185453.675bedac.cohuck@redhat.com>
In-Reply-To: <17d817d4-bfce-98aa-7841-2136cb8dcfc6@redhat.com>
References: <20170913132417.24384-1-david@redhat.com>
	<20170913132417.24384-4-david@redhat.com>
	<17d817d4-bfce-98aa-7841-2136cb8dcfc6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 03/22] s390x: get rid of s390-virtio.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On Wed, 13 Sep 2017 18:34:27 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 13.09.2017 15:23, David Hildenbrand wrote:
> > It is a leftover from the days where we had still the !ccw virtio
> > machine. As this one is long gone, let's move everything to> s390-virtio-ccw.c.  
> 
> Whoops, another thing to fix up:
> 
> hw/s390x/s390-virtio.c is not compiled any more but not completely deleted.

No worries, fixed up.

> 
> > 
> > Suggested-by: Cornelia Huck <cohuck@redhat.com>
> > Reviewed-by: Thomas Huth <thuth@redhat.com>
> > Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > ---
> >  hw/s390x/Makefile.objs     |   1 -
> >  hw/s390x/s390-virtio-ccw.c | 157 ++++++++++++++++++++++++++++++++++++++++++++-
> >  hw/s390x/s390-virtio.c     |  37 -----------
> >  hw/s390x/s390-virtio.h     |  15 -----
> >  4 files changed, 156 insertions(+), 54 deletions(-)
