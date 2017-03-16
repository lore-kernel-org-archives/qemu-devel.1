Received: from eggs.gnu.org ([2001:4830:134:3::10]:51783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1coXNt-0005OT-Cf
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 11:32:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1coXNs-0004VF-ID
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 11:32:13 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:35291)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1coXNs-0004Uq-A7
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 11:32:12 -0400
Received: by mail-wr0-x232.google.com with SMTP id g10so34590683wrg.2
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 08:32:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170316070427.17120-1-stefanha@redhat.com>
References: <20170316070427.17120-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Mar 2017 15:31:50 +0000
Message-ID: <CAFEAcA86DYrQ8XU_+xm_qshYgjnAQyAtRDo7XEnTzxSdTDBANQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/3] Tracing patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 16 March 2017 at 07:04, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The following changes since commit 1883ff34b540daacae948f493b0ba525edf5f642:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2017-03-15 18:44:05 +0000)
>
> are available in the git repository at:
>
>   git://github.com/stefanha/qemu.git tags/tracing-pull-request
>
> for you to fetch changes up to 8755b4afbdcf1c274cab7545a9f76d3d6c7f5c29:
>
>   trace: ensure $(tracetool-y) is defined in top level makefile (2017-03-16 11:51:26 +0800)
>
> ----------------------------------------------------------------
> Pull request
>
> Tracing makefile fixes for QEMU 2.9.
>
> ----------------------------------------------------------------
>
> Daniel P. Berrange (3):
>   makefile: merge GENERATED_HEADERS & GENERATED_SOURCES variables
>   makefile: generate trace-events-all upfront
>   trace: ensure $(tracetool-y) is defined in top level makefile
>
>  Makefile                   | 42 ++++++++++++++++++++++--------------------
>  Makefile.target            |  6 +++---
>  target/s390x/Makefile.objs |  2 +-
>  tests/Makefile.include     |  2 +-
>  trace/Makefile.objs        |  8 --------
>  5 files changed, 27 insertions(+), 33 deletions(-)

Applied, thanks.

-- PMM
