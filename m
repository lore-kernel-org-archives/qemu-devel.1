Received: from eggs.gnu.org ([2001:4830:134:3::10]:50821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gPsdV-00006K-6z
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 12:19:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gPsdU-0000yB-61
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 12:19:29 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:42992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gPsdT-0000wZ-WE
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 12:19:28 -0500
Received: by mail-ot1-x336.google.com with SMTP id v23so3189628otk.9
	for <qemu-devel@nongnu.org>; Thu, 22 Nov 2018 09:19:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181122165417.23894-1-kwolf@redhat.com>
References: <20181122165417.23894-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Nov 2018 17:19:06 +0000
Message-ID: <CAFEAcA99xsyCQ2SaYrR4eAfFc8X_UkXSKe9QTFRXkrpVtRwsUQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/13] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On 22 November 2018 at 16:54, Kevin Wolf <kwolf@redhat.com> wrote:
> The following changes since commit 47c1cc30e440860aa695358f7c2dd0b9d7b53d16:
>
>   Update version for v3.1.0-rc2 release (2018-11-20 18:10:26 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 924956b1efc50af7cc334b7a14f56aa213ca27ef:
>
>   iotests: Enhance 223 to cover multiple bitmap granularities (2018-11-22 16:43:52 +0100)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - block: Fix update of BDRV_O_AUTO_RDONLY in update_flags_from_options()
> - qemu-img: Fix memory leak and typo in error message
> - nvme: Fixes for lockups and crashes
> - scsi-disk: Fix crash if underlying host file or disk returns error
> - Several qemu-iotests fixes and improvements
>
> ----------------------------------------------------------------

Hi; this seems to fail make check on s390x, sparc64, ppc64 (ie all
the bigendian hosts):

TEST: tests/nvme-test... (pid=12356)
  /i386/nvme/nop:                                                      OK
  /i386/nvme/cmb_test:                                                 **
ERROR:/home/linux1/qemu/tests/nvme-test.c:60:nvmetest_cmb_test:
assertion failed (qpci_io_re
adb(pdev, bar, 0) == 0x99): (0 == 153)
FAIL

thanks
-- PMM
