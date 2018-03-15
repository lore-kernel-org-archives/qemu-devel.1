Received: from eggs.gnu.org ([2001:4830:134:3::10]:44812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ewVy5-0005gO-Oo
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 12:43:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ewVy4-0001zn-TI
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 12:43:05 -0400
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:46541)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ewVy4-0001zY-Nb
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 12:43:04 -0400
Received: by mail-oi0-x22b.google.com with SMTP id x12so6219973oie.13
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 09:43:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180313161803.1814-1-kwolf@redhat.com>
References: <20180313161803.1814-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Mar 2018 16:42:43 +0000
Message-ID: <CAFEAcA-u_++4suoFBnea--7hajd1Mnb1kadwRc+GjZvHXvou-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/41] Block layer patches
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

On 13 March 2018 at 16:17, Kevin Wolf <kwolf@redhat.com> wrote:
> The following changes since commit 22ef7ba8e8ce7fef297549b3defcac333742b8=
04:
>
>   Merge remote-tracking branch 'remotes/famz/tags/staging-pull-request' i=
nto staging (2018-03-13 11:42:45 +0000)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to be6c885842efded81a20f4ca24f0d4e123a80c00:
>
>   block/mirror: change the semantic of 'force' of block-job-cancel (2018-=
03-13 16:54:47 +0100)
>
> ----------------------------------------------------------------
> Block layer patches
>
> ----------------------------------------------------------------

I get a compile failure here on some hosts:

/home/pm215/qemu/blockjob.c: In function =E2=80=98block_job_txn_apply.isra.=
8=E2=80=99:
/home/pm215/qemu/blockjob.c:524:5: error: =E2=80=98rc=E2=80=99 may be used
uninitialized in this function [-Werror=3Dmaybe-uninitialized]
     return rc;
     ^

I guess the compiler can't always figure out whether there is
guaranteed to be at least one thing in the list ?

thanks
-- PMM
