Received: from eggs.gnu.org ([2001:4830:134:3::10]:59973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d1D5G-0007f7-HB
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 10:29:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d1D5F-0002kV-EE
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 10:29:22 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:38401)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d1D5F-0002jr-7N
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 10:29:21 -0400
Received: by mail-wm0-x22d.google.com with SMTP id r190so49999964wme.1
	for <qemu-devel@nongnu.org>; Thu, 20 Apr 2017 07:29:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <0f3ee3f1-5d73-79be-2e7d-45c0385c6758@twiddle.net>
References: <1491844419-12485-1-git-send-email-peter.maydell@linaro.org>
	<0f3ee3f1-5d73-79be-2e7d-45c0385c6758@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Apr 2017 15:28:59 +0100
Message-ID: <CAFEAcA_9=zNiJvbbg-Cdc5_rSkA3ySYeo=quP6ApdGG6wibMoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 0/9] arm: Implement M profile exception
 return properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, "patches@linaro.org" <patches@linaro.org>

On 15 April 2017 at 13:31, Richard Henderson <rth@twiddle.net> wrote:
> On 04/10/2017 10:13 AM, Peter Maydell wrote:
>>
>> Peter Maydell (9):
>>   arm: Don't implement BXJ on M-profile CPUs
>>   arm: Thumb shift operations should not permit interworking branches
>>   arm: Factor out "generate right kind of step exception"
>>   arm: Move gen_set_condexec() and gen_set_pc_im() up in the file
>>   arm: Move condition-failed codepath generation out of if()
>>   arm: Abstract out "are we singlestepping" test to utility function
>>   arm: Track M profile handler mode state in TB flags
>>   arm: Implement M profile exception return properly
>>   arm: Remove workarounds for old M-profile exception return
>>     implementation
>>
>>  target/arm/cpu.h       |   9 +++
>>  target/arm/translate.h |   5 ++
>>  target/arm/cpu.c       |  43 +-----------
>>  target/arm/translate.c | 181
>> +++++++++++++++++++++++++++++++++----------------
>>  4 files changed, 138 insertions(+), 100 deletions(-)
>
>
> Reviewed-by: Richard Henderson <rth@twiddle.net>

Thanks; applied to target-arm.next.

-- PMM
