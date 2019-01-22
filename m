Received: from eggs.gnu.org ([209.51.188.92]:48825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gm1r2-0002ek-T4
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:37:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gm1r1-0004A8-0M
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:37:00 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:34498)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gm1qx-00044P-BY
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:36:57 -0500
Received: by mail-pg1-x543.google.com with SMTP id j10so11525108pga.1
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 11:36:54 -0800 (PST)
References: <20190110121736.23448-1-richard.henderson@linaro.org>
	<20190110121736.23448-9-richard.henderson@linaro.org>
	<CAFEAcA9+8XBXDqL8JfTpS8q05XwaZ+Ck1nqAhTLsyN_=WCjXNA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <13b8c253-d3da-3bca-de83-ea9422d5f30f@linaro.org>
Date: Tue, 22 Jan 2019 07:42:27 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9+8XBXDqL8JfTpS8q05XwaZ+Ck1nqAhTLsyN_=WCjXNA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/11] target/arm: Add guarded_pages cpu
 property for user-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 1/22/19 7:29 AM, Peter Maydell wrote:
> On Thu, 10 Jan 2019 at 12:18, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> While waiting for a proper userland ABI, allow static test
>> cases to be written assuming that GP is set for all pages.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/arm/cpu.h           |  4 ++++
>>  target/arm/cpu64.c         | 18 ++++++++++++++++++
>>  target/arm/translate-a64.c |  8 +++++++-
>>  3 files changed, 29 insertions(+), 1 deletion(-)
> 
> This is OK code-wise but I'm a bit wary of committing it
> because then we're stuck with the property forever even
> if it turns out to be irrelevant to whatever the userland
> ABI eventually is.

That's surely simply a matter of documentation.
"Don't rely on this property: it will go away."


r~
