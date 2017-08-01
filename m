Received: from eggs.gnu.org ([2001:4830:134:3::10]:58363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dcb1s-0002rV-Lq
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 13:32:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dcb1p-00051x-Ig
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 13:32:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dcb1p-00051G-C1
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 13:32:21 -0400
Date: Tue, 1 Aug 2017 20:32:08 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170801203102-mutt-send-email-mst@kernel.org>
References: <20170726094235.14267-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170726094235.14267-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [seabios PATCH for qemu 2.10 0/2] seabios: build
 ACPI 1.0-compatible ACPI tables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: seabios@seabios.org, Kevin O'Connor <kevin@koconnor.net>, qemu-devel@nongnu.org, lersek@redhat.com, lists@philjordan.eu, imammedo@redhat.com, phil@philjordan.eu, programmingkidx@gmail.com, kraxel@redhat.com

On Wed, Jul 26, 2017 at 11:42:33AM +0200, Paolo Bonzini wrote:
> Old operating systems would like to have a rev1 (ACPI 1.0) FADT, but
> new operating systems would like to have rev3 (ACPI 2.0).
> Since old operating systems do not know about XSDTs, the
> solution is to point the RSDT to a v1 FADT and the XSDT to a
> rev3 FADT.

So I think for 2.10 Igor's patch is much smaller and only
touches QEMU, I'm inclined to merge just that one.
Let's discuss this after 2.10 is out.

> 
> Paolo Bonzini (2):
>   seabios: build RSDT from XSDT
>   seabios: create rev1 FADT in compatibility RSDT
> 
>  src/fw/paravirt.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  src/std/acpi.h    | 11 +++++++++
>  2 files changed, 78 insertions(+), 1 deletion(-)
> 
> -- 
> 2.13.3
