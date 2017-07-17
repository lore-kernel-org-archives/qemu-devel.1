Received: from eggs.gnu.org ([2001:4830:134:3::10]:53422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXC9I-0001ua-R0
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 15:57:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXC9I-0002ad-5x
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 15:57:44 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:36378)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dXC9H-0002aB-Vx
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 15:57:44 -0400
Received: by mail-wm0-x22b.google.com with SMTP id t70so25631673wmt.1
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 12:57:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170717185830.GD31820@work-vm>
References: <1497462353-3432-1-git-send-email-edgar.iglesias@gmail.com>
	<CAFEAcA-iWRqhNhrJsrvODRunkwMGTUsTMfhdHZw3aCjoc3p1Mg@mail.gmail.com>
	<CAJy5ezpvpohU5x48WrKz57k9+s39hkSCUm+f_u2qf7E0Zin7Mw@mail.gmail.com>
	<20170717185830.GD31820@work-vm>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Jul 2017 20:57:22 +0100
Message-ID: <CAFEAcA_HQFtNr82QqE0+j8_SUGm_8-1JLavBnXYTmRvTVb+vYQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v1 0/7] MMIO Exec pull request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, KONRAD Frederic <frederic.konrad@adacore.com>, Juan Quintela <quintela@redhat.com>

On 17 July 2017 at 19:58, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> * Edgar E. Iglesias (edgar.iglesias@gmail.com) wrote:
>> Is there a way we can prevent migration of the RAMBlock?
>
> Not yet, I think we'd have to:
>    a) Add a flag to the RAMBlock
>    b) Set it/clear it on registration
>    c) Have a RAMBLOCK_FOREACH_MIGRATABLE macro
>    d) Replace all of the RAMBLOCK_FOREACH (and the couple of hand coded
>    cases) with the RAMBLOCK_FOREACH_MIGRATABLE
>    e) Worry about the corner cases!
>
> I've got a few worries about what happens when the kernel tries to
> do dirty yncing - I'm not sure if we have to change anything on that
> interface to skip those RAMBlocks.

Why would we need to skip those RAM blocks? We get correct
behaviour whether the memory is sync'd with the kernel
or not, because we're not going to migrate it anywhere.

thanks
-- PMM
