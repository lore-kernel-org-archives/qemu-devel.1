Received: from eggs.gnu.org ([2001:4830:134:3::10]:38671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dFkHs-0001Ru-53
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:46:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dFkHo-0007Ep-6s
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:46:28 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:36670)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dFkHo-0007ET-1y
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:46:24 -0400
Received: by mail-qt0-x243.google.com with SMTP id j13so13033193qta.3
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 09:46:23 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170525210508.4910-1-aurelien@aurel32.net>
	<20170525210508.4910-22-aurelien@aurel32.net>
	<a0ebc1e0-db39-218e-fcde-9c4563f98b0d@twiddle.net>
	<20170529112211.agqzlngan3dfsrc7@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <4f0d6cf9-7faf-9967-0243-362c8bfe8ea8@twiddle.net>
Date: Tue, 30 May 2017 09:46:19 -0700
MIME-Version: 1.0
In-Reply-To: <20170529112211.agqzlngan3dfsrc7@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 21/26] target/s390x: implement PACK UNICODE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>

On 05/29/2017 04:22 AM, Aurelien Jarno wrote:
> On 2017-05-26 09:35, Richard Henderson wrote:
>> On 05/25/2017 02:05 PM, Aurelien Jarno wrote:
>>> +        } else if (srclen > ssize) {
>>>                b = cpu_ldub_data_ra(env, src, ra) & 0x0f;
>>> -            src--;
>>> -            srclen--;
>>> +            src -= ssize;
>>> +            srclen -= ssize;
>>
>> Surely we need to use lduw in order to correctly read the big-endian 16-bit
>> value, or bias src by +1 to read the low byte of same.
> 
> The operands are read from right to left, therefore src is adjusted to
> point to the last byte before the for loop:
> 
> +    /* The operands are processed from right to left.  */
> +    src += srclen - 1;
> +    dest += destlen - 1;
> 
> Given s390 is big-endian, it means src initially always point to the
> low byte independently to the size of the value.
> 

Quite right.  I didn't consider the processing order.


r~
