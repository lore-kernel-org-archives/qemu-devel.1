Received: from eggs.gnu.org ([2001:4830:134:3::10]:48589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lists@wiesinger.com>) id 1dlsJq-0006Zd-H4
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 03:49:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lists@wiesinger.com>) id 1dlsJn-0003Nc-EV
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 03:49:18 -0400
Received: from [2a02:25b0:aaaa:57a::affe:bade] (port=46270
	helo=vps01.wiesinger.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lists@wiesinger.com>) id 1dlsJn-0002mN-86
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 03:49:15 -0400
From: Gerhard Wiesinger <lists@wiesinger.com>
References: <35eda6a9-086e-f899-e131-288f2346effe@wiesinger.com>
	<ce477c53-25bc-e6dd-3e05-c74af1f33c2d@wiesinger.com>
Message-ID: <3e1f41a8-faff-1858-6f0d-154694dff02d@wiesinger.com>
Date: Sun, 27 Aug 2017 09:47:50 +0200
MIME-Version: 1.0
In-Reply-To: <ce477c53-25bc-e6dd-3e05-c74af1f33c2d@wiesinger.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] kvm_intel fails to load on Conroe CPUs running
 Linux 4.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 17.08.2017 23:14, Gerhard Wiesinger wrote:
> On 17.08.2017 22:58, Gerhard Wiesinger wrote:
> >
> > On 07.08.2017 19:50, Paolo Bonzini wrote:
> >
> > >Not much to say, unfortunately. It's pretty much the same capabilities
> > >as a Prescott/Cedar Mill processor, except that it has MSR bitmaps. It
> > >also lacks FlexPriority compared to the Conroe I had checked.
> > >
> > >It's not great that even the revert patch doesn't apply cleanly---this
> > >is *not* necessarily a boring area of the hypervisor...
> > >
> > >Given the rarity of your machine I'm currently leaning towards _not_
> > >reverting the change. I'll check another non-Xeon Core 2 tomorrow that
> > >is from December 2008 (IIRC). If that one also lacks vNMI, or if I get
> > >other reports, I suppose I will have to reconsider that.
>
> Hello Paolo,
>
> Can you please revert the patch.
>
> CPU is a Core 2 Extreme QX6700: SL9UL (B3) running VERY stable with 
> ECC RAM for years now.
> https://ark.intel.com/products/28028/Intel-Core2-Extreme-Processor-QX6700-8M-Cache-2_66-GHz-1066-MHz-FSB?q=Core%202%20Extreme%20QX6700 
>
> https://en.wikipedia.org/wiki/List_of_Intel_Core_2_microprocessors
>
> CPU details below.
>
> Thank you.
>
> Ciao,
> Gerhard 

Hello Paolo,

Any update on this major issue?

Thnx.

Ciao,
Gerhard
