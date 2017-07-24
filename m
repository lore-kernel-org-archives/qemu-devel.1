Received: from eggs.gnu.org ([2001:4830:134:3::10]:37479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dZhF7-0005Xf-28
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:34:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dZhF4-0006IU-1G
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:34:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dZhF3-0006HQ-Qs
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:34:01 -0400
References: <20170721125609.11117-1-david@redhat.com>
	<20170721125609.11117-4-david@redhat.com>
	<ac7c2032-deed-21b5-8252-d28797e05bf6@twiddle.net>
From: David Hildenbrand <david@redhat.com>
Message-ID: <92ab558b-7de5-9d3a-d189-6e5a6a3b3d6f@redhat.com>
Date: Mon, 24 Jul 2017 19:25:15 +0200
MIME-Version: 1.0
In-Reply-To: <ac7c2032-deed-21b5-8252-d28797e05bf6@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 3/6] target/s390x: implement spm (SET
 PROGRAM MASK)
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

On 24.07.2017 06:39, Richard Henderson wrote:
> On 07/21/2017 05:56 AM, David Hildenbrand wrote:
>> +    tcg_gen_extrl_i64_i32(cc, o->in1);
>> +    tcg_gen_shri_i32(cc, cc, 28);
>> +    tcg_gen_andi_i32(cc, cc, 0x3ul);
>> +    tcg_gen_mov_i32(cc_op, cc);
>> +    tcg_temp_free_i32(cc);
>> +    set_cc_static(s);
> 
>   tcg_gen_extrl_i64_i32(cc_op, o->in1);
>   tcg_gen_extract_i32(cc_op, cc_op, 28, 2);
> 
> 

My tests still pass with the following suggested hunk.

tcg_gen_extrl_i64_i32(cc_op, o->in1);
tcg_gen_extract_i32(cc_op, cc_op, 28, 2);
set_cc_static(s);

Thanks!

> Otherwise,
> 
> Reviewed-by: Richard Henderson <rth@twiddle.net>
> 
> 
> r~
> 


-- 

Thanks,

David
