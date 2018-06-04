Received: from eggs.gnu.org ([2001:4830:134:3::10]:58449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fPtvb-0002ZG-GM
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 14:10:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fPtvX-0007NI-2r
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 14:09:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46316 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1fPtvW-0007Mk-T8
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 14:09:55 -0400
References: <20180603092749.107476-1-marcel.apfelbaum@gmail.com>
	<20180604042928-mutt-send-email-mst@kernel.org>
	<20180604142446.6f910dbf@redhat.com>
	<4e58363f-d055-7556-7a71-51f90e461f4e@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <2003b551-2bc6-f9fe-8303-837397e4ac01@redhat.com>
Date: Mon, 4 Jun 2018 14:09:50 -0400
MIME-Version: 1.0
In-Reply-To: <4e58363f-d055-7556-7a71-51f90e461f4e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC] hw/pc: set q35 as the default x86
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org, rth@twiddle.net



On 06/04/2018 08:35 AM, Paolo Bonzini wrote:
> On 04/06/2018 14:24, Igor Mammedov wrote:
>>> Yes it's easy to add -machine pc but there's no documentation
>>> that tells you to do so. Add to that shortcuts like -cdrom
>>> stop working, hotplug needs extra bridges to work, and one
>>> can see that while management tool users benefit from q35,
>>> command line users will suffer.
>> Maybe we should mark 'pc' default as deprecated first,
>> like we do with CLI options that we wish to drop in future?
>>
>> That way we 'create' documentation, so users would be aware
>> of the change and have time to fix their CLI if they prefer
>> 'pc' machine.
> 
> Michael has listed reasons why 'pc' cannot be deprecated, since some of
> them are not even fixable.  Honestly, 'pc' works well for 99% of the use
> cases---just like you probably don't care whether your laptop has a PCI
> or PCIe chipset.
> 
> Paolo
> 
> 

I understood this comment to mean deprecating a *default* machine type.

So if you do `-M pc` you're still OK, but if you simply omit a machine
type and hope for a specific one you're out of luck.

... We could just deprecate having any default and then make QEMU whine
at you if you don't specify one, like we do for guessing format types on
drive images -- it'll do it, but if it guesses raw it whines at you a
little.
