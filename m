Received: from eggs.gnu.org ([209.51.188.92]:43091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gjoWw-00087j-9y
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 11:59:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gjoWv-0000EP-Ij
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 11:59:06 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35206)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gjoWv-0000Df-CL
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 11:59:05 -0500
Received: by mail-wm1-f66.google.com with SMTP id t200so2792995wmt.0
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 08:59:05 -0800 (PST)
References: <1547566866-129386-1-git-send-email-imammedo@redhat.com>
	<1547566866-129386-10-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e5df2968-6064-73cd-a6ec-14fcdaba4101@redhat.com>
Date: Wed, 16 Jan 2019 17:59:02 +0100
MIME-Version: 1.0
In-Reply-To: <1547566866-129386-10-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 09/14] tests: acpi: move boot_sector_init()
 into x86 tests branch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Gonglei <arei.gonglei@huawei.com>, Laszlo Ersek <lersek@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, Andrew Jones <drjones@redhat.com>

On 1/15/19 4:41 PM, Igor Mammedov wrote:
> boot_sector_init() won't be used by arm/virt board, so move it from
> global scope to x86 branch that uses it.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  tests/bios-tables-test.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index d290dd2..d9efe59 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -799,13 +799,13 @@ int main(int argc, char *argv[])
>      const char *arch = qtest_get_arch();
>      int ret;
>  
> -    ret = boot_sector_init(disk);
> -    if(ret)
> -        return ret;
> -
>      g_test_init(&argc, &argv, NULL);
>  
>      if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
> +        ret = boot_sector_init(disk);
> +        if(ret)
> +           return ret;
> +
>          qtest_add_func("acpi/piix4", test_acpi_piix4_tcg);
>          qtest_add_func("acpi/piix4/bridge", test_acpi_piix4_tcg_bridge);
>          qtest_add_func("acpi/q35", test_acpi_q35_tcg);
> 
