Received: from eggs.gnu.org ([2001:4830:134:3::10]:38998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1f3G1s-0007EL-DP
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 03:06:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1f3G1o-0004zt-CP
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 03:06:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52644 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1f3G1o-0004zS-6b
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 03:06:48 -0400
References: <20180322081837.21460-1-aik@ozlabs.ru>
	<6975e05c-da7a-5a96-4fb5-1234694136d0@redhat.com>
	<102833aa-9046-f4d7-0a66-71e67b89c78f@ozlabs.ru>
	<a77f5133-318c-c144-7ce2-fb264da0b246@redhat.com>
	<ce1e88d5-b09b-40c1-8e51-67d40a20ec8e@ozlabs.ru>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <5cef46c3-55c9-3ac7-756d-1d6c3a05fdb9@redhat.com>
Date: Tue, 3 Apr 2018 09:06:43 +0200
MIME-Version: 1.0
In-Reply-To: <ce1e88d5-b09b-40c1-8e51-67d40a20ec8e@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu] vfio: Print address space address
 when cannot map MMIO for DMA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>

Hi Alexey,

On 03/04/18 05:30, Alexey Kardashevskiy wrote:
> I get the point that it might be confusing and not matching "lspci -vb" but
> still - what is not correct about it? At the time when the message
> appeared, BAR was 0x100a0000.

Yes they were correct at the time the BAR was located at 0x100a0000 but.
But still I suspect the end-user most probably will not be able to
understand this and will interpret it as an error and report a bug;
whereas it works as before. So to me we should rather use a trace-event
for debug purpose until we find a way to output a usable hint for the
end-user.

Thanks

Eric
