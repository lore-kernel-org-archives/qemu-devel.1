Received: from eggs.gnu.org ([2001:4830:134:3::10]:48525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOq3Q-0005eU-V0
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 15:49:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOq3N-0001K0-2O
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 15:49:40 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:41456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fOq3M-0001Gu-Rq
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 15:49:36 -0400
Received: by mail-pf0-x241.google.com with SMTP id v63-v6so12972147pfk.8
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 12:49:36 -0700 (PDT)
References: <20180313224719.4954-1-pbonzini@redhat.com>
	<20180313224719.4954-51-pbonzini@redhat.com>
	<20180601185139.GA25837@flamenco>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e9569cda-8d14-a575-d183-e12328a44dab@linaro.org>
Date: Fri, 1 Jun 2018 12:49:32 -0700
MIME-Version: 1.0
In-Reply-To: <20180601185139.GA25837@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 50/69] hw/alpha/dp264: Use the
 TYPE_SMC37C669_SUPERIO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 06/01/2018 11:51 AM, Emilio G. Cota wrote:
> On Tue, Mar 13, 2018 at 23:47:00 +0100, Paolo Bonzini wrote:
>> From: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> Message-Id: <20180308223946.26784-25-f4bug@amsat.org>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  default-configs/alpha-softmmu.mak |  3 +++
>>  hw/alpha/dp264.c                  | 10 ++++------
>>  2 files changed, 7 insertions(+), 6 deletions(-)
> 
> This commit breaks alpha-softmmu bootup for me. I get no console
> output whatsoever -- not even the green "Hello" when invoking
> the alpha-softmmu binary with no arguments.
> 
> Did anybody else notice this?

I hadn't tested before, but I can certainly confirm.


r~
