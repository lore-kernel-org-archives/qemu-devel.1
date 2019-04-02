Received: from eggs.gnu.org ([209.51.188.92]:48647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hBJpV-0007OX-E4
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:51:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hBJpU-00053b-5j
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:51:57 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:40055)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hBJpT-00053I-Td
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:51:56 -0400
Received: by mail-oi1-x242.google.com with SMTP id 3so10504155oir.7
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 06:51:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190402124907.24421-1-kwolf@redhat.com>
In-Reply-To: <20190402124907.24421-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Apr 2019 13:51:42 +0000
Message-ID: <CAFEAcA9Zd7wx9U0jcXjvDKwC8gyQW773YdLJ5hBtgBHoQ7AxFQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/9] Block layer patches
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

On Tue, 2 Apr 2019 at 19:49, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit d61d1a1fb2f1db6c54651844a28389c523f3f8c7:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/fixes-20190402-pull-request' into staging (2019-04-02 08:18:24 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to f18957b854495129f2e8d6838df3bf47d1c1479c:
>
>   tests/qemu-iotests/235: Allow fallback to tcg (2019-04-02 12:04:56 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - file-posix: Ignore unlock failure instead of crashing
> - gluster: Limit the transfer size to 512 MiB
> - stream: Fix backing chain freezing
> - qemu-img: Enable BDRV_REQ_MAY_UNMAP for zero writes in convert
> - iotests fixes

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
