Received: from eggs.gnu.org ([2001:4830:134:3::10]:54301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fIGGJ-00016G-HD
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:23:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fIGGG-0003eA-V9
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:23:47 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:41940)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fIGGG-0003dX-Mj
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:23:44 -0400
Received: by mail-pg0-x244.google.com with SMTP id w4-v6so4066658pgq.8
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 09:23:44 -0700 (PDT)
References: <20180512004311.9299-1-richard.henderson@linaro.org>
	<20180512004311.9299-7-richard.henderson@linaro.org>
	<CAFEAcA_eynaKKW0BJ1MuGnM1o27D1-QtxgTdMkunrqygw0pjNg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <82bd347e-f40a-6385-f297-cc2070ad3fdc@linaro.org>
Date: Mon, 14 May 2018 09:23:40 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_eynaKKW0BJ1MuGnM1o27D1-QtxgTdMkunrqygw0pjNg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 06/27] fpu/softfloat: Canonicalize NaN
 fraction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 05/14/2018 03:29 AM, Peter Maydell wrote:
> On 12 May 2018 at 01:42, Richard Henderson <richard.henderson@linaro.org> wrote:
>> Shift the NaN fraction to a canonical position, much like we do
>> for the fraction of normal numbers.  Immediately, this simplifies
>> the float-to-float conversion.  Later, this will facilitate
>> manipulation of NaNs within the shared code paths.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> The commit message says it simplifies the float-to-float codepath,
> but the patch doesn't touch that: it's missing the part that was in
> v1 of the series that removed the
>         a.frac = a.frac << (64 - srcf->frac_size) >> (64 - dstf->frac_size);
> line and updated the associated comment.
> 
> Isn't that change necessary in this patch if we're changing the
> canonical representation of NaNs ?

With the reordering of the patches, the offending line never gets added.
So, yeah, the text should be re-worded here.


r~
