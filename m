Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5598BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 22:27:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EF722086A
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 22:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mhs11YjF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EF722086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3RsQ-0005yK-AG
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 18:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k3Rrr-0005Z1-P1
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 18:26:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33370
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k3Rrp-0000JO-9v
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 18:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596666395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dCaInAjy0KspLXWuoEj++xCWsCiYljZP4kj7420xkVM=;
 b=Mhs11YjFXxWLteYX37ucESZJ9PVMVkwOcwzjRiZKHxV4OHWIIxTOjh8MuGtMYTVKAnhE4J
 QL48wFDrdJOcpJNa8Zm86TiN/WWgRvcbgjQuvrcPSzWJTh787YsdGZP9W1sW5GviYakm3G
 TF0nosk+pRZGC9PLZrqmO17YguqIKhM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-hnRSDPvyMPSSsZqiQz0Fwg-1; Wed, 05 Aug 2020 18:26:32 -0400
X-MC-Unique: hnRSDPvyMPSSsZqiQz0Fwg-1
Received: by mail-wr1-f70.google.com with SMTP id z7so13475145wrw.21
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 15:26:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dCaInAjy0KspLXWuoEj++xCWsCiYljZP4kj7420xkVM=;
 b=I1XLeg5fUJRRJlKQQ1zQp4B440n/zx5wuazFYiPyBpAwGMD7wA6derGwNs38nteYfJ
 IjX9EucIEArQVGaCRTgDQFI1i0YYGfOKACB0KzHZ+oygmSa/fNv1eCMiqNGYVXOcA//G
 a1wCBDvWf3XASW8zVEl5BAlCpNyfZRo1fjnqdCLTVgF5SPQw+i0om2quTj/vZh/BOwzx
 33p5lmLgx/SUwDyMf8HhX2LZ2HT1qg7Y2bMw+9PjR1ibgqUkMzMiRGfSXyPrYNJ8evJp
 DRB4smQY9X6toQy/E2PDk8/eCjBa+ZULlv2lG2P+uDtDT3PnmYWT+DitLeTFisy51CXn
 hYGQ==
X-Gm-Message-State: AOAM5302DEXvjdEEI/pG4AZvn0cZWpkcOp+Z5P5Tb+VIAjSIdLfW+/3P
 TMhlLPrYQHvAK6JyFUscjxawZ4bhikVqRPc08nxcjq+vumcoC8KA5YzyPXOslcmb38PA34sA1eD
 BmE8FoS2DHdYNCN0=
X-Received: by 2002:a1c:6289:: with SMTP id w131mr5309018wmb.41.1596666391433; 
 Wed, 05 Aug 2020 15:26:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVJbCktI3uC8fFuZ6bovc54Wau5Z7WKmxVZxt/ctYd7UBPQ9V/XUoQjzkBCSmpCM70zmUUkg==
X-Received: by 2002:a1c:6289:: with SMTP id w131mr5308997wmb.41.1596666391053; 
 Wed, 05 Aug 2020 15:26:31 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net.
 [79.177.102.128])
 by smtp.gmail.com with ESMTPSA id b203sm4378573wmc.22.2020.08.05.15.26.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 15:26:30 -0700 (PDT)
Date: Wed, 5 Aug 2020 18:26:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alyssa Ross <hi@alyssa.is>
Subject: Re: vhost-user protocol feature negotiation
Message-ID: <20200805181352-mutt-send-email-mst@kernel.org>
References: <87sgd1ktx9.fsf@alyssa.is>
MIME-Version: 1.0
In-Reply-To: <87sgd1ktx9.fsf@alyssa.is>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 18:26:35
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 05, 2020 at 03:13:06PM +0000, Alyssa Ross wrote:
> Quoting from the definition of VHOST_USER_SET_PROTOCOL_FEATURES in
> vhost-user.rst:
> 
> >   Only legal if feature bit ``VHOST_USER_F_PROTOCOL_FEATURES`` is present in
> >   ``VHOST_USER_GET_FEATURES``.
> > 
> > .. Note::
> >    Slave that reported ``VHOST_USER_F_PROTOCOL_FEATURES`` must support
> >    this message even before ``VHOST_USER_SET_FEATURES`` was called.
> 
> To me, this could mean either of two things:
> 
> (1) If VHOST_USER_F_PROTOCOL_FEATURES hasn't been set, upon receiving
>     VHOST_USER_SET_PROTOCOL_FEATURES, a backend should enable the
>     protocol features immediately.
> 
> (2) If VHOST_USER_F_PROTOCOL_FEATURES hasn't been set, upon receiving
>     VHOST_USER_SET_PROTOCOL_FEATURES, a backend should store those
>     feature bits, but not actually consider them to be enabled until
>     after VHOST_USER_SET_FEATURES has been received (presumably
>     containing VHOST_USER_F_PROTOCOL_FEATURES).
> 
> The reason I bring this up is that QEMU appears to interpret it as (1),
> while the vhost-user-net backend in Intel's cloud-hypervisor[1]
> interprets it as (2).  So I'm looking for a clarification.
> 
> [1]: https://github.com/cloud-hypervisor/cloud-hypervisor
> 
> Thanks in advance.


IMHO the intent was this: VHOST_USER_F_PROTOCOL_FEATURES bit in
VHOST_USER_GET_FEATURES means that qemu can send
VHOST_USER_GET_PROTOCOL_FEATURES and VHOST_USER_SET_PROTOCOL_FEATURES.

With most feature bits in VHOST_USER_GET_FEATURES, the
specific functionality needs to only be enabled after
VHOST_USER_SET_FEATURES.

However, this is for functionality dealing with guest activity.
VHOST_USER_SET_PROTOCOL_FEATURES has nothing to do with guest directly,
it's about negotiation between qemu and backend: it is only in
VHOST_USER_GET_FEATURES for the reason that this is the only message
(very) old backends reported.  Thus, the backend should not check
whether VHOST_USER_SET_FEATURES sets VHOST_USER_F_PROTOCOL_FEATURES,
instead it should simply always be ready to receive
VHOST_USER_GET_PROTOCOL_FEATURES and VHOST_USER_SET_PROTOCOL_FEATURES.

Backend that isn't always ready to handle
VHOST_USER_GET_PROTOCOL_FEATURES and VHOST_USER_SET_PROTOCOL_FEATURES
should not set VHOST_USER_F_PROTOCOL_FEATURES in
VHOST_USER_GET_FEATURES.

This appears to be closer to (1), but if qemu can't distinguish
then we don't care, right? For example, VHOST_USER_PROTOCOL_F_REPLY_ACK
enables acks on arbitrary messages. Does the backend in question
ignore the affected bit until SET_FEATURES? If yes won't this
make qemu hang?

How would you suggest clarifying the wording?

Thanks,

-- 
MST


