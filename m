Received: from eggs.gnu.org ([2001:4830:134:3::10]:39337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dPRBF-0001So-Gz
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 06:23:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dPRBE-0007AQ-Hm
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 06:23:41 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:36344)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dPRBE-00079t-9h
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 06:23:40 -0400
Received: by mail-wr0-x22c.google.com with SMTP id c11so142185029wrc.3
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 03:23:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
References: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Jun 2017 11:23:18 +0100
Message-ID: <CAFEAcA9dam54FXEK+7RjnxfO=zBuTat7sMe8yUgZD3AEbAtigg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/61] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 23 June 2017 at 17:20, Kevin Wolf <kwolf@redhat.com> wrote:
> The following changes since commit 4c8c1cc544dbd5e2564868e61c5037258e393832:
>
>   Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.10-pull-request' into staging (2017-06-22 19:01:58 +0100)
>
> are available in the git repository at:
>
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 1512008812410ca4054506a7c44343088abdd977:
>
>   Merge remote-tracking branch 'mreitz/tags/pull-block-2017-06-23' into queue-block (2017-06-23 14:09:12 +0200)
>
> ----------------------------------------------------------------
>
> Block layer patches
>

This fails 'make check' on ppc64be Linux, x86-64 FreeBSD, aarch64 Linux:

TEST: tests/virtio-scsi-test... (pid=63911)
  /i386/virtio/scsi/pci/nop:                                           OK
  /i386/virtio/scsi/pci/hotplug:                                       OK
  /i386/virtio/scsi/pci/scsi-disk/unaligned-write-same:                **
ERROR:/home/pm215/qemu/tests/virtio-scsi-test.c:243:test_unaligned_write_same:
assertion failed (0 == vi
rtio_scsi_do_command(vs, write_same_cdb_2, NULL, 0, buf2, 512, NULL)):
(0x00000000 == 0x000000ff)
FAIL
GTester: last random seed: R02Sb24e7d8beec7f0a53a97a610aa09a2b0
(pid=63934)
FAIL: tests/virtio-scsi-test

I also get a core dump in my linux-user smoke test:
/home/petmay01/linaro/qemu-for-merges/build/all-linux-static/ppc-linux-user/qemu-ppc
-L ./gnemul/qemu-ppc ppc/ls -l dummyfile
qemu: uncaught target signal 11 (Segmentation fault) - core dumped

though it's hard to see how the block layer patches would
cause that.

thanks
-- PMM
