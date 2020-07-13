Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8525CC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 16:18:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5798720738
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 16:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WxZYEpQo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5798720738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv1AD-0004Wu-Lg
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 12:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jv19T-000460-QT
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 12:17:59 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24057
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jv19S-0002Mn-3j
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 12:17:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594657077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7fEcNPvbQtu3VJ0pepaiWZR+TS2uVOashY3uGQKig9c=;
 b=WxZYEpQo3/sBHHMf+3hZrDuYLDyt+LNy9FX3OvfPNAhraTm7wlamawjfumom2GVJ50bvsy
 Ie94t53PK5yjUh0pxZ5Atl81bHGwMdBrH6sVd31AKRfhzFyNq/l9FAazN6Xk16P3/vPUJn
 fSusuHa1yF3S/GpelRedWOrNvHnocUE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-y384sXReM3qeUnbce--IBA-1; Mon, 13 Jul 2020 12:17:53 -0400
X-MC-Unique: y384sXReM3qeUnbce--IBA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7FA00100CCC0;
 Mon, 13 Jul 2020 16:17:47 +0000 (UTC)
Received: from localhost (unknown [10.40.208.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A529C60BF3;
 Mon, 13 Jul 2020 16:17:42 +0000 (UTC)
Date: Mon, 13 Jul 2020 18:17:40 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v2 1/3] hw/i386: Initialize topo_ids from
 CpuInstanceProperties
Message-ID: <20200713181740.16a357a6@redhat.com>
In-Reply-To: <78809d9f-a491-8c99-3f35-7f012c7d75bf@amd.com>
References: <159362436285.36204.986406297373871949.stgit@naples-babu.amd.com>
 <159362466108.36204.3751851750959980962.stgit@naples-babu.amd.com>
 <20200713110822.5495e1c6@redhat.com>
 <78809d9f-a491-8c99-3f35-7f012c7d75bf@amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 13 Jul 2020 10:02:22 -0500
Babu Moger <babu.moger@amd.com> wrote:

> > -----Original Message-----
> > From: Igor Mammedov <imammedo@redhat.com>
> > Sent: Monday, July 13, 2020 4:08 AM
> > To: Moger, Babu <Babu.Moger@amd.com>
> > Cc: pbonzini@redhat.com; rth@twiddle.net; ehabkost@redhat.com; qemu-
> > devel@nongnu.org
> > Subject: Re: [PATCH v2 1/3] hw/i386: Initialize topo_ids from
> > CpuInstanceProperties
[...]
> > > +
> > > +/*
> > > + * Initialize topo_ids from CpuInstanceProperties
> > > + * node_id in CpuInstanceProperties(or in CPU device) is a sequential
> > > + * number, but while building the topology  
> >   
> > >we need to separate it for
> > > + * each socket(mod nodes_per_pkg).  
> > could you clarify a bit more on why this is necessary?  
> 
> If you have two sockets and 4 numa nodes, node_id in CpuInstanceProperties
> will be number sequentially as 0, 1, 2, 3.  But in EPYC topology, it will
> be  0, 1, 0, 1( Basically mod % number of nodes per socket).

I'm confused, let's suppose we have 2 EPYC sockets with 2 nodes per socket
so APIC id woulbe be composed like:

 1st socket
   pkg_id(0) | node_id(0)
   pkg_id(0) | node_id(1)

 2nd socket
   pkg_id(1) | node_id(0)
   pkg_id(1) | node_id(1)
  
if that's the case, then EPYC's node_id here doesn't look like
a NUMA node in the sense it's usually used
(above config would have 4 different memory controllers => 4 conventional NUMA nodes).

I wonder if linux guest actually uses node_id encoded in apic id for
configuring/checking numa structures, or it just uses whatever ACPI SRAT
table provided.
 
> > > + */
> > > +static inline void x86_init_topo_ids(X86CPUTopoInfo *topo_info,
> > > +                                     CpuInstanceProperties props,
> > > +                                     X86CPUTopoIDs *topo_ids) {
> > > +    topo_ids->smt_id = props.has_thread_id ? props.thread_id : 0;
> > > +    topo_ids->core_id = props.has_core_id ? props.core_id : 0;
> > > +    topo_ids->die_id = props.has_die_id ? props.die_id : 0;
> > > +    topo_ids->node_id = props.has_node_id ?
> > > +                        props.node_id % MAX(topo_info->nodes_per_pkg, 1) : 0;
> > > +    topo_ids->pkg_id = props.has_socket_id ? props.socket_id : 0; }
> > >  /*
> > >   * Make APIC ID for the CPU 'cpu_index'
> > >   *
> > >  
> 


