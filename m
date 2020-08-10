Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF47C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 14:46:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6951E208A9
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 14:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WTH/0w52"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6951E208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k594e-0003le-Hr
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 10:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k593n-0003MS-6V
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 10:45:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52123
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k593l-0001z8-18
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 10:45:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597070755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NBfAuHUAf2zvtAL9a/O6hjXwH99vIEDNIhLmzF+gqPc=;
 b=WTH/0w52o9jluSUIFcwO/7JNCVtTIIaMGyjDPHPqKBuyhb2wMyuwGPx5wL9cpCn++f8N/n
 y3RrF+97qeDq3OExfiLMSdcg1wJgg5umcO9R+7N+JbUoIy45lM00jNeE+qMnGIAZGAOVTR
 qPLbHXf/a3gdTNoBlPPg+c4M4Anl0e4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-FwtVjcxkMj6uo_NiswmR6A-1; Mon, 10 Aug 2020 10:45:53 -0400
X-MC-Unique: FwtVjcxkMj6uo_NiswmR6A-1
Received: by mail-wr1-f71.google.com with SMTP id w1so4334115wro.4
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 07:45:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NBfAuHUAf2zvtAL9a/O6hjXwH99vIEDNIhLmzF+gqPc=;
 b=KnNzdZlOGXrPSsrtDYYoKaR8Bo0OjGVuofGRvMgQqNqHpV/7yGJ1vdeFEC01Qawz5z
 hmP6sgpNDkRqClw9lu6UhJhp0vR2U78cSk5BMDotWnBinNzo+7XlM5wQ/Y3pPrHHQGGW
 XZMCspEkkYtII0ikJ6DPdgy4GdgUkpo4/oPFU1sMXTj4QImg674qcPQi90Kuw6y7jko/
 YugWqvtlbh1vyfrm26yQAHJoOYG3OqT8xfgNlAM+I2kqKrDX9mP5050cUuDP/TiYnaZT
 E5BFJVNVXpqy4+V2JJ3ndw/P9ZAzsYdGZPo1682P98/RezNehN+aUj9nGil66Jdncr2P
 XzRA==
X-Gm-Message-State: AOAM531inLLSfmmngJ+piwyuXE/+8gcd9KpD0bTqkSpfnvDQokKxnnqS
 39Q/8sl5TArHqjUOJl41KcU9jWeS7TUIlCe+D7S6gSsnQc4Ds/oYImh7STy5S4dYD7zdKn+RUXl
 3upaT1FFGzG+Z4U8=
X-Received: by 2002:adf:e6cc:: with SMTP id y12mr24969166wrm.391.1597070752509; 
 Mon, 10 Aug 2020 07:45:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+BCTEyBWKbvYUuf9c8aOtiwdT3ApuBciwQKUQK+meJ8FliATbgKUPFkldh+ZFKSs9hiRx4w==
X-Received: by 2002:adf:e6cc:: with SMTP id y12mr24969112wrm.391.1597070751694; 
 Mon, 10 Aug 2020 07:45:51 -0700 (PDT)
Received: from redhat.com (bzq-79-180-0-181.red.bezeqint.net. [79.180.0.181])
 by smtp.gmail.com with ESMTPSA id
 33sm21594489wri.16.2020.08.10.07.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2020 07:45:49 -0700 (PDT)
Date: Mon, 10 Aug 2020 10:45:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: Any reason VIRTQUEUE_MAX_SIZE is 1024? Can we increase this limit?
Message-ID: <20200810104453-mutt-send-email-mst@kernel.org>
References: <AM7PR05MB6695D4FF6766BF2942C345D6BB710@AM7PR05MB6695.eurprd05.prod.outlook.com>
 <20200805121107.GG361702@stefanha-x1.localdomain>
 <20200805081144-mutt-send-email-mst@kernel.org>
 <20200806123708.GC379937@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200806123708.GC379937@stefanha-x1.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 03:31:01
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
Cc: jasowang@redhat.com, Yajun Wu <yajunw@mellanox.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 06, 2020 at 01:37:08PM +0100, Stefan Hajnoczi wrote:
> On Wed, Aug 05, 2020 at 08:13:29AM -0400, Michael S. Tsirkin wrote:
> > On Wed, Aug 05, 2020 at 01:11:07PM +0100, Stefan Hajnoczi wrote:
> > > On Thu, Jul 30, 2020 at 07:46:09AM +0000, Yajun Wu wrote:
> > > > I'm doing iperf test on VIRTIO net through vhost-user(HW VDPA).
> > > > Find maximal acceptable tx_queue_size/rx_queue_size is 1024.
> > > > Basically increase queue size can get better RX rate for my case.
> > > > 
> > > > Can we increase the limit(VIRTQUEUE_MAX_SIZE) to 8192 to possibly gain better performance?
> > > 
> > > Hi,
> > > The VIRTIO 1.1 specification says the maximum number of descriptors is
> > > 32768 for both split and packed virtqueues.
> > > 
> > > The vhost kernel code seems to support 32768.
> > > 
> > > The 1024 limit is an implementation limit in QEMU. Increasing it would
> > > require QEMU code changes. For example, VIRTQUEUE_MAX_SIZE is used as
> > > the size of arrays.
> > > 
> > > I can't think of a fundamental reason why QEMU needs to limit itself to
> > > 1024 descriptors. Raising the limit would require fixing up the code and
> > > ensuring that live migration remains compatible with older versions of
> > > QEMU.
> > > 
> > > Stefan
> > 
> > There's actually a reason for a limit: in theory the vq size
> > also sets a limit on the number of scatter/gather entries.
> > both QEMU and vhost can't handle a packet split over > 1k chunks.
> > 
> > We could add an extra limit for s/g size like block and scsi do,
> > this will need spec, guest and host side work.
> 
> Interesting, thanks for explaining! This could be made explicit by
> changing the QEMU code to:
> 
> include/hw/virtio/virtio.h:#define VIRTQUEUE_MAX_SIZE IOV_MAX
> 
> Looking more closely at the vhost kernel code I see that UIO_MAXIOV is
> used in some places but not in vhost_vring_set_num() (ioctl
> VHOST_SET_VRING_NUM). Is there a reason why UIO_MAXIOV isn't enforced
> when the application sets the queue size?
> 
> Stefan


Backends such as vhost-user can handle > iov max. Devices such
as scsi and block have a limit for s/g separate from vq size.

-- 
MST



