Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2091BC56203
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:56:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8224022249
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q0Mo8mEu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8224022249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUs7d-00088U-HV
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 09:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kUs6G-0007ND-DE
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 09:54:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44555)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kUs6E-0004BT-2x
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 09:54:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603202088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CHtVVKncDMChSljwwelCp9zTgkd2lEcwI9yef7BEcXE=;
 b=Q0Mo8mEuhio6AHeQ6XPR3jaeMMe+aFj2mAyeSU+EvQhDf7lWEJbfxbtjNXywDVhot5m0GM
 Hf+JaeEc/YMS+oCrQqctjD3u2TR5Wr0RbqwdbcShltojA6xOzL9pbmS4SvXgbPK0BC25nG
 mRYaIHlwRgtvRJV09jp7gpGFlVuj4Hw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-lgxle8j4PoiTxyav6l98NA-1; Tue, 20 Oct 2020 09:54:47 -0400
X-MC-Unique: lgxle8j4PoiTxyav6l98NA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BAFDD192CC4D;
 Tue, 20 Oct 2020 13:54:45 +0000 (UTC)
Received: from localhost (ovpn-66-44.rdu2.redhat.com [10.10.66.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6252155798;
 Tue, 20 Oct 2020 13:54:45 +0000 (UTC)
Date: Tue, 20 Oct 2020 09:54:44 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v5] sev: add sev-inject-launch-secret
Message-ID: <20201020135444.GR5733@habkost.net>
References: <20201015143713.14682-1-tobin@linux.ibm.com>
 <2f1be055-58c8-dcf8-debc-8956636d8ef8@redhat.com>
MIME-Version: 1.0
In-Reply-To: <2f1be055-58c8-dcf8-debc-8956636d8ef8@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: thomas.lendacky@amd.com, brijesh.singh@amd.com, jejb@linux.ibm.com,
 tobin@ibm.com, qemu-devel@nongnu.org, dgilbert@redhat.com, tobin@linux.ibm.com,
 berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 20, 2020 at 11:03:51AM +0200, Paolo Bonzini wrote:
> On 15/10/20 16:37, tobin@linux.ibm.com wrote:
> > -static void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, Error **errp)
> > +void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, uint64_t size, Error **errp)
> >  {
> >      MemoryRegionSection mrs = memory_region_find(get_system_memory(),
> > -                                                 addr, 1);
> > +                                                 addr, size);
> 
> You need to check size against mrs.size and fail if mrs.size is smaller.
>  Otherwise, the ioctl can access memory out of range.

Good catch!  I'm dequeuing it.

Is there a reason memory_region_find() doesn't ensure that by
default?

It looks like there's only one memory_region_find() call in the
code that doesn't expect the returned section to contain the
entire range (at platform_bus_map_mmio()).  All the remaining
memory_region_find() calls either have size==1 (so it doesn't
matter) or have an extra check for MemoryRegionSection.size.

The call at virtio_balloon_handle_output() looks suspicious,
though, because it looks for a BALLOON_PAGE_SIZE range, but
there's no check for the returned section size.

-- 
Eduardo


