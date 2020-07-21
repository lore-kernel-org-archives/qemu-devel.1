Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DB9C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 10:49:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AC4720674
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 10:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b8YkF4Cg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AC4720674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxpqC-0007c1-B8
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 06:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jxppe-0007Ba-DP
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 06:49:10 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:54075)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jxppc-0006Ei-Kq
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 06:49:10 -0400
Received: by mail-wm1-x331.google.com with SMTP id j18so2348810wmi.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 03:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=BwjPlzHMUtPVG0XJ6cyWe/umel7VC/2YOnRDeZNJZF8=;
 b=b8YkF4CgyWzejoHcBbMAHm/ntjlF7NtM9HmxZNVcV7aVXzO5ahQcfo3RWZuifuPVYF
 2/0NQ+cLlFstL1EvtTbCb696gdkyMfXk+l5v5cPA50fnZkW0M6+gdH1OGYKctfL3EkCa
 R7758mgdkJiAFJMcVxQ6hwOTlLnLXuCyqzzW+aGIbGsNCP9SulthcrviFkZP5P3bNncD
 NMhHGue8hfw2HCXDq/g9/xYh6gY2xkplwXxefogAr9bP9wSbmWKR0WXDilw5F1w0vZbD
 8bpTL2ebErExsqSvYCxbrQc4POnLR8iOSoBzyL2GMbxQuSIdDJTb27PVspeNBqAiwDZE
 JTZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=BwjPlzHMUtPVG0XJ6cyWe/umel7VC/2YOnRDeZNJZF8=;
 b=a9cC/PeYz47bF2Vop/BnO3pSWz+9SmTdiwSmfkJqknt/4CHgAFDCWNPbTVNxa9r7Ue
 /Zo/46c+rrO+V4VLRGf3dZ6+EslS+o2U0rd2FJLHohlyNREcDw0bXtlJNvvyE44w2yhi
 ViC9TcT0DCx6MPDNxeE+7yALBkzHkbmRQAwHs5fyuCdF3WSmgHenco6eRrA7RCrSIO6y
 A5SowRhmGT62FE/bP6QG7cQpAxkLMoj7azYI33ZS2XaSJTzIUNEqDxw4yqS0oYUvQGFb
 bofhF0q6Y9spKj6Bfqdyjzpqh2gkzVC1a8xc96aKlXBUC3tpkbFemM/Ntk2wfN/uoh2i
 w0Ww==
X-Gm-Message-State: AOAM5312ZSfUTsFjcmn4UQVDtrYLpNOc9ViLT6moKXIg44d6gayvth17
 70TA+BFwDY+8Ny1w7ZWefddfAw==
X-Google-Smtp-Source: ABdhPJzOYUQPu+9u+WdYV7gQrEhOcaf1fAhKgr73grq/S8XnC7DQy5zSNafFz8FD3WON0KCpPTpuxQ==
X-Received: by 2002:a05:600c:d5:: with SMTP id
 u21mr3367915wmm.156.1595328546908; 
 Tue, 21 Jul 2020 03:49:06 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l15sm35877030wro.33.2020.07.21.03.49.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 03:49:05 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 01FAB1FF7E;
 Tue, 21 Jul 2020 11:49:05 +0100 (BST)
References: <86d42090-f042-06a1-efba-d46d449df280@arrikto.com>
 <20200715112342.GD18817@stefanha-x1.localdomain>
 <CAJSP0QU78mAK-DiOYXvTOEa3=CAEy1rQtyTBe5rrKDs=yfptAg@mail.gmail.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: Inter-VM device emulation (call on Mon 20th July 2020)
In-reply-to: <CAJSP0QU78mAK-DiOYXvTOEa3=CAEy1rQtyTBe5rrKDs=yfptAg@mail.gmail.com>
Date: Tue, 21 Jul 2020 11:49:04 +0100
Message-ID: <874kq1w3bz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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
Cc: "John G.
 Johnson" <john.g.johnson@oracle.com>, Jag Raman <jag.raman@oracle.com>,
 Andra-Irina Paraschiv <andraprs@amazon.com>, kvm <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>, Alexander Graf <graf@amazon.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Nikos Dragazis <ndragazis@arrikto.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Stefan Hajnoczi <stefanha@gmail.com> writes:

> Thank you everyone who joined!
>
> I didn't take notes but two things stood out:
>
> 1. The ivshmem v2 and virtio-vhost-user use cases are quite different
> so combining them does not seem realistic. ivshmem v2 needs to be as
> simple for the hypervisor to implement as possible even if this
> involves some sacrifices (e.g. not transparent to the Driver VM that
> is accessing the device, performance). virtio-vhost-user is more aimed
> at general-purpose device emulation although support for arbitrary
> devices (e.g. PCI) would be important to serve all use cases.

I believe my phone gave up on the last few minutes of the call so I'll
just say we are interested in being able to implement arbitrary devices
in the inter-VM silos. Devices we are looking at:

  virtio-audio
  virtio-video

these are performance sensitive devices which provide a HAL abstraction
to a common software core.

  virtio-rpmb

this is a secure device where the backend may need to reside in a secure
virtualised world.

  virtio-scmi

this is a more complex device which allows the guest to make power and
clock demands from the firmware. Needless to say this starts to become
complex with multiple moving parts.

The flexibility of vhost-user seems to match up quite well with wanting
to have a reasonably portable backend that just needs to be fed signals
and a memory mapping. However we don't want daemons to automatically
have a full view of the whole of the guests system memory.

> 2. Alexander Graf's idea for a new Linux driver that provides an
> enforcing software IOMMU. This would be a character device driver that
> is mmapped by the device emulation process (either vhost-user-style on
> the host or another VMM for inter-VM device emulation). The Driver VMM
> can program mappings into the device and the page tables in the device
> emulation process will be updated. This way the Driver VMM can share
> memory specific regions of guest RAM with the device emulation process
> and revoke those mappings later.

I'm wondering if there is enough plumbing on the guest side so a guest
can use the virtio-iommu to mark out exactly which bits of memory the
virtual device can have access to? At a minimum the virtqueues need to
be accessible and for larger transfers maybe a bounce buffer. However
for speed you want as wide as possible mapping but no more. It would be
nice for example if a block device could load data directly into the
guests block cache (zero-copy) but without getting a view of the kernels
internal data structures.

Another thing that came across in the call was quite a lot of
assumptions about QEMU and Linux w.r.t virtio. While our project will
likely have Linux as a guest OS we are looking specifically at enabling
virtio for Type-1 hypervisors like Xen and the various safety certified
proprietary ones. It is unlikely that QEMU would be used as the VMM for
these deployments. We want to work out what sort of common facilities
hypervisors need to support to enable virtio so the daemons can be
re-usable and maybe setup with a minimal shim for the particular
hypervisor in question.


--=20
Alex Benn=C3=A9e

