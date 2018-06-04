Received: from eggs.gnu.org ([2001:4830:134:3::10]:54203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fPoi6-00045Z-3U
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 08:35:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fPoi1-0001l6-W1
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 08:35:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35784 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fPoi1-0001kd-Q0
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 08:35:37 -0400
References: <20180603092749.107476-1-marcel.apfelbaum@gmail.com>
	<20180604042928-mutt-send-email-mst@kernel.org>
	<20180604142446.6f910dbf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4e58363f-d055-7556-7a71-51f90e461f4e@redhat.com>
Date: Mon, 4 Jun 2018 14:35:25 +0200
MIME-Version: 1.0
In-Reply-To: <20180604142446.6f910dbf@redhat.com>
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
To: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, rth@twiddle.net, qemu-devel@nongnu.org, ehabkost@redhat.com

On 04/06/2018 14:24, Igor Mammedov wrote:
>> Yes it's easy to add -machine pc but there's no documentation
>> that tells you to do so. Add to that shortcuts like -cdrom
>> stop working, hotplug needs extra bridges to work, and one
>> can see that while management tool users benefit from q35,
>> command line users will suffer.
> Maybe we should mark 'pc' default as deprecated first,
> like we do with CLI options that we wish to drop in future?
> 
> That way we 'create' documentation, so users would be aware
> of the change and have time to fix their CLI if they prefer
> 'pc' machine.

Michael has listed reasons why 'pc' cannot be deprecated, since some of
them are not even fixable.  Honestly, 'pc' works well for 99% of the use
cases---just like you probably don't care whether your laptop has a PCI
or PCIe chipset.

Paolo
