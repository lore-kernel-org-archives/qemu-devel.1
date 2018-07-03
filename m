Received: from eggs.gnu.org ([2001:4830:134:3::10]:52018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1faIsT-0001Hz-As
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:49:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1faIsS-00084B-Cq
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:49:45 -0400
Received: from mail-oi0-x22f.google.com ([2607:f8b0:4003:c06::22f]:44741)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1faIsS-00083z-69
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:49:44 -0400
Received: by mail-oi0-x22f.google.com with SMTP id s198-v6so2822563oih.11
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 03:49:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180703013730.55375-1-eblake@redhat.com>
References: <20180703013730.55375-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Jul 2018 11:49:22 +0100
Message-ID: <CAFEAcA-T7kyoONH+WeQBDbvRBeDgT2MPQ0mn_f3N6O+LeYkBmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/6] NBD patches for 2018-07-02 (3.0 soft
 freeze)
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

On 3 July 2018 at 02:37, Eric Blake <eblake@redhat.com> wrote:
> The following changes since commit ab08440a4ee09032d1a9cb22fdcab23bc7e1c656:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180702' into staging (2018-07-02 17:57:46 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2018-07-02
>
> for you to fetch changes up to a1532a225a183c9fa60b9c1e8ac8a00c7771f64d:
>
>   iotests: New test 223 for exporting dirty bitmap over NBD (2018-07-02 19:50:37 -0500)
>
> Discussed but not included here: we need to ensure that during a
> backup sync:none job, writes must NOT be permitted to the fleecing
> node's backing file as long as reads are being served from the same
> area. Hopefully we can fix this via the existing job, instead of
> having to add a new filter node.
>
> ----------------------------------------------------------------
> nbd patches for 2018-07-02
>
> Bug fixes and iotest exposure of fleecing via NBD (serving a
> read-only point-in-time view via blockdev-backup sync:none,
> as well as serving dirty bitmaps over NBD), including a new
> x-dirty-bitmap parameter when opening NBD clients as the
> counterpart to x-nbd-server-add-bitmap. Also a random fix
> for iscsi block_status spotted by Coverity that missed other
> miscellaneous trees.
>
> - Eric Blake: nbd/server: Fix dirty bitmap logic regression
> - Eric Blake: iscsi: Avoid potential for get_status overflow
> - John Snow/Vladimir Sementsov-Ogievskiy: 0/2 block: formalize and test fleecing
> - Eric Blake: 0/2 test NBD bitmap export
>

Applied, thanks.

-- PMM
