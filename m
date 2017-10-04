Received: from eggs.gnu.org ([2001:4830:134:3::10]:48682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dzjjc-00005r-0i
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 09:29:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dzjjX-0006HP-2v
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 09:29:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dzjjW-0006GZ-SA
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 09:29:07 -0400
Date: Wed, 4 Oct 2017 15:29:01 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171004152901.0e60cf93.cohuck@redhat.com>
In-Reply-To: <0a170e87-54d5-8239-31f3-198b99d3924a@de.ibm.com>
References: <20171004105751.24655-1-borntraeger@de.ibm.com>
	<20171004105751.24655-2-borntraeger@de.ibm.com>
	<512050f4-d7f5-7aac-f617-01ac5ef9513f@redhat.com>
	<0a170e87-54d5-8239-31f3-198b99d3924a@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] s390/kvm: Support for get/set of
 extended TOD-Clock for guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, "Collin L. Walling" <walling@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>

On Wed, 4 Oct 2017 13:44:31 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 10/04/2017 01:42 PM, Thomas Huth wrote:
> > On 04.10.2017 12:57, Christian Borntraeger wrote:  
> >> From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
> >>
> >> Provides an interface for getting and setting the guest's extended
> >> TOD-Clock via a single ioctl to kvm. If the ioctl fails because it
> >> is not support by kvm, then we fall back to the old style of
> >> retrieving the clock via two ioctls.
> >>
> >> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> >> Reviewed-by: Eric Farman <farman@linux.vnet.ibm.com>
> >> Reviewed-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
> >> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> >> [split failure change from epoch index change]
> >> ---
> >>  target/s390x/cpu.c       | 26 +++++++++++++++++++-------
> >>  target/s390x/kvm-stub.c  | 10 ++++++++++
> >>  target/s390x/kvm.c       | 35 ++++++++++++++++++++++++++++++++++-
> >>  target/s390x/kvm_s390x.h |  2 ++
> >>  4 files changed, 65 insertions(+), 8 deletions(-)

> >> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> >> index ebb75ca..4c944a5 100644
> >> --- a/target/s390x/kvm.c
> >> +++ b/target/s390x/kvm.c
> >> @@ -643,10 +643,27 @@ int kvm_s390_get_clock(uint8_t *tod_high, uint64_t *tod_low)
> >>      return kvm_vm_ioctl(kvm_state, KVM_GET_DEVICE_ATTR, &attr);
> >>  }
> >>  
> >> +int kvm_s390_get_clock_ext(uint8_t *tod_high, uint64_t *tod_low)
> >> +{
> >> +    int r;
> >> +    struct kvm_s390_vm_tod_clock gtod;
> >> +  
> > 
> > So you've got a blank line here...  
> 
> Yes, seems that I have forgotten this one. 
> I will let Conny decide if I should resend or if she can fixup.

No worries, I can make this consistent on applying.
