Received: from eggs.gnu.org ([2001:4830:134:3::10]:35523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP5ro-0007Qo-CZ
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 08:15:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP5rn-0008Qt-Lv
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 08:15:00 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:45634)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gP5rn-0008Qc-HJ
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 08:14:59 -0500
Received: by mail-ot1-x32f.google.com with SMTP id 32so1566379ota.12
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 05:14:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181120120326.30879-1-groug@kaod.org>
References: <20181120120326.30879-1-groug@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Nov 2018 13:14:38 +0000
Message-ID: <CAFEAcA-wU0TB2=kb_WHp=gWpZ3edEQj4umeqO-ExKnN4oM9kvg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] 9p fixes for v3.1.0-rc2
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

On 20 November 2018 at 12:03, Greg Kurz <groug@kaod.org> wrote:
> The following changes since commit 3c035a41dca808f096a128fe2b62d849fe638a25:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2018-11-20' into staging (2018-11-20 10:56:57 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/gkurz/qemu.git tags/for-upstream
>
> for you to fetch changes up to 5b3c77aa581ebb215125c84b0742119483571e55:
>
>   9p: take write lock on fid path updates (CVE-2018-19364) (2018-11-20 13:00:35 +0100)
>
> ----------------------------------------------------------------
> Fixes yet another use-after-free issue that could be triggered by a
> misbehaving guest. This is a follow-up to commit:
>
> commit 5b76ef50f62079a2389ba28cacaf6cce68b1a0ed
> Author: Greg Kurz <groug@kaod.org>
> Date:   Wed Nov 7 01:00:04 2018 +0100
>
>     9p: write lock path in v9fs_co_open2()
>
> ----------------------------------------------------------------
> Greg Kurz (1):
>       9p: take write lock on fid path updates (CVE-2018-19364)
>
Applied, thanks.

-- PMM
