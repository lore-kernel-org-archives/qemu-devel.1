Received: from eggs.gnu.org ([2001:4830:134:3::10]:40351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fxtCa-0007L8-NS
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 08:16:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fxszx-0002x1-Fw
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 08:03:00 -0400
References: <20180906055736.20256-1-mark.cave-ayland@ilande.co.uk>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5c204531-2e59-4166-0325-745e4aa98531@redhat.com>
Date: Thu, 6 Sep 2018 14:02:51 +0200
MIME-Version: 1.0
In-Reply-To: <20180906055736.20256-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] scsi: remove lsi53c895a_create() and
 lsi53c810_create() functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, pbonzini@redhat.com, famz@redhat.com, hpoussin@reactos.org, rth@twiddle.net, peter.maydell@linaro.org, armbru@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On 2018-09-06 07:57, Mark Cave-Ayland wrote:
> As part of an upcoming 40p patchset I have a requirement to change the PCI
> configuration of the LSI SCSI. However since commits a64aa5785d "hw: Deprecate -drive
> if=scsi with non-onboard HBAs" and b891538e81 "hw/ppc/prep: Fix implicit creation of
> "-drive if=scsi", the lsi53c8*_create() wrapper functions don't return the device
> state itself.
> 
> Rather than altering these functions to return PCIDevice I simply went ahead and split
> the LSIState structure and QOM types into a new lsi53c895a.h file, as is fairly
> standard QEMU practice.
> 
> Not only does this enable me to change the PCI configuration of the LSI SCSI device
> in an upcoming patchset, but it also allows full access to LSIState if required
> (which is fairly similar to how the code was arranged before a64aa5785d).

I somehow fail to see that something outside of lsi53c895a.c should
really need to access the internals of LSIState. If there is something
that needs to be configured from the outside, it should be done via QOM
properties instead, shouldn't it? So I think I'd rather prefer if you
could do it the other way round and change the lsi*_create() functions
to return a pointer to PCIDevice instead, if possible.

 Thomas
