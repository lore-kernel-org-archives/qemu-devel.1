Received: from eggs.gnu.org ([2001:4830:134:3::10]:53463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dx6xO-0007Ud-44
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:40:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dx6wy-0001FQ-UM
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:40:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dx6wy-0001EK-Nz
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:40:08 -0400
Date: Wed, 27 Sep 2017 09:39:59 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170927093959.3f61dd36.cohuck@redhat.com>
In-Reply-To: <67c13b99-2d44-666b-9328-05917d0fc0dc@redhat.com>
References: <20170926180522.68482-1-borntraeger@de.ibm.com>
	<67c13b99-2d44-666b-9328-05917d0fc0dc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390x/cpumodel: remove ais from z14
 default model-> also for 2.10.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Tue, 26 Sep 2017 20:26:31 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 26.09.2017 20:05, Christian Borntraeger wrote:
> > We disabled ais for 2.10 lets also remove it from the z14 default model.
> > 
> > Fixes: 3f2d07b3b01e  s390x/ais: for 2.10 stable: disable ais facility
> > Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > ---
> >  target/s390x/gen-features.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> > index c8dc104..68e6c31 100644
> > --- a/target/s390x/gen-features.c
> > +++ b/target/s390x/gen-features.c
> > @@ -527,7 +527,6 @@ static uint16_t default_GEN13_GA1[] = {
> >  #define default_GEN13_GA2 EmptyFeat
> >  
> >  static uint16_t default_GEN14_GA1[] = {
> > -    S390_FEAT_ADAPTER_INT_SUPPRESSION,
> >      S390_FEAT_INSTRUCTION_EXEC_PROT,
> >      S390_FEAT_GUARDED_STORAGE,
> >      S390_FEAT_VECTOR_PACKED_DECIMAL,
> >   
> 
> Yes, this has to go into stable, otherwise the migration safe stable
> model would be changed.
> 
> Apart from that, this looks just fine.

So, this should go into stable only, as the patches currently on the
list will fix this properly for 2.11, right?
