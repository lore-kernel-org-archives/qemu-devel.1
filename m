Received: from eggs.gnu.org ([2001:4830:134:3::10]:51440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ePt6m-00012j-GP
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:45:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ePt6l-0000lH-KX
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:45:12 -0500
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:38299)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ePt6l-0000k2-Ef
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:45:11 -0500
Received: by mail-oi0-x244.google.com with SMTP id s9so6560820oie.5
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 08:45:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <089717fa-9e7e-fe79-3315-ccc13c01de8d@linaro.org>
References: <1512752248-17857-1-git-send-email-peter.maydell@linaro.org>
	<089717fa-9e7e-fe79-3315-ccc13c01de8d@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Dec 2017 16:44:50 +0000
Message-ID: <CAFEAcA9+99eeKOxpLwnLBXwH5jr8thFgFNjgRwezqHN2_JeBzg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] sparc: Make sure we mmap at SHMLBA
 alignment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "patches@linaro.org" <patches@linaro.org>

On 12 December 2017 at 05:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 12/08/2017 08:57 AM, Peter Maydell wrote:
>> SPARC Linux has an oddity that it insists that mmap()
>> of MAP_FIXED memory must be at an alignment defined by
>> SHMLBA, which is more aligned than the page size
>> (typically, SHMLBA alignment is to 16K, and pages are 8K).
>> This is a relic of ancient hardware that had cache
>> aliasing constraints, but even on modern hardware the
>> kernel still insists on the alignment.
>>
>> To ensure that we get mmap() alignment sufficient to
>> make the kernel happy, change QEMU_VMALLOC_ALIGN,
>> qemu_fd_getpagesize() and qemu_mempath_getpagesize()
>> to use the maximum of getpagesize() and SHMLBA.
>>
>> In particular, this allows 'make check' to pass on Sparc:
>> we were previously failing the ivshmem tests.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks; I have applied this to master and added a sparc64
host to my set of build systems. (Thanks to John for providing
access to that host.)

-- PMM
