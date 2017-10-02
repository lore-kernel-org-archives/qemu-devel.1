Received: from eggs.gnu.org ([2001:4830:134:3::10]:43992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dz0B5-00045r-2A
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 08:50:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dz0Az-0005pA-Dd
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 08:50:31 -0400
References: <20170929140540.13766-1-otubo@redhat.com>
	<20170929193139.GB17385@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9c365c30-8b63-f762-aa56-5b952b491aec@redhat.com>
Date: Mon, 2 Oct 2017 14:50:07 +0200
MIME-Version: 1.0
In-Reply-To: <20170929193139.GB17385@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv2] dma/i82374: avoid double creation of
 i82374 device
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Eduardo Otubo <otubo@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>
List-ID: <qemu-devel.nongnu.org>

On 29/09/2017 21:31, Eduardo Habkost wrote:
>> -void DMA_init(ISABus *bus, int high_page_enable)
>> +void DMA_init(ISABus *bus, int high_page_enable, Error **errp)
> 
> If you make the function return a boolean to indicate success (in
> addition to setting *errp), you avoid the need for a local_err
> variable on the caller.

I think in this case, rather than a bool, it would be better to return 0
or -EBUSY.  A check for "< 0" would be more self-explanatory in the caller.

Paolo
