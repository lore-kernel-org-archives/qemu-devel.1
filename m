Received: from eggs.gnu.org ([2001:4830:134:3::10]:40375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eCkkz-0004GP-6I
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 06:12:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eCkkx-0006Ny-UL
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 06:12:25 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:55602)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eCkkx-0006Ng-Nd
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 06:12:23 -0500
Received: by mail-wr0-x242.google.com with SMTP id l8so5212009wre.12
	for <qemu-devel@nongnu.org>; Thu, 09 Nov 2017 03:12:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5d78560d-750c-929d-d3eb-e762a0b31b78@linaro.org>
References: <1509993206-26637-1-git-send-email-peter.maydell@linaro.org>
	<1509993206-26637-2-git-send-email-peter.maydell@linaro.org>
	<5d78560d-750c-929d-d3eb-e762a0b31b78@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Nov 2017 11:12:02 +0000
Message-ID: <CAFEAcA-jgiNjLeQUvkKT7+g0rLq2MiNmyuKNiM+gwQmVSe0U9g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/4] linux-user/s390x: Mask si_addr for
 SIGSEGV
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, "patches@linaro.org" <patches@linaro.org>

On 8 November 2017 at 21:18, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 11/06/2017 07:33 PM, Peter Maydell wrote:
>> For s390x, the address passed to a signal handler in the
>> siginfo_t si_addr field is masked (in the kernel this is done in
>> do_sigbus() and do_sigsegv() in arch/s390/mm/fault.c). Implement
>> this architecture-specific oddity in linux-user.
>>
>> This is one of the issues described in
>> https://bugs.launchpad.net/qemu/+bug/1705118
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  linux-user/main.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> Accurate, but really seems like a s390x kernel bug.

The kernel code goes out of its way to do the masking, so if it's
a bug presumably it's a "retain back compat with some older
bug" thing...

thanks
-- PMM
