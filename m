Received: from eggs.gnu.org ([2001:4830:134:3::10]:40991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cpIz1-0003NG-Cb
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 14:21:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cpIz0-0005r9-EV
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 14:21:43 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:35596)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cpIz0-0005r1-7v
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 14:21:42 -0400
Received: by mail-wm0-x22e.google.com with SMTP id u132so36641032wmg.0
	for <qemu-devel@nongnu.org>; Sat, 18 Mar 2017 11:21:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1489774711-27746-1-git-send-email-jcmvbkbc@gmail.com>
References: <1489774711-27746-1-git-send-email-jcmvbkbc@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 18 Mar 2017 18:21:20 +0000
Message-ID: <CAFEAcA9OJPNDwAAqVvFLXjZNCE4qs_3jgTf2uia0VcqG_5VVXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL for 2.9 0/2] target/xtensa fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 17 March 2017 at 18:18, Max Filippov <jcmvbkbc@gmail.com> wrote:
> Hi Peter,
>
> please pull the following two fixes for the target/xtensa.
>
> The following changes since commit dd4d2578215cd380f40a38028a9904e15b135ef3:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/pull-fixes-20170309-1' into staging (2017-03-09 13:16:05 +0000)
>
> are available in the git repository at:
>
>   git://github.com/OSLL/qemu-xtensa.git tags/20170317-xtensa
>
> for you to fetch changes up to f289bb091e6876df2e0e3481cb414c277695a405:
>
>   target/xtensa: fix semihosting argc/argv implementation (2017-03-11 14:59:03 -0800)
>
> ----------------------------------------------------------------
> target/xtensa fixes for 2.9:
>
> - fix build failure when FDT support is not enabled;
> - correctly pass command line arguments to semihosting guests.
>
> ----------------------------------------------------------------
> Max Filippov (2):
>       target/xtensa: xtfpga: load DTB only when FDT support is enabled
>       target/xtensa: fix semihosting argc/argv implementation
>
>  hw/xtensa/xtfpga.c          |  9 +++++++++
>  target/xtensa/xtensa-semi.c | 49 +++++++++++++++++++++++++++++++++------------
>  2 files changed, 45 insertions(+), 13 deletions(-)

Applied, thanks.

-- PMM
