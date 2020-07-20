Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D16DC433EB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 15:57:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B9BE2065E
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 15:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NXvLuVQi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B9BE2065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxYAL-0006cK-7J
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 11:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jxY9n-0006BK-Jv
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 11:56:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47436
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jxY9l-0001Zs-47
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 11:56:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595260603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bc9SSqDEYKqzT/cpLIBtyRYjmrJaB2GtxgsF8jnekfc=;
 b=NXvLuVQi3GKTgCtNnmFFxfXLPZXCSMCtbJjFe9DKFLEYFt1cXSDL9y07g670EgXwvTrJjt
 rAn8Wbh3mOEA7sFqvEfhvo32eVdtAm2wJms5caTPNHBpCTZ9mdXjwzxhmloopWt9hErFuD
 jW12QnlE0JDdRgWixgCpPLXhOwTOe9s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-Y9MBSV8-Nne-DfSHHwa5BA-1; Mon, 20 Jul 2020 11:56:38 -0400
X-MC-Unique: Y9MBSV8-Nne-DfSHHwa5BA-1
Received: by mail-wr1-f72.google.com with SMTP id o12so12276558wrj.23
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 08:56:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=bc9SSqDEYKqzT/cpLIBtyRYjmrJaB2GtxgsF8jnekfc=;
 b=KyaBRUi0qRuvspKEIZqBfJbmq9bdYjT1lVSUPlOp9KDMSLOc+RXmsfy3wQFa1HBPLn
 8XNY5biGj0okYNazGROZzSYPIRKcaYsrd+qUJd62Sjst/1RHXfS/yimdo/XGp9Vf3I09
 iychGHRxu9XBaxJlXJFiYvanPBHbuIiuHU8S/++OQigjNSMdgQFyt91Hb1IfAAbXA64j
 1SYmNZxk2EybAfXvJgXLp+mY1yIx618aPVk+4h9d7hn6EPMTzpcDWhA/sNpd2I8o5Dr0
 DCodSLLHOtoQOhMjm/uBz7DMDPb0xgJIJqXdQKVljHsaogawOck5RV6jbxUD7QYQ8tth
 xgBQ==
X-Gm-Message-State: AOAM532Oc8iLzrfjO54YBeGuZL4GhOaTHXAVXNfnFqtV6jsFX3EReyUR
 lH5fgX8mi9Ap1XWFgRzy86oLQeeJkYtIPxcegFP7++4Nmj2rUoieKad3MuVL/ox8JBHJyg3xOIO
 UxAw1cpMsMiarlDQ=
X-Received: by 2002:a5d:67d2:: with SMTP id n18mr2813404wrw.214.1595260597177; 
 Mon, 20 Jul 2020 08:56:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGF80TRGR7Fg6XRSDoFZLnVYdfgVfK4zQSvVQqK7+TtLeyNjubAmW3uM1l4G8gm4dZm0UXYQ==
X-Received: by 2002:a5d:67d2:: with SMTP id n18mr2813379wrw.214.1595260596742; 
 Mon, 20 Jul 2020 08:56:36 -0700 (PDT)
Received: from redhat.com (bzq-79-179-105-63.red.bezeqint.net. [79.179.105.63])
 by smtp.gmail.com with ESMTPSA id t141sm35105591wmt.26.2020.07.20.08.56.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2020 08:56:35 -0700 (PDT)
Date: Mon, 20 Jul 2020 11:56:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: Intended purpose of virtio-rng's QOM link "rng"?
Message-ID: <20200720112838-mutt-send-email-mst@kernel.org>
References: <87d04qfco3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87d04qfco3.fsf@dusky.pond.sub.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 03:17:01
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
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 20, 2020 at 05:07:08PM +0200, Markus Armbruster wrote:
> What is the intended purpose of object_property_set_link() in
> 
>     static void virtio_rng_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
>     {
>         VirtIORngPCI *vrng = VIRTIO_RNG_PCI(vpci_dev);
>         DeviceState *vdev = DEVICE(&vrng->vdev);
> 
>         if (!qdev_realize(vdev, BUS(&vpci_dev->bus), errp)) {
>             return;
>         }
> 
>         object_property_set_link(OBJECT(vrng), "rng", OBJECT(vrng->vdev.conf.rng),
>                                  NULL);
>     }
> 
> ?
> 
> I'm asking because the function *always* fails.  I believe it's been
> failing for years.
> 
> Similar code in the CCW buddy.  Also virtio-crypto-pci and
> virtio-crypto-ccw link "cryptodev".
> 
> I tried moving it before qdev_realize(), where it doesn't fail.  But
> then *I* fail, namely at finding any effect in QOM.

I suspect that's because there's already a link with that name
created by virtio core. Is that right?

> If it's really useless, I'll send a patch to drop it.
> 
> If it has a use, tell me more, so I can test my patch to move it.


