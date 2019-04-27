Received: from eggs.gnu.org ([209.51.188.92]:43514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKOZk-0005dm-NK
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 10:45:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKOYN-0000uN-Np
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 10:43:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39207)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hKOYM-0000lA-3M
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 10:43:47 -0400
Received: by mail-wr1-f66.google.com with SMTP id a9so8649456wrp.6
	for <qemu-devel@nongnu.org>; Sat, 27 Apr 2019 07:43:42 -0700 (PDT)
References: <20190427144025.22880-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6e3003f3-3d96-c1be-6890-baa2c61d34dc@redhat.com>
Date: Sat, 27 Apr 2019 16:43:39 +0200
MIME-Version: 1.0
In-Reply-To: <20190427144025.22880-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/3] hw/i386/acpi: Improve build modularity
 (isapc/q35/...)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Yang Zhong <yang.zhong@intel.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>

On 4/27/19 4:40 PM, Philippe Mathieu-Daudé wrote:
> This series allow to build the ISAPC/Q35 machines independently.

Oops I guess I forgot:
Based-on: 20190427141905.20393-1-philmd@redhat.com
(i440fx is not a machine)
https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg04673.html

> 
> Regards,
> 
> Phil.
> 
> Philippe Mathieu-Daudé (3):
>   hw/acpi/piix4: Move TYPE_PIIX4_PM to a public header
>   hw/i386/acpi: Add object_resolve_type_unambiguous to improve
>     modularity
>   hw/i386/acpi: Assert a pointer is not null BEFORE using it
> 
>  hw/acpi/piix4.c         | 13 -------------
>  hw/i386/acpi-build.c    | 22 +++++++++++++++++-----
>  hw/isa/lpc_ich9.c       | 11 -----------
>  include/hw/acpi/piix4.h |  2 +-
>  include/hw/i386/ich9.h  |  2 --
>  5 files changed, 18 insertions(+), 32 deletions(-)
> 
