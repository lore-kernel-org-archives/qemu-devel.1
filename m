Received: from eggs.gnu.org ([2001:4830:134:3::10]:49349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eGmHy-0008Rx-2Z
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 08:39:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eGmHx-0003Sf-0p
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 08:39:06 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:41999)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eGmHw-0003SL-Q5
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 08:39:04 -0500
Received: by mail-wm0-x243.google.com with SMTP id 5so17755032wmk.1
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 05:39:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <98692fd0-2048-ce69-3fc2-8b7f44417bfa@twiddle.net>
References: <1510079118-3923-1-git-send-email-peter.maydell@linaro.org>
	<98692fd0-2048-ce69-3fc2-8b7f44417bfa@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Nov 2017 13:38:43 +0000
Message-ID: <CAFEAcA_MA7LmRLhzff26c84XQQbipPbjFgVq=fHnCnYh_kMbNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.11] linux-user: Fix calculation of
 auxv length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

On 8 November 2017 at 08:41, Richard Henderson <rth@twiddle.net> wrote:
> On 11/07/2017 07:25 PM, Peter Maydell wrote:
>> In commit 7c4ee5bcc82e643 we changed the order in which we construct
>> the AUXV, but forgot to adjust the calculation of the length. The
>> result is that we set info->auxv_len to a bogus and negative value,
>> and then later on the code in open_self_auxv() gets confused and
>> ends up presenting the guest with an empty file.
>>
>> Since we now have to calculate the auxv length up-front as part
>> of figuring out how much we're going to put on the stack, set
>> info->auxv_len then; this allows us to assert that we put the
>> same number of entries into auxv as we pre-calculated, rather
>> than merely having a comment saying we need to do that.
>>
>> Fixes: https://bugs.launchpad.net/qemu/+bug/1728116
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  linux-user/elfload.c | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Ping! This is a for-2.11 patch with review, and rc2 is tomorrow:
Riku, are you planning a pull request?

thanks
-- PMM
