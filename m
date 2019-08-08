Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F38C0650F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 09:05:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BEEF2173E
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 09:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BEEF2173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hveMh-0006cg-JI
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 05:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45064)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hveME-000668-Bc
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 05:05:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hveMC-0005YB-Pd
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 05:05:14 -0400
Received: from 1.mo4.mail-out.ovh.net ([178.33.248.196]:34589)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hveMC-0005XE-IZ
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 05:05:12 -0400
Received: from player789.ha.ovh.net (unknown [10.108.42.228])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 0AE9C2019B2
 for <qemu-devel@nongnu.org>; Thu,  8 Aug 2019 11:05:09 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player789.ha.ovh.net (Postfix) with ESMTPSA id A2D008AADC55;
 Thu,  8 Aug 2019 09:04:56 +0000 (UTC)
To: Balamuruhan S <bala24@linux.ibm.com>, qemu-devel@nongnu.org
References: <20190807071445.4109-1-bala24@linux.ibm.com>
 <20190807071445.4109-3-bala24@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <1969bbf9-0d08-5ed5-b626-7355e5247253@kaod.org>
Date: Thu, 8 Aug 2019 11:04:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190807071445.4109-3-bala24@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 16556639605786774483
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudduhedgudefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.248.196
Subject: Re: [Qemu-devel] [RFC PATCH 2/6] hw/ppc/pnv_xscom: extend xscom to
 use python interface
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, maddy@linux.vnet.ibm.com,
 anju@linux.vnet.ibm.com, Joel Stanley <joel@jms.id.au>,
 hari@linux.vnet.ibm.com, pbonzini@redhat.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/08/2019 09:14, Balamuruhan S wrote:
> Existing xscom access emulation for read/write can be
> extended with the python interface to support feeding
> data externally.

You should take a look at Rashmica's patch :

  hw/gpio: Add basic Aspeed GPIO model for AST2400 and AST2500
  https://patchwork.ozlabs.org/patch/1138787

The patch generates model properties in the instance_init handler 
for all Aspeed GPIO pins (a lot) that can then be un/set from the 
QEMU monitor to tweak the values exposed to the guest. It integrates 
well in QEMU and its unit test framework. This is a complex example,
they are simpler ones in QEMU.


I think you could do the same for the OCC SRAM which exposes in host 
memory a large set of data to the PowerNV machine, sensors, pstates, 
etc. You would need to define the properties on top of the structures 
which are shared with the host.

You could follow the same pattern for other well known XSCOM registers.

From there, it is relatively simple to write automated unit tests or 
a tui/gui to tweak at runtime the OCC data of the machine through the 
model properties.

Anyhow, first, we need to extend and correct the PowerNV models that
you are using.  


Thanks,

