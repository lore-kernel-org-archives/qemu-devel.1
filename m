Received: from eggs.gnu.org ([2001:4830:134:3::10]:50615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gC9Tg-0003Mo-AM
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 16:28:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gC9Tc-0001q9-UN
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 16:28:36 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:36438)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gC9TW-0001jm-8W
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 16:28:28 -0400
Received: by mail-pg1-x541.google.com with SMTP id f18-v6so9710023pgv.3
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 13:28:21 -0700 (PDT)
Date: Mon, 15 Oct 2018 13:28:19 -0700 (PDT)
In-Reply-To: <CAFEAcA8o8ozyh6DxFOaymvxwn-6v1G8tmkFKcU=vktQ3QkfTYg@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-4fe44b9e-2ca3-4ad3-9d4c-d55dcf2628c7@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 0/5] Misc RISC-V patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: Michael Clark <mjc@sifive.com>, Alistair.Francis@wdc.com, alistair23@gmail.com, qemu-devel@nongnu.org, sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de, richard.henderson@linaro.org, merker@debian.org, sorear2@gmail.com, rjones@redhat.com

On Fri, 12 Oct 2018 02:34:12 PDT (-0700), peter.maydell@linaro.org wrote:
> On 11 October 2018 at 21:52, Michael Clark <mjc@sifive.com> wrote:
>> Peter, I have to pull in your remote wholesale. I don't cherry-pick from
>> your tree. I think this is truly dumb. This might serve the needs of some
>> folk running Linux but we have emulation fidelity fixes for the RISC-V
>> community as a whole. Alastair is the only person not submitting his patches
>> via the (sub)maintainer tree. BTW Who is the RISC-V port maintainer?
>> Puzzled.
>
> I don't particularly mind who among you RISC-V folk does the QEMU
> submaintainer work. But I would like to see somebody doing it,
> and sitting on all your patches indefinitely in an out-of-tree
> fork is not doing that job. There is no obligation to work
> with upstream on a RISC-V QEMU, of course. But your last
> pull request was back in May, so it's not surprising if
> other people offer to step into that gap.
>
> If you have emulation fidelity fixes, then the best approach
> is to work on getting them upstream.

I agree.  I think the best bet here is to just start picking through the 
patches and submitting those that we have high confidence in -- there's a 
handful of known bugs that have been fixed in Michael's tree.

> If you have downstream consumers for whom you want to maintain
> a validated definitely-works tree, that's great. How you
> manage that downstream tree (when you rebase it, what you
> put in it, whether you make it have formal "releases", etc)
> is up to you. I would suggest that trying to make it be the
> same thing as your development tree for pushing work upstream
> is not likely to serve either purpose well, though.
>
> The expected patch flow for QEMU is:
>  * original patch author posts patch to qemu-devel
>    (this applies also if the author happens to be the
>    submaintainer)
>  * patch gets reviewed on this mailing list, by you or
>    anybody else
>  * patches relevant to risc-v get collected up by the
>    submaintainer
>  * submaintainer submits those patches via pull request
>    (with a frequency usually about every two weeks, more
>    often if volume of patches merits it)

This makes sense.  It's almost exactly the Linux flow, which I'm used to and I 
have down to a fairly mechanical process.  I think the real issue here is that 
we don't have anyone who has officially committed to doing this, so I'm just 
going to pull the trigger and say I'm doing so.

My Linux PR flow is to tag a PR on Mondays, send it out to the list for 
comments, and then if it passes muster to submit an official PR on Wednesdays.  
It's been working smoothly (we've yet to have to kill a PR), so I think I'll do 
the same thing for QEMU except I'll do Tuesday/Thursday.

I talked to Michael on the phone late last week and he seemed OK with this.

>> Here is the pull queue. But I'm not ready to make a PR until we have the CI
>> running the regression.
>
> This phrasing suggests you might be thinking about making a
> large batch pull request all at once close to the
> freeze deadline. That would be a bad idea -- it did not
> work well last release either. Patches are best dribbled
> into upstream at a steady pace as they are written.
> (Note also that pull requests should not contain patches
> which have not already been posted to qemu-devel and
> reviewed here.)
>
> thanks
> -- PMM
