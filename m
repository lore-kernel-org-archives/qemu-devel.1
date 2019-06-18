Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F198C31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 09:20:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49616206BA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 09:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KyB5ZhaU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49616206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55112 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdAHr-0004kd-Ns
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 05:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50770)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hdAGv-0004Ho-PQ
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 05:19:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hdAGu-0007Cj-Eh
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 05:19:21 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40595)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hdAGu-0007AG-7f
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 05:19:20 -0400
Received: by mail-wm1-x344.google.com with SMTP id v19so2356133wmj.5
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 02:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oom3Rit8VhQbsL7J0nT88kfefQHWspJsQamJGjjiBV0=;
 b=KyB5ZhaUPlyyg30XRDDeT5I9BRfZVluC+MXxjQUNtuY1ZTxAxyInBUkBZie+liDpGC
 IMvuqjnJX6923OYm2/gttVFkyS9Fo71J7jG10hyJrmSbIW8Fdu4XlsXKoAlZSAJmGB9g
 YjoJOnBoNpkarx/cMqY3nilAbkRtt2EA9VmmrVsM3vfpVSIN5ywQZASVTu4mz8DtX0IW
 SfLqHTehc9mhQZw030DiJN2iylBNNv3HZMH/C6mgHA9MNzgZYXWJqDVtyeS1ik7uF+eS
 Ew4LYAs8WUI5GIY7fIH115bwGLq2JYfaCTVur9Wvuq8WoNtoX6M7WwpFPY/cqFB61sMy
 jikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oom3Rit8VhQbsL7J0nT88kfefQHWspJsQamJGjjiBV0=;
 b=ZXatS03Tak/lWxA3R8B45b1vIue8JwpHLOaAk9+cFMt3+R1d9piPCQRkxm6XfDxynx
 ocFRbeRNLXdoC/hnfxcoTJ+DwcW9YhOfKrMHUCgD0JTevEwgYt8GjRIWID6k22L6Tt6U
 Ts97XdYM6Akj3SXf6kEsjsr59M9kfgeofbMYukOyCXK6szk1zynwdn/ASb4Si5qBQLPX
 pk9YN0JxPpvhOD8MVFKNQbZjxB06a604RjvkX1gpFNSs6kv0J2kCqGpUaZfFum1Cn/oo
 H9QscCRPsD0l+bTsPhIIRJkCPJ5/tQm6ve4mhLr80wQlYepLI4SiPSYk32ba45y+ohkf
 dsJw==
X-Gm-Message-State: APjAAAVvlxkhsfRfFAh4Vvo95MXXeXYnndADHdPp89o9wzrSdC2oHzZG
 FhV97a2RfJu32+bSFTl7jD6uBa6/8XUEK4TRglo=
X-Google-Smtp-Source: APXvYqz+1YFpTgu+JF2o25iix+6MQSCP13B5JFjApVsGfqOtkWaaQinLO2al1ksfhP8HzlDMQi/kh0XNzymp7d0o1Eg=
X-Received: by 2002:a7b:c7d7:: with SMTP id z23mr2673347wmk.46.1560849558268; 
 Tue, 18 Jun 2019 02:19:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190617181620.30047-1-elena.ufimtseva@oracle.com>
In-Reply-To: <20190617181620.30047-1-elena.ufimtseva@oracle.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 18 Jun 2019 10:19:07 +0100
Message-ID: <CAJSP0QVLfGF3V7oEz33brQmZg+yvnDxR7TXg2fc0_cAfZSb97A@mail.gmail.com>
To: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [RFC PATCH v2 20/35] multi-process: Add QMP &
 extend HMP commands to list remote info
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
Cc: John G Johnson <john.g.johnson@oracle.com>,
 Jag Raman <jag.raman@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Ross Lagerwall <ross.lagerwall@citrix.com>, Liran Alon <liran.alon@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, kanth.ghatraju@oracle.com,
 Dave Gilbert <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 17, 2019 at 7:28 PM <elena.ufimtseva@oracle.com> wrote:
