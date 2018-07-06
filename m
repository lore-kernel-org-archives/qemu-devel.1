Received: from eggs.gnu.org ([2001:4830:134:3::10]:43856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fbTmh-00075e-7M
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 12:40:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fbTma-0005qf-6o
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 12:40:39 -0400
Received: from 6.mo4.mail-out.ovh.net ([188.165.36.253]:45630)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fbTmZ-0005lZ-HH
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 12:40:32 -0400
Received: from player696.ha.ovh.net (unknown [10.109.120.118])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id CFDF9188058
	for <qemu-devel@nongnu.org>; Fri,  6 Jul 2018 18:40:29 +0200 (CEST)
References: <20180705181148.26871-1-clg@kaod.org>
	<20180705133044.634ede43@t450s.home>
	<b5322979-6114-6334-d1f5-ccc6abc049bb@redhat.com>
	<20180706015113.GC23001@xz-mi>
	<9ae66133-86a6-72d8-cd66-f27592caffe9@redhat.com>
	<20180706192326-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <910d2d44-7fb4-dcd5-6440-b3a93acde900@kaod.org>
Date: Fri, 6 Jul 2018 18:40:23 +0200
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
To: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

On 07/06/2018 06:25 PM, Michael S. Tsirkin wrote:
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

That could be another patch though. This is trying to fix vfio-pci 
unplug.

C.
