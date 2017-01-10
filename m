Received: from eggs.gnu.org ([2001:4830:134:3::10]:40548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cR0Hw-0006Hs-6z
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 12:32:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cR0Hv-00089S-7Z
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 12:32:48 -0500
Received: from mail-vk0-x22c.google.com ([2607:f8b0:400c:c05::22c]:33247)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cR0Hv-000899-3T
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 12:32:47 -0500
Received: by mail-vk0-x22c.google.com with SMTP id 137so364270172vkl.0
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 09:32:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1484032706.19018.82.camel@redhat.com>
References: <1483967385-12891-1-git-send-email-kraxel@redhat.com>
	<CAFEAcA_npQNeiSosYGEX2N4OofNaYk_nuti9rhYk12HByVPfFQ@mail.gmail.com>
	<1484032706.19018.82.camel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Jan 2017 17:32:25 +0000
Message-ID: <CAFEAcA_Qs0yrSWY-MdFYw9K4GO98D+jHw9aPpkNgoMc0-ab8Kg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL v2 00/11] ui patch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 10 January 2017 at 07:18, Gerd Hoffmann <kraxel@redhat.com> wrote:
>   Hi,
>
>> >   git://git.kraxel.org/qemu tags/pull-ui-20170109-1
>
>> Hi. I'm afraid this fails to build on OSX:
>>
>> /Users/pm215/src/qemu-for-merges/ui/cocoa.m:688:21: error: use of
>> undeclared identifier 'MOUSE_EVENT_WHEELUP'
>>                     MOUSE_EVENT_WHEELUP : MOUSE_EVENT_WHEELDN;
>>                     ^
>> /Users/pm215/src/qemu-for-merges/ui/cocoa.m:710:45: error: use of
>> undeclared identifier 'MOUSE_EVENT_WHEELUP'
>>                 [INPUT_BUTTON_WHEEL_UP]   = MOUSE_EVENT_WHEELUP,
>>                                             ^
>> /Users/pm215/src/qemu-for-merges/ui/cocoa.m:711:45: error: use of
>> undeclared identifier 'MOUSE_EVENT_WHEELDN'
>>                 [INPUT_BUTTON_WHEEL_DOWN] = MOUSE_EVENT_WHEELDN,
>
> Pushed new tag:
>
>   git://git.kraxel.org/qemu tags/pull-ui-20170110-1
>
> Dropped offending patch (8/11), no other changes.

Applied, thanks.

PS: to guarantee getting my attention on a respun pull request
you need to resend a proper cover email (but you don't need
to resend the rest of the emails). You got lucky this time :-)

thanks
-- PMM
