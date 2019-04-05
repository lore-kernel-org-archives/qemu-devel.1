Received: from eggs.gnu.org ([209.51.188.92]:57710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCKy2-0002te-Na
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 05:16:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCKy1-0008Ht-Ks
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 05:16:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44346)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hCKy1-0008BG-09
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 05:16:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id y7so7050748wrn.11
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 02:16:56 -0700 (PDT)
References: <20190404185730.GA22512@ls3530.dellerweb.de>
	<CAFEAcA9xP8CtXEruuzPHCyuDT5EyMMHFGdCJdfFBhX+C2Jr36A@mail.gmail.com>
	<b48c6984-f0fc-a597-53a0-4869c822ce73@gmx.de>
	<068f4832-7e0b-8850-ffa0-fcf1ecd50295@redhat.com>
	<20190405090212.GF6105@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <740ce541-c92d-5369-1191-eb73fc861fdd@redhat.com>
Date: Fri, 5 Apr 2019 11:16:54 +0200
MIME-Version: 1.0
In-Reply-To: <20190405090212.GF6105@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] configure: Automatically fall back to TCI
 on non-release architectures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, Stefan Weil <sw@weilnetz.de>, Thomas Huth <thuth@redhat.com>
Cc: Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>, Samuel Thibault <samuel.thibault@ens-lyon.org>, QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 4/5/19 11:02 AM, Daniel P. Berrangé wrote:
> On Fri, Apr 05, 2019 at 10:47:54AM +0200, Philippe Mathieu-Daudé wrote:
>> Hi Helge,
>>
>> On 4/5/19 9:56 AM, Helge Deller wrote:
>>> On 05.04.19 03:34, Peter Maydell wrote:
>>>> On Fri, 5 Apr 2019 at 01:59, Helge Deller <deller@gmx.de> wrote:
>>>>> If a non-release architecture is found, and it's known that there is no
>>>>> native TCG support for that CPU, automatically fall back to the TCI
>>>>> implementation instead of requesting the user to run configure again
>>>>> with the --enable-tcg-interpreter option.
>>>>>
>>>>> This change simplifies building qemu in automatic build environments
>>>>> (like in my case the debian buildds) because one does not need to
>>>>> special case on the architectures.
>>>>
>>>> I don't think we should do this. TCI is unmaintained, has several
>>>> known flaws,
>>>
>>> Just out of interest: Is there a list with those flaws somewhere?
>>
>> The last big discussion is in this thread:
>> https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg06528.html

I just noticed this link doesn't show the full thread replies list, and
want to point out Stefan's one:

https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg06841.html

I guess remember someone (Thomas? you Daniel?) posting a link of 3 forks
using TCI for reverse engineering but I can't find it to check if they
are still active.

> Do the various crashes that you illustrate in that cover letter
> still exist today ? If so, 2 years of continued brokenness with no
> fixes would reinforce the the view that it is time to remove TCI
> from the codebase.

Or find a maintainer and add tests...
