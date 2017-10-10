Received: from eggs.gnu.org ([2001:4830:134:3::10]:39664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e1xiz-0000N6-LL
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 12:49:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e1xiw-0003Ke-IH
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 12:49:45 -0400
Received: from mail-pf0-x231.google.com ([2607:f8b0:400e:c00::231]:45023)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e1xiw-0003Jj-Bc
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 12:49:42 -0400
Received: by mail-pf0-x231.google.com with SMTP id x7so7528446pfa.1
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 09:49:42 -0700 (PDT)
References: <20170928203708.9376-1-david@redhat.com>
	<20170928203708.9376-2-david@redhat.com>
	<cf1fd114-9b28-88b1-baac-669407631846@redhat.com>
	<20171010162006.4e541412.cohuck@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5c1d4292-2044-8d0b-c563-8617ff603a8b@linaro.org>
Date: Tue, 10 Oct 2017 09:49:38 -0700
MIME-Version: 1.0
In-Reply-To: <20171010162006.4e541412.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 01/30] s390x/tcg: turn INTERRUPT_EXT
 into a mask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, qemu-s390x@nongnu.org

On 10/10/2017 07:20 AM, Cornelia Huck wrote:
>> The last two function look similar enough that you could merge the
>> functions, e.g.:
>>
>> void cpu_inject_ext_pending_bit(S390CPU *cpu, int bit)
>> {
>>     CPUS390XState *env = &cpu->env;
>>
>>     env->pending_int |= bit;
>>     cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
>> }
>>
>> ?
>>
>> Apart from that, the patch looks fine to me.
>>
>>  Thomas
> FWIW, I'd prefer to keep these as separate functions.

Certainly.  In a later patch they diverge much more than would be easily
separated as Thomas suggests.


r~
