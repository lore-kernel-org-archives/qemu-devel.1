Received: from eggs.gnu.org ([2001:4830:134:3::10]:46541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1daj1S-0007Cn-Eo
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 09:40:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1daj1O-00030y-EE
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 09:40:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1daj1O-0002zV-94
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 09:40:10 -0400
Date: Thu, 27 Jul 2017 15:40:05 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170727154005.0c99521b@gondolin>
In-Reply-To: <f05dcd54-dad7-8939-e87b-e39346cc986c@linux.vnet.ibm.com>
References: <20170725224442.13383-1-pasic@linux.vnet.ibm.com>
	<20170727102636.43d6a789@gondolin>
	<f05dcd54-dad7-8939-e87b-e39346cc986c@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] ccw interpretation AR compliance
 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Thu, 27 Jul 2017 15:18:01 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> [Re-posting my previous reply because I've accidentally
> dropped almost all addresses.]
> 
> On 07/27/2017 10:26 AM, Cornelia Huck wrote:
> > On Wed, 26 Jul 2017 00:44:40 +0200
> > Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> >> Regarding testing: did not do much more than a simple smoke test
> >> with virtio-ccw.  
> > 
> > I think we need a way to throw random channel programs at a channel
> > device...
> >   
> 
> By random do you mean random random, or do you mean carefully crafted
> to provoke (and verify) certain responses. If it's more like the second
> case I've actually wrote something (a kernel driver) for 'internal use'
> but at the moment it's limited to indirect data access support (no test
> cases for invalid invalid channel programs).

That's what I've been thinking of. Standalone guest code would be even
better (can be integrated into automatic testing), but it's certainly
useful.

> The 'internal guys' say it
> probably ain't interesting for the rest of the world make this external,
> but if you are interested I could send you the patch these days.

Would be great if you could make this available. It is especially
interesting for me, but possibly for other folks working on s390 as well.

Might be good together with an "eat this" channel device in qemu.
