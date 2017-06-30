Received: from eggs.gnu.org ([2001:4830:134:3::10]:38314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dQtdU-000333-HZ
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:58:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dQtdT-00065k-QO
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:58:52 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:34707)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dQtdT-00063a-IT
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:58:51 -0400
Received: by mail-wr0-x22b.google.com with SMTP id 77so202468449wrb.1
	for <qemu-devel@nongnu.org>; Fri, 30 Jun 2017 03:58:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170629163011.13388-1-dgilbert@redhat.com>
References: <20170629163011.13388-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Jun 2017 11:58:28 +0100
Message-ID: <CAFEAcA9aB0cdfk-JmXePd4MKGtH973axhgOK7ctQmGL8wNcqjg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] hmp queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 29 June 2017 at 17:30, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit 454d7dc9bc13e46084e0612076e6952c40f4afeb:
>
>   Merge remote-tracking branch 'remotes/gkurz/tags/for-upstream' into staging (2017-06-29 16:21:45 +0100)
>
> are available in the git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-hmp-20170629
>
> for you to fetch changes up to bd1d5ad9f9a1347d6f4338f294253617c565c89a:
>
>   Add chardev-send-break monitor command (2017-06-29 17:14:11 +0100)
>
> ----------------------------------------------------------------
> HMP pull 2017-06-29
>
> ----------------------------------------------------------------
> Stefan Fritsch (1):
>       Add chardev-send-break monitor command
>
> Suraj Jitindar Singh (1):
>       monitor: Add -a (all) option to info registers
>
>  chardev/char.c       | 12 ++++++++++++
>  hmp-commands-info.hx |  6 +++---
>  hmp-commands.hx      | 16 ++++++++++++++++
>  hmp.c                |  8 ++++++++
>  hmp.h                |  1 +
>  monitor.c            | 21 ++++++++++++++++-----
>  qapi-schema.json     | 20 ++++++++++++++++++++
>  tests/test-char.c    | 12 ++++++++++--
>  tests/test-hmp.c     |  1 +
>  9 files changed, 87 insertions(+), 10 deletions(-)
>
Applied, thanks.

-- PMM
