Received: from eggs.gnu.org ([2001:4830:134:3::10]:46395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duiZc-00078q-QT
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 13:14:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duiZY-0000G0-MA
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 13:14:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1duiZY-0000FO-Fb
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 13:14:04 -0400
References: <20170920114637.42004-1-aik@ozlabs.ru>
	<20170920114637.42004-19-aik@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b957a600-b220-7e2c-a831-3b86b06c5d98@redhat.com>
Date: Wed, 20 Sep 2017 19:14:01 +0200
MIME-Version: 1.0
In-Reply-To: <20170920114637.42004-19-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org

On 20/09/2017 13:46, Alexey Kardashevskiy wrote:
> This extends memory_region_transaction_commit() to receive a MR as
> if it is a root MR or its topmost parent is, then we can only rebuild
> its FlatView and update it for address spaces sharing it.
> 
> The optimization gets disabled though if there is full update about to
> commit.
> 
> memory_region_set_enabled() is a special case here, it does not use
> a hint when MR is being disabled.
> 
> On POWER8 with 255 CPUs, 255 virtio-net, 40 PCI bridges guest this brings
> down the boot time from 20s to 12s, the total memory footprint
> goes down (17G -> 8G).

I think this is incorrect if MR has an alias (no matter if enabling or
disabling)?

Paolo
