Received: from eggs.gnu.org ([2001:4830:134:3::10]:50427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1daN1W-00012z-QS
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:10:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1daN1V-0001Ud-QI
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:10:50 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:34017)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1daN1V-0001U2-JZ
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:10:49 -0400
Received: by mail-wr0-x22e.google.com with SMTP id 12so132348214wrb.1
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 07:10:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170726140218.15904-4-eblake@redhat.com>
References: <20170726140218.15904-1-eblake@redhat.com>
	<20170726140218.15904-4-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 26 Jul 2017 15:10:27 +0100
Message-ID: <CAFEAcA9sOaN+yLbikODGN5NTaX88rSU=vTpdD_ovfPzTv=Hu9A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 3/3] maint: Include bug-reporting info in
 --help output.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, Michael Roth <mdroth@linux.vnet.ibm.com>, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>

On 26 July 2017 at 15:02, Eric Blake <eblake@redhat.com> wrote:
> These days, many programs are including a bug-reporting address,
> or better yet, a link to the project web site, at the tail of
> their --help output.  However, we were not very consistent at
> doing so: only qemu-nbd and qemu-qa mentioned anything, with the
> latter pointing to an individual person instead of the project.
>
> Add a new #define that sets up a uniform string, mentioning both
> bug reporting instructions and overall project details, and which
> a downstream vendor could tweak if they want bugs to go to a
> downstream database.  Then use it in all of our binaries which
> have --help output.
>
> The canned text intentionally references http:// instead of https://
> because our https website currently causes certificate errors in
> some browsers.  That can be tweaked later once we have resolved the
> web site issued.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  include/qemu-common.h | 5 +++++
>  vl.c                  | 4 +++-
>  bsd-user/main.c       | 2 ++
>  linux-user/main.c     | 4 +++-
>  qemu-img.c            | 2 +-
>  qemu-io.c             | 5 +++--
>  qemu-nbd.c            | 2 +-
>  qga/main.c            | 2 +-
>  8 files changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/include/qemu-common.h b/include/qemu-common.h
> index b5adbfa5e9..e751361458 100644
> --- a/include/qemu-common.h
> +++ b/include/qemu-common.h
> @@ -22,6 +22,11 @@
>  #define QEMU_COPYRIGHT "Copyright (c) 2003-2017 " \
>      "Fabrice Bellard and the QEMU Project developers"
>
> +/* Bug reporting information for --help arguments, About dialogs, etc */
> +#define QEMU_BUGREPORTS \
> +    "See <http://qemu.org/contribute/report-a-bug> for bug reports.\n" \
> +    "More information on the qemu project at <http://qemu.org>"

QEMU should be all upper case.

> +

I wonder if we may regret the embedded newline when
we come to handling UI about dialogs. I guess we
can cross that bridge when we come to it (they
may need to special case it anyway if they want
to make the links clicky).

thanks
-- PMM
