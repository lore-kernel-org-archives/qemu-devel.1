Received: from eggs.gnu.org ([2001:4830:134:3::10]:45770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eRgKW-0006dh-KX
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 10:31:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eRgKP-0003lG-VU
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 10:30:48 -0500
Received: from mail-oi0-x22c.google.com ([2607:f8b0:4003:c06::22c]:36187)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eRgKP-0003kQ-OF
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 10:30:41 -0500
Received: by mail-oi0-x22c.google.com with SMTP id j14so3666479oih.3
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 07:30:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171220131939.27543-1-kwolf@redhat.com>
References: <20171220131939.27543-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Dec 2017 15:30:20 +0000
Message-ID: <CAFEAcA99EjT-_7XtLAqV9i=k1o=LT-vrT-6tkZmG_M1nouXp0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/14] Block layer patches
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

On 20 December 2017 at 13:19, Kevin Wolf <kwolf@redhat.com> wrote:
> The following changes since commit af352675efb7e92a1f5f6461a042a12015ab3d12:
>
>   Merge remote-tracking branch 'remotes/aurel/tags/pull-target-sh4-20171218' into staging (2017-12-19 19:11:11 +0000)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to b4d526c87b26aff6d8b353951aa175a1236ad887:
>
>   nvme: Add tracing (2017-12-20 11:05:49 +0100)
>
> ----------------------------------------------------------------
> Block layer patches

Hi; this has a merge conflict in hw/block/nvme.c where both
sets of changes are changing the way that the function
handles errors, and I'm not sure which is correct. Can you
resolve and resend, please?

thanks
-- PMM
