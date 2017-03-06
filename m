Received: from eggs.gnu.org ([2001:4830:134:3::10]:57459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cl001-0006z5-77
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 16:16:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ckzzx-0002Oc-NM
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 16:16:57 -0500
Received: from chuckie.co.uk ([82.165.15.123]:34909
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1ckzzx-0002M0-G6
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 16:16:53 -0500
References: <1488822850-23070-1-git-send-email-groug@kaod.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <13a61004-ee6e-cece-7099-b32bc475c897@ilande.co.uk>
Date: Mon, 6 Mar 2017 21:16:25 +0000
MIME-Version: 1.0
In-Reply-To: <1488822850-23070-1-git-send-email-groug@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 0/6] 9pfs fixes for 2.9 2017-03-06
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

On 06/03/17 17:54, Greg Kurz wrote:

> The following changes since commit 56b51708e9e22809d2a78f38d0ac84bb3f3fca92:
> 
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-2.9-20170306' into staging (2017-03-06 13:06:30 +0000)
> 
> are available in the git repository at:
> 
>   https://github.com/gkurz/qemu.git tags/fixes-for-2.9
> 
> for you to fetch changes up to b003fc0d8aa5e7060dbf7e5862b8013c73857c7f:
> 
>   9pfs: fix vulnerability in openat_dir() and local_unlinkat_common() (2017-03-06 17:34:01 +0100)
> 
> ----------------------------------------------------------------
> Fixes issues that got merged with the latest pull request:
> - missing O_NOFOLLOW flag for CVE-2016-960
> - build break with older glibc that don't have O_PATH and AT_EMPTY_PATH
> - various bugs reported by Coverity
> 
> ----------------------------------------------------------------
> Greg Kurz (6):
>       9pfs: fix bogus fd check in local_remove()
>       9pfs: fix fd leak in local_opendir()
>       9pfs: fail local_statfs() earlier
>       9pfs: don't use AT_EMPTY_PATH in local_set_cred_passthrough()
>       9pfs: fix O_PATH build break with older glibc versions
>       9pfs: fix vulnerability in openat_dir() and local_unlinkat_common()
> 
>  hw/9pfs/9p-local.c | 10 +++++++---
>  hw/9pfs/9p-util.h  |  8 +++++++-
>  2 files changed, 14 insertions(+), 4 deletions(-)

Greg - just to confirm that I've done a local checkout of the above tag
and it fixes the build for me. Thanks for taking the time to sort this
one out even though it's an issue caused by an older OS.


ATB,

Mark.
