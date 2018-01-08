Received: from eggs.gnu.org ([2001:4830:134:3::10]:38039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYZRu-0004qX-Ig
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:34:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYZRt-0001HS-NS
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:34:54 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:36449)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eYZRt-0001Gk-J6
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:34:53 -0500
Received: by mail-ot0-x244.google.com with SMTP id w4so9521362otg.3
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 07:34:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <23118.26328.811644.330716@guava.gson.org>
References: <23118.26328.811644.330716@guava.gson.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jan 2018 15:34:32 +0000
Message-ID: <CAFEAcA_iPT14HSkMG4T43H3vykqBu=rFJpBe4idoVh9LFUEJaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] oslib-posix: check for posix_memalign in
 configure script
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andreas Gustafsson <gson@gson.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kamil Rytarowski <kamil@netbsd.org>, QEMU Trivial <qemu-trivial@nongnu.org>

On 4 January 2018 at 17:39, Andreas Gustafsson <gson@gson.org> wrote:
> Check for the presence of posix_memalign() in the configure script,
> not using "defined(_POSIX_C_SOURCE) && !defined(__sun__)".  This
> lets qemu use posix_memalign() on NetBSD versions that have it,
> instead of falling back to valloc() which is wasteful when the
> required alignment is smaller than a page.
>
> Signed-off-by: Andreas Gustafsson <gson@gson.org>
> ---
>  configure          | 19 +++++++++++++++++++
>  util/oslib-posix.c |  2 +-
>  2 files changed, 20 insertions(+), 1 deletion(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Can we put this through the -trivial tree? (cc'd)

thanks
-- PMM
