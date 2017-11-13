Received: from eggs.gnu.org ([2001:4830:134:3::10]:42464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eEFBi-0005CS-DK
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 08:54:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eEFBd-00010I-Qy
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 08:54:10 -0500
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:35193)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eEFBd-0000yu-Ip
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 08:54:05 -0500
Received: by mail-wm0-x229.google.com with SMTP id y80so14874374wmd.0
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 05:54:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171109165939.23154-1-eblake@redhat.com>
References: <20171109165939.23154-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Nov 2017 13:53:43 +0000
Message-ID: <CAFEAcA8HpVcKpXvVaZcTgGasFyNEn+G3e-8DruBaHKS_8MTO_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/8] NBD patches for 2.11-rc1
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

On 9 November 2017 at 16:59, Eric Blake <eblake@redhat.com> wrote:
> The following changes since commit b0fbe46ad82982b289a44ee2495b59b0bad8a842:
>
>   Update version for v2.11.0-rc0 release (2017-11-07 16:05:28 +0000)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2017-11-09
>
> for you to fetch changes up to ef8c887ee01a4e4c8c5c28c86ea5b45162c51bcd:
>
>   nbd/server: Fix structured read of length 0 (2017-11-09 10:25:11 -0600)
>
> ----------------------------------------------------------------
> nbd patches for 2017-11-09
>
> - Vladimir Sementsov-Ogievskiy: nbd/server: fix nbd_negotiate_handle_info
> - Eric Blake: 0/7 various NBD fixes for 2.11
>
> ----------------------------------------------------------------
> Eric Blake (7):
>       nbd-client: Fix error message typos
>       nbd-client: Refuse read-only client with BDRV_O_RDWR
>       nbd/client: Nicer trace of structured reply
>       nbd: Fix struct name for structured reads
>       nbd-client: Short-circuit 0-length operations
>       nbd-client: Stricter enforcing of structured reply spec
>       nbd/server: Fix structured read of length 0
>
> Vladimir Sementsov-Ogievskiy (1):
>       nbd/server: fix nbd_negotiate_handle_info
>

Applied, thanks.

-- PMM
