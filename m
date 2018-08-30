Received: from eggs.gnu.org ([2001:4830:134:3::10]:40985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fvSNi-0003ux-Dp
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 15:13:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fvSNh-0005ke-Rr
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 15:13:26 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180830122756.13991-1-david@redhat.com>
	<20180830122756.13991-5-david@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <f1e1d763-146e-5467-f351-8da03432d40c@twiddle.net>
Date: Thu, 30 Aug 2018 12:13:18 -0700
MIME-Version: 1.0
In-Reply-To: <20180830122756.13991-5-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 4/9] s390x/tcg: support flags for
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>

On 08/30/2018 05:27 AM, David Hildenbrand wrote:
> Storing flags for instructions allows us to efficiently verify certain
> properties at a central point. Examples might later be handling if
> AFP is disabled in CR0, we are not in problem state, or if vector
> instructions are disabled in CR0.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def |  3 +++
>  target/s390x/translate.c   | 22 ++++++++++++++++------
>  2 files changed, 19 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
