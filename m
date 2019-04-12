Received: from eggs.gnu.org ([209.51.188.92]:37026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hEqum-0006ak-7G
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 03:48:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hEqul-0006tG-BR
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 03:48:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38257)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hEquk-0006sQ-V4
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 03:47:59 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1146E3007447
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 07:47:58 +0000 (UTC)
References: <20181119182330.17147-1-pbonzini@redhat.com>
	<20181120114422.GA5072@work-vm>
	<f6c43c98-1319-85bb-c379-72d8caacf68d@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c348ffd5-a044-bc12-d1a7-50b7ab543045@redhat.com>
Date: Fri, 12 Apr 2019 09:47:55 +0200
MIME-Version: 1.0
In-Reply-To: <f6c43c98-1319-85bb-c379-72d8caacf68d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] target/i386: kvm: add VMX migration
 blocker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cole Robinson <crobinso@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org

On 10/04/19 20:26, Cole Robinson wrote:
> On 11/20/18 6:44 AM, Dr. David Alan Gilbert wrote:
>> * Paolo Bonzini (pbonzini@redhat.com) wrote:
>>> Nested VMX does not support live migration yet.  Add a blocker
>>> until that is worked out.
>>>
>>> Nested SVM only does not support it, but unfortunately it is
>>> enabled by default for -cpu host so we cannot really disable it.
>>>
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>
>> So I'm OK with this, but it does need a release note warning whenever it
>> goes in, because it'll surprise those who've already enabled nesting
>> but don't use it on all their VMs.
>>
> 
> We are hitting this in Fedora 30. Now that nested VMX is enabled by
> default at the kernel level, and virt-manager/boxes will use the
> equivalent of -cpu host by default, libvirt managedsave (migrate to
> file) and virt-manager snapshots (savevm) are rejected for default
> created VMs on intel. That's quite unfortunate.
> 
> Any ideas on how to resolve this?

I think the simplest solution is just to finish implementation of nested
VMX live migration and backport it to Fedora 30.

Paolo
