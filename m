Received: from eggs.gnu.org ([2001:4830:134:3::10]:33984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjk2n-0002Rj-67
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 05:02:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjk2m-0003Xk-DK
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 05:02:37 -0500
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:35829)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjk2m-0003XZ-7F
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 05:02:36 -0500
Received: by mail-wm0-x232.google.com with SMTP id v186so11283901wmd.0
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 02:02:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170302034613.21609-1-jcody@redhat.com>
References: <20170302034613.21609-1-jcody@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Mar 2017 10:02:14 +0000
Message-ID: <CAFEAcA-Rf31aKpY__w+K3kL2GzspA9A+LB3V_jPLz-mePztxgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL v3 0/5] Block patches for 2.9
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

On 2 March 2017 at 03:46, Jeff Cody <jcody@redhat.com> wrote:
> The following changes since commit c8c0a1a784cdf70ecea50e93213137c6c89337a7:
>
>   Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' into staging (2017-02-28 13:41:03 +0000)
>
> are available in the git repository at:
>
>   git@github.com:codyprime/qemu-kvm-jtc.git tags/block-pull-request
>
> for you to fetch changes up to 0a55679b4a5061f4d74bdb1a0e81611ba3390b00:
>
>   block/rbd: add support for 'mon_host', 'auth_supported' via QAPI (2017-03-01 22:39:25 -0500)
>
> ----------------------------------------------------------------
> RBD blockdev-add patches for 2.9
> ----------------------------------------------------------------
>
> Jeff Cody (5):
>   block/rbd: don't copy strings in qemu_rbd_next_tok()
>   block/rbd: add all the currently supported runtime_opts
>   block/rbd: parse all options via bdrv_parse_filename
>   block/rbd: add blockdev-add support
>   block/rbd: add support for 'mon_host', 'auth_supported' via QAPI
>
>  block/rbd.c          | 569 ++++++++++++++++++++++++++++++++++-----------------
>  qapi/block-core.json |  62 +++++-
>  2 files changed, 443 insertions(+), 188 deletions(-)

Applied, thanks.

-- PMM
