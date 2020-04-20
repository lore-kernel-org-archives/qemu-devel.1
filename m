Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1668EC3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 19:56:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0B7E206A1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 19:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFDYlKxb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0B7E206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQcWa-0003FQ-T1
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 15:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58422)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jQcVS-00023f-TX
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 15:55:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jQcVS-0006Sf-2a
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 15:55:02 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:33373)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jQcVQ-0006LV-M4; Mon, 20 Apr 2020 15:55:01 -0400
Received: by mail-il1-x142.google.com with SMTP id q10so9799016ile.0;
 Mon, 20 Apr 2020 12:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=398G4gckWG4W3zNtmtoVvwJWVMUrY27VB1c/upy+clY=;
 b=UFDYlKxb1ZUQtOY4yTkEsgMo3voseg6zRD+Qt5zX0LjKR/hzKPUq82uERUZ7RZk1S+
 CuvvmVZb5VdkgYZAdrZ/Q4NCDD6ZT8W5Pj96qQlVD5QWwuxlgP2iYjkQHxh1SsfM080Q
 OD5mExajgNfnF5ANT8svnHZmleoV90UDPvfeFF2xB5sULqfu1Z7aQyNzUc714kf1J9g4
 C49Hvb6rNqQglm+LlTSA8MuTVGJc6Sl4EwnpstiW3ghSOWD0cLcMdPJsT2P8pbpP1wTO
 f9s1C7YhWLwAzZuGtodzWJttML38nqjOMEpgVaZJSTdtH/LBLzQSyE6lQNNgnFnKI5w4
 6XMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=398G4gckWG4W3zNtmtoVvwJWVMUrY27VB1c/upy+clY=;
 b=cH8A5qGcQY6w6lJ1mp2l/po61ckHyHAmrI6QcmbELeZy7vAqg7oL+FfxBoeAgoy9Ah
 j7cycj9phHr/wqbjEAIh9q1RLwcXWSFxCu0Kza2KYAcpgk2Eg899kkdtm4DnC2ZDx16B
 /76QfCJfR1ROn0TZvc6XYF0lz2FboakzIOsPZ7YYXrXkxxYfgPjRjbN7BfLMo+kCN40n
 34n6spNo6HsBZd0zYts2kTgdqAcTlEyw8z7xqNxkOqlTwii+pYnv2SrcgezMiU8bsGSO
 cNZeN7kfHYNZ5txf8R+h3nCYXL8hVVyMHvcgqrs5GlhHvPIuL0BGHL+rHCcIbGtDsRnq
 sI8w==
X-Gm-Message-State: AGi0PuY2aLI4QA7hek5kOFUoy7kW7/kTgeqeHzzyzkxnBOVIr8/b8p3N
 Box6OT7dvlXQFMcAumcYIuGOfGtLADlS7/P++k+r62zc
X-Google-Smtp-Source: APiQypJ4b/94HRv26Xs6FhgYZpAHz6YCpOFpmMOGHuc+J1oEz1Il3g9WNPpeUV2LkA5ywouJUYdcGZ70X6NxMtcflDo=
X-Received: by 2002:a92:9a5c:: with SMTP id t89mr18064586ili.267.1587412499078; 
 Mon, 20 Apr 2020 12:54:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200419162727.19148-1-edgar.iglesias@gmail.com>
 <20200419162727.19148-4-edgar.iglesias@gmail.com>
In-Reply-To: <20200419162727.19148-4-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 20 Apr 2020 12:46:31 -0700
Message-ID: <CAKmqyKO_tG8ERdgtwz_-_jsM3sc0U89fX4pbSpREj7WuPeZi8w@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] hw/arm: xlnx-zcu102: Disable unsupported FDT
 firmware nodes
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::142
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
Cc: figlesia@xilinx.com, Peter Maydell <peter.maydell@linaro.org>,
 Edgar Iglesias <edgar.iglesias@xilinx.com>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Apr 19, 2020 at 9:27 AM Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Disable unsupported FDT firmware nodes if a user passes us
> a DTB with nodes enabled that the machine cannot support
> due to lack of EL3 or EL2 support.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/arm/xlnx-zcu102.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
> index 4eb117c755..3332630380 100644
> --- a/hw/arm/xlnx-zcu102.c
> +++ b/hw/arm/xlnx-zcu102.c
> @@ -23,6 +23,7 @@
>  #include "qemu/error-report.h"
>  #include "qemu/log.h"
>  #include "sysemu/qtest.h"
> +#include "sysemu/device_tree.h"
>
>  typedef struct XlnxZCU102 {
>      MachineState parent_obj;
> @@ -68,6 +69,35 @@ static void zcu102_set_virt(Object *obj, bool value, Error **errp)
>      s->virt = value;
>  }
>
> +static void zcu102_modify_dtb(const struct arm_boot_info *binfo, void *fdt)
> +{
> +    XlnxZCU102 *s = container_of(binfo, XlnxZCU102, binfo);
> +    bool method_is_hvc;
> +    char **node_path;
> +    const char *r;
> +    int prop_len;
> +    int i;
> +
> +    /* If EL3 is enabled, we keep all firmware nodes active.  */
> +    if (!s->secure) {
> +        node_path = qemu_fdt_node_path(fdt, NULL,
> +                                       (char *)"xlnx,zynqmp-firmware",
> +                                       &error_fatal);
> +
> +        for (i = 0; node_path && node_path[i]; i++) {
> +            r = qemu_fdt_getprop(fdt, node_path[i], "method", &prop_len, NULL);
> +            method_is_hvc = r && !strcmp("hvc", r);
> +
> +            /* Allow HVC based firmware if EL2 is enabled.  */
> +            if (method_is_hvc && s->virt) {
> +                continue;
> +            }
> +            qemu_fdt_setprop_string(fdt, node_path[i], "status", "disabled");
> +        }
> +        g_strfreev(node_path);
> +    }
> +}
> +
>  static void xlnx_zcu102_init(MachineState *machine)
>  {
>      XlnxZCU102 *s = ZCU102_MACHINE(machine);
> @@ -169,6 +199,7 @@ static void xlnx_zcu102_init(MachineState *machine)
>
>      s->binfo.ram_size = ram_size;
>      s->binfo.loader_start = 0;
> +    s->binfo.modify_dtb = zcu102_modify_dtb;
>      arm_load_kernel(s->soc.boot_cpu_ptr, machine, &s->binfo);
>  }
>
> --
> 2.20.1
>
>

