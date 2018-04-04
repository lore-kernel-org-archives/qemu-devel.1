Received: from eggs.gnu.org ([2001:4830:134:3::10]:53125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f3htf-0007VR-0o
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 08:52:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f3htb-0003rd-T4
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 08:52:15 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:35179)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f3htb-0003rL-Ko
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 08:52:11 -0400
Received: by mail-wr0-x22c.google.com with SMTP id 80so22505157wrb.2
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 05:52:11 -0700 (PDT)
References: <20180330133525.10994-1-jcmvbkbc@gmail.com>
	<87vad8cl2v.fsf@linaro.org>
	<CAMo8BfJV-2wbx=JnudOB_+GZqQziSuuARNpiJ5rhpGH-KwEbWw@mail.gmail.com>
	<87muyjcllw.fsf@linaro.org>
	<CAFEAcA_WJSoa0-3w7uKZo_zScPCM6qQCfyXiiU44OTV-w_0q+g@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA_WJSoa0-3w7uKZo_zScPCM6qQCfyXiiU44OTV-w_0q+g@mail.gmail.com>
Date: Wed, 04 Apr 2018 13:52:09 +0100
Message-ID: <87d0zfcex2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 4 April 2018 at 11:27, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>> I'm wondering if it should be doing more. After all start/end_exclusive
>> rely on the cpu list and that isn't updated on thread creation - and
>> without that a bunch of other things fail like ld/st exclusive after
>> your first new thread is spawned.
>
> I think that is handled because creating a new thread calls
> cpu_copy(), which creates a new CPU object, which adds itself
> to the CPU list in its realize function (same as for system
> emulation new CPU objects).

Ahh that makes sense - I missed it hidden behind the realize.

--
Alex Benn=C3=A9e
