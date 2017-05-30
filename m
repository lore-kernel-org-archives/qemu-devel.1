Received: from eggs.gnu.org ([2001:4830:134:3::10]:53331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFi7o-0002vl-QN
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:27:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFi7n-0007xU-Rr
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:27:56 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:38064)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dFi7n-0007vf-L9
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:27:55 -0400
Received: by mail-wm0-x22e.google.com with SMTP id e127so102287810wmg.1
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 07:27:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1495739423-32326-5-git-send-email-joserz@linux.vnet.ibm.com>
References: <1495739423-32326-1-git-send-email-joserz@linux.vnet.ibm.com>
	<1495739423-32326-5-git-send-email-joserz@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2017 15:27:33 +0100
Message-ID: <CAFEAcA8ue3V+XFdRZ2tjd5EzQjD+RVbL62tf=zAWXxznOTMxwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH Risu v3 4/4] build: Add support to PowerPC
 BE and remove ARCH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

On 25 May 2017 at 20:10, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com> wrote:
> Essentialy the code for PowerPC BE and LE are the same, so this patch
> renames all *ppc64le.* files to *ppc64.* and reflects such in the
> Makefile.
>
> Due to the fact that all supported archs are covered by guess_arch
> function, this also drops the ARCH parameter from the Makefile.

This change isn't right -- the point is that guess_arch might
(in theory) guess wrong, so the user can override it.

You forgot to delete the comment about "powerpc64-linux-gnu doesn't
work" from the build-all-archs script.

The rest is fine though, so I've made those minor tweaks and
applied the series to risu master.

PS: for patches like this there is a neat git option --find-renames
which you can use when you're generating the patch email to
create smaller and easier to read patches.

thanks
-- PMM
