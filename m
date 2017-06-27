Received: from eggs.gnu.org ([2001:4830:134:3::10]:60322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPgXF-0001KH-7t
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 22:47:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPgXC-0006qy-70
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 22:47:25 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:34541)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dPgXC-0006qc-2B
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 22:47:22 -0400
Received: by mail-qk0-x242.google.com with SMTP id 91so2444233qkq.1
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 19:47:21 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
	<149838119390.6497.17430428991952287717.stgit@frigg.lan>
	<87fuenxdh2.fsf@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <2147a050-3242-29bc-e99f-63a7a04411d2@twiddle.net>
Date: Mon, 26 Jun 2017 19:47:18 -0700
MIME-Version: 1.0
In-Reply-To: <87fuenxdh2.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v9 04/26] target: [tcg] Add generic
 translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel@nongnu.org

On 06/26/2017 03:14 AM, Alex Bennée wrote:
>> +        if ((db->pc_first & TARGET_PAGE_MASK)
>> +            != (db->pc_next & TARGET_PAGE_MASK)) {
>> +            db->is_jmp = DJ_TOO_MANY;
>> +            break;
>> +        }
> 
> How does the first insn avoid this check? And if it does is that right?
> 
> I mean I understand you can construct weird multi-byte instructions
> (especially on x86) that cross the boundary but even if it is the first
> in a TB shouldn't it error if there are no contiguous pages?
> 
> Also isn't the page crossing issue different for SoftMMU and linux-user?

It could be, though I don't believe that many front-ends take advantage.  I 
don't think it makes *that* much difference.

But if it comes to that, there are other edge conditions that can be used, e.g. 
the KSEG non-paged addressing segment for Alpha or MIPS kernel mode.


r~
