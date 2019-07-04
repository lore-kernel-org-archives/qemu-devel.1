Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24135C06510
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 03:43:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA1912189E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 03:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHV0LUW9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA1912189E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiseP-000482-41
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 23:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53983)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sjitindarsingh@gmail.com>) id 1hisdT-0003CU-CN
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 23:42:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sjitindarsingh@gmail.com>) id 1hisdR-00031A-Ok
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 23:42:15 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:45360)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sjitindarsingh@gmail.com>)
 id 1hisdK-0002xh-GI; Wed, 03 Jul 2019 23:42:08 -0400
Received: by mail-pl1-x641.google.com with SMTP id bi6so2306605plb.12;
 Wed, 03 Jul 2019 20:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NLK06uopJD4zWU8A5SxehJuDnNZy1u5lZAk3dkb1XeM=;
 b=CHV0LUW9B+g6ykf7cVc9ZOXMPXAEAwmrlrRrj4UJfEWTyC+cRIbi58HxcKcs3HtPC2
 AK/saCPZRQ3UCKGsERB8ts6VSau+s3kx4mFEX1ykkmQXYwL0PDMZ7SzR9wzhyde0PNlm
 6cqHaDWnibL0SKfoP/pTyeV/ZFjseoiIVEbs8UMF3WbGRm77RDjDKFfgrm9eHtq8ecr6
 /pQ28JIhUE9ZBgelaF2nXoVse6jR+0m+9kv9YDNunZI/F7NuJM2/ZFP0XPS+fg5XrxLe
 mRUF7gkcKVgWUaOFiRCljiYdAFL3+YqWaMf1CQ9Ytr4xa7UV6cvK/yIrGzaRMwcsZ+KU
 wYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NLK06uopJD4zWU8A5SxehJuDnNZy1u5lZAk3dkb1XeM=;
 b=OxH6LAHe9uPl7XZgiqzBJH3SSmnHi8Tp1RdkX3KWNfSeOjDailc4sVWIC0F4QdxSAt
 EefVHb0tD6gf3RNI1eoG2EuPCRBcNeSW/LCG7f++jcxdz+4+onRvZq2SC8Duq/XvKZuM
 Cxzan8PHCb3ChyVyY3hLa5vJK9KOAvP44rt4/490kdz3aTu7bi8YGbt6Y87STqt1SP79
 fcPSIaeJzk7PXNJcfrKC+/39f2XhuuyDkePKvEtHh4MTiMkbThf1XYfZCM73/kY49o/r
 1YLABO9SJwMh12b2KbEJLYZ8g6NumgHr2pB46JRGbvB4P5+3sbBVyAzC8Z7GxCCNx4Xp
 GLiQ==
X-Gm-Message-State: APjAAAW6Ow2qPAwffpIsUMx4LXJkAI6VJ2IV0mlB3HN9sDFova6tGZdW
 qBtGQw96zKOGBiMFHRv+dv4=
X-Google-Smtp-Source: APXvYqxMO0SEhjaBK3V94HC/GKOkSYDicpkb5Iw3TF2oPVWw0A7+7GM23eU9RnXcOOr4BV4hcFoOgg==
X-Received: by 2002:a17:902:e40f:: with SMTP id
 ci15mr46611795plb.103.1562211724647; 
 Wed, 03 Jul 2019 20:42:04 -0700 (PDT)
Received: from surajjs2.ozlabs.ibm.com ([122.99.82.10])
 by smtp.googlemail.com with ESMTPSA id b6sm3525897pgd.5.2019.07.03.20.42.01
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 03 Jul 2019 20:42:03 -0700 (PDT)
Message-ID: <1562211719.10832.15.camel@gmail.com>
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 04 Jul 2019 13:41:59 +1000
In-Reply-To: <20190703061239.GK9442@umbus.fritz.box>
References: <20190701061946.32636-1-sjitindarsingh@gmail.com>
 <20190703061239.GK9442@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2019-07-03 at 16:12 +1000, David Gibson wrote:
> On Mon, Jul 01, 2019 at 04:19:46PM +1000, Suraj Jitindar Singh wrote:
> > The ibm,get_system_parameter rtas call is used by the guest to
> > retrieve
> > data relating to certain parameters of the system. The SPLPAR
> > characteristics option (token 20) is used to determin
> > characteristics of
> > the environment in which the lpar will run.
> > 
> > It may be useful for a guest to know the number of physical host
> > threads
> > present on the underlying system where it is being run. Add the
> > characteristic "HostThrs" to the SPLPAR Characteristics
> > ibm,get_system_parameter rtas call to expose this information to a
> > guest and provide an implementation which determines this
> > information
> > based on the number of interrupt servers present in the device
> > tree.
> > 
> > Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> 
> Hrm, as I said on our call, I have some misgivings about this.
> 
> Starting with the most general: this again publishes host information
> to the guest without filtering, which has caused us problems before
> (e.g. security issues with publishing the host serial and model
> information).  Now, I can't immediately see what harm a guest could
> do
> with the host # threads (especially since it could in theory deduce
> it
> from the PVR, I think) but it still makes me uneasy.

