Received: from eggs.gnu.org ([2001:4830:134:3::10]:42977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dueoQ-0000Lz-Lw
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:13:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dueoI-0007qA-3k
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:13:10 -0400
Received: from mail-oi0-x233.google.com ([2607:f8b0:4003:c06::233]:57175)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dueoH-0007pq-W9
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:13:02 -0400
Received: by mail-oi0-x233.google.com with SMTP id b184so2430340oii.13
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 06:13:01 -0700 (PDT)
References: <20170919211012.13507-1-laurent@vivier.eu>
	<c5e9a983-6543-28d3-8e4c-c49b2ac1b694@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6d132bf1-a651-3210-c475-850441e16cc0@linaro.org>
Date: Wed, 20 Sep 2017 08:12:56 -0500
MIME-Version: 1.0
In-Reply-To: <c5e9a983-6543-28d3-8e4c-c49b2ac1b694@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] softfloat: rename
 make_float[x80|128]_init to const_float[x80|128]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>

On 09/19/2017 04:18 PM, Eric Blake wrote:
> On 09/19/2017 04:10 PM, Laurent Vivier wrote:
>> We already have const_float16(), const_float32() and const_float64(),
>> so rename make_floatx80_init() and make_float128_init() as
> 
> s/as/to now be/
> 
>> const_floatx80() and const_float128().
> 
> s/\./, for consistency./
> 
>>
>> Redefine make_float16(), make_float32() and make_float64() as
> 
> s/as/to be like/
> 
>> make_floatx80() and make_float128() using a cast.
> 
> s/ using a cast/, by using a compound literal/

I was about to make the same quibble.

> I almost wonder if splitting this patch into two parts makes more sense
> (one for the renaming of make_float[x80,128]_init, the other for the
> rewriting of make_float[16,32,64] from gcc extension to compound literal).

I think the patch is fine as-is.

Fix the patch description and I'll give it

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
