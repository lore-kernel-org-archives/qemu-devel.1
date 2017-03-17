Received: from eggs.gnu.org ([2001:4830:134:3::10]:59779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cotfW-0005Bj-NB
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 11:19:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cotfS-0004W4-5g
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 11:19:54 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:38150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cotfR-0004Vt-U5
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 11:19:50 -0400
Received: by mail-wm0-x22d.google.com with SMTP id t189so18594452wmt.1
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 08:19:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1489748902-21765-1-git-send-email-peter.maydell@linaro.org>
References: <1489748902-21765-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Mar 2017 15:19:28 +0000
Message-ID: <CAFEAcA-EKBBXAUd+useYtuKbW-7VX0Wcpki1DnpC1s5d-6izWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] configure: Warn about deprecated hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Thomas Huth <thuth@redhat.com>, "patches@linaro.org" <patches@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>

On 17 March 2017 at 11:08, Peter Maydell <peter.maydell@linaro.org> wrote:
> This commit flags up as deprecated the CPU architectures:
>  * ia64
>  * sparc
>  * anything which we don't have a TCG port for
>    (and which was presumably using TCI)
> and the OSes:
>  * Cygwin
>  * GNU/kFreeBSD
>  * FreeBSD
>  * DragonFly BSD
>  * NetBSD
>  * OpenBSD
>  * Solaris
>  * AIX
>  * Haiku

> This list is definitely too all-encompassing, and we should
> move at least some of the BSDs into "not-deprecated".
> I'm posting the patch for the moment for code review on the
> logic and as a placeholder.
> --

Based on my experiences this afternoon trying to get VMs set
up and build QEMU in them plus feedback in this thread, I'm
going to suggest that:
 * we move FreeBSD to the "supported" list (since we have Sean
   around and I got a VM to build stuff without too much pain;
   bsd-user is currently not compiling though)
 * we leave all the others "unsupported"

In particular, I couldn't get a NetBSD installer to even
boot on KVM, so I have no test setup there. I did get OpenBSD
running but it has several compilation failure problems
(use of non-existent EPROTO, the si.si_band" use in oslib-posix.c
doesn't compile, etc) and the dev environment is totally
unusable in any case.

thanks
-- PMM
