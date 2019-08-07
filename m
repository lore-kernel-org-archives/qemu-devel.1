Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F6BC32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 10:28:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7A1D21E6B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 10:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A1D21E6B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvJAr-0006oy-V6
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 06:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44033)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hvJAQ-0006EB-2b
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 06:27:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hvJAN-0004LP-Sh
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 06:27:38 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36685)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hvJAN-0004L3-MJ
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 06:27:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so90880243wrs.3
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 03:27:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QgLz1DIjZ+iwYqT77zcOK7h1LoZxbIbXoeIqOpwdaVI=;
 b=i7UZvXE2Tx3gLXmud5o1e5SgAVK5987pNUJHLjqp/Xvz4wzs0c4QmG69/lnt/kg4NL
 N3LchYvAmg014BgR2SVbGaCvMX0Zpf+sSdOfIh2UyABBhhEseRT4XcrivAQgX1lCNVTc
 /cRuXd/EfO7pHg2ct39MW1nbPHCO2r6PIIGjUXIt68qoeZr5txLt8Imsj9gNUUmVBh9n
 JxENEO/1OVbc2FQlSv5yH/H+Pi/AS2WTd/PSBcxwjQTd9H8GsCOjpzAbvohQNFKS7nSt
 1mWgA5Lqrsow0dj5ykiMB6unDP4Ys5Y/4Syr/BUpo1E1ggZxZC+7u/jfnRfu0nBw7UIa
 fPrA==
X-Gm-Message-State: APjAAAW0jKXXVdKlRNs+NDGGKfCoxo6j85OXVmw+dn5ku9o/MhUSjtkP
 UdKKl5bVoVPJNpsVVuZQ51KL+cKAsGs=
X-Google-Smtp-Source: APXvYqyrp5+5BAyjwAakmBUnKadtlr+snkYzNv2SMnUtzQ6Mp/a1R59V96JJ/pIJTqlJyPHY3v18Fw==
X-Received: by 2002:a5d:6b07:: with SMTP id v7mr9943794wrw.169.1565173654605; 
 Wed, 07 Aug 2019 03:27:34 -0700 (PDT)
Received: from [192.168.1.39] (214.red-83-51-160.dynamicip.rima-tde.net.
 [83.51.160.214])
 by smtp.gmail.com with ESMTPSA id k9sm3746950wrq.15.2019.08.07.03.27.33
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 03:27:34 -0700 (PDT)
To: Balamuruhan S <bala24@linux.ibm.com>, qemu-devel@nongnu.org
References: <20190807071445.4109-1-bala24@linux.ibm.com>
 <20190807071445.4109-7-bala24@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <7d1b2fd4-aa95-06aa-1d69-fadc77921fb3@redhat.com>
Date: Wed, 7 Aug 2019 12:27:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190807071445.4109-7-bala24@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [RFC PATCH 6/6] hw/ppc/pnv_homer: add python
 interface support for homer/occ common area
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
Cc: maddy@linux.vnet.ibm.com, anju@linux.vnet.ibm.com, hari@linux.vnet.ibm.com,
 clg@kaod.org, pbonzini@redhat.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/7/19 9:14 AM, Balamuruhan S wrote:
