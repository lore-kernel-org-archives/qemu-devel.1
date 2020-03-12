Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1572C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 12:40:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89AA9206B1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 12:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K2HBlPK9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89AA9206B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCN8U-0007nJ-Mm
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 08:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43263)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jCN7c-00070u-NS
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 08:39:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jCN7b-0001yp-Ge
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 08:39:32 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55981
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jCN7b-0001wJ-BT
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 08:39:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584016769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2cOjPplbTGP2ZUXl1h2CrzPwJuPfbNGqACT2ex7H/UE=;
 b=K2HBlPK9DCgsLV6Abzd09hw+poo0/Jj5n4dzLcvncWojTBi7zeFMitRN1i7x5JX47wa2kP
 fY65LnnmfBGdhxuVbKNTCg1H/1a4qkp33EUffD0ioJzJkQrO+Kr+hjFGkv0ezRw378Pp4c
 zGg/9q3kum+xIRkq7Ocdu1vkHAuSuMY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-XfVI6cw9NhOP2kHmXf1xtg-1; Thu, 12 Mar 2020 08:39:23 -0400
X-MC-Unique: XfVI6cw9NhOP2kHmXf1xtg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1443B10838A0;
 Thu, 12 Mar 2020 12:39:22 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 19D3090CFF;
 Thu, 12 Mar 2020 12:39:17 +0000 (UTC)
Date: Thu, 12 Mar 2020 13:39:16 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v7 07/13] hw/386: Add EPYC mode topology decoding functions
Message-ID: <20200312133916.512773bc@redhat.com>
In-Reply-To: <158396721426.58170.2930696192478912976.stgit@naples-babu.amd.com>
References: <158396702138.58170.7920458595372792959.stgit@naples-babu.amd.com>
 <158396721426.58170.2930696192478912976.stgit@naples-babu.amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

On Wed, 11 Mar 2020 17:53:34 -0500
Babu Moger <babu.moger@amd.com> wrote:

> These functions add support for building EPYC mode topology given the smp
> details like numa nodes, cores, threads and sockets.
> 
> The new apic id decoding is mostly similar to current apic id decoding
> except that it adds a new field node_id when numa configured. Removes all
> the hardcoded values. Subsequent patches will use these functions to build
> the topology.
> 
> Following functions are added.
[...]
> x86_topo_ids_from_idx_epyc
you forgot to remove unused anymore function.
No need to respin whole series for it though, you can post as reply to
this patch v8 or do it as a patch on top.




[...]
> 
> The topology details are available in Processor Programming Reference (PPR)
> for AMD Family 17h Model 01h, Revision B1 Processors. The revision guides are
> available from the bugzilla Link below.
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Acked-by: Igor Mammedov <imammedo@redhat.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
[...]
> +static inline void x86_topo_ids_from_idx_epyc(X86CPUTopoInfo *topo_info,
> +                                              unsigned cpu_index,
> +                                              X86CPUTopoIDs *topo_ids)
> +{
> +    unsigned nr_nodes = MAX(topo_info->nodes_per_pkg, 1);
> +    unsigned nr_dies = topo_info->dies_per_pkg;
> +    unsigned nr_cores = topo_info->cores_per_die;
> +    unsigned nr_threads = topo_info->threads_per_core;
> +    unsigned cores_per_node = DIV_ROUND_UP((nr_dies * nr_cores * nr_threads),
> +                                            nr_nodes);
> +
> +    topo_ids->pkg_id = cpu_index / (nr_dies * nr_cores * nr_threads);
> +    topo_ids->node_id = (cpu_index / cores_per_node) % nr_nodes;
> +    topo_ids->die_id = cpu_index / (nr_cores * nr_threads) % nr_dies;
> +    topo_ids->core_id = cpu_index / nr_threads % nr_cores;
> +    topo_ids->smt_id = cpu_index % nr_threads;
> +}
> +
> +/*
[...]


