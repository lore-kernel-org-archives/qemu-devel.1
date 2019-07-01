Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B941C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 09:06:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D599A208E4
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 09:06:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D599A208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhsGa-0007tO-SV
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 05:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42744)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hhsCF-0004px-Nv
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 05:02:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hhsCE-0007y9-67
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 05:01:59 -0400
Received: from 8.mo2.mail-out.ovh.net ([188.165.52.147]:39129)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hhsCD-0007jR-Un
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 05:01:58 -0400
Received: from player738.ha.ovh.net (unknown [10.108.42.119])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id B00741A2691
 for <qemu-devel@nongnu.org>; Mon,  1 Jul 2019 11:01:46 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player738.ha.ovh.net (Postfix) with ESMTPSA id D0DB878A2313;
 Mon,  1 Jul 2019 09:01:41 +0000 (UTC)
Date: Mon, 1 Jul 2019 11:01:40 +0200
From: Greg Kurz <groug@kaod.org>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Message-ID: <20190701110140.1c0e5956@bahia.lan>
In-Reply-To: <20190701061946.32636-1-sjitindarsingh@gmail.com>
References: <20190701061946.32636-1-sjitindarsingh@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 14697778859466922392
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrvdeigddtgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.52.147
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH v3] powerpc/spapr: Add host
 threads parameter to ibm, get_system_parameter
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon,  1 Jul 2019 16:19:46 +1000
Suraj Jitindar Singh <sjitindarsingh@gmail.com> wrote:

> The ibm,get_system_parameter rtas call is used by the guest to retrieve
> data relating to certain parameters of the system. The SPLPAR
> characteristics option (token 20) is used to determin characteristics of
> the environment in which the lpar will run.
> 
> It may be useful for a guest to know the number of physical host threads
> present on the underlying system where it is being run. Add the
> characteristic "HostThrs" to the SPLPAR Characteristics
> ibm,get_system_parameter rtas call to expose this information to a
> guest and provide an implementation which determines this information
> based on the number of interrupt servers present in the device tree.
> 
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> 
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

> 
> V1 -> V2:
> - Take into account that the core may be operating in split core mode
>   meaning a single core may be split into multiple subcores.
> V2 -> V3:
> - Add curly braces for single line if statements
> ---
>  hw/ppc/spapr_rtas.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 5bc1a93271..1bab71c90c 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -229,6 +229,58 @@ static inline int sysparm_st(target_ulong addr, target_ulong len,
>      return RTAS_OUT_SUCCESS;
>  }
>  
> +#define CPUS_PATH       "/proc/device-tree/cpus/"
> +#define SUBCORE_PATH    "/sys/devices/system/cpu/subcores_per_core"
> +
> +static int rtas_get_num_host_threads(void)
> +{
> +    int num_threads = -1;
> +    unsigned long len;
> +    const char *entry;
> +    char *buf;
> +    GDir *dir;
> +
> +    if (!kvm_enabled()) {
> +        return 1;
> +    }
> +
> +    /* Read interrupt servers to determine number of threads per core */
> +    dir = g_dir_open(CPUS_PATH, 0, NULL);
> +    if (!dir) {
> +        return -1;
> +    }
> +
> +    while ((entry = g_dir_read_name(dir))) {
> +        if (!strncmp(entry, "PowerPC,POWER", strlen("PowerPC,POWER"))) {
> +            char *path;
> +
> +            path = g_strconcat(CPUS_PATH, entry, "/ibm,ppc-interrupt-server#s",
> +                               NULL);
> +            if (g_file_get_contents(path, &buf, &len, NULL)) {
> +                num_threads = len / sizeof(int);
> +                g_free(buf);
> +            }
> +
> +            g_free(path);
> +            break;
> +        }
> +    }
> +
> +    g_dir_close(dir);
> +
> +    /* Check if split core mode in use */
> +    if (g_file_get_contents(SUBCORE_PATH, &buf, &len, NULL)) {
> +        int subcores = g_ascii_strtoll(buf, NULL, 10);
> +
> +        if (subcores) {
> +            num_threads /= subcores;
> +        }
> +        g_free(buf);
> +    }
> +
> +    return num_threads;
> +}
> +
>  static void rtas_ibm_get_system_parameter(PowerPCCPU *cpu,
>                                            SpaprMachineState *spapr,
>                                            uint32_t token, uint32_t nargs,
> @@ -250,6 +302,16 @@ static void rtas_ibm_get_system_parameter(PowerPCCPU *cpu,
>                                            current_machine->ram_size / MiB,
>                                            smp_cpus,
>                                            max_cpus);
> +        int num_host_threads = rtas_get_num_host_threads();
> +
> +        if (num_host_threads > 0) {
> +            char *hostthr_val, *old = param_val;
> +
> +            hostthr_val = g_strdup_printf(",HostThrs=%d", num_host_threads);
> +            param_val = g_strconcat(param_val, hostthr_val, NULL);
> +            g_free(hostthr_val);
> +            g_free(old);
> +        }
>          ret = sysparm_st(buffer, length, param_val, strlen(param_val) + 1);
>          g_free(param_val);
>          break;


