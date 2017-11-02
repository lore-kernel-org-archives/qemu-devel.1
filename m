Received: from eggs.gnu.org ([2001:4830:134:3::10]:49761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eADyX-0002wZ-Es
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 07:47:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eADyW-00008t-HG
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 07:47:57 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:53684)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eADyW-00007H-9C
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 07:47:56 -0400
Received: by mail-wm0-x242.google.com with SMTP id r196so10757197wmf.2
	for <qemu-devel@nongnu.org>; Thu, 02 Nov 2017 04:47:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171031230206.32731-1-jsnow@redhat.com>
References: <20171031230206.32731-1-jsnow@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Nov 2017 11:47:34 +0000
Message-ID: <CAFEAcA-s2NwFi-SyJCAeSwy51HNX3EhqNX+2gy98stPZXYHy+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] Ide patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 31 October 2017 at 23:02, John Snow <jsnow@redhat.com> wrote:
> The following changes since commit 7fa00e204902cee0b33a0c60de87e87319d1809f:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20171031' into staging (2017-10-31 14:28:25 +0000)
>
> are available in the git repository at:
>
>   https://github.com/jnsnow/qemu.git tags/ide-pull-request
>
> for you to fetch changes up to 96f43c2b0a663f4789b51ed97297163321e7ba5e:
>
>   ide: avoid referencing NULL dev in rotational rate setting (2017-10-31 18:00:03 -0400)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Daniel P. Berrange (1):
>   ide: avoid referencing NULL dev in rotational rate setting
>
> Thomas Huth (1):
>   hw/ide/ahci: Move allwinner code into a separate file
>
>  hw/ide/Makefile.objs    |   1 +
>  hw/ide/ahci-allwinner.c | 127 ++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/ide/ahci.c           |  95 ------------------------------------
>  hw/ide/core.c           |   4 +-
>  4 files changed, 131 insertions(+), 96 deletions(-)
>  create mode 100644 hw/ide/ahci-allwinner.c
>

Applied, thanks.

-- PMM
