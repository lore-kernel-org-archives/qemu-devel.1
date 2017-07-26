Received: from eggs.gnu.org ([2001:4830:134:3::10]:60555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1daSoq-0001Ru-8f
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 16:22:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1daSon-00032m-KU
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 16:22:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1daSon-000322-Ee
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 16:22:05 -0400
Date: Wed, 26 Jul 2017 16:22:00 -0400 (EDT)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <771944749.19250153.1501100520383.JavaMail.zimbra@redhat.com>
In-Reply-To: <20170726230055-mutt-send-email-mst@kernel.org>
References: <20170726094235.14267-1-pbonzini@redhat.com>
	<20170726094235.14267-2-pbonzini@redhat.com>
	<20170726230055-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [seabios PATCH 1/2] seabios: build RSDT from XSDT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: seabios@seabios.org, Kevin O'Connor <kevin@koconnor.net>, qemu-devel@nongnu.org, lersek@redhat.com, lists@philjordan.eu, imammedo@redhat.com, phil@philjordan.eu, programmingkidx@gmail.com, kraxel@redhat.com



----- Original Message -----
> From: "Michael S. Tsirkin" <mst@redhat.com>
> To: "Paolo Bonzini" <pbonzini@redhat.com>
> Cc: seabios@seabios.org, "Kevin O'Connor" <kevin@koconnor.net>, qemu-devel@nongnu.org, lersek@redhat.com,
> lists@philjordan.eu, imammedo@redhat.com, phil@philjordan.eu, programmingkidx@gmail.com, kraxel@redhat.com
> Sent: Wednesday, July 26, 2017 10:05:03 PM
> Subject: Re: [seabios PATCH 1/2] seabios: build RSDT from XSDT
> 
> On Wed, Jul 26, 2017 at 11:42:34AM +0200, Paolo Bonzini wrote:
> > Old operating systems would like to have a rev1 (ACPI 1.0) FADT, but
> > new operating systems would like to have rev3 (ACPI 2.0).
> > 
> > Since old operating systems do not know about XSDTs, the
> > solution is to point the RSDT to a rev1 FADT and the XSDT to a
> > rev3 FADT.
> > 
> > But, edk2 is not able to handle QEMU providing two FADTs and barfs when
> > it sees the second; edk2 subscribes to the view that the platform code
> > (meaning not only OVMF, but transitively QEMU's ACPI table builder)
> > should not handle such hacks; it's common edk2 code that should handle
> > FADT rev1 vs. rev3 and RSDT vs. XSDT.
> 
> What exactly does it do wrt RSDT?

It ignores the one produced by QEMU and builds it from scratch.  Same
for RSDP and XSDT.

Paolo
