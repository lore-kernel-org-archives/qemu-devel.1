Received: from eggs.gnu.org ([2001:4830:134:3::10]:35207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7Fhc-0007Nh-8V
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 04:06:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7FhX-0004w4-GG
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 04:06:44 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:40559)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g7FhX-0004vf-0y
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 04:06:39 -0400
Received: by mail-ot1-x332.google.com with SMTP id w67so1011938ota.7
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 01:06:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181001171901.11004-1-kwolf@redhat.com>
References: <20181001171901.11004-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Oct 2018 09:06:17 +0100
Message-ID: <CAFEAcA_4JYnEP9P01zSCX+4i-aqJpCfEDjN1GEkO6wNDp7D7PQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/23] Block layer patches
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

On 1 October 2018 at 18:18, Kevin Wolf <kwolf@redhat.com> wrote:
> The following changes since commit 07f426c35eddd79388a23d11cb278600d7e3831d:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180926' into staging (2018-09-28 18:56:09 +0100)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to dd353157942a59c21da07da5ac8749a871f7c3ed:
>
>   tests/test-bdrv-drain: Fix too late qemu_event_reset() (2018-10-01 19:13:55 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - qcow2 cache option default changes (Linux: 32 MB maximum, limited by
>   whatever cache size can be made use of with the specific image;
>   default cache-clean-interval of 10 minutes)
> - reopen: Allow specifying unchanged child node references, and changing
>   a few generic options (discard, detect-zeroes)
> - Fix werror/rerror defaults for -device drive=<node-name>
> - Test case fixes

I still got a hang on OSX on test-bdrv-drain, but I've applied
this anyway, since hopefully it fixes the other intermittent
failure and may reduce the likelihood with the test-bdrv-drain.

thanks
-- PMM
