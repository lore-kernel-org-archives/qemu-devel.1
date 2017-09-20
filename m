Received: from eggs.gnu.org ([2001:4830:134:3::10]:42702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dueoB-00008D-OO
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:13:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1duenk-0007Xf-LP
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:12:55 -0400
Received: from mail-oi0-x233.google.com ([2607:f8b0:4003:c06::233]:46876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1duenk-0007XO-FQ
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:12:28 -0400
Received: by mail-oi0-x233.google.com with SMTP id a74so2506512oib.3
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 06:12:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
References: <20170919150313.10833-1-richard.henderson@linaro.org>
	<20170919150313.10833-5-richard.henderson@linaro.org>
	<87y3p9d3fq.fsf@linaro.org>
Message-ID: <8deb13bd-af38-9851-085f-6428255297d3@linaro.org>
Date: Wed, 20 Sep 2017 08:04:26 -0500
MIME-Version: 1.0
In-Reply-To: <87y3p9d3fq.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 4/8] disas: Support the Capstone
 disassembler library
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org

On 09/20/2017 06:17 AM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> If configured, prefer this over our rather dated copy of the
>> GPLv2-only binutils.  This will be especially apparent with
>> the proposed vector extensions to TCG, as disas/i386.c does
>> not handle AVX.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> Hmm I get a link failure:
> 
>   LINK    tilegx-linux-user/qemu-tilegx
> disas.o: In function `cap_disas_start':
> /home/alex/lsrc/qemu/qemu.git/disas.c:196: undefined reference to `cs_open'

I'm going to assume that this isn't the first executable to be linked, and
therefore it's weirder than what I imagine.

> I wonder if this is a version thing?
> 
>     Package: libcapstone-dev
>     Status: install ok installed
>     Priority: optional
>     Section: libdevel
>     Installed-Size: 4079
>     Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
>     Architecture: amd64
>     Source: capstone
>     Version: 3.0.4-0.2

No, I've got capstone-devel-3.0.4-8.fc26.x86_64.

The only thing I can imagine is that you didn't start from a fresh build tree
and something went wrong during re-configure.


r~
