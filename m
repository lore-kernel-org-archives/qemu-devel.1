Received: from eggs.gnu.org ([2001:4830:134:3::10]:33765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIINz-0003A3-CV
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 13:35:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIINy-0005U7-HQ
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 13:35:19 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:32867)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dIINy-0005Tu-9m
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 13:35:18 -0400
Received: by mail-wr0-x232.google.com with SMTP id v104so57313383wrb.0
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 10:35:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1496746329-32047-1-git-send-email-jcmvbkbc@gmail.com>
References: <1496746329-32047-1-git-send-email-jcmvbkbc@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Jun 2017 18:34:56 +0100
Message-ID: <CAFEAcA_UBTXqzJRkrRjcdWWoAr2dMsP5kVk1baiECwo=+Optvg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 0/4] target/xtensa fixes
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

On 6 June 2017 at 11:52, Max Filippov <jcmvbkbc@gmail.com> wrote:
> Hi Peter,
>
> please pull my current target/xtensa queue.
> Changes v1->v2:
> - re-base series to the latest mainline, fixing breakage caused by chardev
>   code rearrangement.
>
> The following changes since commit a0d4aac7467dd02e5657b79e867f067330266a24:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20170605' into staging (2017-06-05 18:03:43 +0100)
>
> are available in the git repository at:
>
>   git://github.com/OSLL/qemu-xtensa.git tags/20170606-xtensa
>
> for you to fetch changes up to dd7b952b793e341c905355581a21cdbaa8b13c31:
>
>   target/xtensa: handle unknown registers in gdbstub (2017-06-06 02:40:48 -0700)
>
> ----------------------------------------------------------------
> target/xtensa fixes:
>
> - fix read/write simcall mapping flags and return value;
> - use -serial option to direct console output of sim machine to QEMU chardev;
> - fix handling of unknown registers in the gdbstub.
>

Applied, thanks.

-- PMM
