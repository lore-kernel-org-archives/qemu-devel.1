Received: from eggs.gnu.org ([2001:4830:134:3::10]:58445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dwPQa-0006Qu-UZ
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 05:11:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dwPQW-0001a2-Fb
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 05:11:48 -0400
References: <20170915090643.6043-1-otubo@redhat.com>
	<fbe31cc8-c628-32e6-90b0-0341ef1972d3@msgid.tls.msk.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0e84971b-592e-22f7-8815-2b3e193f6c1d@redhat.com>
Date: Mon, 25 Sep 2017 11:11:37 +0200
MIME-Version: 1.0
In-Reply-To: <fbe31cc8-c628-32e6-90b0-0341ef1972d3@msgid.tls.msk.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [[PATCH] dma/i82374: avoid double creation of
 i82374 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>, Eduardo Otubo <otubo@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, qemu-trivial@nongnu.org, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>

On 24/09/2017 23:02, Michael Tokarev wrote:
> 15.09.2017 12:06, Eduardo Otubo wrote:
>> QEMU fails when used with the following command line:
>>
>>   ./ppc64-softmmu/qemu-system-ppc64 -S -machine 40p,accel=tcg -device i82374
>>   qemu-system-ppc64: hw/isa/isa-bus.c:110: isa_bus_dma: Assertion `!bus->dma[0] && !bus->dma[1]' failed.
>>   Aborted (core dumped)
>>
>> The 40p machine type already creates the device i82374. If specified in the
>> command line, it will try to create it again, hence generating the error. The
>> function isa_bus_dma() isn't supposed to be called twice for the same bus. One
>> way to avoid this problem is to set user_creatable=false.
> 
> Applied to -trivial, thanks!

Eduardo, weren't you going to send a version that propagates Error*
correctly instead?

Paolo
