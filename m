Received: from eggs.gnu.org ([2001:4830:134:3::10]:54852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5Wuy-0007o5-CX
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 09:00:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5Wuv-00078n-6R
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 09:00:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60990)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e5Wuu-00078U-W5
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 09:00:49 -0400
Date: Fri, 20 Oct 2017 15:00:43 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171020150043.383b2117.cohuck@redhat.com>
In-Reply-To: <711b1e41-693a-de7d-9c13-fbe0f964c53c@linux.vnet.ibm.com>
References: <20170913132752.8484-1-pasic@linux.vnet.ibm.com>
	<20170913132752.8484-2-pasic@linux.vnet.ibm.com>
	<20170914162603.1cdabd09.cohuck@redhat.com>
	<0b42ef59-4366-175f-8dc7-bc3ed02e2fb4@linux.vnet.ibm.com>
	<20170915092758.16ea52fc.cohuck@redhat.com>
	<711b1e41-693a-de7d-9c13-fbe0f964c53c@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] s390x/ccs: add ccw-tester emulated
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>

On Thu, 19 Oct 2017 18:39:37 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 09/15/2017 09:27 AM, Cornelia Huck wrote:
> >>>     
> >>>> +    DEFINE_PROP_UINT8("chpid_type", CcwTesterDevice, chpid_type,
> >>>> +                       0x98),  
> > This might also need re-evaluation - we should not really need a new
> > chpid type.
> >   
> 
> I'm back at ccw-tester again (for v2). I've realized we did not agree
> on what to use here (chpid_type). Shall I use 0x25 (Fibre Channel) or
> EMULATED_CCW_3270_CHPID_TYPE, or even 0x32 (virtio-ccw) as a default
> value? And should EMULATED_CCW_3270_CHPID_TYPE be called like that
> (is it really supposed to be specific to 3270?
> 
> Sorry I did not notice sooner.

It might make sense to pick whatever z/VM commonly uses for emulated
devices. (Or ask them if they reserved something explicitly for testing
-- that would be an even better match.)
