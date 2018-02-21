Received: from eggs.gnu.org ([2001:4830:134:3::10]:45408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eoZye-00007Q-FJ
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 14:22:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eoZyY-0001L1-Uf
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 14:22:52 -0500
Date: Wed, 21 Feb 2018 20:22:24 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180221202224.2d500f32.cohuck@redhat.com>
In-Reply-To: <724303ad-100b-109f-f843-44e0795f0ae6@redhat.com>
References: <20180221165628.78946-1-pasic@linux.vnet.ibm.com>
	<724303ad-100b-109f-f843-44e0795f0ae6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/1] 390x/cpumodel: document
 S390FeatDef.bit not applicable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On Wed, 21 Feb 2018 18:29:19 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 21.02.2018 17:56, Halil Pasic wrote:

s/390x/s390x/

> > The 'bit' field of the 'S390FeatDef' structure is not applicable to all
> > its instances. Currently this field is not applicable, and remains
> > unused, iff the feature is of type S390_FEAT_TYPE_MISC. Having the value 0
> > specified for multiple such feature definition  was a little confusing,  
> 
> s/  / /

also s/definition/definitions/

> 
> > as it's a perfectly legit bit value, and as the value of the bit
> > field is usually ought to be unique for each feature of a given
> > feature type.
> > 
> > Let us introduce a specialized macro for defining features of type
> > S390_FEAT_TYPE_MISC so, that one does not have to specify neither bit nor
> > type (as the later is implied).  
> 
> s/later is implied/latter is implicit/

I kept 'implied'.

> 
> > 
> > Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> > ---
> > 
> > v1 -> v2
> > * Specialized feature initializer macro for type MISC that does not
> >   require a bit value instead of defining a 'not a bit number' (that
> >   is extremal) bit number.
> > ---
> >  target/s390x/cpu_features.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)

(...)

> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks, applied.
