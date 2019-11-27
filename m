Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAE0C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 04:22:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55E392075C
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 04:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QR/l7S7r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55E392075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZoqQ-0001P8-CF
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 23:22:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bharata.rao@gmail.com>) id 1iZopF-0000S3-5v
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 23:21:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bharata.rao@gmail.com>) id 1iZopD-0002KR-Uf
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 23:21:13 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:35726)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bharata.rao@gmail.com>)
 id 1iZopA-0002Hh-5Y; Tue, 26 Nov 2019 23:21:09 -0500
Received: by mail-oi1-x244.google.com with SMTP id k196so2500454oib.2;
 Tue, 26 Nov 2019 20:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pgRdn7twO1xb37Hov/iNtRYz3Rh0cGh9tEa4AXC6pXc=;
 b=QR/l7S7rGUtF4gzgEJMaXbqpWdQFEnStCJl/tWjXwoMrSbZqTrCxchAio1AGmH84UF
 JQSQluHdWdyT18QySN5DGMFWjZ9QqokSCQhl7qpRO9g6JhTW833S/b1ZY1RmbrHZe0Ej
 +KjDYwigaG322ec3yQkeWBrSj4noBOXd0Ggo+zP9YNhX+kp9HpBm+faCSCzdULCkuPwJ
 5skoIxJljHX2wFJLoDXnVy/ljaZehSZRmGuBtkYGH4bIkbUK1zJd+vvfvBPTAmKhBeXo
 ssS1seCDTXdx1S9pbwakGNnJY1ZsTdW21Ml1R9oKVrT9xhKHmBBJFqiUfI9X9mq12u8V
 y4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pgRdn7twO1xb37Hov/iNtRYz3Rh0cGh9tEa4AXC6pXc=;
 b=XhV2ZjTxwOVj916+Mj/tnah8nbOVFI41zgG05iZMawT0I12ja3LOzs8jGMu6bGBKYr
 +bLLS7+mAMpiUCk61r3n0ISL244Gc2z2paEcNYOUAcrFun7LEpOGMkuYuK9tGNL2aKnL
 nUDIuKnAgwPQnj5UlHAfaPqadvlLFw7BAegAKMy33nkCjFLhlM6XgOcV/+OEvFJhMnKV
 q7wXYR49xU6c5grdsqNmRWXw3/YOLv5955SnK2G9VCnSKA67GySCqJLO77+P6Dy+JTN+
 mytigrUwWllv6DTV5O7tt00oV38QGV9yNidCNd8/MuCFAowSU9Kmg4VzP5CgSWFlCHX/
 ha6w==
X-Gm-Message-State: APjAAAVBS7vfesV0hGsgNUCsjVPbqS1vpf5XpjckLTTiG5FALc0m16/J
 bM9EOWZMPcRaoBt/nSUuiL9zMNcen07qI6G9tuc=
X-Google-Smtp-Source: APXvYqy0dK0G1tOuRLO9VOk924d4dxRxVup+Cv5ys51CtQPvs3ppoUP1pdhwwnN0/szx3i6TG+YJcN/sOwER5hpmkcM=
X-Received: by 2002:aca:5cc6:: with SMTP id q189mr2226522oib.101.1574828465401; 
 Tue, 26 Nov 2019 20:21:05 -0800 (PST)
MIME-Version: 1.0
References: <157107820388.27733.3565652855304038259.stgit@lep8c.aus.stglabs.ibm.com>
 <157107826404.27733.10134514695430511105.stgit@lep8c.aus.stglabs.ibm.com>
 <20191122043045.GD5582@umbus.fritz.box>
In-Reply-To: <20191122043045.GD5582@umbus.fritz.box>
From: Bharata B Rao <bharata.rao@gmail.com>
Date: Wed, 27 Nov 2019 09:50:54 +0530
Message-ID: <CAGZKiBo4bdTTbJ82YV92RtTqbhuj_-GRxt6GceWyPbWdr9LGFA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] spapr: Add NVDIMM device support
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: xiaoguangrong.eric@gmail.com, Shivaprasad G Bhat <sbhat@linux.ibm.com>,
 mst@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 22, 2019 at 10:42 AM David Gibson
<david@gibson.dropbear.id.au> wrote:
>
> Ok.  A number of queries about this.
>
> 1) The PAPR spec for ibm,dynamic-memory-v2 says that the first word in
> each entry is the number of LMBs, but for NVDIMMs you use the
> not-necessarily-equal scm_block_size instead.  Does the NVDIMM
> amendment for PAPR really specify to use different block sizes for
> these cases?  (In which case that's a really stupid spec decision, but
> that wouldn't surprise me at this point).

SCM block sizes can be different from LMB sizes, but here we enforce
that SCM device size (excluding metadata) to multiple of LMB size so
that we don't end up memory range that is not aligned to LMB size.

>
> 2) Similarly, the ibm,dynamic-memory-v2 description says that the
> memory block described by the entry has a whole batch of contiguous
> DRCs starting at the DRC index given and continuing for #LMBs DRCs.
> For NVDIMMs it appears that you just have one DRC for the whole
> NVDIMM.  Is that right?

One NVDIMM has one DRC, In our case, we need to mark the LMBs
corresponding to that address range in ibm,dynamic-memory-v2 as
reserved and invalid.

>
> 3) You're not setting *any* extra flags on the entry.  How is the
> guest supposed to know which are NVDIMM entries and which are regular
> DIMM entries?  AFAICT in this version the NVDIMM slots are
> indistinguishable from the unassigned hotplug memory (which makes the
> difference in LMB and DRC numbering even more troubling).

For NVDIMM case, this patch should populate the LMB set in
ibm,dynamic-memory-v2 something like below:
            elem = spapr_get_drconf_cell(size /lmb_size, addr,
                                         0, -1,
SPAPR_LMB_FLAGS_RESERVED | SPAPR_LMB_FLAGS_DRC_INVALID);

This will ensure that the NVDIMM range will never be considered as
valid memory range for memory hotplug.

>
> 4) AFAICT these are _present_ NVDIMMs, so why is
> SPAPR_LMB_FLAGS_ASSIGNED not set for them?  (and why is the node
> forced to -1, regardless of di->node).
>
> >          QSIMPLEQ_INSERT_TAIL(&drconf_queue, elem, entry);
> >          nr_entries++;
> >          cur_addr = addr + size;
> > @@ -1261,6 +1273,85 @@ static void spapr_dt_hypervisor(SpaprMachineState *spapr, void *fdt)
> >      }
> >  }
> >

> > +static void spapr_create_nvdimm_dr_connectors(SpaprMachineState *spapr)
> > +{
> > +    MachineState *machine = MACHINE(spapr);
> > +    int i;
> > +
> > +    for (i = 0; i < machine->ram_slots; i++) {
> > +        spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_PMEM, i);
>
> What happens if you try to plug an NVDIMM to one of these slots, but a
> regular DIMM has already taken it?

NVDIMM hotplug won't get that occupied slot.

Regards,
Bharata.

