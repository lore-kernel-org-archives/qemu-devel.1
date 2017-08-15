Received: from eggs.gnu.org ([2001:4830:134:3::10]:59968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dhg1q-00064L-FH
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 13:53:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dhg1p-0004fz-LJ
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 13:53:22 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:38641)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dhg1p-0004fH-ED
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 13:53:21 -0400
Received: by mail-wr0-x230.google.com with SMTP id m57so5342267wrm.5
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 10:53:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170815150907.21495-1-eblake@redhat.com>
References: <20170815150907.21495-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Aug 2017 18:52:59 +0100
Message-ID: <CAFEAcA-PtQE=9j91R6AASHFN5b4onH8hHEdfvFJ-z-C4ecBPQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL for 2.10-rc3 0/7] NBD changes for 2.10-rc3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 15 August 2017 at 16:09, Eric Blake <eblake@redhat.com> wrote:
> The following changes since commit 47025a0193f1f910300adfa443305ccf8482ef87:
>
>   qxl: call qemu_spice_display_init_common for secondary devices (2017-08-15 15:04:51 +0100)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2017-08-15
>
> for you to fetch changes up to 72b6ffc76653214b69a94a7b1643ff80df134486:
>
>   nbd-client: Fix regression when server sends garbage (2017-08-15 10:03:28 -0500)
>
> ----------------------------------------------------------------
> nbd patches for 2017-08-15
>
> - Eric Blake: nbd: Fix trace message for disconnect
> - Stefan Hajnoczi: qemu-iotests: step clock after each test iteration
> - Fam Zheng: 0/4 block: Fix non-shared storage migration
> - Eric Blake: nbd-client: Fix regression when server sends garbage
>
> ----------------------------------------------------------------
> Eric Blake (2):
>       nbd: Fix trace message for disconnect
>       nbd-client: Fix regression when server sends garbage
>
> Fam Zheng (3):
>       stubs: Add vm state change handler stubs
>       block-backend: Defer shared_perm tightening migration completion
>       iotests: Add non-shared storage migration case 192
>
> Kevin Wolf (1):
>       nbd: Fix order of bdrv_set_perm and bdrv_invalidate_cache
>
> Stefan Hajnoczi (1):
>       qemu-iotests: step clock after each test iteration

Applied, thanks.

-- PMM
