Received: from eggs.gnu.org ([2001:4830:134:3::10]:46987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f8hi4-0000D6-HR
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 03:40:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f8hhz-00064O-Is
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 03:40:56 -0400
Date: Wed, 18 Apr 2018 09:40:29 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180418094029.14b64108.cohuck@redhat.com>
In-Reply-To: <354ba31f-7502-b873-e254-fe3dbfc07b54@de.ibm.com>
References: <1523819244-29954-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1523819244-29954-4-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1808b8f3-9cff-c849-d012-b23f29d1c11f@redhat.com>
	<354ba31f-7502-b873-e254-fe3dbfc07b54@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 3/5] s390x/cpumodel: Set up CPU model
 for AP device support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net

On Tue, 17 Apr 2018 20:21:31 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 04/16/2018 05:44 PM, David Hildenbrand wrote:
> >   
> >>  
> >> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> >> index 0cdbc15..0d5b0f7 100644
> >> --- a/target/s390x/gen-features.c
> >> +++ b/target/s390x/gen-features.c
> >> @@ -447,6 +447,9 @@ static uint16_t full_GEN12_GA1[] = {
> >>      S390_FEAT_ADAPTER_INT_SUPPRESSION,
> >>      S390_FEAT_EDAT_2,
> >>      S390_FEAT_SIDE_EFFECT_ACCESS_ESOP2,
> >> +    S390_FEAT_AP_QUERY_CONFIG_INFO,
> >> +    S390_FEAT_AP_FACILITIES_TEST,
> >> +    S390_FEAT_AP,
> >>  };
> >>    
> > 
> > Now I have to ask a very stupid question:
> > 
> > I heard that the execution controls in the SIE block for AP are one of
> > the oldest ones we have around. How can it be that the AP feature cannot
> > be used before zEC12?  
> 
> It was a suggestion from the crypto team due to testability. Nobody has a z196
> with the older cards.
> 

Might be worth adding a note to that respect?
