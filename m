Received: from eggs.gnu.org ([2001:4830:134:3::10]:49733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dWU8Q-0002aZ-0m
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 16:57:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dWU8M-0002kx-Un
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 16:57:54 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:62165)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dWU8M-0002k0-Kg
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 16:57:50 -0400
References: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
	<1500040339-119465-15-git-send-email-imammedo@redhat.com>
	<5bec6275-8e15-16c7-8d23-2975a563c78f@twiddle.net>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <9f934ed2-871a-f317-7fd4-cd4b78fe7ca2@vivier.eu>
Date: Sat, 15 Jul 2017 22:57:32 +0200
MIME-Version: 1.0
In-Reply-To: <5bec6275-8e15-16c7-8d23-2975a563c78f@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 14/28] m68k: replace cpu_m68k_init() with
 cpu_generic_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Eduardo Habkost <ehabkost@redhat.com>

Le 15/07/2017 à 20:08, Richard Henderson a écrit :
> On 07/14/2017 03:52 AM, Igor Mammedov wrote:
>> @@ -230,6 +230,8 @@ static void m68k_cpu_realizefn(DeviceState *dev,
>> Error **errp)
>>       M68kCPUClass *mcc = M68K_CPU_GET_CLASS(dev);
>>       Error *local_err = NULL;
>>   +    register_m68k_insns(&cpu->env);
>> +
> 
> I think it would make more sense to do this during m68k_tcg_init.

I agree.

Laurent
