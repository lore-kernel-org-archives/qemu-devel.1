Received: from eggs.gnu.org ([209.51.188.92]:43264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEwvl-0004L3-Om
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 10:13:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEwvh-0004xf-D9
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 10:13:22 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:34366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hEwvh-0004vm-4V
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 10:13:21 -0400
Received: by mail-oi1-x22f.google.com with SMTP id v10so8076175oib.1
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 07:13:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190409210655.777-1-jsnow@redhat.com>
In-Reply-To: <20190409210655.777-1-jsnow@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Apr 2019 15:13:08 +0100
Message-ID: <CAFEAcA8_V6p3BPZ8VKOCFzBoKKU-S2bsBamOXxy3CJGnwFWA1g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] qemu-img: fix .hx and .texi disparity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Tue, 9 Apr 2019 at 22:08, John Snow <jsnow@redhat.com> wrote:
>
> It turns out that having options listed in three places continues to be
> a bad idea. I'm still toying with the idea of an improved infrastructure
> here, but in the meantime, another bandaid.
>
> There are three locations:
> (1) .hx file, formatted as texi
> (2) .hx file, formatted as human readable.
> (3) .texi file, as section headers, formatted as texi.
>
> You can compare the two summaries within the .hx file like so:
>
> Human-readable command summaries:
> `./qemu-img --help | grep 'Command syntax' -A14`
> Detokenized texi command summaries:
> `grep "@item" qemu-img-cmds.hx | sed -E 's|@var\{([^\}]*?)\}|\1|g'`
>
> You can compare the two separate texi summaries like so:
>
> Texi command summaries:
> `grep "@item" qemu-img-cmds.hx"`
> Texi command headers:
> grep -E "@item.*@var" qemu-img.texi | tail -14
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qemu-img.texi    | 4 ++--
>  qemu-img-cmds.hx | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

Applied to master for rc4, since we needed an rc4 anyway and
this is a safe docs change.

thanks
-- PMM
