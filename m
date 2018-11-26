Received: from eggs.gnu.org ([2001:4830:134:3::10]:50957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gROO0-0004q2-BH
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 16:25:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gRONx-0001w7-6O
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 16:25:44 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36312)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gRONx-0001uy-0K
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 16:25:41 -0500
Received: by mail-wr1-f67.google.com with SMTP id t3so20504719wrr.3
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 13:25:40 -0800 (PST)
References: <1543226303-5260-1-git-send-email-liq3ea@gmail.com>
	<87mupw3vm2.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <733cd094-3775-ba2f-242d-e58bc7f2daaa@redhat.com>
Date: Mon, 26 Nov 2018 22:25:36 +0100
MIME-Version: 1.0
In-Reply-To: <87mupw3vm2.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] target: hax: fix a typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>
Cc: ehabkost@redhat.com, qemu-trivial@nongnu.org, laurent@vivier.eu, pbonzini@redhat.com, rth@twiddle.net

Hi Li, Alex.

On 26/11/18 12:51, Alex Bennée wrote:
> 
> Li Qiang <liq3ea@gmail.com> writes:
> 
>> Cc: qemu-trivial@nongnu.org
>>
>> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> 
>> ---
>>  target/i386/hax-all.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
>> index 502ce6f0af..464744a406 100644
>> --- a/target/i386/hax-all.c
>> +++ b/target/i386/hax-all.c
>> @@ -205,7 +205,7 @@ int hax_vcpu_destroy(CPUState *cpu)
>>      }
>>
>>      /*
>> -     * 1. The hax_tunnel is also destroied when vcpu destroy
>> +     * 1. The hax_tunnel is also destroyed when vcpu destroy

I'm not native english speaker. Isn't it:

'The hax_tunnel is also destroyed at vcpu destroy'

or

'The hax_tunnel is also destroyed when vcpu is destroyed'?

>>       * 2. close fd will cause hax module vcpu be cleaned
>>       */
>>      hax_close_fd(vcpu->fd);
> 
> 
> --
> Alex Bennée
> 
