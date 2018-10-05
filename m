Received: from eggs.gnu.org ([2001:4830:134:3::10]:51080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g8SCE-0001L3-MF
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:39:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g8Ryv-0000LZ-DX
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:25:38 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39729)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g8Ryt-0000Ha-DX
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:25:33 -0400
Received: by mail-ot1-x344.google.com with SMTP id c20-v6so13061552otl.6
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 08:25:29 -0700 (PDT)
References: <20180928142533.8451-1-peter.maydell@linaro.org>
	<52177933-047f-d99b-e7d7-2a85e4c8d59c@vivier.eu>
	<eee0054a-4d73-53a2-ca52-dbce4f1996e5@vivier.eu>
	<CAFEAcA_3o3FSScwUcrDX2aFoj-RvNjo=F_Em2HaP=pK5o4=Bng@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2998097f-bb40-409c-16aa-f8bef811444c@linaro.org>
Date: Fri, 5 Oct 2018 10:25:25 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_3o3FSScwUcrDX2aFoj-RvNjo=F_Em2HaP=pK5o4=Bng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: Suppress
 address-of-packed-member warnings in __get/put_user_e
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, "patches@linaro.org" <patches@linaro.org>

On 10/5/18 4:10 AM, Peter Maydell wrote:
> On 5 October 2018 at 01:28, Laurent Vivier <laurent@vivier.eu> wrote:
>> I have the following error when building on Fedora 28 and gcc (GCC)
>> 8.1.1 20180712 (Red Hat 8.1.1-5)
>>
>>   CC      aarch64_be-linux-user/target/arm/arm-semi.o
>> .../target/arm/arm-semi.c: In function ‘do_arm_semihosting’:
>> .../target/arm/arm-semi.c:270:1: error: unknown option after ‘#pragma
>> GCC diagnostic’ kind [-Werror=pragmas]
>>
>> Perhaps you should use a "#if defined(__clang__)" to apply your fix only
>> to clang?
> 
> I did test on gcc, but not that version. The point of the
>    _Pragma("GCC diagnostic ignored \"-Wpragmas\"");
> line is to suppress that error (which it does on my gcc 5)
> so I don't know why your gcc is complaining :-(

I suppose you could try -Wunknown-pragmas.
But from reading the manual it shouldn't make a difference.
OTOH, what you wrote should have worked...


r~
