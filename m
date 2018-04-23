Received: from eggs.gnu.org ([2001:4830:134:3::10]:34233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fAbUm-0001iU-6w
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 09:27:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fAbUl-0001KW-Gh
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 09:27:04 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:41148)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fAbUl-0001K8-Au
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 09:27:03 -0400
Received: by mail-ot0-x243.google.com with SMTP id m22-v6so17143490otf.8
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 06:27:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d3762ab7-e23c-9078-0e1f-57addc334cbe@st.com>
References: <20180423075215.4572-1-christophe.lyon@st.com>
	<20180423075215.4572-3-christophe.lyon@st.com>
	<CAFEAcA9tnh9j=QMxZm7RTMzaRVxh10oEGDCYYO5TL5TvAuvLXw@mail.gmail.com>
	<d3762ab7-e23c-9078-0e1f-57addc334cbe@st.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Apr 2018 14:26:42 +0100
Message-ID: <CAFEAcA-bhRhgxOqCWd3bA+qRsUaskT3XZ61u9_nPW-fnCvPRfw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [ARM/FDPIC v2 2/4] linux-user: ARM-FDPIC: Identify
 ARM FDPIC binaries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christophe Lyon <christophe.lyon@st.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Christophe Lyon <christophe.lyon@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

On 23 April 2018 at 13:53, Christophe Lyon <christophe.lyon@st.com> wrote:
> On 23/04/2018 14:17, Peter Maydell wrote:
>> I have a strong dislike for per-target ifdef ladders. Can we instead
>> put the target's implementation of elf_is_fdpic() into
>> linux-user/$ARCH/target_elf.h
>> and also have that header do
>> #define TARGET_HAS_ELF_FDPIC
>>
>> and then in the generic code we can protect the default elf_is_fdpic()
>> with #ifndef TARGET_HAS_ELF_FDPIC.
>>
>
> How invasive could that be?
> Your proposal is appealing, but target_elf.h is only included by
> linux-user/main.c, which does not define elfhdr etc...
> All that knowledge is in linux-user/elfload.c, which controls what
> include/elf.h defines.

Hmm, I see what you mean. We can't even put the function inside the
existing per-target ifdef ladder, because that comes before the
include of elf.h halfway down elfload.c.

That's a bit of a mess, but it's a mess we shouldn't try to
clean up as part of this patchset, so

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
