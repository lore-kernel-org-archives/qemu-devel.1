Received: from eggs.gnu.org ([2001:4830:134:3::10]:42480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linus.walleij@linaro.org>) id 1eosxt-0002SM-4X
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:39:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linus.walleij@linaro.org>) id 1eosxs-0007QL-AS
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:39:21 -0500
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:34333)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <linus.walleij@linaro.org>)
	id 1eosxs-0007Ph-64
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:39:20 -0500
Received: by mail-io0-x241.google.com with SMTP id e7so6456608ioj.1
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 07:39:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <03f96a6b-3a52-0d72-e634-8b8f167f2992@acm.org>
References: <CACRpkda9B=frmS0QF429p-q+KoCKG=5NON-kQ0Rt-nba2powRA@mail.gmail.com>
	<1519053606-9817-1-git-send-email-minyard@acm.org>
	<1519053606-9817-3-git-send-email-minyard@acm.org>
	<CAFEAcA-jTZMDNTF2rPn20DjSxu=z7n9M+2xo-pNfAYoha_LuzQ@mail.gmail.com>
	<03f96a6b-3a52-0d72-e634-8b8f167f2992@acm.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 22 Feb 2018 16:39:19 +0100
Message-ID: <CACRpkdYMTojtHnafK+kMnm1G7j+9Nj=p65WLZGbrN8MJv+4psQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/2] i2c: Move the bus class to i2c.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Corey Minyard <minyard@acm.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Corey Minyard <cminyard@mvista.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, Feb 20, 2018 at 2:06 PM, Corey Minyard <minyard@acm.org> wrote:
> On 02/19/2018 09:25 AM, Peter Maydell wrote:
>>
>> On 19 February 2018 at 15:20,  <minyard@acm.org> wrote:
>>>
>>> From: Corey Minyard <cminyard@mvista.com>
>>>
>>> Some devices need access to it.
>>>
>>> Signed-off-by: Corey Minyard <cminyard@mvista.com>
>>> ---
>>>   hw/i2c/core.c        | 17 -----------------
>>>   include/hw/i2c/i2c.h | 17 +++++++++++++++++
>>>   2 files changed, 17 insertions(+), 17 deletions(-)
>>
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
>
> Linus, Philippe, do you want me to submit this, or do you want
> to take it?  You can pull it from:
>
> https://github.com/cminyard/qemu.git tags/i2c-bus-move

I don't have any commit rights, if you can push this to the
QEMU master I will happily rebase my stuff and resubmit :)

Yours,
Linus Walleij
