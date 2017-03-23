Received: from eggs.gnu.org ([2001:4830:134:3::10]:47959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cr1uH-0002gy-1Z
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 08:32:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cr1uF-0001gM-QM
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 08:31:57 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:34577)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cr1uF-0001g6-JD
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 08:31:55 -0400
Received: by mail-wr0-x22d.google.com with SMTP id l37so146517752wrc.1
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 05:31:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170322173102.18180-1-jcody@redhat.com>
References: <20170322173102.18180-1-jcody@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Mar 2017 12:31:33 +0000
Message-ID: <CAFEAcA-Er8xFkHoPKUGvJME6+OWbRcPFcP6qFN8=o_qVE-moTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL for-2.9 0/4] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 22 March 2017 at 17:30, Jeff Cody <jcody@redhat.com> wrote:
> The following changes since commit 55a19ad8b2d0797e3a8fe90ab99a9bb713824059:
>
>   Update version for v2.9.0-rc1 release (2017-03-21 17:13:29 +0000)
>
> are available in the git repository at:
>
>   https://github.com/codyprime/qemu-kvm-jtc.git tags/block-pull-request
>
> for you to fetch changes up to 600ac6a0ef5c06418446ef2f37407bddcc51b21c:
>
>   blockjob: add devops to blockjob backends (2017-03-22 13:26:27 -0400)
>
> ----------------------------------------------------------------
> Block patches for 2.9
> ----------------------------------------------------------------
>
> John Snow (3):
>   blockjob: add block_job_start_shim
>   block-backend: add drained_begin / drained_end ops
>   blockjob: add devops to blockjob backends
>
> Paolo Bonzini (1):
>   blockjob: avoid recursive AioContext locking
>
>  block/block-backend.c          | 24 ++++++++++++++--
>  blockjob.c                     | 63 ++++++++++++++++++++++++++++++++----------
>  include/sysemu/block-backend.h |  8 ++++++
>  3 files changed, 79 insertions(+), 16 deletions(-)

Applied, thanks.

-- PMM
