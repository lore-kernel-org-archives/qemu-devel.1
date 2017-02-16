Received: from eggs.gnu.org ([2001:4830:134:3::10]:53941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ceLdF-0008Gq-Lm
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 07:57:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ceLdB-0001w0-RF
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 07:57:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ceLdB-0001vX-LN
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 07:57:53 -0500
References: <efb89578-ba8c-1f42-0ec3-79f769b3f1f1@genode-labs.com>
	<1266688981.22789860.1487246005187.JavaMail.zimbra@redhat.com>
	<f40048d0-23bc-a4c7-8b18-00d6d3fd04b5@genode-labs.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ae235b6f-3e43-c132-c2ff-fd220c8c9dde@redhat.com>
Date: Thu, 16 Feb 2017 13:57:53 +0100
MIME-Version: 1.0
In-Reply-To: <f40048d0-23bc-a4c7-8b18-00d6d3fd04b5@genode-labs.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] x86 tlb_fill in memory_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Boettcher <alexander.boettcher@genode-labs.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, rth@twiddle.net



On 16/02/2017 13:57, Alexander Boettcher wrote:
> Hello Paolo,
> 
> On 16.02.2017 12:53, Paolo Bonzini wrote:
>> As you noticed, the problem is that now cpu_vmexit is called without a
>> cpu_restore_state before.
>>
>> The right fix is to pass the retaddr to cpu_vmexit (via
>> cpu_svm_check_intercept_param); something like this untested patch:
> 
> ...
> 
>>
>> If it works for you we can include it.
> 
> thank you for the quick patch. It works like a charm.
> 
> Do you take care of adding the patch, please ? (I can of course also do.)

Great, I will look at it.  Have you debugged the exact failure mode to
include something in the commit message?

Paolo
