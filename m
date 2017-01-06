Received: from eggs.gnu.org ([2001:4830:134:3::10]:55324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPTM4-0007N9-SI
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 07:10:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPTM3-0006IK-O1
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 07:10:44 -0500
Received: from mail-vk0-x230.google.com ([2607:f8b0:400c:c05::230]:34036)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cPTM3-0006Hg-Ie
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 07:10:43 -0500
Received: by mail-vk0-x230.google.com with SMTP id x186so312882109vkd.1
	for <qemu-devel@nongnu.org>; Fri, 06 Jan 2017 04:10:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1483633930-7103-1-git-send-email-amit.shah@redhat.com>
References: <1483633930-7103-1-git-send-email-amit.shah@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Jan 2017 12:10:22 +0000
Message-ID: <CAFEAcA8nZmDsQvfX+=W3jDJU0rUThsn93fFNYgzxhEyWTx_kHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/4] migration: QTAILQ migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amit Shah <amit.shah@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu list <qemu-devel@nongnu.org>, Jianjun Duan <duanj@linux.vnet.ibm.com>

On 5 January 2017 at 16:32, Amit Shah <amit.shah@redhat.com> wrote:
> The following changes since commit dbe2b65566e76d3c3a0c3358285c0336ac61e757:
>
>   Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.9-pull-request' into staging (2016-12-28 17:11:11 +0000)
>
> are available in the git repository at:
>
>   https://git.kernel.org/pub/scm/virt/qemu/amit/migration.git tags/migration-for-2.9-1
>
> for you to fetch changes up to 8d0c57697abcc57166e918064d9a7f6c7316d01b:
>
>   migration: add error_report (2017-01-04 19:21:26 +0530)
>
> ----------------------------------------------------------------
> Migration: migrate QTAILQ infrastructure for vmstate
>
> ----------------------------------------------------------------

Hi. I'm afraid this fails 'make check' for ppc64be:

TEST: tests/virtio-9p-test... (pid=62775)
  /i386/virtio/9p/pci/nop:                                             OK
  /i386/virtio/9p/pci/config:                                          OK
  /i386/virtio/9p/pci/fs/version/basic:                                OK
  /i386/virtio/9p/pci/fs/attach/basic:                                 **
ERROR:/home/pm215/qemu/tests/libqtest.c:339:qtest_rsp: assertion
failed (words[0] == "OK"): ("ERR" == "OK
")
**
ERROR:/home/pm215/qemu/qtest.c:281:qtest_process_command: assertion
failed: (command)
FAIL
GTester: last random seed: R02S8d2247e6c947755edd81860ea8a2b9c9
(pid=62788)
  /i386/virtio/9p/pci/fs/walk/basic:                                   **
ERROR:/home/pm215/qemu/tests/libqtest.c:339:qtest_rsp: assertion
failed (words[0] == "OK"): ("ERR" == "OK
")
**
ERROR:/home/pm215/qemu/qtest.c:281:qtest_process_command: assertion
failed: (command)
FAIL
GTester: last random seed: R02Sc5c6e6cda2c905d23a2e10a43aae0a39
(pid=62792)
  /i386/virtio/9p/pci/fs/walk/no_slash:                                **
ERROR:/home/pm215/qemu/tests/libqtest.c:339:qtest_rsp: assertion
failed (words[0] == "OK"): ("ERR" == "OK
")
**
ERROR:/home/pm215/qemu/qtest.c:281:qtest_process_command: assertion
failed: (command)
FAIL
GTester: last random seed: R02S1d66c364588fa2597428d8ebd81a1c87
(pid=62796)
  /i386/virtio/9p/pci/fs/walk/dotdot_from_root:                        **
ERROR:/home/pm215/qemu/tests/libqtest.c:339:qtest_rsp: assertion
failed (words[0] == "OK"): ("ERR" == "OK
")
**
ERROR:/home/pm215/qemu/qtest.c:281:qtest_process_command: assertion
failed: (command)
FAIL
GTester: last random seed: R02S8e89f14358da9979cf495fe61d427eb0
(pid=62800)
FAIL: tests/virtio-9p-test

thanks
-- PMM
