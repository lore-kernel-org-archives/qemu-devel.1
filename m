Received: from eggs.gnu.org ([2001:4830:134:3::10]:54876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cYbll-00022O-Bh
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:59:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cYblk-0005uQ-Qy
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:59:01 -0500
Received: from mail-vk0-x235.google.com ([2607:f8b0:400c:c05::235]:34757)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cYblk-0005uH-MJ
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:59:00 -0500
Received: by mail-vk0-x235.google.com with SMTP id r136so241383689vke.1
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 08:59:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170131165557.GE20303@redhat.com>
References: <1485879287-12548-1-git-send-email-peter.maydell@linaro.org>
	<20170131165557.GE20303@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Jan 2017 16:58:39 +0000
Message-ID: <CAFEAcA9Jbv398L=yjPmq7MfV+bpma4TiBX9LbBBHZ_qo5DvuGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] Drop QEMU_GNUC_PREREQ() checks for gcc
 older than 4.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On 31 January 2017 at 16:55, Daniel P. Berrange <berrange@redhat.com> wrote:
> On Tue, Jan 31, 2017 at 04:14:47PM +0000, Peter Maydell wrote:
>> We already require gcc 4.1 or newer (for the atomic
>> support), so the fallback codepaths for older gcc
>> versions than that are now dead code and we can
>> just delete them.
>
> Do we have any explicit check alreadu for 4.1, or do we
> just let the build fail on the atomic code ?
>
> IOW, is there any use in having..
>
> #if !QEMU_GNUC_PREREQ(4, 1)
> # error "QEMU requires GCC >= 4.1 or CLang"
> #endif

I guess we just barf in the atomics. An explicit check might
not be a bad idea I guess, though it depends a bit on how
many releases we've been implicitly requiring 4.1 for. I
suppose it would act as documentation of our current
minimum req.

thanks
-- PMM
