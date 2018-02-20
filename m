Received: from eggs.gnu.org ([2001:4830:134:3::10]:37351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eo7dI-0001ke-Im
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 08:06:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eo7dH-0002Qs-MM
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 08:06:56 -0500
Sender: Corey Minyard <tcminyard@gmail.com>
Reply-To: minyard@acm.org
References: <CACRpkda9B=frmS0QF429p-q+KoCKG=5NON-kQ0Rt-nba2powRA@mail.gmail.com>
	<1519053606-9817-1-git-send-email-minyard@acm.org>
	<1519053606-9817-3-git-send-email-minyard@acm.org>
	<CAFEAcA-jTZMDNTF2rPn20DjSxu=z7n9M+2xo-pNfAYoha_LuzQ@mail.gmail.com>
From: Corey Minyard <minyard@acm.org>
Message-ID: <03f96a6b-3a52-0d72-e634-8b8f167f2992@acm.org>
Date: Tue, 20 Feb 2018 07:06:45 -0600
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-jTZMDNTF2rPn20DjSxu=z7n9M+2xo-pNfAYoha_LuzQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Subject: Re: [Qemu-devel] [PATCH 2/2] i2c: Move the bus class to i2c.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Linus Walleij <linus.walleij@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Corey Minyard <cminyard@mvista.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 02/19/2018 09:25 AM, Peter Maydell wrote:
> On 19 February 2018 at 15:20,  <minyard@acm.org> wrote:
>> From: Corey Minyard <cminyard@mvista.com>
>>
>> Some devices need access to it.
>>
>> Signed-off-by: Corey Minyard <cminyard@mvista.com>
>> ---
>>   hw/i2c/core.c        | 17 -----------------
>>   include/hw/i2c/i2c.h | 17 +++++++++++++++++
>>   2 files changed, 17 insertions(+), 17 deletions(-)
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Linus, Philippe, do you want me to submit this, or do you want
to take it?  You can pull it from:

https://github.com/cminyard/qemu.git tags/i2c-bus-move

-corey

> thanks
> -- PMM
