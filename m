Received: from eggs.gnu.org ([2001:4830:134:3::10]:42892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gREWG-0000CA-OY
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 05:53:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gREWB-00029x-N9
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 05:53:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gREAt-0000fv-9T
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 05:31:31 -0500
Date: Mon, 26 Nov 2018 11:31:25 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181126113125.30275735@redhat.com>
In-Reply-To: <20181123111017-mutt-send-email-mst@kernel.org>
References: <1542882574-109418-1-git-send-email-imammedo@redhat.com>
	<20181123111017-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] acpi: RSDP: fix checksum calculations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, sameo@linux.intel.com, drjones@redhat.com, peter.maydell@linaro.org

On Fri, 23 Nov 2018 11:11:50 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Nov 22, 2018 at 11:29:32AM +0100, Igor Mammedov wrote:
> >  * arm/virt is broken but it looks like linux doesn't care, lets fix it anyways
> >  * x86, got lucky since we didn't use extended fields,
> >    fix it so that it will calculate checksum using correct length
> >    so that it would be easier to unify arm/x86 into one impl.
> >   
> 
> I'd say patch 2 should go into this release.
> What about patch 1? It's cosmetic and it isn't the best we can do.
> 
> Let me know whether you agree.
I'd say they are both 'cosmetic' as they don't cause guest
failure nor even warning (linux doesn't care (so far) and
we don't have windows for ARM to verify extended checksum). 
So we don't have to delay release for both of them.

I assumed that Samuel, would include patches in his RSDP
refactoring series and we would merge them as whole later on.


> 
> > Igor Mammedov (2):
> >   pc: acpi: use correct RSDT length for checksum
> >   arm/virt: acpi: fix incorrect checksums in RSDP
> > 
> >  hw/arm/virt-acpi-build.c | 7 ++++++-
> >  hw/i386/acpi-build.c     | 2 +-
> >  2 files changed, 7 insertions(+), 2 deletions(-)
> > 
> > -- 
> > 2.7.4  
