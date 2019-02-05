Received: from eggs.gnu.org ([209.51.188.92]:42768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr6v1-0005xo-5R
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 15:02:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr6uz-0002ed-77
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 15:02:07 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a]:37865)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gr6ux-0002dd-GP
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 15:02:05 -0500
Received: by mail-ot1-x32a.google.com with SMTP id s13so7958362otq.4
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 12:02:03 -0800 (PST)
MIME-Version: 1.0
References: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Feb 2019 20:01:51 +0000
Message-ID: <CAFEAcA8-Hst3Buax1Qrrm1SVbTtkE-8a_Vj0y3N4TvfPTqR_zw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/76] misc patches for 2019-02-04
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Tue, 5 Feb 2019 at 18:18, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 1c3d45df5e94042d5fb2bb31416072563ab30e49:
>
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2019-02-04' into staging (2019-02-05 12:46:18 +0000)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 5ed76a4c63db9295c6c5d67895925810050d4a46:
>
>   queue: fix QTAILQ_FOREACH_REVERSE_SAFE (2019-02-05 16:50:21 +0100)
>
> ----------------------------------------------------------------
> * cpu-exec fixes (Emilio, Laurent)
> * TCG bugfix in queue.h (Paolo)
> * high address load for linuxboot (Zhijian)
> * PVH support (Liam, Stefano)
> * misc i386 changes (Paolo, Robert, Doug)
> * configure tweak for openpty (Thomas)
> * elf2dmp port to Windows (Viktor)
> * initial improvements to Makefile infrastructure (Yang + GSoC 2013)
>
> ----------------------------------------------------------------

The build tree where I do 'make clean' then 'make' failed when
linking:

  LINK    mips-softmmu/qemu-system-mips
../hw/acpi/piix4.o: In function `piix4_pm_realize':
/home/petmay01/linaro/qemu-for-merges/hw/acpi/piix4.c:515: undefined
reference to `pm_smbus_init'
../hw/i2c/smbus_ich9.o: In function `ich9_smbus_realize':
/home/petmay01/linaro/qemu-for-merges/hw/i2c/smbus_ich9.c:89:
undefined reference to `pm_smbus_init'

(ditto the other mips binaries)

and
  LINK    aarch64-softmmu/qemu-system-aarch64
hw/arm/aspeed.o: In function `palmetto_bmc_i2c_init':
/home/petmay01/linaro/qemu-for-merges/hw/arm/aspeed.c:249: undefined
reference to `smbus_eeprom_init_one'
hw/arm/aspeed.o: In function `ast2500_evb_i2c_init':
/home/petmay01/linaro/qemu-for-merges/hw/arm/aspeed.c:266: undefined
reference to `smbus_eeprom_init_one'
hw/arm/aspeed.o: In function `witherspoon_bmc_i2c_init':
/home/petmay01/linaro/qemu-for-merges/hw/arm/aspeed.c:303: undefined
reference to `smbus_eeprom_init_one'
collect2: error: ld returned 1 exit status

thanks
-- PMM
