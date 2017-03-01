Received: from eggs.gnu.org ([2001:4830:134:3::10]:32930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjBBM-0002jG-GD
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 15:49:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjBBL-0006Vk-EP
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 15:49:08 -0500
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:34161)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjBBL-0006VK-7O
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 15:49:07 -0500
Received: by mail-wr0-x235.google.com with SMTP id l37so38634626wrc.1
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 12:49:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87wpc820xk.fsf@linaro.org>
References: <CAFEAcA_KVG19uhPuBUNx4ySmebnL1Hit6=HUX9ug0FkBFMwasg@mail.gmail.com>
	<877f492ppx.fsf@linaro.org>
	<d3a039e7-77cc-f0de-2b9a-1779009bb7bb@redhat.com>
	<87wpc820xk.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 1 Mar 2017 20:48:45 +0000
Message-ID: <CAFEAcA_i_9dJgDy-HME=LG38f6Yy66zeY-satbbWhv3sStGpyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] xtensa failure: "tcg_handle_interrupt: assertion
 failed: (qemu_mutex_iothread_locked())"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 1 March 2017 at 20:32, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> However I ran into another problem. Code generation leads to a tlb_fill
> which runs afoul of a nested tb_lock(). I'm pretty sure the front-end is
> using the wrong thing to fetch code:

Isn't that the expected (if admittedly kinda dumb) thing where
when we fail a code load during translation it causes us
to attempt a recursive translation before we finally
figure out that it really isn't going to work and longjump
right out to the top level? It's silly and we should
probably at some point figure out a way to do it more
cleanly, but it doesn't actually cause any problem pre-MTTCG...

thanks
-- PMM
