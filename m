Received: from eggs.gnu.org ([2001:4830:134:3::10]:56669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cYdEh-0006cM-WE
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:33:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cYdEh-0004l2-8o
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:33:00 -0500
Received: from mail-ua0-x229.google.com ([2607:f8b0:400c:c08::229]:32957)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cYdEh-0004kp-3m
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:32:59 -0500
Received: by mail-ua0-x229.google.com with SMTP id i68so278830240uad.0
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 10:32:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170131181124.GF20303@redhat.com>
References: <1485879287-12548-1-git-send-email-peter.maydell@linaro.org>
	<87wpdbw2ki.fsf@dusky.pond.sub.org>
	<CAFEAcA-Ggv2VGszZg0Ld3-1wm=hVe8w=4ZcQ7TDRHf5Puq88ug@mail.gmail.com>
	<20170131181124.GF20303@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Jan 2017 18:32:38 +0000
Message-ID: <CAFEAcA_utwK=JxC7aa9chZa2DjuGkBfGAYrEfXVo86pZ5u5-zg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] Drop QEMU_GNUC_PREREQ() checks for gcc
 older than 4.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 31 January 2017 at 18:11, Daniel P. Berrange <berrange@redhat.com> wrote:
> On Tue, Jan 31, 2017 at 06:00:13PM +0000, Peter Maydell wrote:
>> We have attributes which we wrap in QEMU_ macros already
>> even though they always expand to the same thing:
>> QEMU_NORETURN and QEMU_ALIGNED. I'm happy to leave these
>> to follow that pattern. (If you wanted to send a patch
>> series that uninlined all of those then I wouldn't hugely
>> object to it, but I think it touches enough files that it's
>> a separate thing from removing the #if guards that this
>> patch does.)
>
> The other option is just to replace QEMU_WARN_UNUSED_RESULT with
>
>   #define QEMU_WARN_UNUSED_RESULT  G_GNUC_WARN_UNUSED_RESULT
>
> and convert code to use G_GNUC_WARN_UNUSED_RESULT directly until we
> can kill the QEMU specific define. There's no benefit to QEMU having
> its own defines that duplicate stuff already covered by our min
> required glib - G_GNUC_WARN_UNUSED_RESULT was added in 2.10 for
> example.

I wouldn't object to that either, but again it ought to be
a different patch or patch series to this one...

thanks
-- PMM
