Received: from eggs.gnu.org ([2001:4830:134:3::10]:32862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIF7w-0004j3-Du
	for qemu-devel@nongnu.org; Mon, 14 May 2018 11:11:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIF7v-0001zt-9X
	for qemu-devel@nongnu.org; Mon, 14 May 2018 11:11:04 -0400
Received: from mail-oi0-x232.google.com ([2607:f8b0:4003:c06::232]:33565)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIF7v-0001ze-4p
	for qemu-devel@nongnu.org; Mon, 14 May 2018 11:11:03 -0400
Received: by mail-oi0-x232.google.com with SMTP id k5-v6so11007920oiw.0
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 08:11:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1526303228-486609-1-git-send-email-mst@redhat.com>
References: <1526303228-486609-1-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 May 2018 16:10:42 +0100
Message-ID: <CAFEAcA_bWJupL7oj=uxNAi3=1RGUZxpEeKx1L=JBZa6J4CuuYA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 0/3] linux-headers: arch fixups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, James Hogan <jhogan@kernel.org>

On 14 May 2018 at 14:07, Michael S. Tsirkin <mst@redhat.com> wrote:
> It turns out that we have unistd.h and kvm headers for some
> architectures but not others.  We are thus unable to use e.g. usefaultfd
> on these systems unless system headers have been updated.
>
> Fix up update-linux-headers.sh to make sure we auto-updates
> all architectures which have linux-headers/
> (unfortunately this still does not mean "all linux systems").
>
> Tested on x86 only.
>
> Pls consider merging this through the ARM tree.
>
> Changes from v5:
>     rebase to master

Still doesn't apply:

e104462:xenial:qemu$ patches apply -s
id:1526303228-486609-1-git-send-email-mst@redhat.com
Applying: update-linux-headers.sh: unistd.h, kvm consistency
error: sha1 information is lacking or useless (scripts/update-linux-headers.sh).
error: could not build fake ancestor
Patch failed at 0001 update-linux-headers.sh: unistd.h, kvm consistency
Use 'git am --show-current-patch' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
e104462:xenial:qemu$ patch --dry-run -p1 <.git/rebase-apply/patch
checking file scripts/update-linux-headers.sh
Hunk #1 succeeded at 83 (offset -1 lines).
Hunk #2 FAILED at 94.
Hunk #3 FAILED at 124.
2 out of 3 hunks FAILED

The copy of this script in master has code relating to kvm_para.h,
and whatever you've based this patchset on apparently does not,
hence the conflicts.

thanks
-- PMM
