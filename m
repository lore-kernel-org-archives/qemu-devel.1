Received: from eggs.gnu.org ([2001:4830:134:3::10]:45382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <christophe.lyon@st.com>) id 1f7z0u-0000yV-8w
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 03:57:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <christophe.lyon@st.com>) id 1f7z0r-0008Lz-4O
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 03:57:24 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:61537
	helo=mx07-00178001.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <christophe.lyon@st.com>)
	id 1f7z0q-0008Ko-Pf
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 03:57:21 -0400
References: <20180406151752.10854-1-christophe.lyon@st.com>
	<20180406151752.10854-2-christophe.lyon@st.com>
	<CAFEAcA9b7coeoZUX9JhkMZbLsEaM265g5Y844JScaO0k-1dsxA@mail.gmail.com>
From: Christophe Lyon <christophe.lyon@st.com>
Message-ID: <6aa86822-d3c1-61bc-622a-0ce329f5bc7a@st.com>
Date: Mon, 16 Apr 2018 09:57:16 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9b7coeoZUX9JhkMZbLsEaM265g5Y844JScaO0k-1dsxA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Christophe Lyon <christophe.lyon@linaro.org>

On 13/04/2018 17:04, Peter Maydell wrote:
> On 6 April 2018 at 16:17, Christophe Lyon <christophe.lyon@st.com> wrote:
>> Adds --enable-fdpic and --disable-fdpic configure options.  This
>> feature is disabled by default, that's why it is not described in the
>> "Optional features" help section (which are enabled by default if
>> possible).
>>
>> FDPIC ELF objects are identified with e_ident[EI_OSABI] ==
>> ELFOSABI_ARM_FDPIC.
> 
> If we can identify these ELF objects by looking in the ELF header,
> why would we want to make this all a configure option that's
> disabled by default?
> 
> I think we should just have support for these binaries enabled
> always. Otherwise it will bitrot because nobody compiles it.
> 
We are relying on a pre-existing CONFIG_USE_FDPIC, which is currently
never defined. This was introduced by commit 1af02e83 back in 2011,
and indeed if you try to build QEMU with CONFIG_USE_FDPIC, the build fails because elf_is_fdpic() is not defined.

We tried to conform to this existing support, but maybe it's already bit-rotten?
Do you suggest removing CONFIG_USE_FDPIC?

Thanks



> thanks
> -- PMM
> .
> 
