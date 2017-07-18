Received: from eggs.gnu.org ([2001:4830:134:3::10]:50615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXYlO-0000m5-UC
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:06:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXYlN-0006RQ-Vt
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:06:34 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170718045540.16322-1-f4bug@amsat.org>
	<20170718045540.16322-4-f4bug@amsat.org>
	<628617ba-12f6-97ad-6818-1d7d0c63f558@twiddle.net>
	<20170718071452.4hlhpelfposv6eye@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <3290e6b0-a5ec-e5bd-e911-1ace6a401e61@twiddle.net>
Date: Tue, 18 Jul 2017 10:06:20 -1000
MIME-Version: 1.0
In-Reply-To: <20170718071452.4hlhpelfposv6eye@aurel32.net>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 03/10] target/arm: optimize aarch64
 rev16() using extract op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Laurent Vivier <laurent@vivier.eu>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

On 07/17/2017 09:14 PM, Aurelien Jarno wrote:
> On 2017-07-17 20:25, Richard Henderson wrote:
>> On 07/17/2017 06:55 PM, Philippe Mathieu-Daudé wrote:
>>> Aurelien Jarno denoted this function could be implemented more effectively using
>>> the aarch32 rev16() pattern.
>>>     [http://lists.nongnu.org/archive/html/qemu-devel/2017-05/msg03180.html]
>>>
>>> Done with the Coccinelle semantic patch from commit 58daf05d07dd
>>>       (see scripts/coccinelle/tcg_gen_extract.cocci)
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>
>> I'm dropping this patch and replacing it with the much smaller code
>> mentioned in the message quoted above.
> 
> In that case, could you also get the corresponding aarch32 patch:
> http://lists.nongnu.org/archive/html/qemu-devel/2017-05/msg03887.html
> 
> It has already been reviewed.
> 
Done.


r~
