Received: from eggs.gnu.org ([2001:4830:134:3::10]:42477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gCKMN-0003ME-26
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 04:05:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gCKML-0004RC-QH
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 04:05:46 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:41148)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gCKML-00043K-Du
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 04:05:45 -0400
Received: by mail-ot1-x341.google.com with SMTP id c32so21615436otb.8
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 01:05:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <mhng-4fe44b9e-2ca3-4ad3-9d4c-d55dcf2628c7@palmer-si-x1c4>
References: <CAFEAcA8o8ozyh6DxFOaymvxwn-6v1G8tmkFKcU=vktQ3QkfTYg@mail.gmail.com>
	<mhng-4fe44b9e-2ca3-4ad3-9d4c-d55dcf2628c7@palmer-si-x1c4>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Oct 2018 09:05:11 +0100
Message-ID: <CAFEAcA8zC347g6AGo+bA4MsjfLLLrgRk_teGME-CkPx-=uFbYQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 0/5] Misc RISC-V patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: Michael Clark <mjc@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, Alistair Francis <alistair23@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Richard Henderson <richard.henderson@linaro.org>, Karsten Merker <merker@debian.org>, Stef O'Rear <sorear2@gmail.com>, "Richard W.M. Jones" <rjones@redhat.com>

On 15 October 2018 at 21:28, Palmer Dabbelt <palmer@sifive.com> wrote:
> On Fri, 12 Oct 2018 02:34:12 PDT (-0700), peter.maydell@linaro.org wrote:
>> The expected patch flow for QEMU is:
>>  * original patch author posts patch to qemu-devel
>>    (this applies also if the author happens to be the
>>    submaintainer)
>>  * patch gets reviewed on this mailing list, by you or
>>    anybody else
>>  * patches relevant to risc-v get collected up by the
>>    submaintainer
>>  * submaintainer submits those patches via pull request
>>    (with a frequency usually about every two weeks, more
>>    often if volume of patches merits it)
>
>
> This makes sense.  It's almost exactly the Linux flow, which I'm used to and
> I have down to a fairly mechanical process.  I think the real issue here is
> that we don't have anyone who has officially committed to doing this, so I'm
> just going to pull the trigger and say I'm doing so.

Thanks for picking this up.

> My Linux PR flow is to tag a PR on Mondays, send it out to the list for
> comments, and then if it passes muster to submit an official PR on
> Wednesdays.  It's been working smoothly (we've yet to have to kill a PR), so
> I think I'll do the same thing for QEMU except I'll do Tuesday/Thursday.

For QEMU we do patches first, pull requests for reviewed stuff.
If you send a pull request out to the list the assumption is
that it's a request to apply it to master immediately.

thanks
-- PMM
