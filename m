Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17201C4727F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 10:06:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 623AA208FE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 10:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E2ZsmHyj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 623AA208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNCWw-00049C-DG
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 06:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kNCV5-0002aA-Vv
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 06:04:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53624)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kNCV1-000221-C0
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 06:04:47 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601373882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CxtzTdb5qhsDaLeNDH4w00opP9dPJq9mqCVocmml09Q=;
 b=E2ZsmHyjstzMvHFbvsUxxd/O3j79jcUqt0VeCAeMCoARVoBZjEVbnTdguLz0KFAxcvP23H
 V88lPAiHAZSq8PiIn3L+96NhUw6Ua76By6am67gPw9pBvkH1fNGz3e2LetXMLnTSIkNOVG
 MQDUTf/q710T4U9JYGEhW36eabKBYuU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-OlyueWcHOiCwZhVvTYvWKA-1; Tue, 29 Sep 2020 06:04:40 -0400
X-MC-Unique: OlyueWcHOiCwZhVvTYvWKA-1
Received: by mail-wm1-f72.google.com with SMTP id p20so1518767wmg.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 03:04:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=MyLrEb7gkVOJzo8Ds4L7TP8cfGu4LuOf19Hesxji2r4=;
 b=g9IHGlTudAsNlelVN9sThK24+L6L84vFUiKxXriIXSRH0VP7rHUgi0k7KdWBpuU5RW
 23y3XZFzxFLEktboqjabyA1q+5r4tIMyKFvOTz2yv6vvwcHt36lafHM/mYKmUeGjAtml
 yEGrgzyOiFkIBQs+aH8uWlYSB8qoVN3Q1KfP98fRqDlgtT1KeC6U+GaEhNRSWtLQ6yPz
 0N54FxdaSzSdlMRLxakf1msq/zaqbaGH5P9FuxwZtPuqrNmBHGDqZ0nc95Bqub2mVYM7
 LQnykfn+UmFXp0vdZTHAlD+7U1jkFVg6p9XSKTnu9IBlnm+W77Fx5ansC9AVSMY4Oj1h
 58lw==
X-Gm-Message-State: AOAM533gwjMctSKj/EMO3NyMltyyfb1LOjMQbUWAyPJHqXcGDRoeGUGR
 eNAKSzkJFBaEKufOUUI0I6GCp4HOVeRRiC0MLKbCSLuLxQMq+GCej6YEEZfiaAEllH76TkF2/f8
 ztpy911zSJxHhtAU=
X-Received: by 2002:a1c:1983:: with SMTP id 125mr3565659wmz.29.1601373879581; 
 Tue, 29 Sep 2020 03:04:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9KrJUl/ZmFRurt6wR33O9zKqRsWoKP4HfMMII1muYWYVnhZm0oZClE5Z/jbttUDyJWdcBtQ==
X-Received: by 2002:a1c:1983:: with SMTP id 125mr3565629wmz.29.1601373879333; 
 Tue, 29 Sep 2020 03:04:39 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id 88sm5818268wrl.76.2020.09.29.03.04.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 03:04:38 -0700 (PDT)
Date: Tue, 29 Sep 2020 06:04:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: Outline for VHOST_USER_PROTOCOL_F_VDPA
Message-ID: <20200929055110-mutt-send-email-mst@kernel.org>
References: <20200928092537.GA44353@stefanha-x1.localdomain>
 <20200929020114-mutt-send-email-mst@kernel.org>
 <20200929085751.GA181609@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200929085751.GA181609@stefanha-x1.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
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

On Tue, Sep 29, 2020 at 09:57:51AM +0100, Stefan Hajnoczi wrote:
> On Tue, Sep 29, 2020 at 02:09:55AM -0400, Michael S. Tsirkin wrote:
> > On Mon, Sep 28, 2020 at 10:25:37AM +0100, Stefan Hajnoczi wrote:
> > > Why extend vhost-user with vDPA?
> > > ================================
> > > Reusing VIRTIO emulation code for vhost-user backends
> > > -----------------------------------------------------
> > > It is a common misconception that a vhost device is a VIRTIO device.
> > > VIRTIO devices are defined in the VIRTIO specification and consist of a
> > > configuration space, virtqueues, and a device lifecycle that includes
> > > feature negotiation. A vhost device is a subset of the corresponding
> > > VIRTIO device. The exact subset depends on the device type, and some
> > > vhost devices are closer to the full functionality of their
> > > corresponding VIRTIO device than others. The most well-known example is
> > > that vhost-net devices have rx/tx virtqueues and but lack the virtio-net
> > > control virtqueue. Also, the configuration space and device lifecycle
> > > are only partially available to vhost devices.
> > > 
> > > This difference makes it impossible to use a VIRTIO device as a
> > > vhost-user device and vice versa. There is an impedance mismatch and
> > > missing functionality. That's a shame because existing VIRTIO device
> > > emulation code is mature and duplicating it to provide vhost-user
> > > backends creates additional work.
> > 
> > 
> > The biggest issue facing vhost-user and absent in vdpa is
> > backend disconnect handling. This is the reason control path
> > is kept under QEMU control: we do not need any logic to
> > restore control path data, and we can verify a new backend
> > is consistent with old one.
> 
> I don't think using vhost-user with vDPA changes that. The VMM still
> needs to emulate a virtio-pci/ccw/mmio device that the guest interfaces
> with. If the device backend goes offline it's possible to restore that
> state upon reconnection. What have I missed?

The need to maintain the state in a way that is robust
against backend disconnects and can be restored.

> Regarding reconnection in general, it currently seems like a partially
> solved problem in vhost-user. There is the "Inflight I/O tracking"
> mechanism in the spec and some wording about reconnecting the socket,
> but in practice I wouldn't expect all device types, VMMs, or device
> backends to actually support reconnection. This is an area where a
> uniform solution would be very welcome too.

I'm not aware of big issues. What are they?

> There was discussion about recovering state in muser. The original idea
> was for the muser kernel module to host state that persists across
> device backend restart. That way the device backend can go away
> temporarily and resume without guest intervention.
> 
> Then when the vfio-user discussion started the idea morphed into simply
> keeping a tmpfs file for each device instance (no special muser.ko
> support needed anymore). This allows the device backend to resume
> without losing state. In practice a programming framework is needed to
> make this easy and safe to use but it boils down to a tmpfs mmap.
> 
> > > If there was a way to reuse existing VIRTIO device emulation code it
> > > would be easier to move to a multi-process architecture in QEMU. Want to
> > > run --netdev user,id=netdev0 --device virtio-net-pci,netdev=netdev0 in a
> > > separate, sandboxed process? Easy, run it as a vhost-user-net device
> > > instead of as virtio-net.
> > 
> > Given vhost-user is using a socket, and given there's an elaborate
> > protocol due to need for backwards compatibility, it seems safer to
> > have vhost-user interface in a separate process too.
> 
> Right, with vhost-user only the virtqueue processing is done in the
> device backend. The VMM still has to do the virtio transport emulation
> (pci, ccw, mmio) and vhost-user connection lifecycle, which is complex.

IIUC all vfio user does is add another protocol in the VMM,
and move code out of VMM to backend.

Architecturally I don't see why it's safer.

Something like multi-process patches seems like a way to
add defence in depth by having a process in the middle,
outside both VMM and backend.

> Going back to Marc-André's point, why don't we focus on vfio-user so the
> entire device can be moved out of the VMM?
> 
> Stefan

The fact that vfio-user adds a kernel component is one issue.

-- 
MST


