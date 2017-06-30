Received: from eggs.gnu.org ([2001:4830:134:3::10]:39013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dR0vp-0008Hc-1n
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 14:46:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dR0vo-0002mO-8i
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 14:46:17 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
	<149865244195.17063.11938084353514091141.stgit@frigg.lan>
	<20170629225225.GA13979@flamenco>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <69def2b9-13d1-1600-2f4a-4001958ffa97@twiddle.net>
Date: Fri, 30 Jun 2017 11:46:00 -0700
MIME-Version: 1.0
In-Reply-To: <20170629225225.GA13979@flamenco>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v11 01/29] Pass generic CPUState to
 gen_intermediate_code()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Michael Walle <michael@walle.cc>, Laurent Vivier <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Anthony Green <green@moxielogic.com>, Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>, Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Max Filippov <jcmvbkbc@gmail.com>, "open list:ARM" <qemu-arm@nongnu.org>, "open list:PowerPC" <qemu-ppc@nongnu.org>

On 06/29/2017 03:52 PM, Emilio G. Cota wrote:
> On Wed, Jun 28, 2017 at 15:20:42 +0300, Lluís Vilanova wrote:
>> Needed to implement a target-agnostic gen_intermediate_code() in the
>> future.
>>
>> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>> Reviewed-by: Richard Henderson <rth@twiddle.net>
>> ---
> (snip)
>> -void gen_intermediate_code(CPUAlphaState *env, struct TranslationBlock *tb)
>> +void gen_intermediate_code(CPUState *cpu, struct TranslationBlock *tb)
>>   {
>> -    AlphaCPU *cpu = alpha_env_get_cpu(env);
>> -    CPUState *cs = CPU(cpu);
>> +    CPUAlphaState *env = cpu->env_ptr;
> 
> I'd keep the original variable names, i.e. cs for CPUState in this case,
> just like you did for a64:
> 
>> -void gen_intermediate_code_a64(ARMCPU *cpu, TranslationBlock *tb)
>> +void gen_intermediate_code_a64(CPUState *cs, TranslationBlock *tb)
>>   {
>> -    CPUState *cs = CPU(cpu);
>> -    CPUARMState *env = &cpu->env;
>> +    CPUARMState *env = cs->env_ptr;
>> +    ARMCPU *cpu = arm_env_get_cpu(env);
> 
> This will keep the diff size to a minimum.

I asked for the same thing many revisions ago.


r~
