Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00997C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 13:02:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03EAB23447
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 13:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H5ikg/Ar"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03EAB23447
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJG1c-00006x-Nb
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 09:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kJFyA-0005PM-Id
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 08:58:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48263)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kJFy7-0006uI-P9
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 08:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600433907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Swjg6JtNWiSsA7Gqx8LadboTG4OB8kOPgC6rFDALr4A=;
 b=H5ikg/ArlhrjmGirWPUB7yRj49M+TgOCbfpewejn4XsyrhN+MJDGGnVhQQ6mcQlfvUpFOW
 qfI2ZZEanNe4Rx5FToB9sccr0/k4JwIEetEoW6vzbnWW6yr5HHqNcYfVnYXxi/ObAQe5Zz
 YzoEVrbIZtGTHIwbu9iMZkGT5WfJUAs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-sr8c-y12MtKwKleA0KzkuA-1; Fri, 18 Sep 2020 08:58:24 -0400
X-MC-Unique: sr8c-y12MtKwKleA0KzkuA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E3F61019628;
 Fri, 18 Sep 2020 12:58:23 +0000 (UTC)
Received: from gondolin (ovpn-112-191.ams2.redhat.com [10.36.112.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 00F81610F3;
 Fri, 18 Sep 2020 12:58:16 +0000 (UTC)
Date: Fri, 18 Sep 2020 14:58:13 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v2 2/2] virtio-iommu-pci: force virtio version 1
Message-ID: <20200918145813.667833a0.cohuck@redhat.com>
In-Reply-To: <72eea96c-8ad0-90b0-aaa7-dabad1f118d8@redhat.com>
References: <20200908193309.20569-1-eric.auger@redhat.com>
 <20200908193309.20569-3-eric.auger@redhat.com>
 <20200918112909.5f797bf4.cohuck@redhat.com>
 <72eea96c-8ad0-90b0-aaa7-dabad1f118d8@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 00:20:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: jean-philippe@linaro.org, thuth@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 18 Sep 2020 12:24:02 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Connie,
> 
> On 9/18/20 11:29 AM, Cornelia Huck wrote:
> > On Tue,  8 Sep 2020 21:33:09 +0200
> > Eric Auger <eric.auger@redhat.com> wrote:
> >   
> >> Commit 9b3a35ec82 ("virtio: verify that legacy support is not
> >> accidentally on") added a safety check that requires to set
> >> 'disable-legacy=on' on virtio-iommu-pci:
> >>
> >> qemu-system-aarch64: -device virtio-iommu-pci: device is modern-only,
> >> use disable-legacy=on
> >>
> >> virtio-iommu was introduced after the release of VIRTIO 1.0
> >> specifications, so it should be 'modern-only'.
> >>
> >> This patch forces virtio version 1 and removes the 'transitional_name'
> >> property removing the need to specify 'disable-legacy=on' on
> >> virtio-iommu-pci device.  
> > 
> > Not sure whether this patch has been queued already, and how much we
> > care about migration compatibility for virtio-iommu, but would it make
> > sense to force modern on 5.1+ compat machines only? (see
> > https://lore.kernel.org/qemu-devel/20200918074710.27810-1-sgarzare@redhat.com/)  
> 
> I don't think it was pulled yet.
> >   
> >>
> >> Cc: qemu-stable@nongnu.org  
> 
> The virtio-iommu-pci device only is usable on ARM in dt mode so I don't
> think it has production users at the moment.

OK, then we can keep this patch here, I guess.


