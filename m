Received: from eggs.gnu.org ([2001:4830:134:3::10]:34342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epA9F-00084Y-I2
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 05:00:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epA9E-00057a-N1
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 05:00:13 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:42030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1epA9E-00056O-GR
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 05:00:12 -0500
Received: by mail-pl0-x244.google.com with SMTP id 31so4626660ple.9
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 02:00:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <e62e1429-b812-7b92-5d61-055d6aa6a31e@linaro.org>
References: <20180216215608.13227-1-richard.henderson@linaro.org>
	<20180216215608.13227-6-richard.henderson@linaro.org>
	<CAFEAcA8bkt+dOehzyWm3=KUtiVRHak8Ge2gJTJuCg3VAyLQoSQ@mail.gmail.com>
	<e62e1429-b812-7b92-5d61-055d6aa6a31e@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2018 09:59:50 +0000
Message-ID: <CAFEAcA8ZBju=M4THxGdjW+d5LuOkrUcu5hOybfLmaJHGS2FoEw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 5/5] aarch64-linux-user: Add support for
 SVE signal frame records
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 22 February 2018 at 20:14, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 02/22/2018 08:41 AM, Peter Maydell wrote:
>> On 16 February 2018 at 21:56, Richard Henderson
>> <richard.henderson@linaro.org> wrote:

>>> +        if (sve_size <= std_size) {
>>> +            sve_ofs = size;
>>> +            size += sve_size;
>>> +            end1_ofs = size;
>>> +        } else {
>>> +            /* Otherwise we need to allocate extra space.  */
>>> +            extra_ofs = size;
>>> +            size += sizeof(struct target_extra_context);
>>> +            end1_ofs = size;
>>> +            size += QEMU_ALIGN_UP(sizeof(struct target_aarch64_ctx), 16);
>>
>> Why do we add the size of target_aarch64_ctx to size here?
>> We already account for the size of the end record later, so
>> what is this one?
>
> This is for the end record within the extra space, as opposed to the end record
> within the standard space which is what we accounted for before.  A comment
> would help, I supposed.

Oh, so 'size' is accounting for both the standard space used
and the extra space? I had thought that 'size' was just counting
up the standard space used, and the extra space count was in
extra_size.

thanks
-- PMM