> use python interface APIs in homer/occ common area emulation to
> interact with scripts if provided else fallback to normal flow,
> it shows how simple to use the interface to call python methods
> with any number of arguments in any script placed in common
> -module-path provided in qemu commandline.
> 
> Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
> ---
>  hw/ppc/pnv_homer.c      | 20 ++++++++++++++++++++
>  hw/ppc/pnv_xscom.c      |  9 +++++----
>  include/sysemu/sysemu.h |  4 ++++
>  vl.c                    | 24 ++++++++++++++++++++++++
>  4 files changed, 53 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/ppc/pnv_homer.c b/hw/ppc/pnv_homer.c
> index 73a94856d0..6ae5e74f19 100644
> --- a/hw/ppc/pnv_homer.c
> +++ b/hw/ppc/pnv_homer.c
> @@ -16,7 +16,9 @@
>   * You should have received a copy of the GNU Lesser General Public
>   * License along with this library; if not, see <http://www.gnu.org/licenses/>.
>   */
> +#include "sysemu/python_api.h"
>  #include "qemu/osdep.h"
> +#include "sysemu/sysemu.h"
>  #include "sysemu/hw_accel.h"
>  #include "sysemu/cpus.h"
>  #include "hw/ppc/pnv.h"
> @@ -37,6 +39,15 @@ static bool core_max_array(hwaddr addr)
>  
>  static uint64_t homer_read(void *opaque, hwaddr addr, unsigned width)
>  {
> +    if (homer_module && homer) {
> +        uint64_t homer_ret;
> +        char **address = g_malloc(sizeof(uint64_t));
> +        python_args_init_cast_long(address, addr, 0);
> +        homer_ret = python_callback_int(module_path, homer_module, homer, address, 1);
> +        python_args_clean(address, 1);
> +        g_free(address);

Maybe the heap overhead can be simplified alloc'ing in the PnvChip
structure.

> +        return homer_ret;
> +    }
>      switch (addr) {
>          case 0xe2006:  /* max pstate ultra turbo */
>          case 0xe2018:  /* pstate id for 0 */
> @@ -106,6 +117,15 @@ const MemoryRegionOps pnv_homer_ops = {
>  
>  static uint64_t occ_common_area_read(void *opaque, hwaddr addr, unsigned width)
>  {
> +    if (occ_module && occ) {
> +        uint64_t occ_ret;
> +        char **address = g_malloc(sizeof(uint64_t));
> +        python_args_init_cast_long(address, addr, 0);
> +        occ_ret = python_callback_int(module_path, occ_module, occ, address, 1);
> +        python_args_clean(address, 1);
> +        g_free(address);
> +        return occ_ret;
> +    }
>      switch (addr) {
>          /*
>           * occ-sensor sanity check that asserts the sensor
> diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
> index 18a780bcdf..5e41b7c953 100644
> --- a/hw/ppc/pnv_xscom.c
> +++ b/hw/ppc/pnv_xscom.c
> @@ -179,13 +179,14 @@ static uint64_t xscom_read(void *opaque, hwaddr addr, unsigned width)
>      MemTxResult result;
>  
>      if (xscom_module && xscom_readp) {
> -        char **args = g_malloc(2 * sizeof(uint64_t));
> +        char **args = g_malloc(3 * sizeof(uint64_t));
>          PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
>          python_args_init_cast_long(args, pcba, 0);
> -        python_args_init_cast_int(args, pcc->chip_type, 1);
> +        python_args_init_cast_int(args, chip->chip_num, 1);
> +        python_args_init_cast_int(args, pcc->chip_type, 2);
>          val = python_callback_int(module_path, xscom_module, xscom_readp,
> -                                  args, 2);
> -        python_args_clean(args, 2);
> +                                  args, 3);
> +        python_args_clean(args, 3);
>          g_free(args);
>      }
>      else {
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 9b8dc346d6..3c8119e040 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -121,6 +121,10 @@ extern const char *module_path;
>  extern const char *xscom_module;
>  extern const char *xscom_readp;
>  extern const char *xscom_writep;
> +extern const char *homer_module;
> +extern const char *homer;
> +extern const char *occ_module;
> +extern const char *occ;
>  extern int mem_prealloc;
>  
>  #define MAX_NODES 128
> diff --git a/vl.c b/vl.c
> index 28f0dc1c1b..c96d35d907 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -144,6 +144,10 @@ const char *module_path = NULL;
>  const char *xscom_module = NULL;
>  const char *xscom_readp = NULL;
>  const char *xscom_writep = NULL;
> +const char *homer_module = NULL;
> +const char *homer = NULL;
> +const char *occ_module = NULL;
> +const char *occ = NULL;
>  int mem_prealloc = 0; /* force preallocation of physical target memory */
>  bool enable_mlock = false;
>  bool enable_cpu_pm = false;
> @@ -495,6 +499,22 @@ static QemuOptsList qemu_module_opts = {
>              .name = "xscom_write",
>              .type = QEMU_OPT_STRING,
>          },
> +        {
> +            .name = "homer_module",
> +            .type = QEMU_OPT_STRING,
> +        },
> +        {
> +            .name = "homer",
> +            .type = QEMU_OPT_STRING,
> +        },
> +        {
> +            .name = "occ_module",
> +            .type = QEMU_OPT_STRING,
> +        },
> +        {
> +            .name = "occ",
> +            .type = QEMU_OPT_STRING,
> +        },
>          { /* end of list */ }
>      },
>  };
> @@ -3231,6 +3251,10 @@ int main(int argc, char **argv, char **envp)
>                  xscom_module = qemu_opt_get(opts, "xscom_module");
>                  xscom_readp = qemu_opt_get(opts, "xscom_read");
>                  xscom_writep = qemu_opt_get(opts, "xscom_write");
> +                homer_module = qemu_opt_get(opts, "homer_module");
> +                homer = qemu_opt_get(opts, "homer");
> +                occ_module = qemu_opt_get(opts, "occ_module");
> +                occ = qemu_opt_get(opts, "occ");
>                  break;
>              case QEMU_OPTION_mem_prealloc:
>                  mem_prealloc = 1;
> 

