Received: from eggs.gnu.org ([2001:4830:134:3::10]:33658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1coQii-0000rr-2x
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 04:25:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1coQih-00029W-7v
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 04:25:16 -0400
References: <20170316004603.20609-1-jsnow@redhat.com>
	<20170316004603.20609-3-jsnow@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9d0aceb5-e59e-7d61-b4f7-208d699dd5af@redhat.com>
Date: Thu, 16 Mar 2017 09:25:07 +0100
MIME-Version: 1.0
In-Reply-To: <20170316004603.20609-3-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC patch 2/3] block-backend: add drained_begin /
 drained_end ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org



On 16/03/2017 01:46, John Snow wrote:
> 
> - Does the presence of blk->quiesce_counter relieve the burden of needing
>   blk->public.io_limits_disabled? I could probably eliminate this counter
>   entirely and just spy on the root node's quiescent state at key moments
>   instead. I am confident I'm traipsing on delicate drain semantics.

Tricky question.  I believe io_limits_disabled is a bit of a hack.

Certainly you could get rid of disable_external now that we have
drained_begin/drained_end, but it would be a separate patch.

> - Should I treat the separation of a quisced BDS/BB as a drained_end request
>   as an analogue to how blk_insert_bs (in this patch) handles this?

I think so.

Paolo
