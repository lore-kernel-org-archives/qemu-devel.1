Received: from eggs.gnu.org ([2001:4830:134:3::10]:36142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIALx-0001D5-ID
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 05:00:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIALr-000869-SJ
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 05:00:41 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:35758)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dIALr-00085m-ML
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 05:00:35 -0400
Received: by mail-wr0-x22f.google.com with SMTP id q97so50954790wrb.2
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 02:00:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1496682077-32144-1-git-send-email-jcmvbkbc@gmail.com>
References: <1496682077-32144-1-git-send-email-jcmvbkbc@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Jun 2017 10:00:13 +0100
Message-ID: <CAFEAcA9KKjLw7kLojpOY2n6MscDa7xQ_U0ieZLYsD3Mj2ZYOMw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] target/xtensa fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 5 June 2017 at 18:01, Max Filippov <jcmvbkbc@gmail.com> wrote:
> Hi Peter,
>
> please pull my current target/xtensa queue:
>
> The following changes since commit c6e84fbd447a51e1161d74d71566a5f67b47eac5:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2017-06-02 17:46:22 +0100)
>
> are available in the git repository at:
>
>   git://github.com/OSLL/qemu-xtensa.git tags/20170605-xtensa
>
> for you to fetch changes up to aa717e657f3ef2e676803676eaa268ec0108a453:
>
>   target/xtensa: handle unknown registers in gdbstub (2017-06-03 02:16:18 -0700)
>
> ----------------------------------------------------------------
> target/xtensa fixes:
>
> - fix read/write simcall mapping flags and return value;
> - use -serial option to direct console output of sim machine to QEMU chardev;
> - fix handling of unknown registers in the gdbstub.
>
> ----------------------------------------------------------------
> Max Filippov (4):
>       target/xtensa: fix mapping direction in read/write simcalls
>       target/xtensa: fix return value of read/write simcalls
>       target/xtensa: support output to chardev console
>       target/xtensa: handle unknown registers in gdbstub

Hi; I'm afraid this doesn't build:

/home/peter.maydell/qemu/target/xtensa/xtensa-semi.c:34:25: fatal
error: sysemu/char.h: No such file or directory

Looks like you have a clash with the recent char frontend pullreq
which moved the char headers around.

thanks
-- PMM
