Received: from eggs.gnu.org ([2001:4830:134:3::10]:58189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duw0D-0002PS-2z
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 03:34:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duw09-0000Hx-Ts
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 03:34:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1duw09-0000H3-OI
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 03:34:25 -0400
Date: Thu, 21 Sep 2017 03:34:24 -0400 (EDT)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <222247850.7271421.1505979264047.JavaMail.zimbra@redhat.com>
In-Reply-To: <b6ec083e-8e43-7625-2b96-ec56619255ff@ozlabs.ru>
References: <20170920114637.42004-1-aik@ozlabs.ru>
	<20170920114637.42004-19-aik@ozlabs.ru>
	<b957a600-b220-7e2c-a831-3b86b06c5d98@redhat.com>
	<b6ec083e-8e43-7625-2b96-ec56619255ff@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v4 18/18] memory: Give
 memory_region_transaction_commit a hint
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org



----- Original Message -----
> From: "Alexey Kardashevskiy" <aik@ozlabs.ru>
> To: "Paolo Bonzini" <pbonzini@redhat.com>, qemu-devel@nongnu.org
> Sent: Thursday, September 21, 2017 2:02:02 AM
> Subject: Re: [PATCH qemu v4 18/18] memory: Give memory_region_transaction_commit a hint
> 
> On 21/09/17 03:14, Paolo Bonzini wrote:
> > On 20/09/2017 13:46, Alexey Kardashevskiy wrote:
> >> This extends memory_region_transaction_commit() to receive a MR as
> >> if it is a root MR or its topmost parent is, then we can only rebuild
> >> its FlatView and update it for address spaces sharing it.
> >>
> >> The optimization gets disabled though if there is full update about to
> >> commit.
> >>
> >> memory_region_set_enabled() is a special case here, it does not use
> >> a hint when MR is being disabled.
> >>
> >> On POWER8 with 255 CPUs, 255 virtio-net, 40 PCI bridges guest this brings
> >> down the boot time from 20s to 12s, the total memory footprint
> >> goes down (17G -> 8G).
> > 
> > I think this is incorrect if MR has an alias (no matter if enabling or
> > disabling)?
> 
> Hmmm. Right. I can add a aliases_nr counter to an MR (it does not even have
> to go down as aliases are not creared/destroyed often) and take the slow
> path if it is not zero, does it make sense?

It should be a separate series anyway.  Let's get the infrastructure in
so it's easier to experiment.

Paolo
