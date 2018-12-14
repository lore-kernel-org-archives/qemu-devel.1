Received: from eggs.gnu.org ([2001:4830:134:3::10]:37747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXssp-0003YL-DW
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 14:12:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXssn-0008Pr-Sy
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 14:12:23 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b]:40250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXssl-0008Oc-Gg
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 14:12:19 -0500
Received: by mail-oi1-x22b.google.com with SMTP id t204so5412581oie.7
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 11:12:19 -0800 (PST)
MIME-Version: 1.0
References: <20181213090343.1137475-1-groug@kaod.org>
In-Reply-To: <20181213090343.1137475-1-groug@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Dec 2018 19:12:07 +0000
Message-ID: <CAFEAcA8uMP7LmyUeqzGfOUiP16cu7hrDaYt1jHo94cDOpE0qPQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] 9p patches 2018-12-13
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Thu, 13 Dec 2018 at 09:03, Greg Kurz <groug@kaod.org> wrote:
>
> The following changes since commit bb9bf94b3e8926553290bc9a7cb84315af422086:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-request' into staging (2018-12-11 19:18:58 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/gkurz/qemu.git tags/for-upstream
>
> for you to fetch changes up to 93aee84f575d46699f49af3c96194012527e0b22:
>
>   9p: remove support for the "handle" backend (2018-12-12 14:18:10 +0100)
>
> ----------------------------------------------------------------
> Most notable change in this PR is the full removal of the "handle" fsdev
> backend.
>
> ----------------------------------------------------------------
> Greg Kurz (3):
>       9p: use g_new(T, n) instead of g_malloc(sizeof(T) * n)
>       xen/9pfs: use g_new(T, n) instead of g_malloc(sizeof(T) * n)
>       9p: remove support for the "handle" backend

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
