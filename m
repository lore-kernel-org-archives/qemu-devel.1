Received: from eggs.gnu.org ([2001:4830:134:3::10]:49554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eCjJE-0001UX-5q
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 04:39:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eCjJ9-0000A2-WA
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 04:39:40 -0500
Date: Thu, 9 Nov 2017 10:39:31 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171109103931.30bcae29.cohuck@redhat.com>
In-Reply-To: <20171107145546.767-1-richard.henderson@linaro.org>
References: <20171107145546.767-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH] target/s390x: Finish
 implementing RISBGN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, qemu-s390x@nongnu.org

On Tue,  7 Nov 2017 15:55:46 +0100
Richard Henderson <richard.henderson@linaro.org> wrote:

> We added the entry to insn-data.def, but failed to update op_risbg
> to match.  No need to special-case the imask inversion, since that
> is already ~0 for RISBG (and now RISBGN).
> 
> Fixes: 375ee58bedcda359011fe7fa99e0647f66f9ffa0
> Fixes: https://bugs.launchpad.net/qemu/+bug/1701798 (s390x part)
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/s390x/translate.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

Thanks, applied to s390-fixes.
