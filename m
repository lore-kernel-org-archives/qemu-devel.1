Received: from eggs.gnu.org ([2001:4830:134:3::10]:40884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTrae-0006DP-BM
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 12:28:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTrad-0003iW-Ar
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 12:28:44 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:39580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fTrad-0003iC-4q
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 12:28:43 -0400
Received: by mail-ot0-x243.google.com with SMTP id l15-v6so11619872oth.6
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 09:28:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180615142108.27814-1-kwolf@redhat.com>
References: <20180615142108.27814-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 17:28:22 +0100
Message-ID: <CAFEAcA82PF0K0kzjcmWns44d5XcF2bPWcnudr-f_6S_BCNo38w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/26] Block layer patches
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

On 15 June 2018 at 15:20, Kevin Wolf <kwolf@redhat.com> wrote:
> The following changes since commit 91fe7a376ad46e3cc5e82d418aad22173c948a3c:
>
>   Merge remote-tracking branch 'remotes/jasowang/tags/net-pull-request' into staging (2018-06-15 11:41:44 +0100)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 6266e900b8083945cb766b45c124fb3c42932cb3:
>
>   block: Remove dead deprecation warning code (2018-06-15 14:49:44 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - Fix options that work only with -drive or -blockdev, but not with
>   both, because of QDict type confusion
> - rbd: Add options 'auth-client-required' and 'key-secret'
> - Remove deprecated -drive options serial/addr/cyls/heads/secs/trans
> - rbd, iscsi: Remove deprecated 'filename' option
> - Fix 'qemu-img map' crash with unaligned image size
> - Improve QMP documentation for jobs
>

Applied, thanks.

-- PMM
