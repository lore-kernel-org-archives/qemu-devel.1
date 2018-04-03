Received: from eggs.gnu.org ([2001:4830:134:3::10]:52896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f3ULG-0001TH-FA
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 18:23:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f3ULF-0004KO-IT
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 18:23:50 -0400
Received: from mail-oi0-x236.google.com ([2607:f8b0:4003:c06::236]:46610)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f3ULF-0004KB-DJ
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 18:23:49 -0400
Received: by mail-oi0-x236.google.com with SMTP id e123-v6so17457105oih.13
	for <qemu-devel@nongnu.org>; Tue, 03 Apr 2018 15:23:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180402171354.27706-1-jcmvbkbc@gmail.com>
References: <20180402171354.27706-1-jcmvbkbc@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Apr 2018 23:23:28 +0100
Message-ID: <CAFEAcA9c3VPGrEK3JX2cq+jt9L_d4eCzA2ZrQVoL999MGGUQgQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/8] xtensa-specific and generic fixes for
 linux-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

On 2 April 2018 at 18:13, Max Filippov <jcmvbkbc@gmail.com> wrote:
> Hi Peter,
>
> please pull the following batch of linux-user fixes for 2.12.
>
> The following changes since commit dfe732fb68ef9195517f4f380a477d58a054edc1:
>
>   Merge remote-tracking branch 'remotes/jnsnow/tags/ide-pull-request' into staging (2018-03-27 16:25:12 +0100)
>
> are available in the git repository at:
>
>   git://github.com/OSLL/qemu-xtensa.git tags/20180402-xtensa
>
> for you to fetch changes up to 64a563dd8dd6ca2661d96a2e4b69f0a5465cab94:
>
>   target/xtensa: linux-user: fix fadvise64 call (2018-04-02 04:15:35 -0700)
>
> ----------------------------------------------------------------
> xtensa-specific fixes for linux-user:
>
> - fix flushing registers for signal processing in call8 and call12 frames;
> - fix PC value for restarted syscalls;
> - fix sysv IPC structures;
> - fix fadvise64 syscall;
>
> generic fixes for linux-user:
>
> - fix QEMU assertion in multithreaded application by calling cpu_copy
>   under clone_lock;
> - fix mq_getsetattr implementation;
> - fix error propagation in clock_gettime;
> - implement clock_settime.
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
