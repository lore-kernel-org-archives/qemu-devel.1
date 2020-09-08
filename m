Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CFBC43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:42:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F12022206
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ae3g1x7p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F12022206
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFepJ-00060i-Gu
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 10:42:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kFeog-0005Av-Cq
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 10:41:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37623
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kFeoe-0000xR-HA
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 10:41:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599576107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qgdTHd8NGowSZwDg6eCJYPhbgoyY002d0TclHThacBE=;
 b=ae3g1x7plq3OniqpZErFf1i0Kln+mgV8Uqhcdaj2xncAQ0GAYRn9G0NyfilnZtVV40Z1fQ
 YakVgTxYkf8YomhRCV4y8l2cG5WFl96bwduHBpU6lqUautXbOBzgDEBrV4PaKbqqM8ICrI
 2Hm9+yDJ6ZArHjUBaitwcVIs4HLlzQM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-cdmyatQrMKiTRJWLAAMpJg-1; Tue, 08 Sep 2020 10:41:43 -0400
X-MC-Unique: cdmyatQrMKiTRJWLAAMpJg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5EFB800050;
 Tue,  8 Sep 2020 14:41:40 +0000 (UTC)
Received: from gondolin (ovpn-112-243.ams2.redhat.com [10.36.112.243])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CBF813A40;
 Tue,  8 Sep 2020 14:41:32 +0000 (UTC)
Date: Tue, 8 Sep 2020 16:41:30 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Subject: Re: device compatibility interface for live migration with assigned
 devices
Message-ID: <20200908164130.2fe0d106.cohuck@redhat.com>
In-Reply-To: <20200831044344.GB13784@joy-OptiPlex-7040>
References: <3a073222-dcfe-c02d-198b-29f6a507b2e1@redhat.com>
 <20200818091628.GC20215@redhat.com>
 <20200818113652.5d81a392.cohuck@redhat.com>
 <20200820003922.GE21172@joy-OptiPlex-7040>
 <20200819212234.223667b3@x1.home>
 <20200820031621.GA24997@joy-OptiPlex-7040>
 <20200825163925.1c19b0f0.cohuck@redhat.com>
 <20200826064117.GA22243@joy-OptiPlex-7040>
 <20200828154741.30cfc1a3.cohuck@redhat.com>
 <8f5345be73ebf4f8f7f51d6cdc9c2a0d8e0aa45e.camel@redhat.com>
 <20200831044344.GB13784@joy-OptiPlex-7040>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 00:33:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kvm@vger.kernel.org, libvir-list@redhat.com,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, kwankhede@nvidia.com,
 eauger@redhat.com, xin-ran.wang@intel.com, corbet@lwn.net,
 openstack-discuss@lists.openstack.org, shaohe.feng@intel.com,
 kevin.tian@intel.com, Parav Pandit <parav@mellanox.com>,
 jian-feng.ding@intel.com, dgilbert@redhat.com, zhenyuw@linux.intel.com,
 hejie.xu@intel.com, bao.yumeng@zte.com.cn,
 Alex Williamson <alex.williamson@redhat.com>, Sean Mooney <smooney@redhat.com>,
 intel-gvt-dev@lists.freedesktop.org,
 Daniel =?UTF-8?B?UC5CZXJyYW5nw6k=?= <berrange@redhat.com>, eskultet@redhat.com,
 Jiri Pirko <jiri@mellanox.com>, dinechin@redhat.com, devel@ovirt.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 31 Aug 2020 12:43:44 +0800
Yan Zhao <yan.y.zhao@intel.com> wrote:

> On Fri, Aug 28, 2020 at 03:04:12PM +0100, Sean Mooney wrote:
> > On Fri, 2020-08-28 at 15:47 +0200, Cornelia Huck wrote:  
> > > On Wed, 26 Aug 2020 14:41:17 +0800
> > > Yan Zhao <yan.y.zhao@intel.com> wrote:
> > >   
> > > > previously, we want to regard the two mdevs created with dsa-1dwq x 30 and
> > > > dsa-2dwq x 15 as compatible, because the two mdevs consist equal resources.
> > > > 
> > > > But, as it's a burden to upper layer, we agree that if this condition
> > > > happens, we still treat the two as incompatible.
> > > > 
> > > > To fix it, either the driver should expose dsa-1dwq only, or the target
> > > > dsa-2dwq needs to be destroyed and reallocated via dsa-1dwq x 30.  
> > > 
> > > AFAIU, these are mdev types, aren't they? So, basically, any management
> > > software needs to take care to use the matching mdev type on the target
> > > system for device creation?  
> > 
> > or just do the simple thing of use the same mdev type on the source and dest.
> > matching mdevtypes is not nessiarly trivial. we could do that but we woudl have
> > to do that in python rather then sql so it would be slower to do at least today.
> > 
> > we dont currently have the ablity to say the resouce provider must have 1 of these
> > set of traits. just that we must have a specific trait. this is a feature we have
> > disucssed a couple of times and delayed untill we really really need it but its not out
> > of the question that we could add it for this usecase. i suspect however we would do exact
> > match first and explore this later after the inital mdev migration works.  
> 
> Yes, I think it's good.
> 
> still, I'd like to put it more explicitly to make ensure it's not missed:
> the reason we want to specify compatible_type as a trait and check
> whether target compatible_type is the superset of source
> compatible_type is for the consideration of backward compatibility.
> e.g.
> an old generation device may have a mdev type xxx-v4-yyy, while a newer
> generation  device may be of mdev type xxx-v5-yyy.
> with the compatible_type traits, the old generation device is still
> able to be regarded as compatible to newer generation device even their
> mdev types are not equal.

If you want to support migration from v4 to v5, can't the (presumably
newer) driver that supports v5 simply register the v4 type as well, so
that the mdev can be created as v4? (Just like QEMU versioned machine
types work.)


