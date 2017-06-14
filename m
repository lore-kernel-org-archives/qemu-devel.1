Received: from eggs.gnu.org ([2001:4830:134:3::10]:56897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dLETY-0006Yp-Nj
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 16:01:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dLETT-0004Lv-UJ
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 16:01:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36258)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dLETT-0004LQ-Nb
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 16:01:07 -0400
References: <20170613214736.19963-1-david@redhat.com>
	<20170613214736.19963-3-david@redhat.com>
	<cf5f341a-2446-31e5-1990-201a8015a38f@redhat.com>
	<a7963e43-26f0-3910-fdb5-b9e56ae3dd23@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7edf6834-f76a-1360-745c-416077dbcf44@redhat.com>
Date: Wed, 14 Jun 2017 22:00:59 +0200
MIME-Version: 1.0
In-Reply-To: <a7963e43-26f0-3910-fdb5-b9e56ae3dd23@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 2/3] target/s390x: implement mvcos
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Miroslav Benes <mbenes@suse.cz>, agraf@suse.de, Aurelien Jarno <aurelien@aurel32.net>, rth@twiddle.net

On 14.06.2017 09:56, David Hildenbrand wrote:
[...]
>> I think you should also mask the length with 0xffffffff if the PSW was
>> not in 64-bit mode? Or is this done automagically by the generated TCG
>> code already?
> 
> I was asking myself the same question, but it shouldn't really matter as
> was we will be using a maximum of 4096, no?

Question is whether we can end up here somehow in 32-bit mode and the
upper part of the register is still != 0 ... something like 0x100000010
for example. Can we be sure that the upper half is always cleared if we
switch from 64-bit mode to the 32-bit mode before?

 Thomas
