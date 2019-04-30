Received: from eggs.gnu.org ([209.51.188.92]:54568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hLMxm-00057g-Ne
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 03:14:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hLMxl-0003qY-Py
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 03:14:02 -0400
Date: Tue, 30 Apr 2019 09:13:54 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190430091354.23c9aca0.cohuck@redhat.com>
In-Reply-To: <6e6c4b4e-4d08-b4fa-1092-06567a6473da@redhat.com>
References: <20190429090250.7648-1-borntraeger@de.ibm.com>
	<20190429090250.7648-5-borntraeger@de.ibm.com>
	<0ad32bcf-0132-3905-3220-0f50e26937c3@redhat.com>
	<b0b0ec8f-d5ee-c08f-11dd-894d9433159f@de.ibm.com>
	<6e6c4b4e-4d08-b4fa-1092-06567a6473da@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 4/9] s390x/cpumodel: msa9 facility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.ibm.com>, Richard Henderson <rth@twiddle.net>, Collin Walling <walling@linux.ibm.com>, "Jason J . Herne" <jjherne@linux.ibm.com>

On Tue, 30 Apr 2019 09:00:56 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 30.04.19 07:41, Christian Borntraeger wrote:
> > 
> > 
> > On 29.04.19 21:24, David Hildenbrand wrote:  

> >> Just wondering, why keep the PCKMO ones separate, but not e.g. PCC ?  
> > 
> > Because those can be disabled at the HMC. It is painful to disable 5 elements
> > for LPARs that are configured that way. So I created a group for those. That
> > will allow to disable the full group.
> > (we have the same issue with the  exisiting AES and DEA pckmo functions).  
> 
> Rings a bell, maybe that information would be good to have in the cover
> letter. I guess Conny might want to change the description when picking up:
> 
> "Provide the MSA9 facility (stfle.155). This also contains pckmo
> subfunctions for key wrapping. Keep them in a separate group to disable
> those as a block if necessary. This is for example needed when disabling
> key wrapping via the HMC."

Sure, makes sense to fold that in.
