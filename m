Received: from eggs.gnu.org ([2001:4830:134:3::10]:41343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mingo.kernel.org@gmail.com>) id 1gM5Zk-0007fW-3S
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 01:19:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mingo.kernel.org@gmail.com>) id 1gM5Zh-0000Oi-0U
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 01:19:56 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55340)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mingo.kernel.org@gmail.com>)
	id 1gM5Zc-0000Mz-Qw
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 01:19:52 -0500
Received: by mail-wm1-x343.google.com with SMTP id i73-v6so1893478wmd.5
	for <qemu-devel@nongnu.org>; Sun, 11 Nov 2018 22:19:45 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 12 Nov 2018 07:19:40 +0100
From: Ingo Molnar <mingo@kernel.org>
Message-ID: <20181112061940.GA61749@gmail.com>
References: <1541674784-25936-2-git-send-email-lizhijian@cn.fujitsu.com>
	<CAFEAcA_47wyar3WNhuBmNPdr02RHx-wn_TeyFaajpjzvzG8j5Q@mail.gmail.com>
	<c50d103e-95c3-c44c-d852-b6d7f8114b3a@cn.fujitsu.com>
	<20181109072015.GA86700@gmail.com>
	<38905d35-29af-b522-1629-b13e98a47a42@intel.com>
	<d30b404d-624e-0497-879a-2d5df2eb9f31@suse.com>
	<b7b608dc-1743-5e1f-3b88-94d784c4cab2@intel.com>
	<d9c293bd-b43f-999c-55f1-3b90a6020065@zytor.com>
	<20181112045624.GA28219@gmail.com>
	<fcf1d6b5-e64f-3aea-f794-99237e1988cf@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcf1d6b5-e64f-3aea-f794-99237e1988cf@zytor.com>
Subject: Re: [Qemu-devel] [RFC/PoC PATCH 1/3] i386: set initrd_max to 4G - 1
 to allow up to 4G initrd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Li Zhijian <zhijianx.li@intel.com>, Juergen Gross <jgross@suse.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Peter Maydell <peter.maydell@linaro.org>, x86@kernel.org, bp@alien8.de, mingo@redhat.com, tglx@linutronix.de, QEMU Developers <qemu-devel@nongnu.org>, Philip Li <philip.li@intel.com>, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Kees Cook <keescook@chromium.org>


* H. Peter Anvin <hpa@zytor.com> wrote:

> > Such an extended header could use a more modern (self-extending) ABI as 
> > well.
> 
> Yes, although I don't really think it is as much of an issue as it seems at
> this point.
> 
> The limit comes from having used a one-byte jump instruction at the beginning;
> however, these days that limit is functionally walled.
> 
> It is of course possible to address this if it should become necessary,
> however, the current protocol has lasted for 23 years so far and we haven't
> run out yet, even with occasional missteps. As such, I don't think we are in a
> huge hurry to address this particular aspect.

Agreed, fair enough!

> In part as a result of this exchange I have spent some time thinking 
> about the boot protocol and its dependencies, and there is, in fact, a 
> much more serious problem that needs to be addressed: it is not 
> currently possible in a forward-compatible way to map all data areas 
> that may be occupied by bootloader-provided data. The kernel proper has 
> an advantage here, in that the kernel will by definition always be the 
> "owner of the protocol" (anything the kernel doesn't know how to map 
> won't be used by the kernel anyway), but it really isn't a good 
> situation. So I'm currently trying to think up a way to make that 
> possible.

I might be a bit dense early in the morning, but could you elaborate? 
What do you mean by mapping all data areas?

Thanks,

	Ingo
