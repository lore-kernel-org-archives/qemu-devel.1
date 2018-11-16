Received: from eggs.gnu.org ([2001:4830:134:3::10]:45006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNfxl-0005cq-54
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:23:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNfxk-0001MV-Bc
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:23:17 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:42375)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gNfxk-0001MG-44
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:23:16 -0500
Received: by mail-oi1-x236.google.com with SMTP id w13so7322429oiw.9
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 07:23:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181116132931.8737-1-kraxel@redhat.com>
References: <20181116132931.8737-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Nov 2018 15:22:54 +0000
Message-ID: <CAFEAcA-hiZ92ngyy33kbvSZQ_xa7jKdBcTT0sXFFeNsEDab2JQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] Fixes 31 20181116 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>

On 16 November 2018 at 13:29, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit cb968d275c145467c8b385a3618a207ec111eab1:
>
>   Update version for v3.1.0-rc1 release (2018-11-13 18:16:14 +0000)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/fixes-31-20181116-pull-request
>
> for you to fetch changes up to 144aaa990e0d54d08865c4d98ba2138a89689530:
>
>   help: Provide help for egl-headless (2018-11-16 11:44:22 +0100)
>
> ----------------------------------------------------------------
> ui: add rendernode arg for egl-headless (fixes permission issues with libvirt)
>
> ----------------------------------------------------------------
>
> Erik Skultety (3):
>   qapi: Add "rendernode" display option for egl-headless
>   ui: Allow specifying 'rendernode' display option for egl-headless
>   help: Provide help for egl-headless
>
>  ui/egl-headless.c |  2 +-
>  qapi/ui.json      | 17 ++++++++++++++++-
>  qemu-options.hx   |  6 +++++-
>  3 files changed, 22 insertions(+), 3 deletions(-)

Applied, thanks.

-- PMM
