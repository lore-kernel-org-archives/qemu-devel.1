Received: from eggs.gnu.org ([2001:4830:134:3::10]:47978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <christophe.lyon@st.com>) id 1f7z4g-00035v-T5
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 04:01:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <christophe.lyon@st.com>) id 1f7z4b-0003gi-02
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 04:01:18 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:49285)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <christophe.lyon@st.com>)
	id 1f7z4a-0003e8-Lg
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 04:01:12 -0400
References: <20180406151752.10854-1-christophe.lyon@st.com>
	<CAFEAcA9f7UHZAK51jdZsSsx-wc6Mvee0L2BPnOsKy78+ceWi3Q@mail.gmail.com>
From: Christophe Lyon <christophe.lyon@st.com>
Message-ID: <765bb54c-bb55-1ac4-2028-2f7b934ad99b@st.com>
Date: Mon, 16 Apr 2018 10:01:07 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9f7UHZAK51jdZsSsx-wc6Mvee0L2BPnOsKy78+ceWi3Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [ARM/FDPIC 0/4] FDPIC ABI for ARM
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

On 13/04/2018 17:18, Peter Maydell wrote:
> On 6 April 2018 at 16:17, Christophe Lyon <christophe.lyon@st.com> wrote:
>> Hello,
>>
>> This patch series implements the QEMU contribution of the FDPIC
>> ABI for ARM targets.
> 
>> I am currently working on updating the patches for the other toolchain
>> components, and will upstream them soon. This includes gcc, uclibc,
>> and gdb.
>>
>> This series provides support for ARM v7 and later architectures and
>> has been used to run the GCC tests on arm-linux-gnueabi without
>> regression, as well as arm-linux-uclibceabi.
>>
>> Are the QEMU patches OK for inclusion in master?
> 
> Hi; I've given the patches a quick look over for structural
> issues, though I haven't looked too closely at the details.
> I think that given that the support is in Linux master I'm
> happy with it also going into QEMU.
> 
> NB that Laurent has some patchsets outstanding which rework
> the linux-user code to split the per-architecture parts of
> signal.c and main.c into per-architecture files rather than
> having lots of ifdefs. Those will probably land early in the
> 2.13 cycle. I mention this just as a heads-up that at some point
> you'll find yourself with a somewhat painful rebase.
> 

Thanks for the heads-up, I was unaware of that, and indeed I'd
rather avoid such a rebase.

> PS: I'd recommend cc'ing the linux-user maintainers (listed in
> the MAINTAINERS file) on your next version of this patchset.
> 
> thanks
> -- PMM
> .
> 
