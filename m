Received: from eggs.gnu.org ([2001:4830:134:3::10]:40724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fD7Nl-000868-Gp
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 07:54:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fD7Nk-0004BD-Pz
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 07:54:13 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:33978)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fD7Nk-0004Aw-Jg
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 07:54:12 -0400
Received: by mail-ot0-x243.google.com with SMTP id i5-v6so9151142oth.1
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 04:54:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180430091037.13878-1-laurent@vivier.eu>
References: <20180430091037.13878-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Apr 2018 12:53:51 +0100
Message-ID: <CAFEAcA8FoNLxk=Ey01FXE1OXraz1+hoX7N_4zj0KmxPFcs54SQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/42] Linux user for 2.13 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, Cornelia Huck <cohuck@redhat.com>

On 30 April 2018 at 10:09, Laurent Vivier <laurent@vivier.eu> wrote:
> The following changes since commit 6f0c4706b35dead265509115ddbd2a8d1af516c1:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/usb-20180427-pull-request' into staging (2018-04-27 12:27:59 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-2.13-pull-request
>
> for you to fetch changes up to 62aaa5146476911aea1fbe6fbf919d06bba8ab5d:
>
>   linux-user: Add ARM get_tls syscall support (2018-04-30 09:51:31 +0200)
>
> ----------------------------------------------------------------
> Essentially moving code: move signal and cpu_loop arch specific
> functions under the linux-user/<arch> directory
> Add get_tls() syscall and update the patch to apply on
> linux-user/arm/cpu_loop.c
> minor fix for RISC-V (uname) and getdents()
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
