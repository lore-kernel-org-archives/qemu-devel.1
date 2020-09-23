Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B10C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:57:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA9CB2076A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X60J5pjt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA9CB2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL1WJ-0001Go-2M
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 05:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kL1Oj-0001kn-Ot
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:49:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20805)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kL1Oi-0007lY-3r
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:49:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600854551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ebn6NeaJnx+bbO34z9sV4RPsI7SroO2mduZCvxZIGro=;
 b=X60J5pjtAXmJsUBzvjpyNrWdM6kTGp5luDUHTj91ZwnK9Ytc4L99Qbm1/MxJIxKAS53JP4
 f4+T0q4Ksh/O3pF6eZFW/TSdnNVDezfIb97ddlv+H5G/TFT5bVzZ8LH9+K1YMf/Segk87z
 lmG7ihc0/Re8CGP+IuFmcqD9zOv0OMs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-Pyu7j1kON5GA7-9Uyd1FiQ-1; Wed, 23 Sep 2020 05:49:08 -0400
X-MC-Unique: Pyu7j1kON5GA7-9Uyd1FiQ-1
Received: by mail-wm1-f72.google.com with SMTP id t8so1164992wmj.6
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 02:49:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Ebn6NeaJnx+bbO34z9sV4RPsI7SroO2mduZCvxZIGro=;
 b=Z2ChfJvktB1znWmJdgaYhNw2tYXtlL/Tpp4DYkGC42ppswyKe9Mua10c0ULrl/vkeO
 uoHs1fId8ZNwL5UFImHNIGLEKZhDgwqknIpnXZRcjxKeiypxzxBb04a0OsSe3zIXOyLa
 rLAN0SsiFS7vk96J5jW7eWUVJwCHN+5bjC8oi9vQRoIzBpNh6r4Y0frVp9mF1HPq2Gzf
 tgDg4Z2oHuE8i7Lbzj9G93g4AO4Ye3U2iY/8oF7xBvrcnyxU6oF550JntUNGOXGecplQ
 wQFrTEZ//j5+omOVqpO/5ayrITOthgKb9W0HUVBzMYTPhGWCpi1gKPJw+6hgx4VyAtBC
 Eh3Q==
X-Gm-Message-State: AOAM531WdNS5lwOZK2xiDhj7LfEt2YBRC9FzmKVzFT3vCgFSVRhv2ZjS
 YgiM2bGTcTYtD/qx/4cK+2gYFaVUOjbiAYB8oBKgplHRRUfAIM5kEiSWVfpubfOP0j8HAsiZIGT
 +Z0r/SDEn37/FrsA=
X-Received: by 2002:adf:f3c4:: with SMTP id g4mr10331821wrp.168.1600854546749; 
 Wed, 23 Sep 2020 02:49:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwx1nRJtQikKt4zAsEucpxwq/+LnXqtepasexUHBovD5sSrvZF7mBou4bDAdRlYf4ys8sF+TA==
X-Received: by 2002:adf:f3c4:: with SMTP id g4mr10331798wrp.168.1600854546442; 
 Wed, 23 Sep 2020 02:49:06 -0700 (PDT)
Received: from steredhat (host-79-13-204-53.retail.telecomitalia.it.
 [79.13.204.53])
 by smtp.gmail.com with ESMTPSA id z83sm8237630wmb.4.2020.09.23.02.49.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2020 02:49:05 -0700 (PDT)
Date: Wed, 23 Sep 2020 11:49:03 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Robin Meinzer <robmeinzer11@gmx.de>
Subject: Re: Re: questions regarding vsock
Message-ID: <CAGxU2F76macOEQhCVyqNxsNADOcwz2aYGVdj6MtBxd1278Gvbw@mail.gmail.com>
References: <trinity-1a5274e6-418e-46d1-bc32-f6f4380b8906-1600295102243@3c-app-gmx-bap30>
 <20200917112050.GF809514@stefanha-x1.localdomain>
 <trinity-896b2687-1386-4cd4-9ff6-71ac297c19d2-1600807252157@3c-app-gmx-bap70>
MIME-Version: 1.0
In-Reply-To: <trinity-896b2687-1386-4cd4-9ff6-71ac297c19d2-1600807252157@3c-app-gmx-bap70>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
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
Cc: qemu devel list <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Robin,

On Tue, Sep 22, 2020 at 10:46 PM Robin Meinzer <robmeinzer11@gmx.de> wrote:
> I added Stefano Garzarella and qemu-devel as you asked. I wonder if
> you don't support SOCK_DGRAM but only SOCK_STREAM, why having code for
> it then? There are functions like vsock_dgram_connect and a proto_ops
> struct specifically for SOCK_DGRAM, but any attempt to create a socket
> for it ends with -ENODEV (transport_dgram is NULL, I guess it's on
> purpose because you don't support it as you said).

AF_VSOCK supports multiple transports. Some transports (e.g. vmci) implement
SOCK_DGRAM, this is the reason for the code in the vsock core.

virtio-vsock transport currently supports only SOCK_STREAM.
Some people were implementing SOCK_SEQPACKET, but no upstream patches has
been sent yet.

> Another thing, could you please tell me what I have to set in the
> kernel .config to have vsockets working out of the box, for now lsmod
> doesn't show me vmw_vsock_transport_common or vsock or vsock_host
> existence in the form of a autoloaded module at all.

In the guest the vsock modules are loaded when the virtio-vsock device
is discovered on the PCI bus.

In the host the vhost-vsock module (and other vsock modules) is automatically
loaded the first time that a process opens /dev/vhost-vsock.
For testing in the host, you can use the vsock_loopback module that
should be automatically loaded the first time that a process create an
AF_VSOCK socket.
Note: if other vsock modules (e.g. vhost-vsock) are already loaded, you
must load vsock_loopback by hand.


Stefano


