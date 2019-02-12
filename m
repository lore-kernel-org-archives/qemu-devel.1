Received: from eggs.gnu.org ([209.51.188.92]:57342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gtU9T-00040P-4j
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 04:14:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gtU61-0006ot-Ju
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 04:11:21 -0500
Date: Tue, 12 Feb 2019 10:11:00 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190212101100.1d62b04e.cohuck@redhat.com>
In-Reply-To: <20190212053044.29015-1-richard.henderson@linaro.org>
References: <20190212053044.29015-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/2] target/s390x: Implement STCK et al
 for CONFIG_USER_ONLY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On Mon, 11 Feb 2019 21:30:42 -0800
Richard Henderson <richard.henderson@linaro.org> wrote:

> Changes since v2:
>   * Fix botched subject line, include r-b tags.
> 
> Changes since v1:
>   * Move more of hw/s390x/tod.h to a new header.
>   * Use time2tod.
> 
> 
> r~
> 
> 
> Richard Henderson (2):
>   target/s390x: Split out s390-tod.h
>   target/s390x: Implement STCK et al for CONFIG_USER_ONLY
> 
>  include/hw/s390x/tod.h     | 16 +---------------
>  target/s390x/helper.h      |  2 +-
>  target/s390x/s390-tod.h    | 29 +++++++++++++++++++++++++++++
>  target/s390x/misc_helper.c | 34 ++++++++++++++++++++++------------
>  target/s390x/translate.c   |  2 ++
>  target/s390x/insn-data.def | 11 ++++++-----
>  6 files changed, 61 insertions(+), 33 deletions(-)
>  create mode 100644 target/s390x/s390-tod.h
> 

Thanks, applied.
