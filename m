Received: from eggs.gnu.org ([209.51.188.92]:38370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h0rkr-0003mg-KP
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 12:51:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h0rkq-0004I7-SN
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 12:51:57 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:42793)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h0rkq-0004FQ-Mh
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 12:51:56 -0500
Received: by mail-ot1-x32d.google.com with SMTP id i5so4951727oto.9
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 09:51:56 -0800 (PST)
MIME-Version: 1.0
References: <20190304164958.9362-1-peter.maydell@linaro.org>
In-Reply-To: <20190304164958.9362-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Mar 2019 17:51:44 +0000
Message-ID: <CAFEAcA9__1bgmeU3e6LebigwS8tWxvDXs-qq2LxCRVYLEp10xg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/7] cocoa queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On Mon, 4 Mar 2019 at 16:49, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Cocoa queue: this just has the refactoring to ensure we
> can run reliably on OSX Mojave. Thanks to everybody who helped
> in reviewing and testing this.
>
> -- PMM
>
> The following changes since commit 88687719c8859bf98ed94ce91612608c99c51c1a:
>
>   Merge remote-tracking branch 'remotes/stefanberger/tags/pull-tpm-2019-02-25-1' into staging (2019-03-04 15:56:08 +0000)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-cocoa-20190304
>
> for you to fetch changes up to 5588840ff77800e839d8a34b7be10e5c3acd1721:
>
>   ui/cocoa: Perform UI operations only on the main thread (2019-03-04 16:47:31 +0000)
>
> ----------------------------------------------------------------
> cocoa tree:
>  * Support OSX Mojave by ensuring that we always make Cocoa UI
>    function calls from the main thread, never from any other QEMU
>    thread. This was previously mostly harmless, but on Mojave
>    it will cause OSX to terminate the QEMU process.
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
