Received: from eggs.gnu.org ([2001:4830:134:3::10]:53574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cT3q9-00075e-L1
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 04:44:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cT3q8-0007iw-It
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 04:44:37 -0500
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:34608)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1cT3q8-0007il-9w
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 04:44:36 -0500
Received: by mail-lf0-x243.google.com with SMTP id q89so11789577lfi.1
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 01:44:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9WvZbup0AkuUDBPqaA3_xoUncKTKWj-ZHx5F0NBaOwXA@mail.gmail.com>
References: <20170112025606.27332-1-rth@twiddle.net>
	<CAFEAcA9WvZbup0AkuUDBPqaA3_xoUncKTKWj-ZHx5F0NBaOwXA@mail.gmail.com>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Mon, 16 Jan 2017 10:44:14 +0100
Message-ID: <CACXAS8Ad7LKtNUv2aqmE2Ztdgo97JmEPOYY_i7LtKT5ABPwuBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/30] target-sparc sun4v support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <rth@twiddle.net>, QEMU Developers <qemu-devel@nongnu.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On Fri, Jan 13, 2017 at 3:01 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 12 January 2017 at 02:55, Richard Henderson <rth@twiddle.net> wrote:
>> Mark Cave-Ayland asked me to handle the merge of this patch set
>> while he is traveling.
>>
>> This is the v2 that Artyom posted today.  I had reviewed the majority
>> of v1 earlier.  I re-read through the rebase and saw nothing amiss.
>> It passes my tests for sparc32, and does run the OpenSolaris image
>> to which Artyom links.
>>
>>
>> r~
>>
>>
>> The following changes since commit 41a0e54756a9ae6b60be34bb33302a7e085fdb07:
>>
>>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2017-01-10 10:46:21 +0000)
>>
>> are available in the git repository at:
>>
>>   git://github.com/rth7680/qemu.git tags/pull-sparc-20170111
>>
>> for you to fetch changes up to 224be7cc93a37ccd38342811a8925de889de1a49:
>>
>>   target-sparc: fix up niagara machine (2017-01-11 12:23:58 -0800)
>>
>> ----------------------------------------------------------------
>> Sun4v support
>
> This hits clang's unused-function error;
>
> /home/petmay01/linaro/qemu-for-merges/target/sparc/ldst_helper.c:346:20:
> error: unused function 'do_check_asi' [-Werror,-Wunused-function]
> static inline void do_check_asi(CPUSPARCState *env, int asi, uintptr_t ra)
>                    ^
> 1 error generated.
>

My bad. Will add an #ifdef and re-submit.

-- 
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/qemu
