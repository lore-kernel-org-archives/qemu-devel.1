Received: from eggs.gnu.org ([2001:4830:134:3::10]:41343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epIOz-000868-ST
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 13:49:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epIOy-0005C2-NH
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 13:49:01 -0500
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:39217)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1epIOy-0005AF-HO
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 13:49:00 -0500
Received: by mail-pl0-x241.google.com with SMTP id s13so5378644plq.6
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 10:49:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-WGk0Jkvamr3s_sAzLeUS1VrW7UHuUBnU-xDOEpEh95A@mail.gmail.com>
References: <20171228180814.9749-1-lukeshu@lukeshu.com>
	<20171228180814.9749-2-lukeshu@lukeshu.com>
	<CAFEAcA-WGk0Jkvamr3s_sAzLeUS1VrW7UHuUBnU-xDOEpEh95A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2018 18:48:39 +0000
Message-ID: <CAFEAcA-SmyrNBb4u70hSLtJxd6Wq+P4c6fCXtZBvTKRZdBa+_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 01/10] linux-user: Use #if to only call
 validate_guest_space for 32-bit ARM target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luke Shumaker <lukeshu@lukeshu.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Luke Shumaker <lukeshu@parabola.nu>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

On 23 February 2018 at 18:35, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 28 December 2017 at 18:08, Luke Shumaker <lukeshu@lukeshu.com> wrote:
>> From: Luke Shumaker <lukeshu@parabola.nu>
>>
>> Instead of defining a bogus validate_guest_space that always returns 1 on
>> targets other than 32-bit ARM, use #if blocks to only call it on 32-bit ARM
>> targets.  This makes the "normal" flow control clearer.
>>
>> Signed-off-by: Luke Shumaker <lukeshu@parabola.nu>

>> @@ -1845,11 +1835,12 @@ unsigned long init_guest_space(unsigned long host_start,
>>      /* If just a starting address is given, then just verify that
>>       * address.  */
>>      if (host_start && !host_size) {
>> +#if defined(TARGET_ARM) && !defined(TARGET_AARCH64)
>
> I would strongly prefer us not to add new "these targets do
> this" ifdefs, please. The current approach means that any
> target can say it needs an implementation of this hook by
> providing one and defining the TARGET_HAS_VALIDATE_GUEST_SPACE
> macro to say so. I think that's a better approach.

Looking through some of the rest of this patchset I might change
my mind on that (the code in master is very confusing). I won't
have time to get to this til Tuesday now, though.

thanks
-- PMM
