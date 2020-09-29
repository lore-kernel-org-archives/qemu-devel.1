Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78ED9C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 06:10:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C51AA20BED
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 06:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EqKygMgL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C51AA20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kN8qg-00011f-Rr
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 02:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN8pz-0000Vg-K9
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 02:10:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24456)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN8pw-0007zU-IA
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 02:10:07 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601359802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OOa5vl3yPhCokCKhS2YgVhaOguY1h4ycv7ZZ6GB7VKU=;
 b=EqKygMgLdCc3QRO2uBO0SeswqDptLkOimG6nb92mhDGSrrW6GJS8Z5jS6sBAJSWyk0cSn8
 Bb7E7j1tQDTERpjxnOIwC818f5G0y75ey3TCkW6ktkRSngdm+nauJV9SMJghFlpCyPXmmb
 A73rU9KzE17ovAChsx9aDnEWihgsODo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-iQw6h522M7CZg-WEqQGvBQ-1; Tue, 29 Sep 2020 02:10:00 -0400
X-MC-Unique: iQw6h522M7CZg-WEqQGvBQ-1
Received: by mail-wm1-f72.google.com with SMTP id c204so1292333wmd.5
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 23:10:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=OOa5vl3yPhCokCKhS2YgVhaOguY1h4ycv7ZZ6GB7VKU=;
 b=ihK2dzbEr86b7ShugKimo9JtwnpDeOJ0k14a99s+QBWhh84AUXRpdFCCK0IH1j1kj7
 +gOc5dh+b/k+luo9QDvDtNWNlE5yMVyfBsceFo6qHDUBq1+iH/UdlP4gHIg/iFbWRSR8
 w03s7Kfyme3mbt0KmObTUYtoh3obOztm/Fyp9vyIjzBeMzUu8Cyg8LaMiQe0gXuAF/eU
 CnV8dUPqq7YtJ1trlWPfmL8Iu/+/Wq9bAJK70aY+PlLNHKD6U2W19WmWIDyGqrM4+4Rh
 8/AYZkU2I6HJL2i75QCvF1/0GogKQ8XKr0Vl26Ig+Yh8/em+7bsMbTDUTWnlCz0uaiAe
 1Bzg==
X-Gm-Message-State: AOAM531Q6u1PxSBbuzOYJMryD4UEwo2zlyXrlZo7PCfZgEhSMmICLPw5
 8H2Duy0Lmjnh3lkqDmili4rBNk3HmEldGXtlUk2pJUQZJsOuNl7lBCT5NxGkfrFuH8rZxxRyaM5
 2oJayUv+3DnM+g7I=
X-Received: by 2002:a5d:40c4:: with SMTP id b4mr2198874wrq.151.1601359799423; 
 Mon, 28 Sep 2020 23:09:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0r6CajAuD8iA4FQpUfJGJuA9kwauHCND7ctOkKVfeSZqwfK+pmIa19mTxJ3f3FZnq7agdGg==
X-Received: by 2002:a5d:40c4:: with SMTP id b4mr2198840wrq.151.1601359799211; 
 Mon, 28 Sep 2020 23:09:59 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id q15sm4293885wrr.8.2020.09.28.23.09.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 23:09:58 -0700 (PDT)
Date: Tue, 29 Sep 2020 02:09:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: Outline for VHOST_USER_PROTOCOL_F_VDPA
Message-ID: <20200929020114-mutt-send-email-mst@kernel.org>
References: <20200928092537.GA44353@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200928092537.GA44353@stefanha-x1.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: lulu@redhat.com, tiwei.bie@intel.com, jasowang@redhat.com,
 qemu-devel@nongnu.org, raphael.norwitz@nutanix.com, maxime.coquelin@redhat.com,
 kraxel@redhat.com, Felipe Franciosi <felipe@nutanix.com>,
 marcandre.lureau@redhat.com, Nikos Dragazis <ndragazis@arrikto.com>,
 changpeng.liu@intel.com, Daniele Buono <dbuono@us.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks for the post!
I have one comment:

On Mon, Sep 28, 2020 at 10:25:37AM +0100, Stefan Hajnoczi wrote:
> Why extend vhost-user with vDPA?
> ================================
> Reusing VIRTIO emulation code for vhost-user backends
> -----------------------------------------------------
> It is a common misconception that a vhost device is a VIRTIO device.
> VIRTIO devices are defined in the VIRTIO specification and consist of a
> configuration space, virtqueues, and a device lifecycle that includes
> feature negotiation. A vhost device is a subset of the corresponding
> VIRTIO device. The exact subset depends on the device type, and some
> vhost devices are closer to the full functionality of their
> corresponding VIRTIO device than others. The most well-known example is
> that vhost-net devices have rx/tx virtqueues and but lack the virtio-net
> control virtqueue. Also, the configuration space and device lifecycle
> are only partially available to vhost devices.
> 
> This difference makes it impossible to use a VIRTIO device as a
> vhost-user device and vice versa. There is an impedance mismatch and
> missing functionality. That's a shame because existing VIRTIO device
> emulation code is mature and duplicating it to provide vhost-user
> backends creates additional work.


The biggest issue facing vhost-user and absent in vdpa is
backend disconnect handling. This is the reason control path
is kept under QEMU control: we do not need any logic to
restore control path data, and we can verify a new backend
is consistent with old one.

> If there was a way to reuse existing VIRTIO device emulation code it
> would be easier to move to a multi-process architecture in QEMU. Want to
> run --netdev user,id=netdev0 --device virtio-net-pci,netdev=netdev0 in a
> separate, sandboxed process? Easy, run it as a vhost-user-net device
> instead of as virtio-net.

Given vhost-user is using a socket, and given there's an elaborate
protocol due to need for backwards compatibility, it seems safer to
have vhost-user interface in a separate process too.


-- 
MST


