Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEE4C433EB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 11:38:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFE152072E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 11:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W37v9Dpq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFE152072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k01Ss-0005tn-7C
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 07:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k01SG-0005Uj-KW
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 07:38:04 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42582
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k01SD-0000bg-Pe
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 07:38:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595849880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0FGlcWjU6+C8AuCIhiYFdIDdPXmGBRQurVOK6ah65XI=;
 b=W37v9DpqJqZAxk3klmgbfSlg3GttjNtouVwc8Y8tQD9HZK8wY/fFSdTkra8ME8wxpNhW2o
 y/NPQuXwDSfQEiMAHOqv2qX5Gcfmo0gPIntFylDVUSzdCyiuUezzn+RVFGLwPzxEqomZDT
 NWfgkohPVZ61Nz1DppTauTB5gP1dzgU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-XAB0IcVQMjKXBFANzExJcQ-1; Mon, 27 Jul 2020 07:37:58 -0400
X-MC-Unique: XAB0IcVQMjKXBFANzExJcQ-1
Received: by mail-wm1-f69.google.com with SMTP id q15so6994935wmj.6
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 04:37:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=deFielYPvv/bZiEsafzeHFqZbfMpQ2UPhHPLYdTxIHk=;
 b=YO+WxzK7r7ycRgxDd/erAtMLdQ93DqKuyP0u/mZP4VIwwyaAa++LF9A82P9uF9dnFj
 2jncI256Zc1f78Z7mpo1Jc10uzK0mUAb111h7+rLD6qnQ+wtEqpuQ9SGIWtsCnRaXDpf
 o399rB6RReV/cZK526ozlqkYs2tJuuneay5PynaTFOwIZQWAe3mHBaqMt+AlPdEdLT+A
 d0WkDlO/muer0QbqN/fNEoiwpMLcdx7UOw58PG05bbJ6w7HYj9LePiMq5oeRppluWELj
 xsUCNR4sGI7OT/odLGge74bsGO4UaVOjHfcvBbf3XVUzsjV7VFPT2wGZ3Ql8yK1Uvbmv
 VdLA==
X-Gm-Message-State: AOAM533QAfIHZwNMd/i3Kv7Ux+1KYYIsj/7/yA6ZtYMJmbntjWZck4GT
 BT+dmm8Z+YK+++l7kxHxua4QeM59oWHhl13OpH7a/LZMrrfUBqYlP33rdkumCUwopvSmI+zvlrv
 OKxFeYM6h+k/Pf2o=
X-Received: by 2002:a7b:cd83:: with SMTP id y3mr19753131wmj.105.1595849877539; 
 Mon, 27 Jul 2020 04:37:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyC8LSTipBXGm9Ul9bRoWq+upyHZ0Ut55gzk1Ap5DgK521C422fnI/j9iNt+GCvNHP+Fcg+iw==
X-Received: by 2002:a7b:cd83:: with SMTP id y3mr19753104wmj.105.1595849877185; 
 Mon, 27 Jul 2020 04:37:57 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id n3sm12564666wre.29.2020.07.27.04.37.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 04:37:56 -0700 (PDT)
Date: Mon, 27 Jul 2020 07:37:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: Inter-VM device emulation (call on Mon 20th July 2020)
Message-ID: <20200727073311-mutt-send-email-mst@kernel.org>
References: <86d42090-f042-06a1-efba-d46d449df280@arrikto.com>
 <20200715112342.GD18817@stefanha-x1.localdomain>
 <CAJSP0QU78mAK-DiOYXvTOEa3=CAEy1rQtyTBe5rrKDs=yfptAg@mail.gmail.com>
 <874kq1w3bz.fsf@linaro.org>
 <20200727101403.GF380177@stefanha-x1.localdomain>
 <87h7tt45dr.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <87h7tt45dr.fsf@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:46:13
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
Cc: "John G. Johnson" <john.g.johnson@oracle.com>,
 Jag Raman <jag.raman@oracle.com>, Andra-Irina Paraschiv <andraprs@amazon.com>,
 kvm <kvm@vger.kernel.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 Eric Auger <eric.auger@redhat.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>, Alexander Graf <graf@amazon.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Nikos Dragazis <ndragazis@arrikto.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 27, 2020 at 11:30:24AM +0100, Alex Bennée wrote:
