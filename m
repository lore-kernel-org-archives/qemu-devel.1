Received: from eggs.gnu.org ([2001:4830:134:3::10]:46673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1g7IW4-0003lS-SV
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 07:07:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1g7IVz-0003xI-Aq
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 07:07:00 -0400
Date: Tue, 2 Oct 2018 13:06:47 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181002130647.61644af2.cohuck@redhat.com>
In-Reply-To: <20180902003322.3428-3-pavel.zbitskiy@gmail.com>
References: <20180902003322.3428-1-pavel.zbitskiy@gmail.com>
	<20180902003322.3428-3-pavel.zbitskiy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 2/3] target/s390x: exception on
 non-aligned LPSW(E)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, david@redhat.com, richard.henderson@linaro.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

On Sat,  1 Sep 2018 20:33:21 -0400
Pavel Zbitskiy <pavel.zbitskiy@gmail.com> wrote:

> Both LPSW and LPSWE should raise a specification exception when their
> operand is not doubleword aligned.
> 
> Signed-off-by: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
> ---
>  target/s390x/translate.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Thanks, applied.
