Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8F6C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 06:36:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCC6E206D7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 06:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/VXp9Y3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCC6E206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyUq6-0001cQ-3q
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 02:36:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jyUpK-00019i-Ne
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 02:35:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42472
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jyUpJ-0000PU-3T
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 02:35:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595486132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0sa6zTJFWmnzJMuDzG4xtWOkKIjeg8jF7Ob0tj+Z4mM=;
 b=U/VXp9Y3vobgdtJIYgTVKTn6Q75sP32isFmneFFn0dV3oFjSwmQkp3Pii5M7G1xBYN5zmJ
 Z8cwMnfA0AfdTqcrXvCTJNCLVIHF/YVHRmdwM+koKL/sh6au9e+gY27cMnfpOLqCpQhSJM
 DJNVuxZx1Xc+Y/ICZGHY8hS5GyOhtgA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63--c3Afsi7MzmZw2HrZR-OcQ-1; Thu, 23 Jul 2020 02:35:28 -0400
X-MC-Unique: -c3Afsi7MzmZw2HrZR-OcQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CD0E10059A8;
 Thu, 23 Jul 2020 06:35:27 +0000 (UTC)
Received: from gondolin (ovpn-112-228.ams2.redhat.com [10.36.112.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B49AA5F7D8;
 Thu, 23 Jul 2020 06:35:20 +0000 (UTC)
Date: Thu, 23 Jul 2020 08:35:18 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 0/2] virtio: non-legacy device handling
Message-ID: <20200723083518.5076eb60.cohuck@redhat.com>
In-Reply-To: <20200720115406.508f2115.pasic@linux.ibm.com>
References: <20200707105446.677966-1-cohuck@redhat.com>
 <20200720115406.508f2115.pasic@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 22:13:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Eric Auger <eric.auger@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 20 Jul 2020 11:54:06 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Tue,  7 Jul 2020 12:54:44 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > As discussed in "virtio-fs: force virtio 1.x usage", it seems like
> > a good idea to make sure that any new virtio device (which does not
> > support legacy virtio) is indeed a non-transitional device, just to
> > catch accidental misconfigurations. We can easily compile a list
> > of virtio devices with legacy support and have transports verify
> > in their plugged callbacks that legacy support is off for any device
> > not in that list.
> > 
> > Most new virtio devices force non-transitional already, so nothing
> > changes for them. vhost-user-fs-pci even does not allow to configure
> > a non-transitional device, so it is fine as well.
> > 
> > One problematic device, however, is virtio-iommu-pci. It currently
> > offers both the transitional and the non-transitional variety of the
> > device, and does not force anything. I'm unsure whether we should
> > consider transitional virtio-iommu unsupported, or if we should add
> > some compat handling. (The support for legacy or not generally may
> > change based upon the bus, IIUC, so I'm unsure how to come up with
> > something generic.)
> >   
> 
> Both patches look good to me (Acked-by: Halil Pasic
> <pasic@linux.ibm.com>). I tend to agree with Davids comment on how
> this information is coded: the more object oriented way would have
> been to store this at the something like VirtioDeviceClass, but
> Michael's argument stands.
> 
> Another OO option would be to expose this as a virtio property. Would
> enable introspection, and would also give the host admin means to
> force non-legacy for transitional devices. But the juice is probably not
> worth the squeeze.

I agree, that would be a lot of hassle for exposing what is basically
static information.


