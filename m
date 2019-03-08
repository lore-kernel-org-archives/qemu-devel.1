Received: from eggs.gnu.org ([209.51.188.92]:32916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2DJS-0003T3-AV
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 06:05:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2DJN-00045D-Gy
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 06:05:14 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:39166)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h2DJN-00041O-AR
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 06:05:09 -0500
Received: by mail-ot1-x341.google.com with SMTP id e15so17006252otk.6
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 03:05:08 -0800 (PST)
MIME-Version: 1.0
References: <20190307100656.14044-1-laurent@vivier.eu>
In-Reply-To: <20190307100656.14044-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Mar 2019 11:04:56 +0000
Message-ID: <CAFEAcA_+S-RpnzqsBG3s9QT6465FsaZnQ+Z6eF6F9v_cL_=xAQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/9] Linux user for 4.0 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

On Thu, 7 Mar 2019 at 10:09, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit 32694e98b8d7a246345448a8f707d2e11d6c65e2:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-request' into staging (2019-03-06 18:52:19 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-4.0-pull-request
>
> for you to fetch changes up to 61b463fbf6cbf21fcd9abb5af765a19b88dbc1ba:
>
>   linux-user: add new netlink types (2019-03-07 11:02:33 +0100)
>
> ----------------------------------------------------------------
> - Update netlink types to linux v5.0
> - fix accept4/getpeername/getsockname/recvfrom/recvmsg/read
> - add/fix ELF_PLATFORM ofr aarch64 and arm
> - fix "may be used uninitialized" warnings
> - Fix breakpoint support in Nios
> - Nicer strace output of chroot() syscall
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
