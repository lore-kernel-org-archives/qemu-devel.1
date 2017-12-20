Received: from eggs.gnu.org ([208.118.235.92]:36483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eRgeh-0005LY-JQ
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 10:51:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eRgee-0006tb-3F
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 10:51:39 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:62326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eRged-0006tE-Pa
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 10:51:36 -0500
References: <20171219201613.7399-1-michael.weiser@gmx.de>
	<20171219201613.7399-3-michael.weiser@gmx.de>
	<bd78a6f5-f023-af5a-0d35-f3b29ae4e7a6@vivier.eu>
	<CAFEAcA8D0n_PNJ-fqMq8KtZSBRdf2i=3cxcbwT1HSnFi9_MhpA@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <12f2eb2c-cc6b-102e-dc6b-2526c03ea42c@vivier.eu>
Date: Wed, 20 Dec 2017 16:51:23 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8D0n_PNJ-fqMq8KtZSBRdf2i=3cxcbwT1HSnFi9_MhpA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 2/5] linux-user: Add separate aarch64_be
 uname
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Michael Weiser <michael.weiser@gmx.de>, QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

Le 20/12/2017 à 16:36, Peter Maydell a écrit :
> On 20 December 2017 at 15:20, Laurent Vivier <laurent@vivier.eu> wrote:
>> Le 19/12/2017 à 21:16, Michael Weiser a écrit :
>>> Make big-endian aarch64 systems identify as aarch64_be as expected by
>>> big-endian userland and toolchains.
>>>
>>> Signed-off-by: Michael Weiser <michael.weiser@gmx.de>
>>> ---
>>>  linux-user/aarch64/target_syscall.h | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/linux-user/aarch64/target_syscall.h b/linux-user/aarch64/target_syscall.h
>>> index 1b62953eeb..604ab99b14 100644
>>> --- a/linux-user/aarch64/target_syscall.h
>>> +++ b/linux-user/aarch64/target_syscall.h
>>> @@ -8,7 +8,11 @@ struct target_pt_regs {
>>>      uint64_t        pstate;
>>>  };
>>>
>>> +#if defined(TARGET_WORDS_BIGENDIAN)
>>> +#define UNAME_MACHINE "aarch64_be"
>>> +#else
>>>  #define UNAME_MACHINE "aarch64"
>>> +#endif
>>>  #define UNAME_MINIMUM_RELEASE "3.8.0"
>>
>> For aarch64_be, I think the minimum release should be 4.9.0
>> (see kernel commit cfa88c79462d "arm64: Set UTS_MACHINE in the Makefile")
> 
> Isn't the thing that defines what we set the minimum-release
> to glibc, not the kernel? That is, the reason we lie to the
> guest about the kernel version for some architectures is because
> the glibc for those archs insists on a minimum kernel version
> which the host may not have. Unless aarch64_be glibc insists
> on kernel 4.9.0 there's no need to tell the guest that.

As you are the author of the original commit (4a24a75810 "linux-user:
Allow targets to specify a minimum uname release"), I guess you're
right. So ignore my comment...

Thanks,
Laurent
