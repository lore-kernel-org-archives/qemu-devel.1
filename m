Received: from eggs.gnu.org ([2001:4830:134:3::10]:48323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1ceJXx-0001BQ-Uz
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 05:44:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1ceJXu-0006sP-1A
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 05:44:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1ceJXt-0006s1-RU
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 05:44:17 -0500
References: <cover.1487224954.git.ben@skyportsystems.com>
	<a669a5fd5981d6bb4820f0d9915f5a2633638a6a.1487224954.git.ben@skyportsystems.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <33522509-9009-98b6-040e-0538de7c49f8@redhat.com>
Date: Thu, 16 Feb 2017 11:44:14 +0100
MIME-Version: 1.0
In-Reply-To: <a669a5fd5981d6bb4820f0d9915f5a2633638a6a.1487224954.git.ben@skyportsystems.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 8/8] MAINTAINERS: Add VM Generation ID
 entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ben@skyportsystems.com, qemu-devel@nongnu.org
Cc: imammedo@redhat.com, mst@redhat.com

On 02/16/17 07:18, ben@skyportsystems.com wrote:
> From: Ben Warren <ben@skyportsystems.com>
> 
> Also add BIOS tables entry
> 
> Signed-off-by: Ben Warren <ben@skyportsystems.com>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fb57d8e..e2e4b4f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -909,6 +909,7 @@ F: hw/acpi/*
>  F: hw/smbios/*
>  F: hw/i386/acpi-build.[hc]
>  F: hw/arm/virt-acpi-build.c
> +F: tests/bios-tables-test.c

(1) Please add:

tests/acpi-utils.c
tests/acpi-utils.h

(2) I think this hunk belongs to

[PATCH v7 6/8] tests: Move reusable ACPI code into a utility file

or else an entirely separate patch.

>  
>  ppc4xx
>  M: Alexander Graf <agraf@suse.de>
> @@ -1123,6 +1124,13 @@ F: hw/nvram/chrp_nvram.c
>  F: include/hw/nvram/chrp_nvram.h
>  F: tests/prom-env-test.c
>  
> +VM Generation ID
> +M: Ben Warren <ben@skyportsystems.com>
> +S: Maintained
> +F: hw/acpi/vmgenid.c
> +F: include/hw/acpi/vmgenid.h
> +F: tests/vmgenid-test.c
> +

(3) Please add:

docs/specs/vmgenid.txt
stubs/vmgenid.c

With those changes, for this patch:

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks
Laszlo


>  Subsystems
>  ----------
>  Audio
> 
