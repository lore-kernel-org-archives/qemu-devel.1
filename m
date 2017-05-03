Received: from eggs.gnu.org ([2001:4830:134:3::10]:42594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d5tzw-0007pm-E0
	for qemu-devel@nongnu.org; Wed, 03 May 2017 09:07:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d5tzr-0005ti-OB
	for qemu-devel@nongnu.org; Wed, 03 May 2017 09:07:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1d5tzr-0005tD-EU
	for qemu-devel@nongnu.org; Wed, 03 May 2017 09:07:11 -0400
Date: Wed, 3 May 2017 15:07:05 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170503150705.7a55ca5c@nial.brq.redhat.com>
In-Reply-To: <1493803036-4048-1-git-send-email-he.chen@linux.intel.com>
References: <1493803036-4048-1-git-send-email-he.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tests: acpi: extend cphp and memhp
 testcase with numa distance check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: He Chen <he.chen@linux.intel.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Andrew Jones <drjones@redhat.com>

On Wed,  3 May 2017 17:17:16 +0800
He Chen <he.chen@linux.intel.com> wrote:

> Signed-off-by: He Chen <he.chen@linux.intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

Eduardo,

could you take it through your tree as well and
add as part of this patch SLIT tables blobs for
piix4/q35 that tests/acpi-test-data/rebuild-expected-aml.sh
will generate.

> ---
>  tests/bios-tables-test.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index 88dbf97..c593165 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -710,7 +710,8 @@ static void test_acpi_piix4_tcg_cphp(void)
>      data.machine = MACHINE_PC;
>      data.variant = ".cphp";
>      test_acpi_one("-smp 2,cores=3,sockets=2,maxcpus=6"
> -                  " -numa node -numa node",
> +                  " -numa node -numa node"
> +                  " -numa dist,src=0,dst=1,val=21",
>                    &data);
>      free_test_data(&data);
>  }
> @@ -723,7 +724,8 @@ static void test_acpi_q35_tcg_cphp(void)
>      data.machine = MACHINE_Q35;
>      data.variant = ".cphp";
>      test_acpi_one(" -smp 2,cores=3,sockets=2,maxcpus=6"
> -                  " -numa node -numa node",
> +                  " -numa node -numa node"
> +                  " -numa dist,src=0,dst=1,val=21",
>                    &data);
>      free_test_data(&data);
>  }
> @@ -772,7 +774,10 @@ static void test_acpi_q35_tcg_memhp(void)
>      memset(&data, 0, sizeof(data));
>      data.machine = MACHINE_Q35;
>      data.variant = ".memhp";
> -    test_acpi_one(" -m 128,slots=3,maxmem=1G -numa node", &data);
> +    test_acpi_one(" -m 128,slots=3,maxmem=1G"
> +                  " -numa node -numa node"
> +                  " -numa dist,src=0,dst=1,val=21",
> +                  &data);
>      free_test_data(&data);
>  }
>  
> @@ -783,7 +788,10 @@ static void test_acpi_piix4_tcg_memhp(void)
>      memset(&data, 0, sizeof(data));
>      data.machine = MACHINE_PC;
>      data.variant = ".memhp";
> -    test_acpi_one(" -m 128,slots=3,maxmem=1G -numa node", &data);
> +    test_acpi_one(" -m 128,slots=3,maxmem=1G"
> +                  " -numa node -numa node"
> +                  " -numa dist,src=0,dst=1,val=21",
> +                  &data);
>      free_test_data(&data);
>  }
>  
