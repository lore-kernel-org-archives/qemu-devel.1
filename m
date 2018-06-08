Received: from eggs.gnu.org ([2001:4830:134:3::10]:59858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fRDez-000382-0j
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 05:26:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fRDex-0000VM-Ug
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 05:26:16 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:37737)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fRDex-0000Uw-PH
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 05:26:15 -0400
Received: by mail-oi0-x242.google.com with SMTP id l22-v6so11254047oib.4
	for <qemu-devel@nongnu.org>; Fri, 08 Jun 2018 02:26:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180607152119.3447-1-groug@kaod.org>
References: <20180607152119.3447-1-groug@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Jun 2018 10:25:54 +0100
Message-ID: <CAFEAcA9Nc0P_M70JQfbdndFu8cKT79o7F=R-pnVnqfROXCF_1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/7] 9p patches 2018-06-07
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 7 June 2018 at 16:21, Greg Kurz <groug@kaod.org> wrote:
> The following changes since commit 5d328d7d2f1fd4fb160bcfb6e4eb838720274438:
>
>   Merge remote-tracking branch 'remotes/awilliam/tags/vfio-update-20180605.0' into staging (2018-06-07 08:59:28 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/gkurz/qemu.git tags/for-upstream
>
> for you to fetch changes up to aca6897fba149a2a650dcdf5a5e1ae828371f4aa:
>
>   9p: xattr: Properly translate xattrcreate flags (2018-06-07 12:17:22 +0200)
>
> ----------------------------------------------------------------
> Mostly bug fixes and code sanitization motivated by the upcoming
> support for Darwin hosts. Thanks to Keno Fischer.
>
> ----------------------------------------------------------------
> Keno Fischer (7):
>       9p: proxy: Fix size passed to `connect`
>       9p: local: Properly set errp in fstatfs error path
>       9p: Move a couple xattr functions to 9p-util
>       9p: xattr: Fix crashes due to free of uninitialized value
>       9p: local: Avoid warning if FS_IOC_GETVERSION is not defined
>       9p: Properly check/translate flags in unlinkat
>       9p: xattr: Properly translate xattrcreate flags

Applied, thanks.

-- PMM
