Received: from eggs.gnu.org ([2001:4830:134:3::10]:53118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Michael.Nawrocki@gtri.gatech.edu>)
	id 1eEFhg-0001Xn-1A
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:27:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Michael.Nawrocki@gtri.gatech.edu>)
	id 1eEFhc-0005lc-Ob
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:27:12 -0500
Received: from relay2.gtri.gatech.edu ([130.207.199.168]:42468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Michael.Nawrocki@gtri.gatech.edu>)
	id 1eEFhc-0005kI-Kc
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:27:08 -0500
References: <20171110202556.28541-1-michael.nawrocki@gtri.gatech.edu>
	<888aa8cc-25d3-bcc5-9a97-78d59b972c05@redhat.com>
From: Michael Nawrocki <michael.nawrocki@gtri.gatech.edu>
Message-ID: <f8b1a08d-5781-70c4-3c16-76927cdbb854@gtri.gatech.edu>
Date: Mon, 13 Nov 2017 09:27:05 -0500
MIME-Version: 1.0
In-Reply-To: <888aa8cc-25d3-bcc5-9a97-78d59b972c05@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 0/1] Add 8-byte wide AMD
 flash support, partial interleaving
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, mreitz@redhat.com

On 11/10/2017 06:12 PM, Paolo Bonzini wrote:
> On 10/11/2017 21:25, Mike Nawrocki wrote:
>> This patch set does a few things. First, it switches the AMD CFI flash MMIO
>> operations from the old MMIO API to the new one. Second, it enables 8-byte wide
>> flash arrays. Finally, it adds flash interleaving using the "device-width" and
>> "max-device-width" properties, using the same interface as pflash_cfi01.c. Much
>> of the code was taken and adapted from that file.
> 
> This unfortunately is not a patch set, it's a patch that does many
> things.  You should split it in three parts, according to the three
> things you've mentioned in the message above.
> 
> Paolo
> 

Sure, no problem. I'll get the split patch set out shortly.

Thanks,
Mike
