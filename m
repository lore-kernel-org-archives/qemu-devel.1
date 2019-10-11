Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1772ECE58D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 19:04:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 808AF214E0
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 19:04:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 808AF214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJ0DU-0003F5-Iw
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 15:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35300)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iJ0Cn-0002pw-Ri
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 15:04:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iJ0Cl-0003nW-2M
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 15:04:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45306)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iJ0Ck-0003mz-Pt
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 15:03:59 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B3098307D847;
 Fri, 11 Oct 2019 19:03:57 +0000 (UTC)
Received: from localhost (ovpn-116-20.phx2.redhat.com [10.3.116.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 917B01001B09;
 Fri, 11 Oct 2019 19:03:54 +0000 (UTC)
Date: Fri, 11 Oct 2019 16:03:53 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: "Moger, Babu" <Babu.Moger@amd.com>
Subject: Re: [Qemu-devel] [RFC 2 PATCH 13/16] machine: Add new epyc property
 in PCMachineState
Message-ID: <20191011190353.GF4084@habkost.net>
References: <156779689013.21957.1631551572950676212.stgit@localhost.localdomain>
 <156779718791.21957.9675425538561156773.stgit@localhost.localdomain>
 <20191011035906.GH29387@habkost.net>
 <35f27ef1-a8ee-19e3-fa01-230135f1ed02@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35f27ef1-a8ee-19e3-fa01-230135f1ed02@amd.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Fri, 11 Oct 2019 19:03:57 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: "mst@redhat.com" <mst@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 11, 2019 at 04:59:37PM +0000, Moger, Babu wrote:
> 
> On 10/10/19 10:59 PM, Eduardo Habkost wrote:
> > On Fri, Sep 06, 2019 at 07:13:09PM +0000, Moger, Babu wrote:
> >> Adds new epyc property in PCMachineState and also in MachineState.
> >> This property will be used to initialize the mode specific handlers
> >> to generate apic ids.
> >>
> >> Signed-off-by: Babu Moger <babu.moger@amd.com>
> >> ---
> > [...]
> >> diff --git a/include/hw/boards.h b/include/hw/boards.h
> >> index 12eb5032a5..0001d42e50 100644
> >> --- a/include/hw/boards.h
> >> +++ b/include/hw/boards.h
> >> @@ -299,6 +299,8 @@ struct MachineState {
> >>      AccelState *accelerator;
> >>      CPUArchIdList *possible_cpus;
> >>      CpuTopology smp;
> >> +    bool epyc;
> >> +
> > 
> > This won't scale at all when we start adding new CPU models with
> > different topology constraints.
> 
> Yes, I knew. This could cause scaling issues. Let me see if we could
> do anything different.
> 
> > 
> > I still have hope we can avoid having separate set of topology ID
> > functions (see my reply to "hw/386: Add new epyc mode topology
> 
> Yes. That was my hope too. Let me think thru this bit more. I will come
> back on this.

If you don't manage to use a common function in the next version,
it's not a big deal.  My main request is to make the calculations
easier to follow (e.g. avoiding any expression with more than two
terms, and always using an explicit "_per_*" suffix in all
variables and constants).

There's one possible problem I didn't realize yesterday: we might
need a mechanism to force a field width to be larger than
apicid_bitwidth_for_count(number_of_ids) (e.g. having 2 bits for
core ID even if there's only 1 or 2 cores per CCX).  Maybe the
solution is to add optional field width parameters to
X86CPUTopoInfo.

Then we could redefine the width functions like this:

static inline unsigned apicid_core_width(X86CPUTopoInfo *topo)
{
    return MAX(apicid_bitwidth_for_count(topo->nr_cores), topo->min_core_bits);
}


Maybe we could replace the collection of fields with arrays to make all
calculations generic.  Untested example:

enum TopoField {
    TOPO_FIELD_THREADS = 0,
    TOPO_FIELD_CORES,
    TOPO_FIELD_CCXS,  /* AMD */
    TOPO_FIELD_DIES = TOPO_FIELD_CCX, /* Intel */
    TOPO_FIELD_NODES,
    TOPO_FIELD_PKG,
    MAX_TOPO_FIELD,
};

struct TopoFieldDefinition {
    /* Number of IDs at this level */
    unsigned count;
    /* Minimum number of APIC ID bits for this level */
    unsigned min_width;
};

struct X86CPUTopoInfo
{
    TopoFieldDefinition fields[MAX_TOPO_FIELD];
};

struct X85CPUTopoIDs
{
    unsigned ids[MAX_TOPO_FIELD];
};

static inline unsigned apicid_field_width(const X86CPUTopoInfo *topo, TopoField field)
{
    TopoFieldDefinition *def = &topo->fields[field];
    return MAX(apicid_bitwidth_for_count(def->count), def->min_width);
}

static inline unsigned apicid_field_offset(const X86CPUTopoInfo *topo, TopoField field)
{
    if (field == 0) {
        return 0;
    }
    return apicid_field_offset(topo, field - 1) + apic_id_field_width(topo, field - 1);
}


static inline apic_id_t apicid_from_topo_ids(const X86CPUTopoInfo *topo,
                                             const X86CPUTopoIDs *ids)
{
    TopoField field;
    apic_id_t r = 0;
    for (field = 0; l < MAX_TOPO_FIELD; l++) {
        unsigned offset = apicid_field_offset(topo, field);
        unsigned width = apicid_field_width(topo, field);
        assert(apicid_bitwidth_for_count(ids->ids[field] + 1) < apicid_field_width(topo, field));
        r = deposit64(r, offset, width,  ids->ids[field];
    }
    return r;
}

static inline void x86_topo_ids_from_apicid(apic_id_t apicid,
                                            const X86CPUTopoInfo *topo,
                                            X86CPUTopoIDs *ids)
{
    TopoField field;
    for (field = 0; l < MAX_TOPO_FIELD; l++) {
        unsigned offset = apicid_field_offset(topo, field);
        unsigned width = apicid_field_width(topo, field);
        ids->ids[field] = extract64(apicid, offset, width);
    }
}

> 
> 
> > decoding functions").  But if we really have to create separate
> > functions, we can make them part of the CPU model table, not a
> > boolean machine property.
> > 

-- 
Eduardo

