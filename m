Received: from eggs.gnu.org ([2001:4830:134:3::10]:50601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eU9yG-00008E-Vx
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 06:34:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eU9yE-0002MH-3k
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 06:34:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eU9yD-0002KJ-Qb
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 06:34:02 -0500
Date: Wed, 27 Dec 2017 12:33:48 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171227123348.525f236b@igors-macbook-pro.local>
In-Reply-To: <20171214040855.22231-2-douly.fnst@cn.fujitsu.com>
References: <20171214040855.22231-1-douly.fnst@cn.fujitsu.com>
	<20171214040855.22231-2-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RESEND PATCH for-2.12 1/2] ACPI/unit-test: Add a
 testcase for RAM allocation in numa node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: ehabkost@redhat.com, mst@redhat.com, peter.maydell@linaro.org, indou.takao@jp.fujitsu.com, qemu-devel@nongnu.org

On Thu, 14 Dec 2017 12:08:54 +0800
Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:

> As QEMU supports the memory-less node, it is possible that there is
> no RAM in the first numa node(also be called as node0). eg:
>   ... \
>   -m 128,slots=3,maxmem=1G \
>   -numa node -numa node,mem=128M \
> 
> But, this makes it hard for QEMU to build a known-to-work ACPI SRAT
> table. Only fixing it is not enough.
> 
> Add a testcase for this situation to make sure the ACPI table is
> correct for guest.
> 
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
> ---
>  tests/acpi-test-data/pc/DSDT.numamem  | Bin 0 -> 5150 bytes
>  tests/acpi-test-data/pc/SRAT.numamem  | Bin 0 -> 224 bytes
>  tests/acpi-test-data/q35/DSDT.numamem | Bin 0 -> 7834 bytes
>  tests/acpi-test-data/q35/SRAT.numamem | Bin 0 -> 224 bytes
>  tests/bios-tables-test.c              |  24 ++++++++++++++++++++++++
>  5 files changed, 24 insertions(+)
>  create mode 100644 tests/acpi-test-data/pc/DSDT.numamem
>  create mode 100644 tests/acpi-test-data/pc/SRAT.numamem
>  create mode 100644 tests/acpi-test-data/q35/DSDT.numamem
>  create mode 100644 tests/acpi-test-data/q35/SRAT.numamem
> 
> diff --git a/tests/acpi-test-data/pc/DSDT.numamem b/tests/acpi-test-data/pc/DSDT.numamem
> new file mode 100644
> index 0000000000000000000000000000000000000000..224cfdd9e983e02dac5f4bf7e210eaa64cb0dc78
> GIT binary patch
> literal 5150
> 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
> X)TZG7kLVu(w1s%rZLs0M;`09i9gxjE
> 
> literal 0
> HcmV?d00001
> 
> diff --git a/tests/acpi-test-data/pc/SRAT.numamem b/tests/acpi-test-data/pc/SRAT.numamem
> new file mode 100644
> index 0000000000000000000000000000000000000000..dbc595d9cb85d3fcb5a4243153f42bb431c9de8f
> GIT binary patch
> literal 224
> zcmWFzatwLEz`(%x#mV2<BUr&HBEUHqD8>jB1F=Cg2*ZH@DxXmUE`z~9*2k!U%mXRq
> Yf~!ZCL8t>-1O^}2VG2>z!9?-X08OU~0RR91
> 
> literal 0
> HcmV?d00001
> 
> diff --git a/tests/acpi-test-data/q35/DSDT.numamem b/tests/acpi-test-data/q35/DSDT.numamem
> new file mode 100644
> index 0000000000000000000000000000000000000000..8c9fa445b0119b6f67533cb968855b41fb9925d9
> GIT binary patch
> literal 7834
> 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
> T7U*c>n%cO|8|hZC(G~v(I>Rw)
> 
> literal 0
> HcmV?d00001
> 
> diff --git a/tests/acpi-test-data/q35/SRAT.numamem b/tests/acpi-test-data/q35/SRAT.numamem
> new file mode 100644
> index 0000000000000000000000000000000000000000..dbc595d9cb85d3fcb5a4243153f42bb431c9de8f
> GIT binary patch
> literal 224
> zcmWFzatwLEz`(%x#mV2<BUr&HBEUHqD8>jB1F=Cg2*ZH@DxXmUE`z~9*2k!U%mXRq
> Yf~!ZCL8t>-1O^}2VG2>z!9?-X08OU~0RR91
> 
> literal 0
> HcmV?d00001
> 
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index e28e0c98cf..def81fc243 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -810,6 +810,28 @@ static void test_acpi_piix4_tcg_memhp(void)
>      free_test_data(&data);
>  }
>  
> +static void test_acpi_q35_tcg_numamem(void)
> +{
> +    test_data data;
> +
> +    memset(&data, 0, sizeof(data));
> +    data.machine = MACHINE_Q35;
> +    data.variant = ".numamem";
> +    test_acpi_one(" -numa node -numa node,mem=128", &data);
> +    free_test_data(&data);
> +}
> +
> +static void test_acpi_piix4_tcg_numamem(void)
> +{
> +    test_data data;
> +
> +    memset(&data, 0, sizeof(data));
> +    data.machine = MACHINE_PC;
> +    data.variant = ".numamem";
> +    test_acpi_one(" -numa node -numa node,mem=128", &data);
> +    free_test_data(&data);
> +}
> +
>  int main(int argc, char *argv[])
>  {
>      const char *arch = qtest_get_arch();
> @@ -832,6 +854,8 @@ int main(int argc, char *argv[])
>          qtest_add_func("acpi/q35/cpuhp", test_acpi_q35_tcg_cphp);
>          qtest_add_func("acpi/piix4/memhp", test_acpi_piix4_tcg_memhp);
>          qtest_add_func("acpi/q35/memhp", test_acpi_q35_tcg_memhp);
> +        qtest_add_func("acpi/piix4/numamem", test_acpi_piix4_tcg_numamem);
> +        qtest_add_func("acpi/q35/numamem", test_acpi_q35_tcg_numamem);
>      }
>      ret = g_test_run();
>      boot_sector_cleanup(disk);

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
