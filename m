Received: from eggs.gnu.org ([2001:4830:134:3::10]:53885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cYzRn-0006uW-NB
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 13:16:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cYzRm-0007QN-Gl
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 13:15:59 -0500
Received: from mail-yw0-x241.google.com ([2607:f8b0:4002:c05::241]:34924)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cYzRm-0007QJ-CD
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 13:15:58 -0500
Received: by mail-yw0-x241.google.com with SMTP id l16so11583196ywb.2
	for <qemu-devel@nongnu.org>; Wed, 01 Feb 2017 10:15:58 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <CAJBMM-sX4fGckYy-eNRdZ9dKamOoJoK2fQ4TLS80T5n6jCkpFg@mail.gmail.com>
	<20170114080435.GF25986@lianli.shorne-pla.net>
	<20170120163918.GD7836@lianli.shorne-pla.net>
	<d27b7c60-a9fe-e92e-a937-d2d13b78f290@twiddle.net>
	<20170124102625.GF7836@lianli.shorne-pla.net>
	<01f7a18d-f4f5-18f3-0932-b32c06ad0b0c@twiddle.net>
	<20170125123430.GG7836@lianli.shorne-pla.net>
	<39f927aa-26fe-0e43-7c6b-efe1b70bc5fa@twiddle.net>
	<20170126131229.GB16014@lianli.shorne-pla.net>
	<ddb9c656-aa3e-5d90-c8fc-0058af5b603b@twiddle.net>
	<20170201100423.GE21641@lianli.shorne-pla.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <c840eff0-2be7-07d7-eae9-4cded569d146@twiddle.net>
Date: Wed, 1 Feb 2017 10:15:54 -0800
MIME-Version: 1.0
In-Reply-To: <20170201100423.GE21641@lianli.shorne-pla.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target-openrisc: Fix exception handling
 status registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stafford Horne <shorne@gmail.com>
Cc: Jia Liu <proljc@gmail.com>, qemu-devel@nongnu.org, openrisc@lists.librecores.org

On 02/01/2017 02:04 AM, Stafford Horne wrote:
> On Thu, Jan 26, 2017 at 09:26:55AM -0800, Richard Henderson wrote:
>> On 01/26/2017 05:12 AM, Stafford Horne wrote:
>>> I just sent you a mail with a link to my kernel for download.
>>>
>>> One thing I noticed is you passed '-append console=ttyS0' I think that
>>> does nothing on openrisc since as far as I know openrisc only gets boot
>>> params from the device tree file. I tried with and without it and got no
>>> differences.
>>
>> That was just reflex, wondering where the output went.
>>
>>> Another thing, I am using a 'late' version of gcc built with musl cross [1]
>>> , I dont think it would make a difference, but maybe?
>>
>> I think that's likely the difference.  I can indeed boot your kernel.
> 
> Hi Richard,
> 
> For kernel builds I have created toolchain binaries here:
> 
>   http://shorne.noip.me/crosstool/files/bin/x86_64/5.4.0/
> 
> These should work.
> 
> If all is ok with the qemu patch I sent what is the next step to get them
> incorporated.  Do you need any help from me?
> 
> ... Actually I just checked your branch on github, it looks like you are
> doing a few updates.  Let me know if you want me to review anything.

Yes, I've been attempting to revive a patch set from 2013 that cleans up the
implementation, fixing a few other bugs in the process.

However, testing it properly has been tricky.  It appears as if I'm debugging
qemu and gcc simultaneously, while your gdb branch doesn't want to compile for
me.  So I've been limited to instruction traces from qemu, which is slow going.

If you'd like to do your own testing on my tgt-or1k-2 branch, that would be
appreciated.


r~
