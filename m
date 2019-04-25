Received: from eggs.gnu.org ([209.51.188.92]:52130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJZeZ-00011Y-V0
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 04:22:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJZeY-0007aR-6A
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 04:22:47 -0400
Received: from mga01.intel.com ([192.55.52.88]:22899)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hJZeX-0007XN-Gm
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 04:22:45 -0400
Date: Thu, 25 Apr 2019 16:22:11 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190425082211.GG24829@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <1556170489-131927-1-git-send-email-imammedo@redhat.com>
	<1556170489-131927-14-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556170489-131927-14-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 13/13] tests: acpi: print error unable
 to dump ACPI table during rebuild
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, Wei Yang <richardw.yang@linux.intel.com>, Andrew Jones <drjones@redhat.com>, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, Ben Warren <ben@skyportsystems.com>

On Thu, Apr 25, 2019 at 07:34:49AM +0200, Igor Mammedov wrote:
>Instead of just asserting print the error that lead to assert first.
>While at it move assert into rebuild branch, which removes reduntant
>check done in case of !rebuild branch is taken (the later is taken
>care of by g_assert_no_error).
>
>Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>

>---
> tests/bios-tables-test.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>
>diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
>index f117461..5a5d036 100644
>--- a/tests/bios-tables-test.c
>+++ b/tests/bios-tables-test.c
>@@ -199,11 +199,14 @@ static void dump_aml_files(test_data *data, bool rebuild)
>                                        sdt->aml, ext);
>             fd = g_open(aml_file, O_WRONLY|O_TRUNC|O_CREAT,
>                         S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP|S_IROTH);
>+            if (fd < 0) {
>+                perror(aml_file);
>+            }
>+            g_assert(fd >= 0);
>         } else {
>             fd = g_file_open_tmp("aml-XXXXXX", &sdt->aml_file, &error);
>             g_assert_no_error(error);
>         }
>-        g_assert(fd >= 0);
> 
>         ret = qemu_write_full(fd, sdt->aml, sdt->aml_len);
>         g_assert(ret == sdt->aml_len);
>-- 
>2.7.4

-- 
Wei Yang
Help you, Help me
