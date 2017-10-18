Received: from eggs.gnu.org ([2001:4830:134:3::10]:34576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1e4jzW-0005ag-Mc
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 04:46:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1e4jzS-0008FD-HW
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 04:46:18 -0400
References: <1508247148-25240-1-git-send-email-thuth@redhat.com>
	<1508247148-25240-2-git-send-email-thuth@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <55077ede-27be-64f7-657b-f3688b7642c7@redhat.com>
Date: Wed, 18 Oct 2017 10:46:09 +0200
MIME-Version: 1.0
In-Reply-To: <1508247148-25240-2-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/4] tests: Rename pc-cpu-test.c to
 cpu-plug-test.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>

On 17.10.2017 15:32, Thomas Huth wrote:
> The test will be extended to work on other architectures, too, so let's
> use a more generic name for the file and the functions in here first.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/Makefile.include                   |  4 ++--
>  tests/{pc-cpu-test.c => cpu-plug-test.c} | 24 ++++++++++++------------
>  2 files changed, 14 insertions(+), 14 deletions(-)
>  rename tests/{pc-cpu-test.c => cpu-plug-test.c} (87%)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 4ca15e6..3d7e814 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -276,7 +276,7 @@ gcov-files-i386-y += hw/usb/dev-hid.c
>  gcov-files-i386-y += hw/usb/dev-storage.c
>  check-qtest-i386-y += tests/usb-hcd-xhci-test$(EXESUF)
>  gcov-files-i386-y += hw/usb/hcd-xhci.c
> -check-qtest-i386-y += tests/pc-cpu-test$(EXESUF)
> +check-qtest-i386-y += tests/cpu-plug-test$(EXESUF)
>  check-qtest-i386-y += tests/q35-test$(EXESUF)
>  check-qtest-i386-y += tests/vmgenid-test$(EXESUF)
>  gcov-files-i386-y += hw/pci-host/q35.c
> @@ -780,7 +780,7 @@ tests/usb-hcd-ohci-test$(EXESUF): tests/usb-hcd-ohci-test.o $(libqos-usb-obj-y)
>  tests/usb-hcd-uhci-test$(EXESUF): tests/usb-hcd-uhci-test.o $(libqos-usb-obj-y)
>  tests/usb-hcd-ehci-test$(EXESUF): tests/usb-hcd-ehci-test.o $(libqos-usb-obj-y)
>  tests/usb-hcd-xhci-test$(EXESUF): tests/usb-hcd-xhci-test.o $(libqos-usb-obj-y)
> -tests/pc-cpu-test$(EXESUF): tests/pc-cpu-test.o
> +tests/cpu-plug-test$(EXESUF): tests/cpu-plug-test.o
>  tests/postcopy-test$(EXESUF): tests/postcopy-test.o
>  tests/vhost-user-test$(EXESUF): tests/vhost-user-test.o $(test-util-obj-y) \
>  	$(qtest-obj-y) $(test-io-obj-y) $(libqos-virtio-obj-y) $(libqos-pc-obj-y) \
> diff --git a/tests/pc-cpu-test.c b/tests/cpu-plug-test.c
> similarity index 87%
> rename from tests/pc-cpu-test.c
> rename to tests/cpu-plug-test.c
> index 11d3e81..4579119 100644
> --- a/tests/pc-cpu-test.c
> +++ b/tests/cpu-plug-test.c
> @@ -1,5 +1,5 @@
>  /*
> - * QTest testcase for PC CPUs
> + * QTest testcase for CPU plugging
>   *
>   * Copyright (c) 2015 SUSE Linux GmbH
>   *
> @@ -13,7 +13,7 @@
>  #include "libqtest.h"
>  #include "qapi/qmp/types.h"
>  
> -struct PCTestData {
> +struct PlugTestData {
>      char *machine;
>      const char *cpu_model;
>      unsigned sockets;
> @@ -21,11 +21,11 @@ struct PCTestData {
>      unsigned threads;
>      unsigned maxcpus;
>  };
> -typedef struct PCTestData PCTestData;
> +typedef struct PlugTestData PlugTestData;
>  
> -static void test_pc_with_cpu_add(gconstpointer data)
> +static void test_plug_with_cpu_add(gconstpointer data)
>  {
> -    const PCTestData *s = data;
> +    const PlugTestData *s = data;
>      char *args;
>      QDict *response;
>      unsigned int i;
> @@ -48,9 +48,9 @@ static void test_pc_with_cpu_add(gconstpointer data)
>      g_free(args);
>  }
>  
> -static void test_pc_without_cpu_add(gconstpointer data)
> +static void test_plug_without_cpu_add(gconstpointer data)
>  {
> -    const PCTestData *s = data;
> +    const PlugTestData *s = data;
>      char *args;
>      QDict *response;
>  
> @@ -73,7 +73,7 @@ static void test_pc_without_cpu_add(gconstpointer data)
>  
>  static void test_data_free(gpointer data)
>  {
> -    PCTestData *pc = data;
> +    PlugTestData *pc = data;
>  
>      g_free(pc->machine);
>      g_free(pc);
> @@ -82,12 +82,12 @@ static void test_data_free(gpointer data)
>  static void add_pc_test_case(const char *mname)
>  {
>      char *path;
> -    PCTestData *data;
> +    PlugTestData *data;
>  
>      if (!g_str_has_prefix(mname, "pc-")) {
>          return;
>      }
> -    data = g_new(PCTestData, 1);
> +    data = g_new(PlugTestData, 1);
>      data->machine = g_strdup(mname);
>      data->cpu_model = "Haswell"; /* 1.3+ theoretically */
>      data->sockets = 1;
> @@ -108,14 +108,14 @@ static void add_pc_test_case(const char *mname)
>          path = g_strdup_printf("cpu/%s/init/%ux%ux%u&maxcpus=%u",
>                                 mname, data->sockets, data->cores,
>                                 data->threads, data->maxcpus);
> -        qtest_add_data_func_full(path, data, test_pc_without_cpu_add,
> +        qtest_add_data_func_full(path, data, test_plug_without_cpu_add,
>                                   test_data_free);
>          g_free(path);
>      } else {
>          path = g_strdup_printf("cpu/%s/add/%ux%ux%u&maxcpus=%u",
>                                 mname, data->sockets, data->cores,
>                                 data->threads, data->maxcpus);
> -        qtest_add_data_func_full(path, data, test_pc_with_cpu_add,
> +        qtest_add_data_func_full(path, data, test_plug_with_cpu_add,
>                                   test_data_free);
>          g_free(path);
>      }
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David
