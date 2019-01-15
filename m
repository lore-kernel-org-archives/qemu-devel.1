Received: from eggs.gnu.org ([209.51.188.92]:55550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gjSaF-00023v-LE
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 12:33:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gjSRR-000412-0s
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 12:23:57 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:38646)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gjSRQ-00040K-2D
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 12:23:56 -0500
Received: by mail-ot1-x331.google.com with SMTP id e12so3212338otl.5
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 09:23:55 -0800 (PST)
MIME-Version: 1.0
References: <20190114162605.5330-1-eblake@redhat.com>
In-Reply-To: <20190114162605.5330-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Jan 2019 17:23:43 +0000
Message-ID: <CAFEAcA8hR1aurEfv4qtx1LVV1W-F=NXHeRRjMH8BHJntgqFVsQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/20] NBD patches through 2019-01-14
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

On Mon, 14 Jan 2019 at 16:28, Eric Blake <eblake@redhat.com> wrote:
>
> The following changes since commit 7260438b7056469610ee166f7abe9ff8a26b8b=
16:
>
>   Merge remote-tracking branch 'remotes/palmer/tags/riscv-for-master-3.2-=
part2' into staging (2019-01-14 11:41:43 +0000)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2019-01-14
>
> for you to fetch changes up to 636192c4b6052820ea126a5287c58a8f53f3c84f:
>
>   qemu-nbd: Add --bitmap=3DNAME option (2019-01-14 10:09:46 -0600)
>
> ----------------------------------------------------------------
> nbd patches for 2019-01-14
>
> Promote bitmap/NBD interfaces to stable for use in incremental
> backups. Add 'qemu-nbd --bitmap'.
>
> - John Snow: 0/11 bitmaps: remove x- prefix from QMP api
> - Philippe Mathieu-Daud=C3=A9: qemu-nbd: Rename 'exp' variable clashing w=
ith math::exp() symbol
> - Eric Blake: 0/8 Promote x-nbd-server-add-bitmap to stable
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
