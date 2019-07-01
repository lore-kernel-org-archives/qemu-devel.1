Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A4BC5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 04:24:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EC4E206A3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 04:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gr76AMl1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EC4E206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhnrk-0002cd-J9
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 00:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55251)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sjitindarsingh@gmail.com>) id 1hhnqo-0001qV-Tw
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 00:23:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sjitindarsingh@gmail.com>) id 1hhnqn-0006rs-Pv
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 00:23:34 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:33466)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sjitindarsingh@gmail.com>)
 id 1hhnqi-0006oK-Ug; Mon, 01 Jul 2019 00:23:29 -0400
Received: by mail-pf1-x444.google.com with SMTP id x15so5884684pfq.0;
 Sun, 30 Jun 2019 21:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=O91hD0CTKKdfv92y1KQoXhH2x/V2Gz3Rr3hVJ5Kk0LE=;
 b=Gr76AMl1bwp7PzYhfOC86kiC5zXCBdwB+uM9g44WfugZI90sqY1ROcvLndtJoYXdMh
 uVt1xoxjEYebznDjwNEW9voFIlDd+Qi2FqfXuKyk2fFWwJrweaVgTvE7bDZbynnyKLWU
 CvSW2uMM3xWx4DIJ2PoTl0v69Tr/O5yLV/25T54czMqFS86sKYme2JHDaS8JNWA81DcC
 DczXxIFj47rYht0nkHAfz1guwOuYTGIlGEZ34b/IBFANrkP2PlxGfVioNXqxsOILAlxQ
 eh/LuP1VBXFO6G1RjaaVFXqPvfTyPbBJa9arI1h4hbTwOmc0pqTABLZsyXPSHR4y3UgK
 4vuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=O91hD0CTKKdfv92y1KQoXhH2x/V2Gz3Rr3hVJ5Kk0LE=;
 b=b3yKBH5wIe5O0zy915Q2zcy+0IAakaTM+gWVnuu6jYJrCv6vv8fLYL9bqNrkKmHmBT
 Ozeem54Y05OoyFQMrYvz6wwAatZLoyEnlq3xuVMExvJBaujDIcy0NLvqkhzfPijcWGwy
 1MAOgiG2JuDvkBe80Y3kMWTw7Ska0ZutumkHlmJ173OnpEUz0IrJOJKYw7JbXnUCQDJ2
 X+YfoihQtSN5u5lkrFJDcbzRRzvWVnYzoY6vTnbC9I2wO3XlXEyT1Pr6HWggsr+wG/2y
 PJDspg8LFo1p8dHIACMsRhfekF2Qsq0fQKoaUwFAdJWfSh7betZyqdYgUecWaHBIwKwq
 L9pw==
X-Gm-Message-State: APjAAAW2H/XgzD+M3USx4EvvgdyPqTnSMMXWTP1pDCU8FRe8OVxL5VVR
 q6teU4eryCORdsKK/K5GMeJCXNvr
X-Google-Smtp-Source: APXvYqwsxDcCDH68NlqOGgXdz+ajxwwqa6RiaXF1aP60B5MqCKvW36fJeBurFYOvvrqM1PQXw2QuTA==
X-Received: by 2002:a17:90a:730b:: with SMTP id
 m11mr28306987pjk.89.1561955006272; 
 Sun, 30 Jun 2019 21:23:26 -0700 (PDT)
Received: from surajjs2.ozlabs.ibm.com ([122.99.82.10])
 by smtp.googlemail.com with ESMTPSA id r27sm17658930pgn.25.2019.06.30.21.23.24
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 30 Jun 2019 21:23:25 -0700 (PDT)
Message-ID: <1561955001.10832.2.camel@gmail.com>
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 01 Jul 2019 14:23:21 +1000
In-Reply-To: <20190628092952.GB29462@umbus.fritz.box>
References: <20190624055812.3906-1-sjitindarsingh@gmail.com>
 <20190628092952.GB29462@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH 1/2] ppc/spapr: Add
 implementation of hcall H_PURR
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2019-06-28 at 19:29 +1000, David Gibson wrote:
> On Mon, Jun 24, 2019 at 03:58:11PM +1000, Suraj Jitindar Singh wrote:
> > The hcall H_PURR is used by a guest to read the PURR (processor
> > utilisation of resources register). A guest expects that this
> > register
> > will count at a rate of timebase scaled by the number of guest
> > vcpus
> > present in the vcore. That is the per vcpu purr will count at a
> > rate of
> > timebase / # vcpus per vcore.
> > 
> > Implement a handler for the H_PURR hcall and return the purr value
> > divided by smp_threads so that the sum of the purr deltas across
> > the
> > vcpus of a vcore equals the timebase delta
> > 
> > Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> 
> Does this need something new advertised in the hypertas DT entry?

Hi David,

There doesn't seem to be a concensus on what the return value from the
H_PURR hcall should be, whether it just returns the hardware value or
does some adjusting of the value based on guest smt mode as I've
implemented in the patch below.

As such please drop this patch series.

The guest can just read the purr register directly anyway and then
interpret the values as it pleases.

Kind Regards,
Suraj

> 
> > ---
> >  hw/ppc/spapr_hcall.c | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> > 
> > diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> > index aae9fd2b3e..88b3343f04 100644
> > --- a/hw/ppc/spapr_hcall.c
> > +++ b/hw/ppc/spapr_hcall.c
> > @@ -1819,6 +1819,27 @@ static target_ulong h_update_dt(PowerPCCPU
> > *cpu, SpaprMachineState *spapr,
> >      return H_SUCCESS;
> >  }
> >  
> > +static target_ulong h_purr(PowerPCCPU *cpu, SpaprMachineState
> > *spapr,
> > +                           target_ulong opcode, target_ulong
> > *args)
> > +{
> > +    CPUPPCState *env = &cpu->env;
> > +    target_ulong purr;
> > +
> > +    if (kvm_enabled()) {
> > +        cpu_synchronize_state(CPU(cpu));
> > +        /*
> > +         * Divide by smp_threads so that the sum of the purr
> > deltas across the
> > +         * vcpus of a vcore equal the timebase delta.
> > +         */
> > +        purr = env->spr[SPR_PURR] / smp_threads;
> > +    } else {
> > +        purr = cpu_ppc_load_purr(env);
> > +    }
> > +    args[0] = purr;
> > +
> > +    return H_SUCCESS;
> > +}
> > +
> >  static spapr_hcall_fn papr_hypercall_table[(MAX_HCALL_OPCODE / 4)
> > + 1];
> >  static spapr_hcall_fn kvmppc_hypercall_table[KVMPPC_HCALL_MAX -
> > KVMPPC_HCALL_BASE + 1];
> >  
> > @@ -1915,6 +1936,9 @@ static void hypercall_register_types(void)
> >      spapr_register_hypercall(H_LOGICAL_DCBF, h_logical_dcbf);
> >      spapr_register_hypercall(KVMPPC_H_LOGICAL_MEMOP,
> > h_logical_memop);
> >  
> > +    /* hcall-purr */
> > +    spapr_register_hypercall(H_PURR, h_purr);
> > +
> >      /* qemu/KVM-PPC specific hcalls */
> >      spapr_register_hypercall(KVMPPC_H_RTAS, h_rtas);
> >  
> 
> 

