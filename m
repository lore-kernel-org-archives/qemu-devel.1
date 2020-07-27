Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF2FC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 10:31:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5DB12075A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 10:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z2A9HWvq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5DB12075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k00Pu-0002qe-2X
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 06:31:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k00Ot-0001ra-66
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 06:30:31 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:43360)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k00Or-0008A6-24
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 06:30:30 -0400
Received: by mail-wr1-x42d.google.com with SMTP id a15so14315572wrh.10
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 03:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ef+DlaPDlCdGo3GcQcb/cr5plIeVe0IdjPjPGvh9Xlw=;
 b=z2A9HWvqP8rUdS23qGeI4oeuzorNnNTPzGD9XntkgGyZpU1srjFbFlMHFkcb9StnPJ
 n9v5VN0tFiHnug/CCCCSSkHHWozP8XO4937s/cbUuNFP39chWhbsqlU4tPnflja5OeTE
 kg/dNfhCdNWMednO4Sa/ww97VKQ/mt+9K5UTYUddX2Bnn0yEO2Mt2dor9HG35a4lJHfc
 qqr7BpOpex8xYikAfL5j3MCM+AXUWDYahOUOGqtJxS/HDVpIUt7IYkuhMOE4x2Bb12WZ
 JS2+sNsVkxQXzXYpurbuo7TLVJ7cB6ZimA/0tQayXLAw76xhZP1vrG7NVGO3eeDn0ZMU
 /HqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ef+DlaPDlCdGo3GcQcb/cr5plIeVe0IdjPjPGvh9Xlw=;
 b=BLn9yWhEiT4u6xs8ZxqHOrldzPaCozKyRz3m/g1oTn4nrKU8FI+a8neWrBJK24UQ6U
 BsUwXFrkxOaU1iNY+TWe0Amuhfj9cJxVXZmGWIULR7ocpdsrNWLeSS6TbKmMM6LCMa0a
 06nnOQAsLTAVoeMOV9GEIdbeMjEDTTBglI8P9i7H1EuQrIVWrND/3XBC09plZ8rPxqEi
 BVa/M0uQ+kbefD6PJ0Yjz922NIIdRS7Nt2K2FojwnzXhEAbCtFYH3pjDP6a4WYq9/Y3U
 4IY9k3ZR7S+kzBrQrSKY4SLV+HODzAYb1fxvXIIMzyBL8tn8idJJDb6e/ZYvsHC24eST
 d/Nw==
X-Gm-Message-State: AOAM533vNPpx3a+9TbYpQQ+1QeQ6GgLEhdXY4yww/8AaIJQ+h5R5Oiq8
 b5qrQhw55oFLCyjUcNbFfsLz3Q==
X-Google-Smtp-Source: ABdhPJwCGWvlr8PvKPAIatHcCGvWo7ZNxfYvqPc2JcsXJpH3HzTyXWfTPcp+1HArG829ltp3gnr0pg==
X-Received: by 2002:adf:dcc9:: with SMTP id x9mr21684234wrm.153.1595845826053; 
 Mon, 27 Jul 2020 03:30:26 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t17sm3180629wmj.34.2020.07.27.03.30.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 03:30:24 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 373BB1FF7E;
 Mon, 27 Jul 2020 11:30:24 +0100 (BST)
References: <86d42090-f042-06a1-efba-d46d449df280@arrikto.com>
 <20200715112342.GD18817@stefanha-x1.localdomain>
 <CAJSP0QU78mAK-DiOYXvTOEa3=CAEy1rQtyTBe5rrKDs=yfptAg@mail.gmail.com>
 <874kq1w3bz.fsf@linaro.org>
 <20200727101403.GF380177@stefanha-x1.localdomain>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: Inter-VM device emulation (call on Mon 20th July 2020)
In-reply-to: <20200727101403.GF380177@stefanha-x1.localdomain>
Date: Mon, 27 Jul 2020 11:30:24 +0100
Message-ID: <87h7tt45dr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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
 "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>, Alexander Graf <graf@amazon.com>,
 Eric Auger <eric.auger@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Nikos Dragazis <ndragazis@arrikto.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Stefan Hajnoczi <stefanha@redhat.com> writes:

> On Tue, Jul 21, 2020 at 11:49:04AM +0100, Alex Benn=C3=A9e wrote:
>> Stefan Hajnoczi <stefanha@gmail.com> writes:
>> > 2. Alexander Graf's idea for a new Linux driver that provides an
>> > enforcing software IOMMU. This would be a character device driver that
>> > is mmapped by the device emulation process (either vhost-user-style on
>> > the host or another VMM for inter-VM device emulation). The Driver VMM
>> > can program mappings into the device and the page tables in the device
>> > emulation process will be updated. This way the Driver VMM can share
>> > memory specific regions of guest RAM with the device emulation process
>> > and revoke those mappings later.
>>=20
>> I'm wondering if there is enough plumbing on the guest side so a guest
>> can use the virtio-iommu to mark out exactly which bits of memory the
>> virtual device can have access to? At a minimum the virtqueues need to
>> be accessible and for larger transfers maybe a bounce buffer. However
>> for speed you want as wide as possible mapping but no more. It would be
>> nice for example if a block device could load data directly into the
>> guests block cache (zero-copy) but without getting a view of the kernels
>> internal data structures.
>
> Maybe Jean-Philippe or Eric can answer that?
>
>> Another thing that came across in the call was quite a lot of
>> assumptions about QEMU and Linux w.r.t virtio. While our project will
>> likely have Linux as a guest OS we are looking specifically at enabling
>> virtio for Type-1 hypervisors like Xen and the various safety certified
>> proprietary ones. It is unlikely that QEMU would be used as the VMM for
>> these deployments. We want to work out what sort of common facilities
>> hypervisors need to support to enable virtio so the daemons can be
>> re-usable and maybe setup with a minimal shim for the particular
>> hypervisor in question.
>
> The vhost-user protocol together with the backend program conventions
> define the wire protocol and command-line interface (see
> docs/interop/vhost-user.rst).
>
> vhost-user is already used by other VMMs today. For example,
> cloud-hypervisor implements vhost-user.

Ohh that's a new one for me. I see it is a KVM only project but it's
nice to see another VMM using the common rust-vmm backend. There is
interest in using rust-vmm to implement VMMs for type-1 hypervisors but
we need to work out if there are two many type-2 concepts backed into
the lower level rust crates.

> I'm sure there is room for improvement, but it seems like an incremental
> step given that vhost-user already tries to cater for this scenario.
>
> Are there any specific gaps you have identified?

Aside from the desire to limit the shared memory footprint between the
backend daemon and a guest not yet.

I suspect the eventfd mechanism might just end up being simulated by the
VMM as a result of whatever comes from the type-1 interface indicating a
doorbell has been rung. It is after all just a FD you consume numbers
over right?

Not all setups will have an equivalent of a Dom0 "master" guest to do
orchestration. Highly embedded are likely to have fixed domains created
as the firmware/hypervisor start up.

>
> Stefan


--=20
Alex Benn=C3=A9e

