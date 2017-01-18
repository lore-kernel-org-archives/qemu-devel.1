Received: from eggs.gnu.org ([2001:4830:134:3::10]:50468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cTmDL-000320-3y
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 04:07:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cTmDG-0008Bw-1Q
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 04:07:31 -0500
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:36139)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cTmDF-0008BP-QQ
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 04:07:25 -0500
Received: by mail-lf0-x243.google.com with SMTP id h65so766593lfi.3
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 01:07:25 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170117193033.23178-1-ehabkost@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <089cc65d-6e44-5e73-82e0-36c4a7e8e867@redhat.com>
Date: Wed, 18 Jan 2017 10:07:24 +0100
MIME-Version: 1.0
In-Reply-To: <20170117193033.23178-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] Remove arch_init SMBIOS and ACPI code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>



On 17/01/2017 20:30, Eduardo Habkost wrote:
> This creates stubs for SMBIOS and ACPI option parsing functions,
> so that we don't need arch-specific #ifdefs in arch_init just for
> calling the option parsers.
> 
> Eduardo Habkost (3):
>   stubs: Add smbios_entry_add() stub
>   stubs: acpi_table_add() stub
>   arch_init: Move acpi_table_add() call back to vl.c
> 
>  include/sysemu/arch_init.h |  2 --
>  arch_init.c                | 20 --------------------
>  stubs/acpi.c               |  7 +++++++
>  stubs/smbios.c             |  7 +++++++
>  vl.c                       |  9 +++++++--
>  stubs/Makefile.objs        |  2 ++
>  6 files changed, 23 insertions(+), 24 deletions(-)
>  create mode 100644 stubs/acpi.c
>  create mode 100644 stubs/smbios.c
> 

Pretty much the same patches are in my pending pull request.

Paolo