> 
> Stefan Hajnoczi <stefanha@redhat.com> writes:
> 
> > On Tue, Jul 21, 2020 at 11:49:04AM +0100, Alex Bennée wrote:
> >> Stefan Hajnoczi <stefanha@gmail.com> writes:
> >> > 2. Alexander Graf's idea for a new Linux driver that provides an
> >> > enforcing software IOMMU. This would be a character device driver that
> >> > is mmapped by the device emulation process (either vhost-user-style on
> >> > the host or another VMM for inter-VM device emulation). The Driver VMM
> >> > can program mappings into the device and the page tables in the device
> >> > emulation process will be updated. This way the Driver VMM can share
> >> > memory specific regions of guest RAM with the device emulation process
> >> > and revoke those mappings later.
> >> 
> >> I'm wondering if there is enough plumbing on the guest side so a guest
> >> can use the virtio-iommu to mark out exactly which bits of memory the
> >> virtual device can have access to? At a minimum the virtqueues need to
> >> be accessible and for larger transfers maybe a bounce buffer. However
> >> for speed you want as wide as possible mapping but no more. It would be
> >> nice for example if a block device could load data directly into the
> >> guests block cache (zero-copy) but without getting a view of the kernels
> >> internal data structures.
> >
> > Maybe Jean-Philippe or Eric can answer that?
> >
> >> Another thing that came across in the call was quite a lot of
> >> assumptions about QEMU and Linux w.r.t virtio. While our project will
> >> likely have Linux as a guest OS we are looking specifically at enabling
> >> virtio for Type-1 hypervisors like Xen and the various safety certified
> >> proprietary ones. It is unlikely that QEMU would be used as the VMM for
> >> these deployments. We want to work out what sort of common facilities
> >> hypervisors need to support to enable virtio so the daemons can be
> >> re-usable and maybe setup with a minimal shim for the particular
> >> hypervisor in question.
> >
> > The vhost-user protocol together with the backend program conventions
> > define the wire protocol and command-line interface (see
> > docs/interop/vhost-user.rst).
> >
> > vhost-user is already used by other VMMs today. For example,
> > cloud-hypervisor implements vhost-user.
> 
> Ohh that's a new one for me. I see it is a KVM only project but it's
> nice to see another VMM using the common rust-vmm backend. There is
> interest in using rust-vmm to implement VMMs for type-1 hypervisors but
> we need to work out if there are two many type-2 concepts backed into
> the lower level rust crates.
> 
> > I'm sure there is room for improvement, but it seems like an incremental
> > step given that vhost-user already tries to cater for this scenario.
> >
> > Are there any specific gaps you have identified?
> 
> Aside from the desire to limit the shared memory footprint between the
> backend daemon and a guest not yet.

So it's certainly nice for security but not really a requirement for a
type-1 HV, right?

> I suspect the eventfd mechanism might just end up being simulated by the
> VMM as a result of whatever comes from the type-1 interface indicating a
> doorbell has been rung. It is after all just a FD you consume numbers
> over right?

Does not even have to be numbers. We need a way to be woken up, a way to
stop/start listening for wakeups and a way to detect that there was a
wakeup while we were not listening.

Though there are special tricks for offloads where we poke through
layers in order to map things directly to hardware.

> Not all setups will have an equivalent of a Dom0 "master" guest to do
> orchestration. Highly embedded are likely to have fixed domains created
> as the firmware/hypervisor start up.
> 
> >
> > Stefan
> 
> 
> -- 
> Alex Bennée


