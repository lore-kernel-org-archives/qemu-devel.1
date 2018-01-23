Received: from eggs.gnu.org ([2001:4830:134:3::10]:46864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1edyLK-0005ax-Cp
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 08:10:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1edyLJ-00086m-4s
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 08:10:26 -0500
Received: from mail-ot0-x230.google.com ([2607:f8b0:4003:c0f::230]:42714)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1edyLJ-00086V-07
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 08:10:25 -0500
Received: by mail-ot0-x230.google.com with SMTP id s3so336301otc.9
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 05:10:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1516620426-18530-1-git-send-email-thuth@redhat.com>
References: <1516620426-18530-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Jan 2018 13:10:03 +0000
Message-ID: <CAFEAcA9mTTFCp2C5gODqFFj54hnJfDZ9dN_mPA92bZA77novMg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/9] CPU hotplug test,
 __FUNCTION__ and some fprintf patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>

On 22 January 2018 at 11:26, Thomas Huth <thuth@redhat.com> wrote:
> The following changes since commit b384cd95eb9c6f73ad84ed1bb0717a26e29cc78f:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-request' into staging (2018-01-19 16:35:25 +0000)
>
> are available in the git repository at:
>
>   https://github.com/huth/qemu.git tags/pull-request-2018-01-22
>
> for you to fetch changes up to 1081ed2c4b71b5fe8bd31f6de8cdaa630c8acfd3:
>
>   hw/isa: Replace fprintf(stderr, "*\n" with error_report() (2018-01-22 09:51:00 +0100)
>
> ----------------------------------------------------------------
> Pull request for various patches that have been reviewed and
> laying on the mailing list for a while, but where apparently
> no maintainer currently feels responsible for picking up.
> ----------------------------------------------------------------
> Alistair Francis (5):
>       Replace all occurances of __FUNCTION__ with __func__
>       Fixes after renaming __FUNCTION__ to __func__
>       hw/bt: Replace fprintf(stderr, "*\n" with error_report()
>       hw/ipmi: Replace fprintf(stderr, "*\n" with error_report()
>       hw/isa: Replace fprintf(stderr, "*\n" with error_report()
>
> Thomas Huth (4):
>       tests: Rename pc-cpu-test.c to cpu-plug-test.c
>       tests/cpu-plug-test: Check the CPU hot-plugging with device_add, too
>       tests/cpu-plug-test: Check CPU hot-plugging on ppc64, too
>       tests/cpu-plug-test: Test CPU hot-plugging on s390x
>

Applied, thanks.

-- PMM
