Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFA7C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 11:53:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAF74206E7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 11:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K3CK0lxO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF74206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k01hA-000585-3J
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 07:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1k01gT-0004HG-6T
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 07:52:45 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:41621)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1k01gR-0002Ng-6w
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 07:52:44 -0400
Received: by mail-ed1-x543.google.com with SMTP id c2so6055598edx.8
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 04:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=D5pQiMPzLB8XD5JHM4wdoWxT4TgqCFRpOcFljgyTlfc=;
 b=K3CK0lxO2t8MyWxIBSrkltJCVJh7mLsvW2hqQK75KIpcJdI6shjwejuVcaD2hN10Sy
 XmUGeS5ZhpQ//k9mjCdxLGUgkzwPCtJDOe6QXpWr+d3SPbLTiAYCgs0v27wVIYyZ1uBd
 OcZn+xroudR4UzgnffapO5Yw6SDzV0kKiwJDxAurvtpV3r25A6aJd0yA/qILRcEZLKqp
 XQZFeONuAs0DTEqQCcg74OhB54RxAaFmw7ywGEdliCJBqk93YUMXQbE3zik3qfQOLkEm
 +U/TPxXY3UAn8CwtH6KZDw8pVuTdQdc9NTsgXBU0erkaSPowlM934kzZ6g6slUHeFLJj
 /PUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=D5pQiMPzLB8XD5JHM4wdoWxT4TgqCFRpOcFljgyTlfc=;
 b=BvsUUXnz9VYlv3oI/+8WEH2NQ2hxgvJ3V4i8Ce93CoZIbqTWYfPS/2Qe9UkvmcZFlN
 akrnOicnKZ+ME41q81PCX0OCJOZgREY6uRurrkvo/UPClD4Ci8q54RTQWnodH0OhGN4Z
 Q+61me1MLFNXiNVzLAtqJb0jYPXd6OZyvC30y2trZMqpPB9fC4S0IboaNi3CoRWzzYse
 N9OaNU0NwUzG8ItCIeTG+nRERjTKNtZGyelfP4wf+vqFRxHxMVPDb3UWt3F30xq3GKnC
 voRWp56C3tYVZX1alPxL7GTHtjtfjwMx8DRAz99nfNVkmAd8pSQfzwgGkN8XukS+5PiM
 AQlg==
X-Gm-Message-State: AOAM533eFUpbyfZFCgpbio5D6dSXQOceH2975ms4NHPvRr5cXGCfOqnb
 A6f022tPrsp+CyRd9BJZDsUTPA==
X-Google-Smtp-Source: ABdhPJyz7oMH5aj3Z7KcOTsoBp1IC9xCaWx+x2xvCBguSsbEnabd8V4mqYOIHsCAcbXk/z+m6gJynw==
X-Received: by 2002:a50:fd8d:: with SMTP id o13mr1277004edt.313.1595850761074; 
 Mon, 27 Jul 2020 04:52:41 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id h19sm6777631ejt.115.2020.07.27.04.52.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 04:52:40 -0700 (PDT)
Date: Mon, 27 Jul 2020 13:52:25 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: Inter-VM device emulation (call on Mon 20th July 2020)
Message-ID: <20200727115225.GA12008@myrica>
References: <86d42090-f042-06a1-efba-d46d449df280@arrikto.com>
 <20200715112342.GD18817@stefanha-x1.localdomain>
 <CAJSP0QU78mAK-DiOYXvTOEa3=CAEy1rQtyTBe5rrKDs=yfptAg@mail.gmail.com>
 <874kq1w3bz.fsf@linaro.org>
 <20200727101403.GF380177@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200727101403.GF380177@stefanha-x1.localdomain>
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=jean-philippe@linaro.org; helo=mail-ed1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
 kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>, Alexander Graf <graf@amazon.com>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Nikos Dragazis <ndragazis@arrikto.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 27, 2020 at 11:14:03AM +0100, Stefan Hajnoczi wrote:
> On Tue, Jul 21, 2020 at 11:49:04AM +0100, Alex Bennée wrote:
> > Stefan Hajnoczi <stefanha@gmail.com> writes:
> > > 2. Alexander Graf's idea for a new Linux driver that provides an
> > > enforcing software IOMMU. This would be a character device driver that
> > > is mmapped by the device emulation process (either vhost-user-style on
> > > the host or another VMM for inter-VM device emulation). The Driver VMM
> > > can program mappings into the device and the page tables in the device
> > > emulation process will be updated. This way the Driver VMM can share
> > > memory specific regions of guest RAM with the device emulation process
> > > and revoke those mappings later.
> > 
> > I'm wondering if there is enough plumbing on the guest side so a guest
> > can use the virtio-iommu to mark out exactly which bits of memory the
> > virtual device can have access to? At a minimum the virtqueues need to
> > be accessible and for larger transfers maybe a bounce buffer. However

Just to make sure I didn't misunderstand - do you want to tell the guest
precisely where the buffers are, like "address X is the used ring, address
Y is the descriptor table", or do you want to specify a range of memory
where the guest can allocate DMA buffers, in no specific order, for a
given device?  So far I've assumed we're talking about the latter.

> > for speed you want as wide as possible mapping but no more. It would be
> > nice for example if a block device could load data directly into the
> > guests block cache (zero-copy) but without getting a view of the kernels
> > internal data structures.
> 
> Maybe Jean-Philippe or Eric can answer that?

Virtio-iommu could describe which bits of guest-physical memory is
available for DMA for a given device. It already provides a mechanism for
describing per-device memory properties (the PROBE request) which is
extensible. And I think the virtio-iommu device could be used exclusively
for this, too, by having DMA bypass the VA->PA translation
(VIRTIO_IOMMU_F_BYPASS) and only enforcing guest-physical boundaries. Or
just describe the memory and not enforce anything.

I don't know how to plug this into the DMA layer of a Linux guest, though,
but there seems to exist a per-device DMA pool infrastructure. Have you
looked at rproc_add_virtio_dev()?  It seems to allocates a specific DMA
region per device, from a "memory-region" device-tree property, so perhaps
you could simply reuse this.

Thanks,
Jean

> 
> > Another thing that came across in the call was quite a lot of
> > assumptions about QEMU and Linux w.r.t virtio. While our project will
> > likely have Linux as a guest OS we are looking specifically at enabling
> > virtio for Type-1 hypervisors like Xen and the various safety certified
> > proprietary ones. It is unlikely that QEMU would be used as the VMM for
> > these deployments. We want to work out what sort of common facilities
> > hypervisors need to support to enable virtio so the daemons can be
> > re-usable and maybe setup with a minimal shim for the particular
> > hypervisor in question.
> 
> The vhost-user protocol together with the backend program conventions
> define the wire protocol and command-line interface (see
> docs/interop/vhost-user.rst).
> 
> vhost-user is already used by other VMMs today. For example,
> cloud-hypervisor implements vhost-user.
> 
> I'm sure there is room for improvement, but it seems like an incremental
> step given that vhost-user already tries to cater for this scenario.
> 
> Are there any specific gaps you have identified?
> 
> Stefan



