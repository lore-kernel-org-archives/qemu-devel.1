Received: from eggs.gnu.org ([2001:4830:134:3::10]:48039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cu0Y6-0001Cj-23
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 13:41:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cu0Y4-0005rV-TT
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 13:41:22 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:32887)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cu0Y4-0005rJ-M6
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 13:41:20 -0400
Received: by mail-wr0-x235.google.com with SMTP id w43so111621061wrb.0
	for <qemu-devel@nongnu.org>; Fri, 31 Mar 2017 10:41:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170331170018.11643.80499.stgit@gimli.home>
References: <20170331170018.11643.80499.stgit@gimli.home>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 Mar 2017 18:40:58 +0100
Message-ID: <CAFEAcA8xFEPE+bBM0ZBgq6oK9uU=r+GKMaO5W9CSqMw2CG5pgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/1] VFIO fixes 2017-03-31
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 31 March 2017 at 18:01, Alex Williamson <alex.williamson@redhat.com> wrote:
> The following changes since commit 37c4a85cd256a51c5f58ee7e531f25f0e89b2c87:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-hmp-20170331' into
> staging (2017-03-31 12:43:27 +0100)
>
> are available in the git repository at:
>
>
>   git://github.com/awilliam/qemu-vfio.git tags/vfio-updates-20170331.0
>
> for you to fetch changes up to 93587e3af3a259deac89c12863d93653d69d22b8:
>
>   Revert "vfio/pci-quirks.c: Disable stolen memory for igd VFIO" (2017-03-31
> 10:04:41 -0600)
>
> ----------------------------------------------------------------
> VFIO fixes 2017-03-31
>
>  - We can't disable stolen memory for UPT mode, it breaks Windows
>    drivers on Gen9+ IGD (Xiong Zhang)
>
> ----------------------------------------------------------------
> Xiong Zhang (1):
>       Revert "vfio/pci-quirks.c: Disable stolen memory for igd VFIO"

Applied, thanks.

-- PMM
