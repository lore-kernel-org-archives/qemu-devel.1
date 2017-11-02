Received: from eggs.gnu.org ([2001:4830:134:3::10]:45968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eA49z-0004fi-BI
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 21:19:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eA49x-0000pe-RD
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 21:19:07 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:45898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1eA49x-0000pW-LJ
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 21:19:05 -0400
Received: by mail-pg0-x242.google.com with SMTP id b192so3618766pga.2
	for <qemu-devel@nongnu.org>; Wed, 01 Nov 2017 18:19:05 -0700 (PDT)
References: <f512ef4b-11ac-0cd2-0037-4608f2059669@ozlabs.ru>
	<d80a7e33-f055-d59e-8aff-2ed1f9a79c83@ozlabs.ru>
	<20171027071241.GA30326@localhost.localdomain>
	<12b21c38-3d03-929b-aea0-7de5efe55d56@ozlabs.ru>
	<9ac46d04-9a6a-67a5-73b3-fa2208c03e35@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <0c64b45d-3f42-7866-ffa8-b2d0a32dddb0@ozlabs.ru>
Date: Thu, 2 Nov 2017 12:19:00 +1100
MIME-Version: 1.0
In-Reply-To: <9ac46d04-9a6a-67a5-73b3-fa2208c03e35@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] iotest 194 fails on vhdx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Jeff Cody <jcody@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>

On 28/10/17 19:25, Paolo Bonzini wrote:
> On 28/10/2017 08:57, Alexey Kardashevskiy wrote:
>> On 27/10/17 18:12, Jeff Cody wrote:
>>> VHDX does not support migration (VMDK fails the same way). 
>>
>> Probably a very ignorant question but how can an image format not support
>> migration at all? Is not it simple writing blocks, one-by-one? Thanks.
> 
> VHDX does not implement bdrv_invalidate_cache.  If you add that
> callback, it can support migration.


I could give it a try but is there a demand for it really?



-- 
Alexey
