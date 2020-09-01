Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7251C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 12:16:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CC17207BC
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 12:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="azK9ayYe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CC17207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD5Da-0000Q6-NF
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 08:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kD5C5-0007ND-HU
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 08:15:21 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33161)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kD5C3-00067b-N9
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 08:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598962518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=usUKAEN6jNeherrc3hhx97ohUUJgVU5Kt4itxc+lNbo=;
 b=azK9ayYeJYC3QgX8Ph8spCwx6NPXRQ7buXQE441YtvkBw/jrBN9SJuv9Y//9s6RSg5Qf1v
 3Npm7/nx6/b/iXjD9AYEndzX+5W55bJfomUdTCEf6gJC26c4BH8duApkfoxOb29SVoZvtG
 9upfVH2qfMFTNuSM6WhQyRmQW+071Uo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-vZYYl2ybMcCZuhuGh3xwFA-1; Tue, 01 Sep 2020 08:15:15 -0400
X-MC-Unique: vZYYl2ybMcCZuhuGh3xwFA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F27041006705;
 Tue,  1 Sep 2020 12:15:13 +0000 (UTC)
Received: from imammedo-mac (unknown [10.40.193.201])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5513B5C1A3;
 Tue,  1 Sep 2020 12:15:08 +0000 (UTC)
Date: Tue, 1 Sep 2020 14:15:06 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v6 05/10] Revert "hw/i386: Introduce apicid functions
 inside X86MachineState"
Message-ID: <20200901141506.5b2f6fbf@imammedo-mac>
In-Reply-To: <159889935648.21294.8095493980805969544.stgit@naples-babu.amd.com>
References: <159889924378.21294.16494070903874534542.stgit@naples-babu.amd.com>
 <159889935648.21294.8095493980805969544.stgit@naples-babu.amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 23:17:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 31 Aug 2020 13:42:36 -0500
Babu Moger <babu.moger@amd.com> wrote:

> This reverts commit 6121c7fbfd98dbc3af1b00b56ff2eef66df87828.
> 
> Remove the EPYC specific apicid decoding and use the generic
> default decoding.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/i386/x86.c         |    5 -----
>  include/hw/i386/x86.h |    9 ---------
>  2 files changed, 14 deletions(-)
> 
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index 3cc2318212..727c4a0f1d 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -896,11 +896,6 @@ static void x86_machine_initfn(Object *obj)
>      x86ms->smm = ON_OFF_AUTO_AUTO;
>      x86ms->acpi = ON_OFF_AUTO_AUTO;
>      x86ms->smp_dies = 1;
> -
> -    x86ms->apicid_from_cpu_idx = x86_apicid_from_cpu_idx;
> -    x86ms->topo_ids_from_apicid = x86_topo_ids_from_apicid;
> -    x86ms->apicid_from_topo_ids = x86_apicid_from_topo_ids;
> -    x86ms->apicid_pkg_offset = apicid_pkg_offset;
>  }
>  
>  static void x86_machine_class_init(ObjectClass *oc, void *data)
> diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
> index b79f24e285..4d9a26326d 100644
> --- a/include/hw/i386/x86.h
> +++ b/include/hw/i386/x86.h
> @@ -63,15 +63,6 @@ typedef struct {
>      OnOffAuto smm;
>      OnOffAuto acpi;
>  
> -    /* Apic id specific handlers */
> -    uint32_t (*apicid_from_cpu_idx)(X86CPUTopoInfo *topo_info,
> -                                    unsigned cpu_index);
> -    void (*topo_ids_from_apicid)(apic_id_t apicid, X86CPUTopoInfo *topo_info,
> -                                 X86CPUTopoIDs *topo_ids);
> -    apic_id_t (*apicid_from_topo_ids)(X86CPUTopoInfo *topo_info,
> -                                      const X86CPUTopoIDs *topo_ids);
> -    uint32_t (*apicid_pkg_offset)(X86CPUTopoInfo *topo_info);
> -
>      /*
>       * Address space used by IOAPIC device. All IOAPIC interrupts
>       * will be translated to MSI messages in the address space.
> 


