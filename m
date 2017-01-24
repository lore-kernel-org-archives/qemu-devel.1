Received: from eggs.gnu.org ([2001:4830:134:3::10]:34311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cVz0J-00024d-LC
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:11:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cVz0I-00030K-R3
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:11:11 -0500
Received: from mail-vk0-x22f.google.com ([2607:f8b0:400c:c05::22f]:32894)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cVz0I-0002zo-M4
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:11:10 -0500
Received: by mail-vk0-x22f.google.com with SMTP id k127so109344856vke.0
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 03:11:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170123175945.9260-1-rth@twiddle.net>
References: <20170123175945.9260-1-rth@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jan 2017 11:10:48 +0000
Message-ID: <CAFEAcA-v9abp43Ma1fG5a2rS6zFxU88cHrVotqGO8m6adSCz+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL v2 00/25] New hppa-linux target support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, deller@gmx.de

On 23 January 2017 at 17:59, Richard Henderson <rth@twiddle.net> wrote:
> Version 2: drop patch 6 which caused the IPV6 compilation errors on
> older systems.
>
> I suspect that the systems simply do not have proper glibc support
> for IPV6.  One can debate whether we want to get these constants
> directly from <linux/*>, or whether we want to ifdef the support.
>
> However, let's improve that bit of linux-user in another patch set.
>
>
> r~
>
>
> The following changes since commit d1c82f7cc34443841095f490345f86c9d8baca34:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20170120-v2' into staging (2017-01-20 15:53:58 +0000)
>
> are available in the git repository at:
>
>   git://github.com/rth7680/qemu.git tags/pull-hppa-20170123
>
> for you to fetch changes up to ebe9383caefd56d519e965a5d87bca29f0aeffe3:
>
>   target-hppa: Implement floating-point insns (2017-01-23 09:52:40 -0800)
>
> ----------------------------------------------------------------
> hppa-linux target support
>

Applied, thanks.

-- PMM
