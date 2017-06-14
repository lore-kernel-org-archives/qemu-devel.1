Received: from eggs.gnu.org ([2001:4830:134:3::10]:39223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dLHy3-0006Xg-9k
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 19:44:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dLHy0-0006sF-6U
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 19:44:55 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:36371)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dLHy0-0006rr-1n
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 19:44:52 -0400
Received: by mail-qt0-x242.google.com with SMTP id s33so3509665qtg.3
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 16:44:50 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170613214736.19963-1-david@redhat.com>
	<20170613214736.19963-3-david@redhat.com>
	<cf5f341a-2446-31e5-1990-201a8015a38f@redhat.com>
	<a7963e43-26f0-3910-fdb5-b9e56ae3dd23@redhat.com>
	<7edf6834-f76a-1360-745c-416077dbcf44@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <24103d8d-f691-e81f-c6e7-b69251f99365@twiddle.net>
Date: Wed, 14 Jun 2017 16:44:45 -0700
MIME-Version: 1.0
In-Reply-To: <7edf6834-f76a-1360-745c-416077dbcf44@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Miroslav Benes <mbenes@suse.cz>, agraf@suse.de, Aurelien Jarno <aurelien@aurel32.net>

On 06/14/2017 01:00 PM, Thomas Huth wrote:
> On 14.06.2017 09:56, David Hildenbrand wrote:
> [...]
>>> I think you should also mask the length with 0xffffffff if the PSW was
>>> not in 64-bit mode? Or is this done automagically by the generated TCG
>>> code already?
>>
>> I was asking myself the same question, but it shouldn't really matter as
>> was we will be using a maximum of 4096, no?
> 
> Question is whether we can end up here somehow in 32-bit mode and the
> upper part of the register is still != 0 ... something like 0x100000010
> for example. Can we be sure that the upper half is always cleared if we
> switch from 64-bit mode to the 32-bit mode before?

We don't currently have any length masking at the translate level.
Within mem_helper.c, we have wrap_length.


r~