C.

 
> 
> Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
> ---
>  hw/ppc/pnv_xscom.c      | 31 ++++++++++++++++++++++++++++---
>  include/sysemu/sysemu.h |  4 ++++
>  qemu-options.hx         | 14 ++++++++++++++
>  vl.c                    | 42 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 88 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
> index 2b81c75f56..5d5b5e9884 100644
> --- a/hw/ppc/pnv_xscom.c
> +++ b/hw/ppc/pnv_xscom.c
> @@ -17,11 +17,13 @@
>   * License along with this library; if not, see <http://www.gnu.org/licenses/>.
>   */
>  
> +#include "sysemu/python_api.h"
>  #include "qemu/osdep.h"
>  #include "hw/hw.h"
>  #include "qemu/log.h"
>  #include "qemu/module.h"
>  #include "sysemu/hw_accel.h"
> +#include "sysemu/sysemu.h"
>  #include "target/ppc/cpu.h"
>  #include "hw/sysbus.h"
>  
> @@ -157,8 +159,20 @@ static uint64_t xscom_read(void *opaque, hwaddr addr, unsigned width)
>      uint64_t val = 0;
>      MemTxResult result;
>  
> -    /* Handle some SCOMs here before dispatch */
> -    val = xscom_read_default(chip, pcba);
> +    if (xscom_module && xscom_readp) {
> +        char **args = g_malloc(2 * sizeof(uint64_t));
> +        PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
> +        python_args_init_cast_long(args, pcba, 0);
> +        python_args_init_cast_int(args, pcc->chip_type, 1);
> +        val = python_callback_int(module_path, xscom_module, xscom_readp,
> +                                  args, 2);
> +        python_args_clean(args, 2);
> +        g_free(args);
> +    }
> +    else {
> +        /* Handle some SCOMs here before dispatch */
> +        val = xscom_read_default(chip, pcba);
> +    }
>      if (val != -1) {
>          goto complete;
>      }
> @@ -184,8 +198,19 @@ static void xscom_write(void *opaque, hwaddr addr, uint64_t val,
>      uint32_t pcba = pnv_xscom_pcba(chip, addr);
>      MemTxResult result;
>  
> +    if (xscom_module && xscom_writep) {
> +        char **args = g_malloc(sizeof(uint64_t));
> +        bool xscom_success;
> +        python_args_init_cast_long(args, pcba, 0);
> +        xscom_success = python_callback_bool(module_path, xscom_module,
> +                                             xscom_writep, args, 1);
> +        python_args_clean(args, 1);
> +        g_free(args);
> +        if (xscom_success)
> +            goto complete;
> +    }
>      /* Handle some SCOMs here before dispatch */
> -    if (xscom_write_default(chip, pcba, val)) {
> +    else if (xscom_write_default(chip, pcba, val)) {
>          goto complete;
>      }
>  
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 984c439ac9..9b8dc346d6 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -117,6 +117,10 @@ extern bool enable_mlock;
>  extern bool enable_cpu_pm;
>  extern QEMUClockType rtc_clock;
>  extern const char *mem_path;
> +extern const char *module_path;
> +extern const char *xscom_module;
> +extern const char *xscom_readp;
> +extern const char *xscom_writep;
>  extern int mem_prealloc;
>  
>  #define MAX_NODES 128
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 9621e934c0..06c9f34d99 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -385,6 +385,20 @@ STEXI
>  Allocate guest RAM from a temporarily created file in @var{path}.
>  ETEXI
>  
> +DEF("module-path", HAS_ARG, QEMU_OPTION_modulepath,
> +    "-module-path FILE  provide absolute path where python modules"
> +    "resides\n", QEMU_ARCH_ALL)
> +STEXI
> +@item -module-path [path=]@var{absolute path}[,homer_module=homer,homer_func=func1]
> +@findex -module-path
> +Provides information about where the python modules exist and the callback
> +functions defined.
> +
> +@example
> +qemu-system-ppc64 -module-path /home/modules/,homer_module=homer,homer_func=homer_read
> +@end example
> +ETEXI
> +
>  DEF("mem-prealloc", 0, QEMU_OPTION_mem_prealloc,
>      "-mem-prealloc   preallocate guest memory (use with -mem-path)\n",
>      QEMU_ARCH_ALL)
> diff --git a/vl.c b/vl.c
> index b426b32134..28f0dc1c1b 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -140,6 +140,10 @@ int display_opengl;
>  const char* keyboard_layout = NULL;
>  ram_addr_t ram_size;
>  const char *mem_path = NULL;
> +const char *module_path = NULL;
> +const char *xscom_module = NULL;
> +const char *xscom_readp = NULL;
> +const char *xscom_writep = NULL;
>  int mem_prealloc = 0; /* force preallocation of physical target memory */
>  bool enable_mlock = false;
>  bool enable_cpu_pm = false;
> @@ -469,6 +473,32 @@ static QemuOptsList qemu_mem_opts = {
>      },
>  };
>  
> +static QemuOptsList qemu_module_opts = {
> +    .name = "module_path",
> +    .implied_opt_name = "module_path",
> +    .head = QTAILQ_HEAD_INITIALIZER(qemu_module_opts.head),
> +    .merge_lists = true,
> +    .desc = {
> +        {
> +            .name = "module_path",
> +            .type = QEMU_OPT_STRING,
> +        },
> +        {
> +            .name = "xscom_module",
> +            .type = QEMU_OPT_STRING,
> +        },
> +        {
> +            .name = "xscom_read",
> +            .type = QEMU_OPT_STRING,
> +        },
> +        {
> +            .name = "xscom_write",
> +            .type = QEMU_OPT_STRING,
> +        },
> +        { /* end of list */ }
> +    },
> +};
> +
>  static QemuOptsList qemu_icount_opts = {
>      .name = "icount",
>      .implied_opt_name = "shift",
> @@ -2923,6 +2953,7 @@ int main(int argc, char **argv, char **envp)
>      qemu_add_opts(&qemu_machine_opts);
>      qemu_add_opts(&qemu_accel_opts);
>      qemu_add_opts(&qemu_mem_opts);
> +    qemu_add_opts(&qemu_module_opts);
>      qemu_add_opts(&qemu_smp_opts);
>      qemu_add_opts(&qemu_boot_opts);
>      qemu_add_opts(&qemu_add_fd_opts);
> @@ -3190,6 +3221,17 @@ int main(int argc, char **argv, char **envp)
>              case QEMU_OPTION_mempath:
>                  mem_path = optarg;
>                  break;
> +            case QEMU_OPTION_modulepath:
> +                opts = qemu_opts_parse_noisily(qemu_find_opts("module_path"),
> +                                               optarg, true);
> +                if (!opts) {
> +                    exit(EXIT_FAILURE);
> +                }
> +                module_path = qemu_opt_get(opts, "module_path");
> +                xscom_module = qemu_opt_get(opts, "xscom_module");
> +                xscom_readp = qemu_opt_get(opts, "xscom_read");
> +                xscom_writep = qemu_opt_get(opts, "xscom_write");
> +                break;
>              case QEMU_OPTION_mem_prealloc:
>                  mem_prealloc = 1;
>                  break;
> 


