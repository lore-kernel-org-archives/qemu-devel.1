Received: from eggs.gnu.org ([2001:4830:134:3::10]:52800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dkalU-00074P-Th
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 14:52:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dkalT-0004oy-Uv
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 14:52:32 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:34686)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dkalT-0004oL-NM
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 14:52:31 -0400
Received: by mail-wr0-x22c.google.com with SMTP id p14so3232720wrg.1
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 11:52:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170823163349.11663-1-eblake@redhat.com>
References: <20170823163349.11663-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 23 Aug 2017 19:52:09 +0100
Message-ID: <CAFEAcA-Jj=vqac25VRBrB4ECS01kRox5OQTtvQ75U0fGiKiD+Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/6] NBD pull request for 2.10-rc4
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

On 23 August 2017 at 17:33, Eric Blake <eblake@redhat.com> wrote:
> The following changes since commit 3da2bd8c4a80178fb115c70b858cecbfb1eb1067:
>
>   numa: Move numa_legacy_auto_assign_ram to pc-i440fx-2.9 (2017-08-23 13:53:15 +0100)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2017-08-23
>
> for you to fetch changes up to 40f4a21895b5a7eae4011593837069f63460d983:
>
>   nbd-client: avoid spurious qio_channel_yield() re-entry (2017-08-23 11:22:15 -0500)
>
> ----------------------------------------------------------------
> nbd patches for 2017-08-23
>
> - Fam Zheng: 0/4 block: Fix non-shared storage migration
> - Stefan Hajnoczi: qemu-iotests: add 194 non-shared storage migration test
> - Stefan Hajnoczi: nbd-client: avoid spurious qio_channel_yield() re-entry
>
> ----------------------------------------------------------------
> Fam Zheng (3):
>       block-backend: Refactor inactivate check
>       block-backend: Allow more "can inactivate" cases
>       mirror: Mark target BB as "force allow inactivate"
>
> Stefan Hajnoczi (3):
>       block: Update open_flags after ->inactivate() callback
>       qemu-iotests: add 194 non-shared storage migration test
>       nbd-client: avoid spurious qio_channel_yield() re-entry

Applied, thanks.

-- PMM
