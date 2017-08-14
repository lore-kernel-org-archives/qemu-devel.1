Received: from eggs.gnu.org ([2001:4830:134:3::10]:34249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dh9Dh-0002Cw-3v
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 02:51:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dh9Dg-0000zU-9X
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 02:51:25 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:34372)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dh9Dg-0000ym-20
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 02:51:24 -0400
Received: by mail-wr0-x22a.google.com with SMTP id l9so8693356wrl.1
	for <qemu-devel@nongnu.org>; Sun, 13 Aug 2017 23:51:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1502681591-31362-1-git-send-email-jasowang@redhat.com>
References: <1502681591-31362-1-git-send-email-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Aug 2017 07:51:00 +0100
Message-ID: <CAFEAcA_WbQ9R9FsyM0vcTtZ1jOCiA9WNicH4qg+UwG=C2zhZ8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/5] Net patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 14 August 2017 at 04:33, Jason Wang <jasowang@redhat.com> wrote:
> The following changes since commit 9db6ffc76676731a25a5538ab71e8ca6ac234f80:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2017-08-11 15:11:50 +0100)
>
> are available in the git repository at:
>
>   https://github.com/jasowang/qemu.git tags/net-pull-request
>
> for you to fetch changes up to 131f6055f1f0eba4cd2e862a8ff907dbde4d94d1:
>
>   qemu-doc: Mention host_net_add/-remove in the deprecation chapter (2017-08-14 10:56:47 +0800)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
> Mao Zhongyi (4):
>       net/rocker: Remove the dead error handling
>       net/rocker: Plug memory leak in pci_rocker_init()
>       net/rocker: Convert to realize()
>       net/rocker: Fix the unusual macro name
>
> Thomas Huth (1):
>       qemu-doc: Mention host_net_add/-remove in the deprecation chapter

It's not clear to me why these should all be going into 2.10,
especially since the date for rc3 is tomorrow and that in theory
is our final rc. At this point we should only be taking patches
that are fixes for significant bugs or bugs that are regressions
since 2.9. (Docs changes are OK too.) Is there a good reason
for putting in all these rocker patches that you haven't
mentioned in the cover letter? They look like 2.11 material
just judging by the patch titles.

thanks
-- PMM
