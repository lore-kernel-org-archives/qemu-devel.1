Received: from eggs.gnu.org ([2001:4830:134:3::10]:54547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dqFTj-00015J-1k
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:21:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dqFTe-0004dG-JW
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:21:35 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:46241)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dqFTe-0004bE-BA
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:21:30 -0400
Received: by mail-wm0-x231.google.com with SMTP id i189so1155125wmf.1
	for <qemu-devel@nongnu.org>; Fri, 08 Sep 2017 02:21:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1504545540-8002-1-git-send-email-peter.maydell@linaro.org>
References: <1504545540-8002-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Sep 2017 10:21:08 +0100
Message-ID: <CAFEAcA8a+wri1aMeGi88K=wY2dMZFU0sTMoEzakVGq9R5wEgrA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] configure: Drop AIX host support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: "patches@linaro.org" <patches@linaro.org>

On 4 September 2017 at 18:19, Peter Maydell <peter.maydell@linaro.org> wrote:
> Nobody has mentioned AIX host support on the mailing list for years,
> and we have no test systems for it so it is most likely broken.
> We've advertised in configure for two releases now that we plan
> to drop support for this host OS, and have had no complaints.
> Drop the AIX host support code.
>
> We can also drop the now-unused AIX version of sys_cache_info().
>
> Note that the _CALL_AIX define used in the PPC tcg backend is
> also used for Linux PPC64, and so that code should not be removed.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  configure        | 13 +------------
>  util/cacheinfo.c | 11 +----------
>  2 files changed, 2 insertions(+), 22 deletions(-)

Applied to master, thanks.

-- PMM