>
> From: Jagannathan Raman <jag.raman@oracle.com>
>
> Add query-remote QMP command and extend "info" HMP command, to list
> the remote objects used by QEMU.
>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> ---
>  hmp-commands-info.hx          | 16 +++++++
>  hmp.h                         |  1 +
>  hw/proxy/Makefile.objs        |  1 +
>  hw/proxy/monitor.c            | 88 +++++++++++++++++++++++++++++++++++
>  include/hw/proxy/qemu-proxy.h |  1 +
>  qapi/block-core.json          | 29 ++++++++++++
>  6 files changed, 136 insertions(+)
>  create mode 100644 hw/proxy/monitor.c
>
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index c59444c461..b145e755eb 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -932,6 +932,22 @@ STEXI
>  Show SEV information.
>  ETEXI
>
> +#if defined(CONFIG_MPQEMU)
> +    {
> +        .name       = "remote",
> +        .args_type  = "",
> +        .params     = "",
> +        .help       = "list remote objects",
> +        .cmd        = hmp_info_remote,
> +    },
> +
> +STEXI
> +@item remote
> +@findex remote
> +list remote objects.
> +ETEXI
> +#endif
> +
>  STEXI
>  @end table
>  ETEXI
> diff --git a/hmp.h b/hmp.h
> index 43617f2646..6919f99218 100644
> --- a/hmp.h
> +++ b/hmp.h
> @@ -150,5 +150,6 @@ void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict);
>  void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
>  void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict);
>  void hmp_info_sev(Monitor *mon, const QDict *qdict);
> +void hmp_info_remote(Monitor *mon, const QDict *qdict);
>
>  #endif
> diff --git a/hw/proxy/Makefile.objs b/hw/proxy/Makefile.objs
> index f562f5a0e9..e6420602b8 100644
> --- a/hw/proxy/Makefile.objs
> +++ b/hw/proxy/Makefile.objs
> @@ -1,2 +1,3 @@
>  common-obj-$(CONFIG_MPQEMU) += qemu-proxy.o
>  common-obj-$(CONFIG_MPQEMU) += proxy-lsi53c895a.o
> +common-obj-$(CONFIG_MPQEMU) += monitor.o
> diff --git a/hw/proxy/monitor.c b/hw/proxy/monitor.c
> new file mode 100644
> index 0000000000..694f34a446
> --- /dev/null
> +++ b/hw/proxy/monitor.c
> @@ -0,0 +1,88 @@
> +/*
> + * QEMU monitor command handler for multi-process QEMU
> + *
> + * Copyright 2019, Oracle and/or its affiliates.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#include <sys/types.h>
> +
> +#include "qemu/osdep.h"
> +#include "qapi/qapi-types-block-core.h"
> +#include "qapi/qapi-commands-block-core.h"
> +#include "monitor/monitor.h"
> +#include "qemu/option.h"
> +#include "hmp.h"
> +#include "hw/boards.h"
> +#include "hw/proxy/qemu-proxy.h"
> +
> +/*
> + * TODO: Is there a callback where the allocated memory for QMP could be free'd

QAPI objects are freed by the monitor.  The QAPI code generator
produces a function for freeing each QAPI object and the monitor will
call it after sending the response to the monitor client.

> + */
> +RemoteProcList *qmp_query_remote(Error **errp)
> +{
> +    MachineState *ms = MACHINE(current_machine);
> +    RemoteProcList *proclist, *proc;
> +    GHashTableIter itr;
> +    PCIProxyDev *pdev;
> +    PCIProxyDevClass *k;

This shouldn't be limited to PCI.  From what I can tell this is an
implementation detail, so it's fine for now.  Just make sure not to
put PCI-specific things in the QMP interface so that we can use this
for other devices in the future (USB, etc).

