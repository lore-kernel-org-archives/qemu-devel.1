Received: from eggs.gnu.org ([2001:4830:134:3::10]:59155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f3gTO-00048j-BS
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 07:21:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f3gTN-0003IM-H7
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 07:21:02 -0400
Received: from mail-ot0-x22b.google.com ([2607:f8b0:4003:c0f::22b]:45155)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f3gTN-0003IB-Ai
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 07:21:01 -0400
Received: by mail-ot0-x22b.google.com with SMTP id h26-v6so22867669otj.12
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 04:21:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87muyjcllw.fsf@linaro.org>
References: <20180330133525.10994-1-jcmvbkbc@gmail.com>
	<87vad8cl2v.fsf@linaro.org>
	<CAMo8BfJV-2wbx=JnudOB_+GZqQziSuuARNpiJ5rhpGH-KwEbWw@mail.gmail.com>
	<87muyjcllw.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 4 Apr 2018 12:20:40 +0100
Message-ID: <CAFEAcA_WJSoa0-3w7uKZo_zScPCM6qQCfyXiiU44OTV-w_0q+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] linux-user: call cpu_copy under clone_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>

On 4 April 2018 at 11:27, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> I'm wondering if it should be doing more. After all start/end_exclusive
> rely on the cpu list and that isn't updated on thread creation - and
> without that a bunch of other things fail like ld/st exclusive after
> your first new thread is spawned.

I think that is handled because creating a new thread calls
cpu_copy(), which creates a new CPU object, which adds itself
to the CPU list in its realize function (same as for system
emulation new CPU objects).

thanks
-- PMM
