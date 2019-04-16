Received: from eggs.gnu.org ([209.51.188.92]:41791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGQAC-0004Cs-Ck
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 11:38:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGQAB-0000YJ-C7
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 11:38:24 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:43118)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hGQAA-0000Ur-Rm
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 11:38:23 -0400
Received: by mail-oi1-x22f.google.com with SMTP id t81so17331678oig.10
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 08:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190416142802.11990-1-kwolf@redhat.com>
In-Reply-To: <20190416142802.11990-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Apr 2019 16:38:07 +0100
Message-ID: <CAFEAcA_=qyZZLj2sVacnCP0pEpkzSVwsA5YKk6VhB+0Z4HvPvg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] qcow2: Fix potential corruption with
 external data file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, 16 Apr 2019 at 15:28, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit a9b305ba291fb74f7ff732b3d7b8f4c812431ddf:
>
>   socket: allow wait=false for client socket (2019-04-16 10:40:43 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 93e32b3e2012a668e4da1c2566d2935c24060435:
>
>   qcow2: Fix preallocation bdrv_pwrite to wrong file (2019-04-16 16:23:24 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - qcow2: Fix potential corruption for preallocated resize with external data file
>
> ----------------------------------------------------------------
> Kevin Wolf (1):
>       qcow2: Fix preallocation bdrv_pwrite to wrong file

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
