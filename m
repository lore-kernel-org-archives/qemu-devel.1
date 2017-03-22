Received: from eggs.gnu.org ([2001:4830:134:3::10]:46338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cqgS8-0002Y9-UX
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 09:37:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cqgS4-00032q-Eb
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 09:37:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cqgS4-00031Y-8L
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 09:37:24 -0400
References: <4712D8F4B26E034E80552F30A67BE0B1A2D69E@ORSMSX112.amr.corp.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cce399b0-45d2-ac24-4975-6e27ad04f833@redhat.com>
Date: Wed, 22 Mar 2017 14:37:21 +0100
MIME-Version: 1.0
In-Reply-To: <4712D8F4B26E034E80552F30A67BE0B1A2D69E@ORSMSX112.amr.corp.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] only link current target arch traces to
 qemu-system
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Xu, Anthony" <anthony.xu@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>



On 22/03/2017 03:03, Xu, Anthony wrote:
> When building target x86_64-softmmu, all other architectures' trace.o are linked into 
> x86_64-softmmu/qemu-system-x86_64, like hw/arm/trace.o, hw/mips/trace.o etc., 
> that is not necessary.
>  Same thing happens when building other targets.
> 
> Only current target arch traces should be linked into qemu-system.
> 
> Signed-off -by: Anthony Xu <anthony.xu@intel.com>

It's a bit cleaner, but does the benefit outweight the maintenance cost
of the additional code added to the Makefiles?

Paolo
