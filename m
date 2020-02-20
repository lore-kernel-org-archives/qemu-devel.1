Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA37C11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 12:44:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0974924670
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 12:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cFXlk3vm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0974924670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4lBe-0001VV-8p
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 07:44:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51829)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j4lB5-00016J-Fc
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 07:43:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j4lB3-0005Ej-R0
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 07:43:38 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21243
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j4lB3-0005Dc-Ft
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 07:43:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582202616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iwtCtM75BykrURzqDKszQeNWtR3uEDgVl+0pSFJQ3I8=;
 b=cFXlk3vmEpLgSQ5wvjtYpjM9Z3iNdtssMso14pnsNi8eiB3Wv9SITleiVRpaGZC7Kr19wi
 ZRlPjKBnGfbtRvtbFndpzZNJU4C58gl0mGgzkP3Y9sgoMl0YszTodFRl0/vnUKXBvb71QR
 z3CAIEG1wqLNRnqC0O2UFBFcEtNcgq0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-cJ7zLi2XNfqeK4SjvGykRg-1; Thu, 20 Feb 2020 07:43:34 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7AA241005513;
 Thu, 20 Feb 2020 12:43:33 +0000 (UTC)
Received: from localhost (ovpn-200-36.brq.redhat.com [10.40.200.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5E4B31001B28;
 Thu, 20 Feb 2020 12:43:26 +0000 (UTC)
Date: Thu, 20 Feb 2020 13:43:24 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v4 07/16] hw/i386: Rename apicid_from_topo_ids to
 x86_apicid_from_topo_ids
Message-ID: <20200220134324.2ce64c38@redhat.com>
In-Reply-To: <158161783201.48948.10267676745424104315.stgit@naples-babu.amd.com>
References: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
 <158161783201.48948.10267676745424104315.stgit@naples-babu.amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: cJ7zLi2XNfqeK4SjvGykRg-1
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

On Thu, 13 Feb 2020 12:17:12 -0600
Babu Moger <babu.moger@amd.com> wrote:

> For consistancy rename apicid_from_topo_ids to x86_apicid_from_topo_ids.
> No functional change.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/i386/pc.c               |    2 +-
>  include/hw/i386/topology.h |    6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 02fdb3d506..be72a49716 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1808,7 +1808,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>          topo_ids.die_id = cpu->die_id;
>          topo_ids.core_id = cpu->core_id;
>          topo_ids.smt_id = cpu->thread_id;
> -        cpu->apic_id = apicid_from_topo_ids(&topo_info, &topo_ids);
> +        cpu->apic_id = x86_apicid_from_topo_ids(&topo_info, &topo_ids);
>      }
>  
>      cpu_slot = pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, &idx);
> diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
> index 522c77e6a9..3158157430 100644
> --- a/include/hw/i386/topology.h
> +++ b/include/hw/i386/topology.h
> @@ -107,8 +107,8 @@ static inline unsigned apicid_pkg_offset(X86CPUTopoInfo *topo_info)
>   *
>   * The caller must make sure core_id < nr_cores and smt_id < nr_threads.
>   */
> -static inline apic_id_t apicid_from_topo_ids(X86CPUTopoInfo *topo_info,
> -                                             const X86CPUTopoIDs *topo_ids)
> +static inline apic_id_t x86_apicid_from_topo_ids(X86CPUTopoInfo *topo_info,
> +                                                 const X86CPUTopoIDs *topo_ids)
>  {
>      return (topo_ids->pkg_id  << apicid_pkg_offset(topo_info)) |
>             (topo_ids->die_id  << apicid_die_offset(topo_info)) |
> @@ -160,7 +160,7 @@ static inline apic_id_t x86_apicid_from_cpu_idx(X86CPUTopoInfo *topo_info,
>  {
>      X86CPUTopoIDs topo_ids;
>      x86_topo_ids_from_idx(topo_info, cpu_index, &topo_ids);
> -    return apicid_from_topo_ids(topo_info, &topo_ids);
> +    return x86_apicid_from_topo_ids(topo_info, &topo_ids);
>  }
>  
>  #endif /* HW_I386_TOPOLOGY_H */
> 


