Received: from eggs.gnu.org ([2001:4830:134:3::10]:38476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fvSHc-0005Bo-9t
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 15:07:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fvSHb-0002D9-Kb
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 15:07:08 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180830122756.13991-1-david@redhat.com>
	<20180830122756.13991-2-david@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <9951de86-a2be-38f3-e9dd-6165cb1fbd85@twiddle.net>
Date: Thu, 30 Aug 2018 12:06:59 -0700
MIME-Version: 1.0
In-Reply-To: <20180830122756.13991-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/9] s390x: move
 tcg_s390_program_interrupt() into TCG code and mark it noreturn
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
> Move it into TCG-only code and provide a stub. Turn it into noreturn.
> 
> As Richard noted, we currently don't log the psw.addr before restoring
> the state, fix that by moving (duplicating) the qemu_log_mask in the
> tcg/kvm handlers.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/excp_helper.c | 13 +++++++++++++
>  target/s390x/interrupt.c   | 15 +--------------
>  target/s390x/kvm.c         |  3 ++-
>  target/s390x/tcg-stub.c    |  5 +++++
>  target/s390x/tcg_s390x.h   |  2 ++
>  5 files changed, 23 insertions(+), 15 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
