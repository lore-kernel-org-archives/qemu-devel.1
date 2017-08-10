Received: from eggs.gnu.org ([2001:4830:134:3::10]:54416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dfrY5-00063c-9S
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 13:47:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dfrY4-0000Fo-2I
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 13:47:09 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:37022)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dfrY3-0000DG-Qw
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 13:47:07 -0400
Received: by mail-wr0-x22e.google.com with SMTP id 33so5601158wrz.4
	for <qemu-devel@nongnu.org>; Thu, 10 Aug 2017 10:47:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1502380961-16398-1-git-send-email-groug@kaod.org>
References: <1502380961-16398-1-git-send-email-groug@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Aug 2017 18:46:46 +0100
Message-ID: <CAFEAcA8WE21t_SW9JhS=niuMJsei+NENdyUq4MeYdcCMHY=MwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL] 9pfs fixes for 2.10 20170810
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

On 10 August 2017 at 17:02, Greg Kurz <groug@kaod.org> wrote:
> The following changes since commit b38df311c174c98ef8cce7dec9f46603b083018e:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-2.10-20170809' into staging (2017-08-10 11:12:36 +0100)
>
> are available in the git repository at:
>
>   https://github.com/gkurz/qemu.git tags/for-upstream
>
> for you to fetch changes up to 4751fd5328dfcd4fe2f9055728a72a0e3ae56512:
>
>   9pfs: local: fix fchmodat_nofollow() limitations (2017-08-10 14:36:11 +0200)
>
> ----------------------------------------------------------------
> Just a single fix for an annoying regression introduced in 2.9 when fixing
> CVE-2016-9602.
>
> ----------------------------------------------------------------
> Greg Kurz (1):
>       9pfs: local: fix fchmodat_nofollow() limitations
>
>  hw/9pfs/9p-local.c | 42 +++++++++++++++++++++++++++++++++++-------
>  hw/9pfs/9p-util.h  | 24 +++++++++++++++---------
>  2 files changed, 50 insertions(+), 16 deletions(-)
> --

Applied, thanks.

-- PMM
