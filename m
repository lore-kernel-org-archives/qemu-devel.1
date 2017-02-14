Received: from eggs.gnu.org ([2001:4830:134:3::10]:47440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cdZn1-0007ST-A3
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 04:52:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cdZmz-0000Cy-TW
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 04:52:51 -0500
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:37487)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cdZmz-0000AY-N7
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 04:52:49 -0500
Received: by mail-wm0-x22e.google.com with SMTP id v77so12805542wmv.0
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 01:52:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170213175033.7314-1-dgilbert@redhat.com>
References: <20170213175033.7314-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Feb 2017 09:52:26 +0000
Message-ID: <CAFEAcA9tX-vFscg2p7ASVaSpO2y-x7XnyLMS4wtMN0ZyNjqPLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/14] migration queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Pavel Butsykin <pbutsykin@virtuozzo.com>, amit@kernel.org, zhanghailiang <zhang.zhanghailiang@huawei.com>, Ashijeet Acharya <ashijeetacharya@gmail.com>, Juan Quintela <quintela@redhat.com>

On 13 February 2017 at 17:50, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit df96bfab49dab2d0373e49b51bbb51ce72e1601e:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/pull-vga-20170213-1' into staging (2017-02-13 10:54:49 +0000)
>
> are available in the git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-migration-20170213a
>
> for you to fetch changes up to 982b78c5e37864c06fd7b5f156d80bf02628a855:
>
>   virtio/migration: Migrate virtio-net to VMState (2017-02-13 17:27:14 +0000)
>
> ----------------------------------------------------------------
> Migration
>
>   Amit: migration: remove myself as maintainer
>         MAINTAINERS: update my email address
>   Ashijeet: migrate: Introduce zero RAM checks to skip RAM migration
>   Pavel: Postcopy release RAM
>   Halil: consolidate VMStateField.start
>   Hailiang: COLO: fix setting checkpoint-delay not working properly
>          COLO: Shutdown related socket fd while do failover
>          COLO: Don't process failover request while loading VM's state
>   Me:
>      migration: Add VMSTATE_UNUSED_VARRAY_UINT32
>      migration: Add VMSTATE_WITH_TMP
>      tests/migration: Add test for VMSTATE_WITH_TMP
>      virtio-net VMState conversion and new VMSTATE macros
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
