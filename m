Received: from eggs.gnu.org ([2001:4830:134:3::10]:52434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eEwKR-0006Mw-De
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 06:58:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eEwKQ-0004EM-Mr
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 06:58:03 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:47629)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eEwKQ-0004DJ-GP
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 06:58:02 -0500
Received: by mail-wr0-x242.google.com with SMTP id k61so20240455wrc.4
	for <qemu-devel@nongnu.org>; Wed, 15 Nov 2017 03:58:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAKmqyKORH2jwGP4ULZv6B8=262OhznHkwOzONd9HFQoJkKzD=A@mail.gmail.com>
References: <1510066898-3725-1-git-send-email-peter.maydell@linaro.org>
	<CAKmqyKORH2jwGP4ULZv6B8=262OhznHkwOzONd9HFQoJkKzD=A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Nov 2017 11:57:40 +0000
Message-ID: <CAFEAcA-z_gfMr+=8c1kexo6iL--uxNVMzOnN0aox0FGAv3pHjQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.11] target/arm: Report GICv3 sysregs
 present in ID registers if needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Stefano Stabellini <sstabellini@kernel.org>, Patch Tracking <patches@linaro.org>

On 15 November 2017 at 01:14, Alistair Francis <alistair23@gmail.com> wrote:
> On Tue, Nov 7, 2017 at 7:01 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
>> The CPU ID registers ID_AA64PFR0_EL1, ID_PFR1_EL1 and ID_PFR1
>> have a field for reporting presence of GICv3 system registers.
>> We need to report this field correctly in order for Xen to
>> work as a guest inside QEMU emulation. We mustn't incorrectly
>> claim the sysregs exist when they don't, though, or Linux will
>> crash.
>>
>> Unfortunately the way we've designed the GICv3 emulation in QEMU
>> puts the system registers as part of the GICv3 device, which
>> may be created after the CPU proper has been realized. This
>> means that we don't know at the point when we define the ID
>> registers what the correct value is. Handle this by switching
>> them to calling a function at runtime to read the value, where
>> we can fill in the GIC field appropriately.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> Is this going to make it into 2.11?

Yes, it's supposed to go into 2.11 -- I think I just forgot
to put it in the rc1 pullreq, but it'll go in rc2.

thanks
-- PMM
