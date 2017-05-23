Received: from eggs.gnu.org ([2001:4830:134:3::10]:32813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDCkR-0004w7-H2
	for qemu-devel@nongnu.org; Tue, 23 May 2017 12:33:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDCkQ-0003LS-PG
	for qemu-devel@nongnu.org; Tue, 23 May 2017 12:33:27 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:32902)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dDCkQ-0003LM-L2
	for qemu-devel@nongnu.org; Tue, 23 May 2017 12:33:26 -0400
Received: by mail-qk0-x244.google.com with SMTP id o85so23446758qkh.0
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 09:33:26 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170523030312.6360-1-rth@twiddle.net>
	<20170523030312.6360-31-rth@twiddle.net>
	<20170523111218.3rkdldvfgk7y2uhy@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <28ee67e4-319c-d005-26ed-009d448f61ef@twiddle.net>
Date: Tue, 23 May 2017 09:33:22 -0700
MIME-Version: 1.0
In-Reply-To: <20170523111218.3rkdldvfgk7y2uhy@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 30/31] target/s390x: Implement CSPG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: qemu-devel@nongnu.org

On 05/23/2017 04:12 AM, Aurelien Jarno wrote:
> On 2017-05-22 20:03, Richard Henderson wrote:
>> Signed-off-by: Richard Henderson <rth@twiddle.net>
>> ---
>>   target/s390x/insn-data.def | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
>> index 4c91f30..8604847 100644
>> --- a/target/s390x/insn-data.def
>> +++ b/target/s390x/insn-data.def
>> @@ -838,6 +838,7 @@
>>   #ifndef CONFIG_USER_ONLY
>>   /* COMPARE AND SWAP AND PURGE */
>>       D(0xb250, CSP,     RRE,   Z,   r1_32u, ra2, r1_P, 0, csp, 0, MO_TEUL)
>> +    D(0xb98a, CSPG,    RRE,   Z,   r1_o, ra2, r1_P, 0, csp, 0, MO_TEQ)
> 
> CSPG is part of the of the DAT-enhancement facility. I called it DAT_ENH
> in my local patches to match the name we have in the CPU features.

The translator needs a large overhaul to bring it into line with the (more 
recently added) facilities infrastructure.  We don't currently enforce anything.

But you're also right that I shouldn't just ignore the issue and leave it 
marked incorrectly.


r~
