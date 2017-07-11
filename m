Received: from eggs.gnu.org ([2001:4830:134:3::10]:37211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUyec-0004gm-BQ
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 13:08:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUyeb-0007Ft-Db
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 13:08:54 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170710192128.9048-1-alex.bennee@linaro.org>
	<20170710192128.9048-5-alex.bennee@linaro.org>
	<e21159d2-42aa-1b08-5ea9-2f367a8e452f@twiddle.net>
	<87lgnv9y50.fsf@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <72e9af8d-bf60-58cf-7509-a5c337f2605b@twiddle.net>
Date: Tue, 11 Jul 2017 07:08:41 -1000
MIME-Version: 1.0
In-Reply-To: <87lgnv9y50.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 4/5] target/arm: use DISAS_JUMP for ISB
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, cota@braap.org, qemu-devel@nongnu.org, "open list:ARM" <qemu-arm@nongnu.org>

On 07/10/2017 10:27 PM, Alex Bennée wrote:
> 
> Richard Henderson <rth@twiddle.net> writes:
> 
>> On 07/10/2017 09:21 AM, Alex Bennée wrote:
>>> -        s->is_jmp = DISAS_UPDATE;
>>> +        gen_a64_set_pc_im(s->pc);
>>> +        s->is_jmp = DISAS_JUMP;
>>
>> Better would be gen_goto_tb.  The destination is known, so there's no
>> need to go through lookup_and_goto_ptr.  You still get the icount_decr
>> check at the start of the linked TB, which is what you're looking for.
>>
>> Interesting that a64's gen_goto_tb sets is_jmp, but a32 does not...
> 
> Hmm the only caller that is not already in the exit path sets it. Maybe
> I should push the s->is_jmp to the a32 gen_goto_tb? I can then do the
> same in both.

Sounds reasonable.


r~
