Received: from eggs.gnu.org ([2001:4830:134:3::10]:41692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fdI1s-0008KV-3v
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 12:31:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fdI1p-0005us-1I
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 12:31:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33902 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fdI1o-0005uW-RU
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 12:31:44 -0400
References: <1531236069-7500-1-git-send-email-viktor.prutyanov@virtuozzo.com>
	<20180711160025.GU7451@localhost.localdomain>
	<20180711192609.70582657@vp-pc>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c327b20d-b73e-2e63-194a-536c7243b53e@redhat.com>
Date: Wed, 11 Jul 2018 18:31:35 +0200
MIME-Version: 1.0
In-Reply-To: <20180711192609.70582657@vp-pc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] dump: add kernel_gs_base to QEMU CPU state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, rth@twiddle.net, rkagan@virtuozzo.com

On 11/07/2018 18:26, Viktor Prutyanov wrote:
>> Where are the tools using this information, that need to be
>> updated?  Won't this break existing versions of those tools?
>>
>> Is the dump format and pointers to available tools documented
>> somewhere?
> I hope that someone from community knows about those tools because I
> can't find such tools.
> 

I checked crash, and it doesn't have any issue with QEMUCPUState that is
bigger than what is currently in QEMU.  It doesn't use anything but CR3
and IDT base.  It also doesn't at all check the version! :O

Paolo
