Received: from eggs.gnu.org ([2001:4830:134:3::10]:54932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f857V-0003fC-7M
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 10:28:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f857U-0004fa-Cc
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 10:28:37 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:34169)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f857U-0004fJ-5L
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 10:28:36 -0400
Received: by mail-ot0-x243.google.com with SMTP id i5-v6so8110535oth.1
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 07:28:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <871sffp7fv.fsf@dusky.pond.sub.org>
References: <20180312131806.23209-1-stefanha@redhat.com>
	<CAFEAcA8VxyrDVMija0C219E5cPtKLC13YHcLFbB+VMRw9uCA_A@mail.gmail.com>
	<871sffp7fv.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Apr 2018 15:28:14 +0100
Message-ID: <CAFEAcA8Q+0CGW6YR5kuvq090E8Q1YO_Fm9L8RVgJ8nFByHF1qA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] checkpatch: warn about missing MAINTAINERS
 file changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 16 April 2018 at 15:11, Markus Armbruster <armbru@redhat.com> wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> On 12 March 2018 at 13:18, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>>> Warn if files are added/renamed/deleted without MAINTAINERS file
>>> changes.  This has helped me in Linux and we could benefit from this
>>> check in QEMU.
>>>
>>> This patch is a manual cherry-pick of Linux commit
>>> 13f1937ef33950b1112049972249e6191b82e6c9 ("checkpatch: emit a warning on
>>> file add/move/delete") by Joe Perches <joe@perches.com>.
>>>
>>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>>> ---
>>
>> Unfortunately the patch doesn't magically cause maintainers
>> to appear for the new files :-)
>
> Fortunately, the patch can get new files non-magically rejected unless a
> maintainers appears :)

I think that "author of code lists themselves in MAINTAINERS
but then doesn't in practice do anything" is not really much
better (and arguably worse) than "code has no listed maintainer".

thanks
-- PMM
