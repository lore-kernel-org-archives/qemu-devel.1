Received: from eggs.gnu.org ([209.51.188.92]:38907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr07A-0007fT-5G
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 07:46:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr077-0001bL-Dx
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 07:46:12 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:41532)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gr077-0001bE-8I
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 07:46:09 -0500
Received: by mail-ot1-x32b.google.com with SMTP id u16so5380174otk.8
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 04:46:09 -0800 (PST)
MIME-Version: 1.0
References: <1549305379-51117-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA9RmsnMTuQU3a4G+Q6=RL9_YOm5Fi-OyVwkX2fTMzvYCA@mail.gmail.com>
	<014991ae-f48e-4a82-b1d1-2ae3034606cc@redhat.com>
In-Reply-To: <014991ae-f48e-4a82-b1d1-2ae3034606cc@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Feb 2019 12:45:56 +0000
Message-ID: <CAFEAcA8QKZahU9nm+xP4Cj0UAUo3G5-QQ8PbZ=vQqZQOSmLUhw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/77] Misc patches for 2019-02-04
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Tue, 5 Feb 2019 at 11:27, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 05/02/19 10:35, Peter Maydell wrote:
> > On Mon, 4 Feb 2019 at 18:38, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >>
> >> The following changes since commit 773c4a6228fd910556cee2d477ee56c591a30000:
> >>
> >>   test-filter-mirror: pass UNIX domain socket through fd (2019-02-04 16:03:20 +0000)
> >>
> >> are available in the git repository at:
> >>
> >>   git://github.com/bonzini/qemu.git tags/for-upstream
> >
> > Hi; my script says:
> > error: remotes/bonzini/tags/for-upstream: cannot verify a non-tag
> > object of type commit.
> > Does not appear to be a signed tag
> >
> > Did something go wrong at your end?
>
> Hmm this is a first.  Repushed now.

I get this conflict in default-configs/lm32-softmmu.mak that I don't
know how to resolve:

<<<<<<< HEAD
CONFIG_MILKYMIST_TMU2=$(call land,$(CONFIG_X11),$(CONFIG_OPENGL))
CONFIG_FRAMEBUFFER=y
CONFIG_PTIMER=y
CONFIG_PFLASH_CFI01=y
CONFIG_PFLASH_CFI02=y
CONFIG_SD=y
=======
>>>>>>> remotes/bonzini/tags/for-upstream

Your patches remove the CONFIG_MILKYMIST_TMU2 line entirely
so I don't know how to add the change that commit 57d434407adc967a696d
makes to make the symbol depend on both CONFIG_X11 and CONFIG_OPENGL
rather than only on CONFIG_OPENGL.

Please can you rebase and resend?

thanks
-- PMM
