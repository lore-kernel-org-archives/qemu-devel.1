Received: from eggs.gnu.org ([2001:4830:134:3::10]:55762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dKTZm-00034A-JG
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 13:56:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dKTZh-0005Ns-PF
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 13:56:30 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:62197)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dKTZh-0005MJ-Ec
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 13:56:25 -0400
References: <20170611231633.32582-1-laurent@vivier.eu>
	<20170611231633.32582-5-laurent@vivier.eu>
	<48fecf30-cc95-de46-e4a7-50f94dd1d49b@twiddle.net>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <aded5012-9d86-825f-be0a-2b1c54a1fa3b@vivier.eu>
Date: Mon, 12 Jun 2017 19:56:01 +0200
MIME-Version: 1.0
In-Reply-To: <48fecf30-cc95-de46-e4a7-50f94dd1d49b@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 4/7] target-m68k: move fmove CR to a
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>

Le 12/06/2017 à 18:13, Richard Henderson a écrit :
> On 06/11/2017 04:16 PM, Laurent Vivier wrote:
>> Move code of fmove to/from control register to a function
>>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> ---
>>   target/m68k/translate.c | 66
>> ++++++++++++++++++++++++++++++-------------------
>>   1 file changed, 41 insertions(+), 25 deletions(-)
> 
> In that this is 100% code movement,
> 
> Reviewed-by: Richard Henderson <rth@twiddle.net>
> 
> 
>> +            cpu_abort(NULL, "Unimplemented: fmove from control %d",
>> mask);
>> +            goto undef;
> 
> But cpu_abort doesn't return, and will exit qemu.
> This should be qemu_log_mask(LOG_UNIMP, ...).

Do you want I update the patch to fix that?

Thanks,
Laurent
