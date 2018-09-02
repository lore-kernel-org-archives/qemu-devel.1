Received: from eggs.gnu.org ([2001:4830:134:3::10]:59468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fwW4l-0002MC-Rv
	for qemu-devel@nongnu.org; Sun, 02 Sep 2018 13:22:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fwVwL-0000TW-OY
	for qemu-devel@nongnu.org; Sun, 02 Sep 2018 13:13:34 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:41773)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fwVwL-0000SL-Bq
	for qemu-devel@nongnu.org; Sun, 02 Sep 2018 13:13:33 -0400
Received: by mail-oi0-x241.google.com with SMTP id k12-v6so29855710oiw.8
	for <qemu-devel@nongnu.org>; Sun, 02 Sep 2018 10:13:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180902123608.124586-1-ybettan@redhat.com>
References: <20180902123608.124586-1-ybettan@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 2 Sep 2018 18:13:11 +0100
Message-ID: <CAFEAcA9mSb-RQMkEr8p-BEUH65Y7Y4TDbMZJkJjWoo_z-iT9sg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/4] Reformatted INFO files to fit the
 Markdown (.md) format.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yoni Bettan <ybettan@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>

On 2 September 2018 at 13:36, Yoni Bettan <ybettan@redhat.com> wrote:
> This patch make INFO files (e.g. README, CODING_STYLE etc) much more
> readable when watched from GitHub GUI.
>
> ./VERSION and ./MAINTAINERS were leave untouched otherwise
> ./scripts/get_maintainer.pl breaks.
>
> ./COPYING and ./COPYING.LIB were leave untouched because it look likes
> they come from GNU and not QEMU.

Thanks for this patch, but we don't use Markdown format.
We use RST for docs files, but README, CODING_STYLE, etc
are just plain text and fine as they are I think.

-- PMM
