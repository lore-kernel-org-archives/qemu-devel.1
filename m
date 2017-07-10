Received: from eggs.gnu.org ([2001:4830:134:3::10]:42417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dUWgW-0007rR-7N
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 07:17:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dUWgV-00006Z-3Q
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 07:17:00 -0400
Date: Mon, 10 Jul 2017 13:16:49 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170710111649.GB5772@noname.redhat.com>
References: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
	<CAFEAcA_=YZFScbOU_nBLpzGuupo6EKNcSZhJGDZQZeTu7KVq4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_=YZFScbOU_nBLpzGuupo6EKNcSZhJGDZQZeTu7KVq4A@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 000/100] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

Am 10.07.2017 um 11:28 hat Peter Maydell geschrieben:
> On 7 July 2017 at 18:07, Kevin Wolf <kwolf@redhat.com> wrote:
> > The following changes since commit b11365867568ba954de667a0bfe0945b8f78d6bd:
> >
> >   Merge remote-tracking branch 'remotes/borntraeger/tags/s390x-20170706' into staging (2017-07-06 11:42:59 +0100)
> >
> > are available in the git repository at:
> >
> >
> >   git://repo.or.cz/qemu/kevin.git tags/for-upstream
> >
> > for you to fetch changes up to 7d982302db173616d011e07ee43be3b0aae872b1:
> >
> >   Merge remote-tracking branch 'mreitz/tags/pull-block-2017-07-07' into queue-block (2017-07-07 18:11:41 +0200)
> >
> > ----------------------------------------------------------------
> >
> > Block layer patches
> 
> Hi -- I'm afraid this doesn't build with clang:

My clang didn't complain, unfortunately.

>   CC      block/qcow2-bitmap.o
> /home/petmay01/linaro/qemu-for-merges/block/qcow2-bitmap.c:1183:9:
> error: variable 'ret' is used uninitialized whenever 'if' condition is
> true [-Werror,-Wsometimes-uninitialized]
>     if (tb_offset < 0) {
>         ^~~~~~~~~~~~~
> /home/petmay01/linaro/qemu-for-merges/block/qcow2-bitmap.c:1222:12:
> note: uninitialized use occurs here
>     return ret;
>            ^~~
> /home/petmay01/linaro/qemu-for-merges/block/qcow2-bitmap.c:1183:5:
> note: remove the 'if' if its condition is always false
>     if (tb_offset < 0) {
>     ^~~~~~~~~~~~~~~~~~~~
> /home/petmay01/linaro/qemu-for-merges/block/qcow2-bitmap.c:1165:12:
> note: initialize the variable 'ret' to silence this warning
>     int ret;
>            ^
>             = 0
> 1 error generated.
> 
> Looking at the code, the compiler appears to be correct
> that that error-exit path has forgotten to set ret.

Indeed. This is from commit 519d4789 ('qcow2: add persistent dirty
bitmaps support') and came through Max' tree.

Max, I'll split the pull request and send only my tree in v2. Please
submit a separate pull request for the patches in your tree once the
build is fixed.

Kevin
