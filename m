Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E29C43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 12:35:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC39020EDD
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 12:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FlhgdSTe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC39020EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKL2W-00059M-RO
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 08:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kKKze-0002JX-Li
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 08:32:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43705)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kKKzb-0000v4-Ec
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 08:32:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600691546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vNMNIDMF6eTHlo4TYQrUVrdAeMqSLNfpT/KFR4Sy12I=;
 b=FlhgdSTemhJpjE2wWLpgcc5TsbVDdS/lg6mlxZwj9lKpl+cr6NIFf/j1vlRVgCETvgz699
 EZq2SxKxRA9btasGGj/32w5mAK0HEbQQbEvMJHq58eiBSZbgCEEi7SE4E271PS2AtAD9i4
 LrNJKXBhdrqVuz/uUKIEM/aZMUQH4xw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-rLhVLX5-O_Cnyyak7V-kLw-1; Mon, 21 Sep 2020 08:32:24 -0400
X-MC-Unique: rLhVLX5-O_Cnyyak7V-kLw-1
Received: by mail-wr1-f70.google.com with SMTP id r16so5786718wrm.18
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 05:32:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=vNMNIDMF6eTHlo4TYQrUVrdAeMqSLNfpT/KFR4Sy12I=;
 b=JnAF/fDPCSPmi62fEbtWRMlvSWgTM/l5IFCnz08LTCCmqH28gUbVaOdTc0p9vb5V71
 VSdh6C87y5Yb6H0UjVZuiaVpuYKVHRfc83rvaoBwG93Gg5uCnCQXW2XqMl0OK29Ej7Lf
 bkdowJlTaRcDQSgdWGWW6iENtghVDZmoXbakmmHEY7WmOA/JmMt4jMcrG/aibZ0xpfe4
 yvz5QTqiOWo+ClzN6jHXH9vA6Dwx16B8EmroPfsQkVqshwisTgZE0TYiNR6KqcR7KewR
 JKf4YNgkE7J/5M8JolfEaGkJ2P3nwLJTriFRxYC8LdC6EDATY276DDvLwELTLQgSWmvD
 arBQ==
X-Gm-Message-State: AOAM530jkmQ+KiGKIcjA9zo8g1xnXOQuv/ZnlBKrrRIu6Gfy52qj3FGs
 GwBn9Z3Jfj/IZ4nnN3vpK7IpmnVh+1mzcxLJbJTa8V9T1WrIY8/BqPP6y6UWUqqRbnc/RXEEwJC
 dV4bXhp2GP4HWNjI=
X-Received: by 2002:a1c:4303:: with SMTP id q3mr29955530wma.158.1600691542798; 
 Mon, 21 Sep 2020 05:32:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXOhzxfnYUNnHPF27lTuL5xwbV/vKYDUsVVRMXRhQURpr798s2B5gSuP+ZWStCbQSfOvT6rw==
X-Received: by 2002:a1c:4303:: with SMTP id q3mr29955511wma.158.1600691542604; 
 Mon, 21 Sep 2020 05:32:22 -0700 (PDT)
Received: from redhat.com (bzq-109-65-116-225.red.bezeqint.net.
 [109.65.116.225])
 by smtp.gmail.com with ESMTPSA id c25sm19486859wml.31.2020.09.21.05.32.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2020 05:32:21 -0700 (PDT)
Date: Mon, 21 Sep 2020 08:32:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 0/2] vhost-vdpa: add trace functions in vhost-vdpa.c
Message-ID: <20200921083214-mutt-send-email-mst@kernel.org>
References: <20200920162434.868041-1-lvivier@redhat.com>
 <20200921084136.GB71121@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200921084136.GB71121@stefanha-x1.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:44:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Cindy Lu <lulu@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 21, 2020 at 09:41:36AM +0100, Stefan Hajnoczi wrote:
> On Sun, Sep 20, 2020 at 06:24:32PM +0200, Laurent Vivier wrote:
> > Add trace events functions in vdpa functions.
> > 
> > Modify qemu_hexdump() to be able to dump the vdpa config
> > in trace logs in hexadecimal form.
> > 
> > Laurent Vivier (2):
> >   util/hexdump: introduce qemu_hexdump_line()
> >   vhost-vdpa: add trace-events
> > 
> >  hw/virtio/trace-events | 29 ++++++++++++++
> >  hw/virtio/vhost-vdpa.c | 85 +++++++++++++++++++++++++++++++++++++++---
> >  include/qemu-common.h  |  8 ++++
> >  util/hexdump.c         | 54 +++++++++++++++++----------
> >  4 files changed, 151 insertions(+), 25 deletions(-)
> 
> Please take this through the VIRTIO/vhost/vDPA tree:
> 
> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>


Will do, tagged.


