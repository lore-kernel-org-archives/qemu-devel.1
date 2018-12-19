Received: from eggs.gnu.org ([2001:4830:134:3::10]:52366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gZjez-00075s-8S
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 16:45:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gZjey-0002wJ-BF
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 16:45:45 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41000)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gZjey-0002vV-4T
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 16:45:44 -0500
Received: by mail-wr1-x441.google.com with SMTP id x10so21023085wrs.8
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 13:45:43 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20181219085038.7729-1-peterx@redhat.com>
	<20181219085038.7729-3-peterx@redhat.com>
	<c9e56e11-214f-552a-faea-cb5901392164@redhat.com>
	<20181219212418.GJ19442@habkost.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2b60279a-26bc-1569-3f3c-da507fed2c44@redhat.com>
Date: Wed, 19 Dec 2018 22:45:40 +0100
MIME-Version: 1.0
In-Reply-To: <20181219212418.GJ19442@habkost.net>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, libvir-list@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>, Jiri Denemark <jdenemar@redhat.com>

On 19/12/18 22:24, Eduardo Habkost wrote:
> On Wed, Dec 19, 2018 at 09:12:55PM +0100, Paolo Bonzini wrote:
>> On 19/12/18 09:50, Peter Xu wrote:
>>> Starting from QEMU 4.0, let's specify "split" as the default value for
>>> kernel-irqchip.
>>>
>>> So for QEMU>=4.0 we'll have: allowed=Y,required=N,split=Y
>>>    for QEMU<=3.1 we'll have: allowed=Y,required=N,split=N
>>>    (omitting all the "kernel_irqchip_" prefix)
>>>
>>> Note that this "split" is optional - we'll first try to enable split
>>> kernel irqchip, and we'll fall back to complete kernel irqchip if we
>>> found that the kernel capability is missing.
>>
>> Please just fail completely and require a new kernel for the 4.0 machine
>> type.  There are subtle differences between kernel and QEMU irqchip, I
>> don't think we want to open that can of worms.
> 
> This would make existing VMs that are runnable with pc-q35-3.1.0
> not runnable by only updating the machine-type.
> 
> The good news is that we can make this a non-issue by clearly
> documenting that QEMU needs a more recent kernel (just like we'll
> do for RDTSCP[1]).

Right, RDTSCP is exactly what came to mind.

Paolo
