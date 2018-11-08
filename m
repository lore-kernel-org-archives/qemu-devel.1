Received: from eggs.gnu.org ([2001:4830:134:3::10]:45471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gKquc-0001lD-93
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 15:28:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gKquS-00010v-1O
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 15:28:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gKquR-0000zM-L8
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 15:28:11 -0500
References: <e496287e-f8ba-3608-42e1-efb697cfc784@redhat.com>
	<20181107154114.GC27585@caravaggio>
	<dd68d3e8-6448-3a67-3212-fd3d3bfba2e2@redhat.com>
	<20181107192414.GH12503@habkost.net>
	<c6bbfeb8-53c5-0e0c-cf36-14e586cfb581@redhat.com>
	<a0decaa7-d83b-b0ad-60ea-aa0890feb905@redhat.com>
	<20181108130648.GJ12503@habkost.net>
	<95a93d53-f87d-bd96-9363-582c4eae4160@redhat.com>
	<20181108171437.GM12503@habkost.net>
	<dda55f75-58d3-111c-4f43-99a9f686981e@redhat.com>
	<20181108184242.GQ12503@habkost.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2f4793c3-5509-1def-3157-02bc0d9bbe26@redhat.com>
Date: Thu, 8 Nov 2018 21:28:06 +0100
MIME-Version: 1.0
In-Reply-To: <20181108184242.GQ12503@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] QEMU and Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, "Zhong, Yang" <yang.zhong@intel.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

Oops. :)

On 08/11/2018 19:42, Eduardo Habkost wrote:
>>> Keeping in mind that I might be talking about extra challenges we
>>> won't address right now (no cart before the horse), I have new
>>> questions:
>>>
>>> Why you say backends are not a target configuration and
>>> accelerators are?  What's the definition of "target
>>> configuration"?

Something that affects the hardware seen by the guest is target
configuration.

Backends do not affect what hardware the guest sees.  Boards and devices
do; accelerators do, but that's more of a side-effect than something
intended.

Paolo
