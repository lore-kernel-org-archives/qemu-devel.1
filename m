Received: from eggs.gnu.org ([2001:4830:134:3::10]:45090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUbUE-0003xG-W5
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:24:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUbUE-0007Po-Ao
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:24:39 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:34943)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dUbUE-0007PU-2c
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:24:38 -0400
Received: by mail-wr0-x22c.google.com with SMTP id k67so144928682wrc.2
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 09:24:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4f304a14-572d-2835-cb0e-9d93c1c6dece@redhat.com>
References: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
	<1499238885-26161-23-git-send-email-pbonzini@redhat.com>
	<CAFEAcA-B+aChqZBSnGws7RXheEyg+cutaqvXP8qVgNoUgzQAJA@mail.gmail.com>
	<4f304a14-572d-2835-cb0e-9d93c1c6dece@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Jul 2017 17:24:16 +0100
Message-ID: <CAFEAcA-vuPxc0GZc4Her1Trtak-RL9wcMR1L9SGRhzGg3wUGEA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 22/42] configure: factor out list of
 supported Xen/KVM/HAX targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, Anthony PERARD <anthony.perard@citrix.com>

On 10 July 2017 at 17:14, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 10/07/2017 17:49, Peter Maydell wrote:
>> On 5 July 2017 at 08:14, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>> This will be useful when the functions are called, early in the configure
>>> process, to filter out targets that do not support hardware acceleration.
>>>
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>
>>> +supported_xen_target() {
>>> +    test "$xen" = "yes" || return 1
>>> +    glob "$1" "*-softmmu" || return 1
>>> +    case "${1%-softmmu}:$cpu" in
>>> +        arm:arm | aarch64:aarch64 | \
>>> +        i386:i386 | i386:x86_64 | x86_64:i386 | x86_64:x86_64)
>>> +            return 0
>>> +        ;;
>>
>> This says that arm-on-arm and aarch64-on-aarch64 are supported
>> Xen targets...
>
> Hmm, this comes from my old patches.  IIRC the reason for the change,
> when it wasn't a change (many conflicts ago) was that Xen folks were
> using --disable-tcg because their device model for Xen PV on ARM was
> actually an x86_64 QEMU.
>
> Stefano and Anthony, is this still true?  If so, would it make sense to
> add the Xen PV machine type to qemu-system-arm---that is, is it
> something you can whip up easily, or should I just remove that line?

I think you should just fix configure for the moment, because
this patch wasn't supposed to change anything about what we
build (AIUI). We can think about changing the Xen PV on ARM
build setup as a separate thing if we want to, I suspect it
is more invasive than a couple of lines changing in configure.

thanks
-- PMM
