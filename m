Received: from eggs.gnu.org ([2001:4830:134:3::10]:49907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cv1DN-0005Pc-WC
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:36:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cv1DM-0004uL-QW
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:36:10 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:33701)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cv1DM-0004uB-K9
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:36:08 -0400
Received: by mail-wr0-x22d.google.com with SMTP id w43so167204784wrb.0
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 05:36:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1490698718-23762-1-git-send-email-peter.maydell@linaro.org>
References: <1490698718-23762-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Apr 2017 13:35:46 +0100
Message-ID: <CAFEAcA-BW_FyUdBgZHaFeGJRir7DQ4S+7Oj429OY=yOL1XLveQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH for-2.9] configure: Mark SPARC as supported
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

On 28 March 2017 at 11:58, Peter Maydell <peter.maydell@linaro.org> wrote:
> Thanks to John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> and the Debian Project, we now have access to a SPARC Linux
> system we can use for build testing. Move SPARC back into
> the "supported" list.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> We should also at least apply the TCG fixes:
>  http://patchwork.ozlabs.org/patch/743890/
>  http://patchwork.ozlabs.org/patch/743890/
> and ideally the bios-tables-test fix, but that's a testsuite bug:
>  http://patchwork.ozlabs.org/patch/744178/
>
> There are 'make check' failures in qga-test on this box but
> they don't seem architecture related:
>  https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg04712.html
>
> I also see some failures in ppc64 guests which might just be
> timeout issues and which I haven't investigated yet.
> I don't think those are severe enough to worry about for this
> release.

Applied to master since the TCG fixes have now gone in.

thanks
-- PMM
