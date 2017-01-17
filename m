Received: from eggs.gnu.org ([2001:4830:134:3::10]:43417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTRGA-0007su-Fw
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 05:45:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTRG9-0000VT-Lf
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 05:45:02 -0500
Received: from mail-ua0-x234.google.com ([2607:f8b0:400c:c08::234]:35179)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cTRG9-0000VI-Gk
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 05:45:01 -0500
Received: by mail-ua0-x234.google.com with SMTP id y9so100211383uae.2
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 02:45:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1484641214.31968.26.camel@redhat.com>
References: <1484132292-21458-1-git-send-email-kraxel@redhat.com>
	<CAFEAcA-X3mXPR5GX0_Xqs6uXiv3ur6rimb4Yoeixop87ZuMaWg@mail.gmail.com>
	<1484641214.31968.26.camel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Jan 2017 10:44:40 +0000
Message-ID: <CAFEAcA9F3UzZkM=qX=aNe2_x9mW6dt3gQsgYUbhaXRVB2FdVhw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] cocoa: stop using MOUSE_EVENT_*
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

On 17 January 2017 at 08:20, Gerd Hoffmann <kraxel@redhat.com> wrote:
> On Mo, 2017-01-16 at 18:35 +0000, Peter Maydell wrote:
>> On 11 January 2017 at 10:58, Gerd Hoffmann <kraxel@redhat.com> wrote:
>> > No need to go the indirect route with a bitfield and mapping the bits to
>> > INPUT_BUTTON_*.  We can use a bool array and INPUT_BUTTON_* directly
>> > instead.
>> >
>> > Untested, not even compiled, due to lack of a osx^Wmacos machine.
>> > Test results are very welcome.
>>
>> So what does the patch gain us?
>
> I can drop MOUSE_EVENT_WHEEL* without breaking the osx build.

Why do you want to drop it, though? It's a valid mouse event
type, and you're not going to drop the whole MOUSE_EVENT_* set
of defines, I assume, because they're used in lots of devices.

>> We'll now loop round
>> that button array for every event rather than only
>> the ones where the button state changed,
>
> Well, we loop round anyway, you just don't see it directly b/c it is
> hidden in the qemu_input_update_buttons() helper function.

No, we only call qemu_input_update_buttons() if last_buttons != buttons.

thanks
-- PMM
