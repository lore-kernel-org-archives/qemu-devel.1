Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C7DC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 13:32:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A17DE20674
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 13:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E3Dxn8iB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A17DE20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyxo4-0008Ax-VT
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 09:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jyxn2-00070U-UX
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 09:31:08 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55889
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jyxn1-000250-4i
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 09:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595597466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T402wqxv4ShpL7ibsbUzq3wR7lwrd8ET5naXkYR5Kes=;
 b=E3Dxn8iBsqBHD/KwjcU7HVZQCaxDdTClFPnj1k808h+iJ0QV6qvyT0xKBgMzTtKra2vEkn
 ub+EgZ8fGntSW//Z6HBvG0R7io5YlHg70kO8eLvIkQfwQUU5w0pOgJTv6c+gTvC3aZ07gE
 ZqQxWl1dlEEK97yn6ybtlIlEqy5zIyk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-nW4Uut2gOjSeMjSYYtRyPw-1; Fri, 24 Jul 2020 09:31:04 -0400
X-MC-Unique: nW4Uut2gOjSeMjSYYtRyPw-1
Received: by mail-wm1-f69.google.com with SMTP id a5so3967362wmj.5
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 06:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=T402wqxv4ShpL7ibsbUzq3wR7lwrd8ET5naXkYR5Kes=;
 b=jp1oPZGXre4JicygQ+ZSMyARlw6urJ7LgqeLqt5N3cpaVKUE0SNfPowBj3YzSbAcCO
 VmV+AXvuBUG0xaFGXTGahCKQOai9salD6WBZRqjdwA5LEtkITtguNx7De1QXErwTGr1a
 5pOMeVvzxeoN/xUwUKYL8f9jWL6aQjJ3xlnvlzS9b2r0kBKoZzc6NMgp7x+lEzxPxCwF
 Aqop29CTjb7NX9dph5Hbt70mELbIlSForPx5lpKKg05LLvNlSobXROlry7n+YDTOtM1q
 FZlo4mCvR28Aw3B9XxBiINV6bWc7uXX28XXSms+3+EVlDYIk1IvfhJKW6u3T4kH9hi1h
 G3Kw==
X-Gm-Message-State: AOAM531KNSIuLw1T3H8uPe3iIatU0dNvfUcpx6p0zSsjNyv5hpQxABuU
 Y+Ge51Ag0KkAO6Ws30I2FScXnuQapvSleOHv77tgwXcV51iDEjWV0KUwVe99aOnThOZZB0BKqBu
 uLRO2pLBsb7H1Gy8=
X-Received: by 2002:a5d:4906:: with SMTP id x6mr9019651wrq.142.1595597463307; 
 Fri, 24 Jul 2020 06:31:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzpaca/zJG/Y0XgE4AYYG6QPpIyO7W47VX22+2AiHkV6d6TJNQ5t7rxOXN0/H7XNmurbuIiVA==
X-Received: by 2002:a5d:4906:: with SMTP id x6mr9019626wrq.142.1595597463088; 
 Fri, 24 Jul 2020 06:31:03 -0700 (PDT)
Received: from redhat.com (bzq-79-179-105-63.red.bezeqint.net. [79.179.105.63])
 by smtp.gmail.com with ESMTPSA id t133sm10266341wmf.0.2020.07.24.06.31.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2020 06:31:02 -0700 (PDT)
Date: Fri, 24 Jul 2020 09:30:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [BUG] vhost-vdpa: qemu-system-s390x crashes with second
 virtio-net-ccw device
Message-ID: <20200724092906-mutt-send-email-mst@kernel.org>
References: <20200724152718.4e1cbc9e.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200724152718.4e1cbc9e.cohuck@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 06:44:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: qemu-s390x@nongnu.org, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Cindy Lu <lulu@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 24, 2020 at 03:27:18PM +0200, Cornelia Huck wrote:
> When I start qemu with a second virtio-net-ccw device (i.e. adding
> -device virtio-net-ccw in addition to the autogenerated device), I get
> a segfault. gdb points to
> 
> #0  0x000055d6ab52681d in virtio_net_get_config (vdev=<optimized out>, 
>     config=0x55d6ad9e3f80 "RT") at /home/cohuck/git/qemu/hw/net/virtio-net.c:146
> 146	    if (nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
> 
> (backtrace doesn't go further)
> 
> Starting qemu with no additional "-device virtio-net-ccw" (i.e., only
> the autogenerated virtio-net-ccw device is present) works. Specifying
> several "-device virtio-net-pci" works as well.
> 
> Things break with 1e0a84ea49b6 ("vhost-vdpa: introduce vhost-vdpa net
> client"), 38140cc4d971 ("vhost_net: introduce set_config & get_config")
> works (in-between state does not compile).

Ouch. I didn't test all in-between states :(
But I wish we had a 0-day instrastructure like kernel has,
that catches things like that.

> This is reproducible with tcg as well. Same problem both with
> --enable-vhost-vdpa and --disable-vhost-vdpa.
> 
> Have not yet tried to figure out what might be special with
> virtio-ccw... anyone have an idea?
> 
> [This should probably be considered a blocker?]


