Received: from eggs.gnu.org ([2001:4830:134:3::10]:40009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dzNWP-0001sz-CW
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:46:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dzNWK-0003hs-DN
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:46:05 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:43842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dzNWK-0003hG-9G
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:46:00 -0400
Received: by mail-qt0-x243.google.com with SMTP id a43so7092137qta.0
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 06:46:00 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170928165414.7339-1-richard.henderson@linaro.org>
	<20170928165414.7339-5-richard.henderson@linaro.org>
	<17f88913-12dc-b462-d6fd-9b1c6cfbd6a9@amsat.org>
	<1085a4f8-d12b-f87c-caa7-a9927247d7e8@linaro.org>
	<1be5c928-43d0-e8d1-7c6b-0c37f40c7a54@amsat.org>
	<e4110def-0b26-f16f-593c-07e1b5eb67c6@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f1e00f85-8949-0f92-bd4b-b1cbfc92a503@amsat.org>
Date: Tue, 3 Oct 2017 10:45:56 -0300
MIME-Version: 1.0
In-Reply-To: <e4110def-0b26-f16f-593c-07e1b5eb67c6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 4/9] disas: Support the Capstone
 disassembler library
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org

On 10/02/2017 10:51 PM, Richard Henderson wrote:
> On 10/02/2017 02:45 PM, Philippe Mathieu-Daudé wrote:
>> On 10/02/2017 03:34 PM, Richard Henderson wrote:
>>> On 10/02/2017 09:36 AM, Philippe Mathieu-Daudé wrote:
>>>> Maybe some defines like:
>>>>
>>>> #define LARGEST_TARGET_INSTR_SIZE 32
>>>>
>>>> #define MINIMUM_TARGET_PAGE_SIZE 1024
>>>
>>> Eh.  If I weren't simply pulling numbers out of my hat, perhaps.
>>> Does it really make things clearer beyond sizeof or a great big comment?
>>
>> big comment is great!
> 
> Like the one that's already there?

Yes, sorry for being that unclear, I wanted to say "_this_ big comment
_is_ great!". I suppose I think about using #defines because my English
isn't that conveying than yours :)

> 
> +        /* We want to read memory for one insn, but generically we do not
> +           know how much memory that is.  We have a small buffer which is
> +           known to be sufficient for all supported targets.  Try to not
> +           read beyond the page, Just In Case.  For even more simplicity,
> +           ignore the actual target page size and use a 1k boundary.  If
> +           that turns out to be insufficient, we'll come back around the
> +           loop and read more.  */
> 
> 
> r~
> 
