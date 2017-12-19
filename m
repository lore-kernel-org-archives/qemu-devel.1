Received: from eggs.gnu.org ([2001:4830:134:3::10]:38657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eR5ZM-0007Gt-Ra
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 19:15:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eR5ZM-00051I-0g
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 19:15:40 -0500
Received: from mail-oi0-x22f.google.com ([2607:f8b0:4003:c06::22f]:45505)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eR5ZL-00050I-Rp
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 19:15:39 -0500
Received: by mail-oi0-x22f.google.com with SMTP id x20so11787099oix.12
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 16:15:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171218143530.12082-1-stefanha@redhat.com>
References: <20171218143530.12082-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Dec 2017 00:15:18 +0000
Message-ID: <CAFEAcA8fBMYV_uvphxadgXbfzAb+BoOhWVdvX5q4=fXsGBoj3A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/23] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 18 December 2017 at 14:35, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The following changes since commit 411ad78115ebeb3411cf4b7622784b93dfabe259:
>
>   Merge remote-tracking branch 'remotes/stefanberger/tags/pull-tpm-2017-12-15-1' into staging (2017-12-17 15:27:41 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 585426c518958aa768564596091474be786aae51:
>
>   qemu-iotests: add 203 savevm with IOThreads test (2017-12-18 13:12:53 +0000)
>
> ----------------------------------------------------------------
>

This failed 'make check' on all hosts:

TEST: tests/virtio-blk-test... (pid=49005)
  /arm/virtio/blk/mmio/basic:                                          **
ERROR:/home/pm215/qemu/tests/libqos/virtio.c:94:qvirtio_wait_queue_isr:
assertion failed: (g_get_monotonic_time() - start_time <= timeout_us)
FAIL
GTester: last random seed: R02S8877aa3278e71261919aae7707897a80
(pid=49024)
FAIL: tests/virtio-blk-test


thanks
-- PMM
