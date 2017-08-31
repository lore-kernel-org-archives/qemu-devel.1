Received: from eggs.gnu.org ([2001:4830:134:3::10]:36954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dnMbf-00068v-HQ
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 06:21:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dnMbe-0008HE-H1
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 06:21:51 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:34102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dnMbe-0008Gj-A8
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 06:21:50 -0400
Received: by mail-wr0-x22d.google.com with SMTP id z91so880207wrc.1
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 03:21:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Aug 2017 11:21:28 +0100
Message-ID: <CAFEAcA9_qAYnvfTSr9dFCSLvi=whtUijGmqjHFyehCZv3azfGg@mail.gmail.com>
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

I would suggest also commit 1201d308519f1e915866d7583d5136d03cc1d384
("slirp: fix clearing ifq_so from pending packets") which I've
just applied to master, as it fixes a use-after-free if the
guest sends suitable bogus packets and the VM is using slirp
networking.

thanks
-- PMM
