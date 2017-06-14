Received: from eggs.gnu.org ([2001:4830:134:3::10]:34231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dL2Km-0001Tp-9c
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 03:03:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dL2Ki-0001rJ-CQ
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 03:03:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dL2Ki-0001rB-6M
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 03:03:16 -0400
References: <20170613214736.19963-1-david@redhat.com>
	<20170613214736.19963-4-david@redhat.com>
	<e1193b07-a074-140d-c44b-c122d6909c12@twiddle.net>
From: David Hildenbrand <david@redhat.com>
Message-ID: <ec1668df-7098-62b9-a3b6-b79cac8f224d@redhat.com>
Date: Wed, 14 Jun 2017 09:03:11 +0200
MIME-Version: 1.0
In-Reply-To: <e1193b07-a074-140d-c44b-c122d6909c12@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 3/3] s390x/cpumodel: allow to enable
 MVCOS for qemu cpu model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: agraf@suse.de, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, Miroslav Benes <mbenes@suse.cz>

On 14.06.2017 06:44, Richard Henderson wrote:
> On 06/13/2017 02:47 PM, David Hildenbrand wrote:
>> +    if (!s390_has_feat(S390_FEAT_MOVE_WITH_OPTIONAL_SPEC)) {
>> +        program_interrupt(env, PGM_OPERATION, 6);
>> +    }
> 
> This is (supposed to be) done via the feature field of insn-data.def.
> 
> Except that we do not yet enforce that; we haven't updated that bit of the 
> translator since we actually added support for the feature bits.

That makes sense, I'll drop this hunk then. So wiring up these bits with
the CPU model directly sounds like what we want to do.

Thanks!

> 
> 
> r~
> 


-- 

Thanks,

David
