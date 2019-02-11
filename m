Received: from eggs.gnu.org ([209.51.188.92]:36388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gt8I5-0008UK-LJ
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 04:54:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gt8I5-0006yJ-2Y
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 04:54:17 -0500
Date: Mon, 11 Feb 2019 10:54:11 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190211105411.1994d0cf.cohuck@redhat.com>
In-Reply-To: <20190209063152.9490-3-richard.henderson@linaro.org>
References: <20190209063152.9490-1-richard.henderson@linaro.org>
	<20190209063152.9490-3-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2 2/2] This is a
 non-privileged instruction that was only implemented for system mode.
 However, the stck instruction is used by glibc,
 so this was causing SIGILL for programs run under debian stretch.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com

On Fri,  8 Feb 2019 22:31:52 -0800
Richard Henderson <richard.henderson@linaro.org> wrote:

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/s390x/helper.h      |  2 +-
>  target/s390x/misc_helper.c | 34 ++++++++++++++++++++++------------
>  target/s390x/translate.c   |  2 ++
>  target/s390x/insn-data.def | 11 ++++++-----
>  4 files changed, 31 insertions(+), 18 deletions(-)

I'd be happy to queue this if I get a proper subject line for this
patch :) (I can fix up the rest.)
