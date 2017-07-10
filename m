Received: from eggs.gnu.org ([2001:4830:134:3::10]:41384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUV07-0001EM-FI
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 05:29:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUV06-0003c6-EP
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 05:29:07 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:34428)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dUV05-0003ak-PM
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 05:29:06 -0400
Received: by mail-wr0-x233.google.com with SMTP id 77so130277094wrb.1
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 02:29:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
References: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Jul 2017 10:28:44 +0100
Message-ID: <CAFEAcA_=YZFScbOU_nBLpzGuupo6EKNcSZhJGDZQZeTu7KVq4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 000/100] Block layer patches
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

On 7 July 2017 at 18:07, Kevin Wolf <kwolf@redhat.com> wrote:
> The following changes since commit b11365867568ba954de667a0bfe0945b8f78d6bd:
>
>   Merge remote-tracking branch 'remotes/borntraeger/tags/s390x-20170706' into staging (2017-07-06 11:42:59 +0100)
>
> are available in the git repository at:
>
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 7d982302db173616d011e07ee43be3b0aae872b1:
>
>   Merge remote-tracking branch 'mreitz/tags/pull-block-2017-07-07' into queue-block (2017-07-07 18:11:41 +0200)
>
> ----------------------------------------------------------------
>
> Block layer patches
>

Hi -- I'm afraid this doesn't build with clang:

  CC      block/qcow2-bitmap.o
/home/petmay01/linaro/qemu-for-merges/block/qcow2-bitmap.c:1183:9:
error: variable 'ret' is used uninitialized whenever 'if' condition is
true [-Werror,-Wsometimes-uninitialized]
    if (tb_offset < 0) {
        ^~~~~~~~~~~~~
/home/petmay01/linaro/qemu-for-merges/block/qcow2-bitmap.c:1222:12:
note: uninitialized use occurs here
    return ret;
           ^~~
/home/petmay01/linaro/qemu-for-merges/block/qcow2-bitmap.c:1183:5:
note: remove the 'if' if its condition is always false
    if (tb_offset < 0) {
    ^~~~~~~~~~~~~~~~~~~~
/home/petmay01/linaro/qemu-for-merges/block/qcow2-bitmap.c:1165:12:
note: initialize the variable 'ret' to silence this warning
    int ret;
           ^
            = 0
1 error generated.

Looking at the code, the compiler appears to be correct
that that error-exit path has forgotten to set ret.

thanks
-- PMM
