Received: from eggs.gnu.org ([2001:4830:134:3::10]:58402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gRbcM-0000iy-0V
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:33:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gRbcL-0003v8-8u
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:33:25 -0500
References: <20181125205000.10324-1-philmd@redhat.com>
	<20181125205000.10324-2-philmd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <d5a96abc-c384-3f3c-5f95-8b08887ef423@vivier.eu>
Date: Tue, 27 Nov 2018 12:33:11 +0100
MIME-Version: 1.0
In-Reply-To: <20181125205000.10324-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH for-3.1 01/25] MAINTAINERS:
 Fix ACPI tests data files path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

On 25/11/2018 21:49, Philippe Mathieu-Daudé wrote:
> Missed while moving those files in 438c78dab75.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  MAINTAINERS | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1032406c56..6c4f25fb05 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1216,8 +1216,7 @@ F: hw/i386/acpi-build.[hc]
>  F: hw/arm/virt-acpi-build.c
>  F: tests/bios-tables-test.c
>  F: tests/acpi-utils.[hc]
> -F: tests/acpi-test-data/*
> -F: tests/acpi-test-data/*/*
> +F: tests/data/acpi/
>  
>  ppc4xx
>  M: David Gibson <david@gibson.dropbear.id.au>
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
