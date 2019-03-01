Received: from eggs.gnu.org ([209.51.188.92]:39038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzjDt-0007Qu-6U
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 09:33:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzj4K-0000Ny-FH
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 09:23:21 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:39540)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gzj4K-0000Ni-9c
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 09:23:20 -0500
Received: by mail-oi1-x229.google.com with SMTP id b4so19602604oif.6
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 06:23:19 -0800 (PST)
MIME-Version: 1.0
References: <20190228181710.2477-1-minyard@acm.org>
In-Reply-To: <20190228181710.2477-1-minyard@acm.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Mar 2019 14:23:08 +0000
Message-ID: <CAFEAcA-D=NkapD80o7M_Tqg+3jbojEVhCSfCGFGbm8QSndAB0Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/19] Fix/add vmstate handling in some I2C
 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Corey Minyard <minyard@acm.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Thu, 28 Feb 2019 at 18:17, <minyard@acm.org> wrote:
>
> The following changes since commit 86c7e2f4a93322a76afea5ee6806a83420d1dfea:
>
>   Merge remote-tracking branch 'remotes/berrange/tags/authz-core-pull-request' into staging (2019-02-26 17:59:41 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/cminyard/qemu.git tags/i2c-for-release-20190228
>
> for you to fetch changes up to c203d4514b9c8c1c3bf25988a81edf3813eb3c6d:
>
>   i2c: Verify that the count passed in to smbus_eeprom_init() is valid (2019-02-27 21:06:08 -0600)
>
> ----------------------------------------------------------------
> This has been out there long enough, I need to get this in.
>
> This was changed a little bit since my post on Feb 20 (to which
> there were no comments) due to changes I had to work around:
>
> Change b296b664abc73253 "smbus: Add a helper to generate SPD EEPROM
> data" added a function to include/hw/i2c/smbus.h, which I had to move to
> include/hw/smbus_eeprom.h.
>
> There were some changes to hw/i2c/Makefile.objs that I had to fix up.
>
> Beyond that, no changes.
>
> Thanks,
>
> -corey

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
