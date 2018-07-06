Received: from eggs.gnu.org ([2001:4830:134:3::10]:49453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fbUC1-0007Hw-Qz
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 13:06:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fbUBy-0003nm-JS
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 13:06:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35674 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fbUBy-0003nL-Do
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 13:06:46 -0400
References: <20180705181148.26871-1-clg@kaod.org>
	<20180705133044.634ede43@t450s.home>
	<b5322979-6114-6334-d1f5-ccc6abc049bb@redhat.com>
	<20180706015113.GC23001@xz-mi>
	<9ae66133-86a6-72d8-cd66-f27592caffe9@redhat.com>
	<20180706192326-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <81e79024-b1db-6616-04cd-d2a1f2eb3ef4@redhat.com>
Date: Fri, 6 Jul 2018 19:06:36 +0200
MIME-Version: 1.0
In-Reply-To: <20180706192326-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] pci: remove pci_del_option_rom()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

On 06/07/2018 18:25, Michael S. Tsirkin wrote:
> On Fri, Jul 06, 2018 at 05:55:23PM +0200, Paolo Bonzini wrote:
>> On 06/07/2018 03:51, Peter Xu wrote:
>>>
>>> A question about memory region auto destruction (which might not
>>> related to this patch): I see that we have object_property_add_child()
>>> in memory_region_do_init() to achieve the auto destruction but only if
>>> the "name" of memory region is specified.  Could we just do that
>>> unconditionally (though we might of course need to generate some of
>>> the names), or is there a reason not to do so?
>>
>> I'm not sure actually if there are still regions without a name...
>>
>> Paolo
> 
> Answer to Peter's question would be a yes then?
> 
> With all the autodestruct I'm unsure when is calling vmstate_unregister_ram appropriate.
> Is it necessary to invoke that from pci any longer?
> 

I think vmstate_unregister_ram is not necessary at all.  This patch, or
Alex's suggestion, are smaller changes in that direction---more suitable
as we're closer to the release.

Paolo
