Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB716C3567B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 08:19:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8612A20658
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 08:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+dFtjVY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8612A20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j68xp-00070K-IS
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 03:19:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55224)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j68xD-0006aa-A4
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 03:19:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j68xB-0005MT-Fa
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 03:19:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39423
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j68xB-0005L2-Bq
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 03:19:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582532340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rXsbuP+UGTrrRwYOOcIYs5kwT0nXYTPJY8VdyCYjHpY=;
 b=A+dFtjVYDD/xbjUPum5oTt/WB4JFV0CilxwVpxUiUwRc00M1hjDJ4OxWVcVPiUaJg8Jhhi
 aaBassvPWoPnZOH7H5lXDKyVGHAT6tZh8jNLph4UglpAZbc64LNTxy5dGUxGRO1c2l4HZc
 ujyIqjR0DkBQ0A8eGjLNOLqKUVyvU8s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-o67wr48GNCGT_T-54QYJiw-1; Mon, 24 Feb 2020 03:18:41 -0500
X-MC-Unique: o67wr48GNCGT_T-54QYJiw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B44CC1005513;
 Mon, 24 Feb 2020 08:18:39 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BF04327081;
 Mon, 24 Feb 2020 08:18:35 +0000 (UTC)
Date: Mon, 24 Feb 2020 09:18:33 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v4 04/16] hw/i386: Introduce init_topo_info to
 initialize X86CPUTopoInfo
Message-ID: <20200224091833.2d3dec7f@redhat.com>
In-Reply-To: <3188d0e7-7f1c-aa03-d3ec-f512d9905158@amd.com>
References: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
 <158161781120.48948.3568234592332597800.stgit@naples-babu.amd.com>
 <20200221180501.72e4ff3c@redhat.com>
 <3188d0e7-7f1c-aa03-d3ec-f512d9905158@amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 21 Feb 2020 11:51:15 -0600
Babu Moger <babu.moger@amd.com> wrote:

> On 2/21/20 11:05 AM, Igor Mammedov wrote:
> > On Thu, 13 Feb 2020 12:16:51 -0600
> > Babu Moger <babu.moger@amd.com> wrote:
> >   
> >> Initialize all the parameters in one function init_topo_info.  
> > 
> > is it possible to squash it in 2/16
> >   
> Sure. We can do that.
> >   
> >>
> >> Move the data structure X86CPUTopoIDs and X86CPUTopoInfo into
> >> x86.h.  
> > A reason why it's moved should be here.  
> 
> Apicid functions will be part of X86MachineState data structure(patches
> introduced later).These functions will use X86CPUTopoIDs and
> X86CPUTopoInfo definition. Will add these details. Thanks

why not just include topology.h into the X86MachineState header,
and keep topo structures/functions where they are now?
(I dislike a little scattering consolidated pieces across multiple files,
but what worries me more is that it makes target/i386/cpu.c via
topology.h -> x86.h chain pull in a lot of unrelated dependencies)

So I'd keep X86CPUTopoIDs and X86CPUTopoInfo in topology.h 

[...]
> >> +static inline void init_topo_info(X86CPUTopoInfo *topo_info,
> >> +                                  const X86MachineState *x86ms)
> >> +{
> >> +    MachineState *ms = MACHINE(x86ms);
> >> +
> >> +    topo_info->dies_per_pkg = x86ms->smp_dies;
> >> +    topo_info->cores_per_die = ms->smp.cores;
> >> +    topo_info->threads_per_core = ms->smp.threads;
> >> +}

this is pure machine specific helper, and aren't used anywhere else
beside machine code.
Suggest to put it in pc.c or x86.c to keep topology.h machine independent.

> >>  
> >>  /* Return the bit width needed for 'count' IDs
> >>   */
> >> diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
> >> index 4b84917885..ad62b01cf2 100644
> >> --- a/include/hw/i386/x86.h
> >> +++ b/include/hw/i386/x86.h
> >> @@ -36,6 +36,23 @@ typedef struct {
> >>      bool compat_apic_id_mode;
> >>  } X86MachineClass;
> >>  
> >> +/* APIC IDs can be 32-bit, but beware: APIC IDs > 255 require x2APIC support
> >> + */
> >> +typedef uint32_t apic_id_t;
> >> +
> >> +typedef struct X86CPUTopoIDs {
> >> +    unsigned pkg_id;
> >> +    unsigned die_id;
> >> +    unsigned core_id;
> >> +    unsigned smt_id;
> >> +} X86CPUTopoIDs;
> >> +
> >> +typedef struct X86CPUTopoInfo {
> >> +    unsigned dies_per_pkg;
> >> +    unsigned cores_per_die;
> >> +    unsigned threads_per_core;
> >> +} X86CPUTopoInfo;
> >> +
> >>  typedef struct {
> >>      /*< private >*/
> >>      MachineState parent;
> >>  
> >   
> 


