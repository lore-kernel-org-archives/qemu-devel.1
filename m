Received: from eggs.gnu.org ([2001:4830:134:3::10]:43058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dZhdE-0007Wk-31
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:59:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dZhd9-0000Wl-9d
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:59:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49860)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dZhd9-0000WU-41
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:58:55 -0400
References: <20170721125609.11117-1-david@redhat.com>
	<4a89b217-6d7b-af98-ceb8-379605e161e5@twiddle.net>
From: David Hildenbrand <david@redhat.com>
Message-ID: <7b888011-23ce-6afd-0ff0-5004aeff1bef@redhat.com>
Date: Mon, 24 Jul 2017 19:58:50 +0200
MIME-Version: 1.0
In-Reply-To: <4a89b217-6d7b-af98-ceb8-379605e161e5@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 0/6] target/s390x: tcg improvments + MSA
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, cohuck@redhat.com, borntraeger@de.ibm.com

On 24.07.2017 05:16, Richard Henderson wrote:
> On 07/21/2017 05:56 AM, David Hildenbrand wrote:
>> 1. smaller pgm irq instruction length fixes
> 
> I think maybe we should add insn length data to the unwind data, so that we can 
> have env->int_pgm_ilen set to the right value whenever cpu_restore_state is called.
> 
> 
> r~
> 

You mean, passing a third argument to tcg_gen_insn_start():
	tcg_gen_insn_start(dc.pc, dc.cc_op, dc.ilen);

by setting TARGET_INSN_START_EXTRA_WORDS=2 ?

Then we would have to do instruction length detection before
tcg_gen_insn_start() and therefore before translate_one().


-- 

Thanks,

David
