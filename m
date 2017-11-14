Received: from eggs.gnu.org ([2001:4830:134:3::10]:55549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eEVwL-0002xm-A8
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 02:47:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eEVwI-0007rm-72
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 02:47:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eEVwH-0007qv-UU
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 02:47:22 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F116D68694
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 07:47:20 +0000 (UTC)
Received: from [10.36.116.149] (ovpn-116-149.ams2.redhat.com [10.36.116.149])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6BE902A2E6
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 07:47:20 +0000 (UTC)
References: <cover.1510612380.git.alistair.francis@xilinx.com>
	<df19adc81d183a5030fc07c2cfc0cab65616562b.1510612380.git.alistair.francis@xilinx.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <039b6d90-5d99-85a3-b719-28e9e394c64f@redhat.com>
Date: Tue, 14 Nov 2017 08:47:18 +0100
MIME-Version: 1.0
In-Reply-To: <df19adc81d183a5030fc07c2cfc0cab65616562b.1510612380.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 27/29] hw/xen*: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 13.11.2017 23:36, Alistair Francis wrote:
> Replace a large number of the fprintf(stderr, "*\n" calls with
> error_report(). The functions were renamed with these commands and then
> compiler issues where manually fixed.
> 
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> 
> Some lines where then manually tweaked to pass checkpatch.
> 
> xen_pt_log() was left with an fprintf(stderr,
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Acked-by: Anthony PERARD <anthony.perard@citrix.com>
> ---
> V3:
>  - Don't change xen_pt_log()
> V2:
>  - Split hw patch into individual directories
> 
>  hw/xen/xen-common.c        | 11 ++++++-----
>  hw/xenpv/xen_domainbuild.c | 24 ++++++++++++------------
>  hw/xenpv/xen_machine_pv.c  |  9 +++++----
>  3 files changed, 23 insertions(+), 21 deletions(-)
> 
> diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
> index 632a938dcc..42ada2ac05 100644
> --- a/hw/xen/xen-common.c
> +++ b/hw/xen/xen-common.c
> @@ -9,6 +9,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  #include "hw/xen/xen_backend.h"
>  #include "qmp-commands.h"
>  #include "chardev/char.h"
> @@ -47,19 +48,19 @@ static int store_dev_info(int domid, Chardev *cs, const char *string)
>      /* We now have everything we need to set the xenstore entry. */
>      xs = xs_open(0);
>      if (xs == NULL) {
> -        fprintf(stderr, "Could not contact XenStore\n");
> +        error_report("Could not contact XenStore");
>          goto out;
>      }
>  
>      path = xs_get_domain_path(xs, domid);
>      if (path == NULL) {
> -        fprintf(stderr, "xs_get_domain_path() error\n");
> +        error_report("xs_get_domain_path() error");
>          goto out;
>      }
>      newpath = realloc(path, (strlen(path) + strlen(string) +
>                  strlen("/tty") + 1));
>      if (newpath == NULL) {
> -        fprintf(stderr, "realloc error\n");
> +        error_report("realloc error");
>          goto out;
>      }
>      path = newpath;
> @@ -96,13 +97,13 @@ static void xenstore_record_dm_state(struct xs_handle *xs, const char *state)
>      char path[50];
>  
>      if (xs == NULL) {
> -        fprintf(stderr, "xenstore connection not initialized\n");
> +        error_report("xenstore connection not initialized");
>          exit(1);
>      }
>  
>      snprintf(path, sizeof (path), "device-model/%u/state", xen_domid);
>      if (!xs_write(xs, XBT_NULL, path, state, strlen(state))) {
> -        fprintf(stderr, "error recording dm state\n");
> +        error_report("error recording dm state");
>          exit(1);
>      }
>  }
> diff --git a/hw/xenpv/xen_domainbuild.c b/hw/xenpv/xen_domainbuild.c
> index 027f76fad1..f5514ffec2 100644
> --- a/hw/xenpv/xen_domainbuild.c
> +++ b/hw/xenpv/xen_domainbuild.c
> @@ -25,22 +25,22 @@ static int xenstore_domain_mkdir(char *path)
>      int i;
>  
>      if (!xs_mkdir(xenstore, 0, path)) {
> -        fprintf(stderr, "%s: xs_mkdir %s: failed\n", __func__, path);
> -	return -1;
> +        error_report("%s: xs_mkdir %s: failed", __func__, path);
> +        return -1;
>      }
>      if (!xs_set_permissions(xenstore, 0, path, perms_ro, 2)) {
> -        fprintf(stderr, "%s: xs_set_permissions failed\n", __func__);
> -	return -1;
> +        error_report("%s: xs_set_permissions failed", __func__);
> +        return -1;
>      }

Bonus points for fixing the bad indentation of the return statements :-)

Patch looks fine to me!

Reviewed-by: Thomas Huth <thuth@redhat.com>
