Received: from eggs.gnu.org ([2001:4830:134:3::10]:42755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cW4rW-0003K6-6h
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 12:26:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cW4rV-0001Qg-Ct
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 12:26:30 -0500
Received: from mail-ua0-x22e.google.com ([2607:f8b0:400c:c08::22e]:34299)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cW4rV-0001QK-8L
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 12:26:29 -0500
Received: by mail-ua0-x22e.google.com with SMTP id 35so139134141uak.1
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 09:26:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
References: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jan 2017 17:26:08 +0000
Message-ID: <CAFEAcA-eXHbKc081aVe5MxXpTTvdYE++TU61iYLboSAtFYTknQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/31] Trivial patches for 2017-01-24
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>

On 24 January 2017 at 09:39, Michael Tokarev <mjt@tls.msk.ru> wrote:
> Hi!
> This is a next trivial-patches pull request after a long while.
> We had a new release (2.8), new year holidays and other stuff.
> So here we go now with whatever has been collected so far.
>
> Please consider applying.
>
> Thanks,
>
> /mjt
>
> The following changes since commit 3879284d6517dc22529395bdb259f4183b5891=
27:
>
>   Merge remote-tracking branch 'remotes/berrange/tags/pull-qio-2017-01-23=
-2' into staging (2017-01-23 15:59:09 +0000)
>
> are available in the git repository at:
>
>   git://git.corpit.ru/qemu.git tags/trivial-patches-fetch
>
> for you to fetch changes up to bed534dd4032446750ad3e7a806c24d81bc5851b:
>
>   hw/isa/isa-bus: Set category of the "isabus-bridge" device (2017-01-24 =
12:38:03 +0300)
>
> ----------------------------------------------------------------
> trivial patches for 2017-01-24
>
> ----------------------------------------------------------------

This failed to build, all targets:

/home/petmay01/linaro/qemu-for-merges/arch_init.c:95:5: error: no
previous prototype for =E2=80=98qemu_read_default_config_files=E2=80=99
[-Werror=3Dmissing-prototypes]

I suspect this may be the result of merge conflicts getting
wrongly resolved -- can you rebase and resend, please?

thanks
-- PMM
