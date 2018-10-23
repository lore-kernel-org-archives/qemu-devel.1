Received: from eggs.gnu.org ([2001:4830:134:3::10]:33953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gF52c-0004Fj-Dw
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 18:20:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gF52X-0001E4-6u
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 18:20:46 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51526)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gF52W-00018m-Ru
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 18:20:41 -0400
Received: by mail-wm1-f67.google.com with SMTP id 143-v6so3316498wmf.1
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 15:20:38 -0700 (PDT)
References: <20181022183656.4902-1-sameo@linux.intel.com>
	<20181022183656.4902-18-sameo@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bf28ee56-7d18-d98f-d116-3c076a424992@redhat.com>
Date: Wed, 24 Oct 2018 00:20:34 +0200
MIME-Version: 1.0
In-Reply-To: <20181022183656.4902-18-sameo@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 17/26] hw: i386: Convert PC machine type to
 firmware build methods
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On 22/10/2018 20:36, Samuel Ortiz wrote:
> +    /* Firmware building handler */
> +    mc->firmware_build_methods.acpi.madt = build_madt;
> +    mc->firmware_build_methods.acpi.rsdp = build_rsdp_rsdt;
> +    mc->firmware_build_methods.acpi.setup = acpi_setup;
> +    mc->firmware_build_methods.acpi.mcfg = build_mcfg;
> +    mc->firmware_build_methods.acpi.srat = build_srat;
> +    mc->firmware_build_methods.acpi.slit = build_slit;
> +

mc->firmware_build_methods.acpi.setup is not called anywhere, as far as
I can see?

Paolo