Correct, a guest could pretty reliably determine this information
anyway based on the PVR. It can't account for a POWER8 operating in
split core mode, but I don't know any harm that could be done by
introducing this information.

Additionally it doesn't really tell you anything about how you're going
to be scheduled (at least on POWER9) since vcpus are scheduled on a per
thread, not per core basis.

> 
> Secondly, the "HostThrs" tag doesn't seem to be documented in PAPR as
> something that this system-parameter will include.  I don't much like
> the idea of adding ad-hoc bits of information here without some
> thought going into designing and specifying it first.

This isn't documented in papr, it has been decided that this is how the
information will be communicated to a guest. This is the most
appropriate place to put this information and the HostThrs name is
consistent with the naming of other information in this property.

We have other non-papr information in qemu, for example hcall numbers,
so this isn't exactly a precedent.

> 
> > 
> > ---
> > 
> > V1 -> V2:
> > - Take into account that the core may be operating in split core
> > mode
> >   meaning a single core may be split into multiple subcores.
> > V2 -> V3:
> > - Add curly braces for single line if statements
> > ---
> >  hw/ppc/spapr_rtas.c | 62
> > +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 62 insertions(+)
> > 
> > diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> > index 5bc1a93271..1bab71c90c 100644
> > --- a/hw/ppc/spapr_rtas.c
> > +++ b/hw/ppc/spapr_rtas.c
> > @@ -229,6 +229,58 @@ static inline int sysparm_st(target_ulong
> > addr, target_ulong len,
> >      return RTAS_OUT_SUCCESS;
> >  }
> >  
> > +#define CPUS_PATH       "/proc/device-tree/cpus/"
> > +#define
> > SUBCORE_PATH    "/sys/devices/system/cpu/subcores_per_core"
> > +
> > +static int rtas_get_num_host_threads(void)
> > +{
> > +    int num_threads = -1;
> > +    unsigned long len;
> > +    const char *entry;
> > +    char *buf;
> > +    GDir *dir;
> > +
> > +    if (!kvm_enabled()) {
> > +        return 1;
> > +    }
> > +
> > +    /* Read interrupt servers to determine number of threads per
> > core */
> > +    dir = g_dir_open(CPUS_PATH, 0, NULL);
> > +    if (!dir) {
> > +        return -1;
> > +    }
> > +
> > +    while ((entry = g_dir_read_name(dir))) {
> > +        if (!strncmp(entry, "PowerPC,POWER",
> > strlen("PowerPC,POWER"))) {
> > +            char *path;
> > +
> > +            path = g_strconcat(CPUS_PATH, entry, "/ibm,ppc-
> > interrupt-server#s",
> > +                               NULL);
> > +            if (g_file_get_contents(path, &buf, &len, NULL)) {
> > +                num_threads = len / sizeof(int);
> > +                g_free(buf);
> > +            }
> > +
> > +            g_free(path);
> > +            break;
> > +        }
> > +    }
> > +
> > +    g_dir_close(dir);
> > +
> > +    /* Check if split core mode in use */
> > +    if (g_file_get_contents(SUBCORE_PATH, &buf, &len, NULL)) {
> > +        int subcores = g_ascii_strtoll(buf, NULL, 10);
> > +
> > +        if (subcores) {
> > +            num_threads /= subcores;
> > +        }
> > +        g_free(buf);
> > +    }
> 
> Finally, all the logic above is built on the assumption of a ppc host
> - and not just that but an IBM POWER host...

RTAS services are defined as being provided by a papr platform, and the
existence of the ibm,ppc-interrupt-server#s device tree property is a
requirement of a papr platform. So I don't see this being an issue.

> 
> > +    return num_threads;
> > +}
> > +
> >  static void rtas_ibm_get_system_parameter(PowerPCCPU *cpu,
> >                                            SpaprMachineState
> > *spapr,
> >                                            uint32_t token, uint32_t
> > nargs,
> > @@ -250,6 +302,16 @@ static void
> > rtas_ibm_get_system_parameter(PowerPCCPU *cpu,
> >                                            current_machine-
> > >ram_size / MiB,
> >                                            smp_cpus,
> >                                            max_cpus);
> > +        int num_host_threads = rtas_get_num_host_threads();
> > +
> > +        if (num_host_threads > 0) {
> 
> ... this sort of implements a fallback in other cases (KVM PR with a
> non-IBM host, TCG, but the boundary conditions are not really well
> defined.

This is essentially catching the error case of
rtas_get_num_host_threads() returning a negative number or not finding
the required properties (which as mentioned above are required). The
KVM-PR case will work the same as the KVM-HV case where the host device
tree will be queried. For TCG we just default to 1 since this
information shouldn't be relevant to a TCG guest.

> 
> > +            char *hostthr_val, *old = param_val;
> > +
> > +            hostthr_val = g_strdup_printf(",HostThrs=%d",
> > num_host_threads);
> > +            param_val = g_strconcat(param_val, hostthr_val, NULL);
> > +            g_free(hostthr_val);
> > +            g_free(old);
> > +        }
> >          ret = sysparm_st(buffer, length, param_val,
> > strlen(param_val) + 1);
> >          g_free(param_val);
> >          break;
> 
> 

