Received: from eggs.gnu.org ([2001:4830:134:3::10]:47186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e8MRJ-0005Hy-Fp
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 04:25:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e8MRG-0006TM-CY
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 04:25:57 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:51777)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e8MRG-0006RW-6b
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 04:25:54 -0400
Received: by mail-wm0-f46.google.com with SMTP id b9so7452750wmh.0
	for <qemu-devel@nongnu.org>; Sat, 28 Oct 2017 01:25:54 -0700 (PDT)
References: <f512ef4b-11ac-0cd2-0037-4608f2059669@ozlabs.ru>
	<d80a7e33-f055-d59e-8aff-2ed1f9a79c83@ozlabs.ru>
	<20171027071241.GA30326@localhost.localdomain>
	<12b21c38-3d03-929b-aea0-7de5efe55d56@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9ac46d04-9a6a-67a5-73b3-fa2208c03e35@redhat.com>
Date: Sat, 28 Oct 2017 10:25:50 +0200
MIME-Version: 1.0
In-Reply-To: <12b21c38-3d03-929b-aea0-7de5efe55d56@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Alexey Kardashevskiy <aik@ozlabs.ru>, Jeff Cody <jcody@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>

On 28/10/2017 08:57, Alexey Kardashevskiy wrote:
> On 27/10/17 18:12, Jeff Cody wrote:
>> VHDX does not support migration (VMDK fails the same way). 
> 
> Probably a very ignorant question but how can an image format not support
> migration at all? Is not it simple writing blocks, one-by-one? Thanks.

VHDX does not implement bdrv_invalidate_cache.  If you add that
callback, it can support migration.

Paolo
