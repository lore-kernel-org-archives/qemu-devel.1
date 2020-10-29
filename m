Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98128C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 20:26:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDE5920725
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 20:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KbIUIh0+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDE5920725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYEVZ-0001Ut-Qr
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 16:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kYEUx-00011a-3D
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 16:26:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33330)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kYEUs-0003Bz-Kn
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 16:26:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604003167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TWbcttGtd4gO6X6hh29i3YMngXqHbKL/xXmoggrdBY8=;
 b=KbIUIh0+ZNar3gLeQ5smwFFudZuIRQKmLxXt2UZKJ49K3F2DrUtel4SD6lj6cSELhmDrIY
 UfDU6qNrioYy8jfk+mGvIZgrlSR8vGwFElw2CoIHvyxcm3kElZKHwG4DJfD5MqmVzW1mFT
 3imrXo4lmveZI3UN/awzNjmm9oWUNCI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-4XVIl27IPyyZ0TUs9s-eGA-1; Thu, 29 Oct 2020 16:26:03 -0400
X-MC-Unique: 4XVIl27IPyyZ0TUs9s-eGA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80C86425CC;
 Thu, 29 Oct 2020 20:26:02 +0000 (UTC)
Received: from gondolin (ovpn-112-55.ams2.redhat.com [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CFE2260C17;
 Thu, 29 Oct 2020 20:25:57 +0000 (UTC)
Date: Thu, 29 Oct 2020 21:25:54 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v1] docs/devel: Add VFIO device migration documentation
Message-ID: <20201029212554.11f1b54c.cohuck@redhat.com>
In-Reply-To: <20201029130519.7eb1e704@w520.home>
References: <1603950791-27236-1-git-send-email-kwankhede@nvidia.com>
 <20201029125221.69352b48.cohuck@redhat.com>
 <9479dffd-e434-e336-6ed8-07fc2edd2453@nvidia.com>
 <20201029130519.7eb1e704@w520.home>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:47:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: mcrossley@nvidia.com, cjia@nvidia.com, qemu-devel@nongnu.org,
 Kirti Wankhede <kwankhede@nvidia.com>, dnigam@nvidia.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 29 Oct 2020 13:05:19 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Thu, 29 Oct 2020 23:11:16 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
> > Thanks for corrections Cornelia. I had done the corrections you 
> > suggested I had not replied, see my comments on couple of places where I 
> > disagree.
> > 
> > 
> > On 10/29/2020 5:22 PM, Cornelia Huck wrote:  
> > > On Thu, 29 Oct 2020 11:23:11 +0530
> > > Kirti Wankhede <kwankhede@nvidia.com> wrote:

> > >> +Detailed description of UAPI for VFIO device for migration is in the comment
> > >> +above ``vfio_device_migration_info`` structure definition in header file
> > >> +linux-headers/linux/vfio.h.    
> > > 
> > > I think I'd copy that to this file. If I'm looking at the
> > > documentation, I'd rather not go hunting for source code to find out
> > > what structure you are talking about. Plus, as it's UAPI, I don't
> > > expect it to change much, so it should be easy to keep the definitions
> > > in sync (famous last words).
> > >     
> > 
> > I feel its duplication of documentation. I would like to know others 
> > views as well.  
> 
> 
> TBH I don't think it's necessary here either, we're documenting the
> QEMU interaction with the uAPI, the uAPI itself is documented in the
> kernel header.  I don't think it would be unreasonable to ask someone
> trying to understand this to look at both sources together.

Ok, I can live with that. But let me correct some nits :)

"A detailed description of the UAPI for VFIO device migration can be
found in the comment for the ``vfio_device_migration_info`` structure
in the header file linux-headers/linux/vfio.h."

(...)

> > >> +remaining data for VFIO device till pending_bytes returned by vendor driver
> > >> +is zero.    
> > > 
> > > "...and interactively copies the remaining data for the VFIO device
> > > until the vendor driver indicates that no data remains (pending_bytes
> > > is zero)." ?  
> 
> 
> Connie, was that intentional to replace "iteratively" with
> "interactively"?  Iteratively seems correct to me.

Eh, should be "iteratively", of course. Too many meetings :/


