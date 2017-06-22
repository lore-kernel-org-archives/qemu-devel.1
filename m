Received: from eggs.gnu.org ([2001:4830:134:3::10]:58825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dNyQz-0002XM-Ce
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 05:29:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dNyQw-0005IX-9K
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 05:29:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dNyQw-0005IS-38
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 05:29:50 -0400
References: <1498040401-16361-1-git-send-email-yang.zhong@intel.com>
	<1498040401-16361-4-git-send-email-yang.zhong@intel.com>
	<d35da9df-43b0-c59b-38b4-1affd7448fcc@redhat.com>
	<20170622070644.GB28944@yangzhon-Virtual>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3fcc4865-1a1d-fdac-b8a5-5670083c6f19@redhat.com>
Date: Thu, 22 Jun 2017 11:29:46 +0200
MIME-Version: 1.0
In-Reply-To: <20170622070644.GB28944@yangzhon-Virtual>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/15] tcg: tcg_handle_interrupt() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhong Yang <yang.zhong@intel.com>
Cc: qemu-devel@nongnu.org, a.rigo@virtualopensystems.com, anthony.xu@intel.com



On 22/06/2017 09:06, Zhong Yang wrote:
>> On 21/06/2017 12:19, Yang Zhong wrote:
>>> Move tcg_handle_interrupt() from translate-common.c to
>>> translate-all.c.
>>>
>>> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
>> Why?
>>
>> Paolo
>>
>   Hello Paolo,
> 
>   translate-common.c only include one tcg_handle_interrupt() fucntion, when i
>   move tcpu_interrupt_handler = tcg_handle_interrupt in tcg_exec_init() for disable-tcg,
>   maybe moving the tcg_handle_interrupt() function definition into same file with tcg_exec_init()
>   function is better. those are like cpu_interrupt_handler = kvm_handle_interrupt did in kvm-all.c. thanks!

Looking again at translate-common.c, it makes more sense to merge it
with accel/tcg/tcg-all.c.  The tcg_handle_interrupt can become static
and the cpu_interrupt_handler assignment can go in tcg-all.c's tcg_init
function.

The declaration for cpu_interrupt_handler can be placed in qom/cpu.c.

Paolo
