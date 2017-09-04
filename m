Received: from eggs.gnu.org ([2001:4830:134:3::10]:43268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dovGS-0006Uk-Jy
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 13:34:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dovGN-0008H2-Nm
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 13:34:24 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:37571)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dovGN-0008GR-HU
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 13:34:19 -0400
Received: by mail-wr0-x22b.google.com with SMTP id n33so3289127wrn.4
	for <qemu-devel@nongnu.org>; Mon, 04 Sep 2017 10:34:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Sep 2017 18:33:57 +0100
Message-ID: <CAFEAcA_UD1fCmVTnL8TN5A9OfUw8fSxSxDBnhyLyuL_CEHfP2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 00/79] Patch Round-up for stable 2.9.1,
 freeze on 2017-09-04
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>

On 29 August 2017 at 01:13, Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> Hi everyone,
>
> The following new patches are queued for QEMU stable v2.9.1:
>
>   https://github.com/mdroth/qemu/commits/stable-2.9-staging
>
> The release is planned for 2017-09-07:
>
>   http://wiki.qemu.org/Planning/2.9
>
> Please respond here or CC qemu-stable@nongnu.org on any patches you
> think should be included in the release.
>
> Testing/feedback is greatly appreciated.

If it's not too late for this stable release, you might consider
3e4d91b94ce400326fae0850578d9e9f30a71adb
(which just hit master).

This is a pretty long-standing bug, so it's not the end of
the world if it doesn't get in, but it does fix a bug which
was causing real-world FreeBSD AArch64 guest binaries to segfault:
https://bugs.launchpad.net/qemu/+bug/1711316
https://bugs.launchpad.net/qemu/+bug/1713066

thanks
-- PMM
