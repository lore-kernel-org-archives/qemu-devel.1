Received: from eggs.gnu.org ([2001:4830:134:3::10]:47883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gCUCI-0003cN-5l
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 14:36:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gCUCF-0004Wu-GI
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 14:36:02 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:37197)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gCUCF-0004W3-1w
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 14:35:59 -0400
Received: by mail-pg1-x541.google.com with SMTP id c10-v6so11259571pgq.4
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 11:35:58 -0700 (PDT)
Date: Tue, 16 Oct 2018 11:35:56 -0700 (PDT)
In-Reply-To: <CAFEAcA8zC347g6AGo+bA4MsjfLLLrgRk_teGME-CkPx-=uFbYQ@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-1213dc80-bef4-407e-818b-e4e7b63a45d3@palmer-si-x1c4>
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

On Tue, 16 Oct 2018 01:05:11 PDT (-0700), peter.maydell@linaro.org wrote:
> On 15 October 2018 at 21:28, Palmer Dabbelt <palmer@sifive.com> wrote:
>> On Fri, 12 Oct 2018 02:34:12 PDT (-0700), peter.maydell@linaro.org wrote:
>>> The expected patch flow for QEMU is:
>>>  * original patch author posts patch to qemu-devel
>>>    (this applies also if the author happens to be the
>>>    submaintainer)
>>>  * patch gets reviewed on this mailing list, by you or
>>>    anybody else
>>>  * patches relevant to risc-v get collected up by the
>>>    submaintainer
>>>  * submaintainer submits those patches via pull request
>>>    (with a frequency usually about every two weeks, more
>>>    often if volume of patches merits it)
>>
>>
>> This makes sense.  It's almost exactly the Linux flow, which I'm used to and
>> I have down to a fairly mechanical process.  I think the real issue here is
>> that we don't have anyone who has officially committed to doing this, so I'm
>> just going to pull the trigger and say I'm doing so.
>
> Thanks for picking this up.
>
>> My Linux PR flow is to tag a PR on Mondays, send it out to the list for
>> comments, and then if it passes muster to submit an official PR on
>> Wednesdays.  It's been working smoothly (we've yet to have to kill a PR), so
>> I think I'll do the same thing for QEMU except I'll do Tuesday/Thursday.
>
> For QEMU we do patches first, pull requests for reviewed stuff.
> If you send a pull request out to the list the assumption is
> that it's a request to apply it to master immediately.

Yep, that's the same as Linux.  I just send the PR to the RISC-V mailing lists 
marked as an RFC so it doesn't get confused.  If you don't want me to do this 
in QEMU land then it's fine.
