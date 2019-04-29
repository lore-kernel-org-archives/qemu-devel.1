Received: from eggs.gnu.org ([209.51.188.92]:46015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLCjS-0001ON-7O
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 16:18:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLCjR-0002Xu-Bu
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 16:18:34 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:44717)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLCjR-0002XN-5L
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 16:18:33 -0400
Received: by mail-pf1-x442.google.com with SMTP id y13so5868215pfm.11
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 13:18:32 -0700 (PDT)
References: <20190330005900.17282-1-richard.henderson@linaro.org>
	<20190330005900.17282-4-richard.henderson@linaro.org>
	<CAFEAcA-3qrQXk9iMY_9VZSLzdnn=EzzYOqhe61UQKYn-w__3Zw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a3da11b9-b2e2-2222-1194-437c7ccad61d@linaro.org>
Date: Mon, 29 Apr 2019 13:18:23 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-3qrQXk9iMY_9VZSLzdnn=EzzYOqhe61UQKYn-w__3Zw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 3/4] linux-user: Parse
 NT_GNU_PROPERTY_TYPE_0 notes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>

On 4/29/19 9:17 AM, Peter Maydell wrote:
>> +        struct elf_phdr *eppnt = phdr + i;
>> +
>> +        switch (eppnt->p_type) {
>> +        case PT_LOAD:
>> +            {
> 
> I think you have an extra layer of indent here that we usually
> don't do for switch statement cases.

No, that indent is exactly right for a compound statement
not associated with an if/while/whatnot.

> #define GNU0_MAGIC const_le32('G' | 'N' << 8 | 'U' << 16)
> 
> and then you can avoid the #ifdef HOST_WORDS_BIGENDIAN?

Sure.


r~
