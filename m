Received: from eggs.gnu.org ([2001:4830:134:3::10]:58726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZiGb-0004sE-0w
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 15:16:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZiGX-0005RT-0m
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 15:16:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49734)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gZiGW-0005RC-Na
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 15:16:24 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1B2669D435
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 20:16:24 +0000 (UTC)
References: <20181219085038.7729-1-peterx@redhat.com>
	<20181219085038.7729-3-peterx@redhat.com>
	<20181219105133-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8be642cf-6e92-dc1f-0478-7e72a3bbf69f@redhat.com>
Date: Wed, 19 Dec 2018 21:16:14 +0100
MIME-Version: 1.0
In-Reply-To: <20181219105133-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/4] q35: set split kernel irqchip as
 default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On 19/12/18 16:52, Michael S. Tsirkin wrote:
> On Wed, Dec 19, 2018 at 04:50:36PM +0800, Peter Xu wrote:
>> Starting from QEMU 4.0, let's specify "split" as the default value for
>> kernel-irqchip.
>>
>> So for QEMU>=4.0 we'll have: allowed=Y,required=N,split=Y
>>    for QEMU<=3.1 we'll have: allowed=Y,required=N,split=N
>>    (omitting all the "kernel_irqchip_" prefix)
>>
>> Note that this "split" is optional - we'll first try to enable split
>> kernel irqchip, and we'll fall back to complete kernel irqchip if we
>> found that the kernel capability is missing.
>>
>> Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> I'm split on this one ;)
> On the one hand why not make pc and q35 are consistent here?
> On the other hand we really should work to leave PC alone
> as much as we can ...
> 
> Paolo, what's your opinion?

The idea was to avoid bumping the minimal kernel version for PC, only
for Q35.  PC can still use split irqchip for security purposes, but only
Q35 needs it for features.

Paolo
