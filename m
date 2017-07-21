Received: from eggs.gnu.org ([2001:4830:134:3::10]:53343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dYZnd-0007nQ-Hg
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:25:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dYZnc-00009s-Js
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:25:05 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:36907)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dYZnc-00008m-E4
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:25:04 -0400
Received: by mail-wm0-x22e.google.com with SMTP id e131so17017526wme.0
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 08:25:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1499958932-23839-1-git-send-email-peter.maydell@linaro.org>
References: <1499958932-23839-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Jul 2017 16:24:42 +0100
Message-ID: <CAFEAcA_R4MpMCOX2F9-VgLsYFmqVebY1H27xkCNvfQJc61sUvQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] configure: Never use 'uname' to identify
 target OS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>
Cc: "patches@linaro.org" <patches@linaro.org>

On 13 July 2017 at 16:15, Peter Maydell <peter.maydell@linaro.org> wrote:
> For a very long time we have used 'uname -s' as our fallback if
> we don't identify the target OS using a compiler #define. This
> obviously doesn't work for cross-compilation, and we've had
> a comment suggesting we fix this in configure for a long time.
> Since we now have an exhaustive list of which OSes we can run
> on (thanks to commit 898be3e0415 making an unrecognized OS
> be a fatal error), we know which ones we're missing.
>
> Add check_define tests for the remaining OSes we support.  The
> defines checked are based on ones we already use in the codebase for
> identifying the host OS (with the exception of GNU/kFreeBSD).
> We can now set bogus_os immediately rather than doing it later.
>
> We leave the comment about uname being bad untouched, since
> there is still a use of it for the fallback for unrecognized
> host CPU type.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

Applied, thanks.

-- PMM
