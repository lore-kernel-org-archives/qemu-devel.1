Received: from eggs.gnu.org ([2001:4830:134:3::10]:45639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cihPc-0001kM-P9
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 08:01:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cihPb-0006FU-OE
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 08:01:52 -0500
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:35833)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cihPb-0006FO-Ix
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 08:01:51 -0500
Received: by mail-wm0-x22f.google.com with SMTP id v186so84879118wmd.0
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 05:01:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170227223337.17434-1-laurent@vivier.eu>
References: <20170227223337.17434-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Feb 2017 13:01:29 +0000
Message-ID: <CAFEAcA_Dje0ibNsqQFp+OC=UT6+WkY-K-_f_yb=w+vER3P2gFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/6] Linux user for upstream patches
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

On 27 February 2017 at 22:33, Laurent Vivier <laurent@vivier.eu> wrote:
> The following changes since commit 8f2d7c341184a95d05476ea3c45dbae2b9ddbe51:
>
>   Merge remote-tracking branch 'remotes/berrange/tags/pull-qcrypto-2017-02-27-1' into staging (2017-02-27 15:33:21 +0000)
>
> are available in the git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-upstream-pull-request
>
> for you to fetch changes up to 98a3331a552f6e033da10bd07b14ccdd81d05e61:
>
>   syscall: fixed mincore(2) not failing with ENOMEM (2017-02-27 23:10:02 +0100)
>
> ----------------------------------------------------------------
> Tested with ltp-full-20170116, target ppc, host x86_64,
> debian version 8.7
>
> Total Tests: 1111
> Total Skipped Tests: 174
> Total Failures: 67
> Kernel Version: 4.9.10-200.fc25.x86_64
> Machine Architecture: ppc
>
> Changes since last pull request:
> -mincore01                      FAIL       1
> +mincore01                      PASS       0
>
> [tested on top of 2f16960, as 3725794 is broken]
> ----------------------------------------------------------------
>

Applied, thanks.

-- PMM
