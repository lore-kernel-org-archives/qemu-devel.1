Received: from eggs.gnu.org ([2001:4830:134:3::10]:44298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fZDWh-000534-G0
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 06:54:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fZDWg-0004xV-KZ
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 06:54:47 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:39413)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fZDWg-0004wh-ER
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 06:54:46 -0400
Received: by mail-ot0-x243.google.com with SMTP id l15-v6so12584192oth.6
	for <qemu-devel@nongnu.org>; Sat, 30 Jun 2018 03:54:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180629140959.6690-1-kwolf@redhat.com>
References: <20180629140959.6690-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 30 Jun 2018 11:54:24 +0100
Message-ID: <CAFEAcA9iq7LJbRKNf+rRcmSYRvJC=8bYoPoT8fvfbKuyxxd3Pw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/29] Block layer patches
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

On 29 June 2018 at 15:09, Kevin Wolf <kwolf@redhat.com> wrote:
> The following changes since commit 609ef9f451759151d0bfe7c3843410ab94d68f18:
>
>   Merge remote-tracking branch 'remotes/berrange/tags/qio-next-pull-request' into staging (2018-06-28 17:53:31 +0100)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 583c99d39368526dfb57a715b04a6ceea27dbe1e:
>
>   block: Remove unused sector-based vectored I/O (2018-06-29 14:20:56 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - Make truncate operations asynchronous (so that preallocation in
>   blockdev-create doesn't block the main loop any more)
> - usb-storage: Add rerror/werror properties
> - nvme: Add num_queues property
> - qemu-img convert: Copy offloading fixes (including data corruption fix)
> - qcow2: Fix cluster leak on temporary write error
> - Use byte-based functions instead of bdrv_co_readv/writev()
> - Various small fixes and cleanups
>

Applied, thanks.

-- PMM
