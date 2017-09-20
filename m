Received: from eggs.gnu.org ([2001:4830:134:3::10]:46993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duiam-0007vv-UO
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 13:15:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duiak-0000vX-9a
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 13:15:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:6973)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1duiak-0000vC-30
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 13:15:18 -0400
References: <20170920114637.42004-1-aik@ozlabs.ru>
	<20170920114637.42004-10-aik@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <611f7d09-7c5d-20c4-9b9b-1c1f58525fb1@redhat.com>
Date: Wed, 20 Sep 2017 19:15:15 +0200
MIME-Version: 1.0
In-Reply-To: <20170920114637.42004-10-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v4 09/18] memory: Store physical root
 MR in FlatView
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
> Address spaces get to keep a root MR (alias or not) but FlatView stores
> the actual MR as this is going to be used later on to decide whether to
> share a particular FlatView or not.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v4:
> * s/memory_region_unalias_entire/memory_region_get_flatview_root/

Did you try the idea of checking for single-child regions too?

Paolo
