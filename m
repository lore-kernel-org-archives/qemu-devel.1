Received: from eggs.gnu.org ([2001:4830:134:3::10]:41074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f80J2-0005Z7-6W
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 05:20:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f80J1-0005kP-Ec
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 05:20:12 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:40568)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f80J1-0005jn-AG
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 05:20:11 -0400
Received: by mail-ot0-x242.google.com with SMTP id h8-v6so5513203otj.7
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 02:20:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6aa86822-d3c1-61bc-622a-0ce329f5bc7a@st.com>
References: <20180406151752.10854-1-christophe.lyon@st.com>
	<20180406151752.10854-2-christophe.lyon@st.com>
	<CAFEAcA9b7coeoZUX9JhkMZbLsEaM265g5Y844JScaO0k-1dsxA@mail.gmail.com>
	<6aa86822-d3c1-61bc-622a-0ce329f5bc7a@st.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Apr 2018 10:19:50 +0100
Message-ID: <CAFEAcA_4PW-crD3NaQj2nhy6bupt4XW2Yf54i-cjs2edz39hRw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [ARM/FDPIC 1/4] linux-user: ARM-FDPIC: Add
 configure option to support loading of FDPIC binaries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christophe Lyon <christophe.lyon@st.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Christophe Lyon <christophe.lyon@linaro.org>

On 16 April 2018 at 08:57, Christophe Lyon <christophe.lyon@st.com> wrote:
> On 13/04/2018 17:04, Peter Maydell wrote:
>> I think we should just have support for these binaries enabled
>> always. Otherwise it will bitrot because nobody compiles it.
>>
> We are relying on a pre-existing CONFIG_USE_FDPIC, which is currently
> never defined. This was introduced by commit 1af02e83 back in 2011,
> and indeed if you try to build QEMU with CONFIG_USE_FDPIC, the build fails
> because elf_is_fdpic() is not defined.

This looks like an excellent demonstration of why we shouldn't
hide this feature behind a defaults-to-off #define :-)

> Do you suggest removing CONFIG_USE_FDPIC?

Yes. Given how old the existing disabled FDPIC code is, I would also
suggest you carefully review any of it that you're using...

thanks
-- PMM
