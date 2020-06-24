Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F24C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 14:02:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3B4720724
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 14:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F55In5Oc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3B4720724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo5z9-0002dc-1b
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 10:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jo5l4-0008Bt-Oj
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 09:48:11 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31300
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jo5l2-0002lp-L9
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 09:48:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593006487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QvkNWk5+sDNjcLWQTCoB546+AqfVB2tWU7hl+BStmuU=;
 b=F55In5OcQi5VyY+/9vzMFmAL8I/pw8WcJF799OX6JzE775JegnCHyAkrlo1vCwFZsEtQvf
 V0KTqdNcB6iIHslh7pzStsDvWatR6ViKcMR8BV5ecoCbQfovlzCXkCiEmaOBCsR6tPNVk0
 ws0iA9HH+jqqrBTS7VPPpiJFefGLAAY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-SndShDYJMt6FQ_4Kq9pWZA-1; Wed, 24 Jun 2020 09:48:04 -0400
X-MC-Unique: SndShDYJMt6FQ_4Kq9pWZA-1
Received: by mail-wr1-f70.google.com with SMTP id g14so2991882wrp.8
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 06:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QvkNWk5+sDNjcLWQTCoB546+AqfVB2tWU7hl+BStmuU=;
 b=Xvl7H4dbed3N6UWcmBCGAXBLlh5hx3vGxXnMTH0uyHLJHbJNjlyt0LaLlxjOVLYKkl
 2kcKOHVgB0zyNMRguwShjaTKNt8bsSW/JwEgjs0214vKW3urLr2nAF4+iqQXUhZn88I+
 e7NHGpb8fQDYWLWr3z4135GsYqROUXyTpkVZpQ/76BFxF7y9ghAh4WAx+D1sJzLtM9jQ
 tNLQHiG82VTQSjfjx4CAtn/Or155iKuETAbTroNuicXUg3fLCN5yfKxu5VNo5WV863HY
 Qx+9gFT27FPhExZmQ767bv0YlSLeFmKvbxO31BDWNv+o6T8/jdJrVhprlSzN9I+mCW+w
 IQMg==
X-Gm-Message-State: AOAM531v0TpKqtREV93d9iMyiksgJ7AAuXFHwcnBgyBPSFYXx5qFWiWk
 0EFO6pfqscfY407LOB8ryrxVGXrbM8b8+EdfV54C37V4nSem6TaVcZrTgjlMnaxbS2dHId5Q218
 s/kSAQ33SlGty/WI=
X-Received: by 2002:a1c:9802:: with SMTP id a2mr28580859wme.64.1593006483089; 
 Wed, 24 Jun 2020 06:48:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/K3oXnjT4hX7r0maQboEfYJGJZ7ig1sb0b4aDkXaHFKt1efhTJfB4hRDwojCIamHuVrClyQ==
X-Received: by 2002:a1c:9802:: with SMTP id a2mr28580823wme.64.1593006482818; 
 Wed, 24 Jun 2020 06:48:02 -0700 (PDT)
Received: from redhat.com ([82.166.20.53])
 by smtp.gmail.com with ESMTPSA id n8sm23986121wrj.44.2020.06.24.06.48.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 06:48:02 -0700 (PDT)
Date: Wed, 24 Jun 2020 09:47:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v5 0/5] VIRTIO-IOMMU probe request support and MSI bypass
 on ARM
Message-ID: <20200624094510-mutt-send-email-mst@kernel.org>
References: <20200624132625.27453-1-eric.auger@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200624132625.27453-1-eric.auger@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 01:59:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, jean-philippe@linaro.org, qemu-devel@nongnu.org,
 peterx@redhat.com, armbru@redhat.com, qemu-arm@nongnu.org, pbonzini@redhat.com,
 bbhushan2@marvell.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 24, 2020 at 03:26:20PM +0200, Eric Auger wrote:
> By default the virtio-iommu translates MSI transactions. This
> behavior is inherited from ARM SMMU. However the virt machine
> code knows where the MSI doorbells are, so we can easily
> declare those regions as VIRTIO_IOMMU_RESV_MEM_T_MSI. With that
> setting the guest iommu subsystem will not need to map MSIs.
> This setup will simplify the VFIO integration.
> 
> In this series, the ITS or GICV2M doorbells are declared as
> HW MSI regions to be bypassed by the VIRTIO-IOMMU.


> This also paves the way to the x86 integration where the MSI
> region, [0xFEE00000,0xFEEFFFFF], will be exposed by the q35
> machine.  However this will be handled in a separate series
> when not-DT support gets resolved.

What's going on with that btw?
I think the next step is to put the spec up for virtio tc vote,
then we can merge that, right? acpi parts will need to be
ratified by the acpi sig.

> Best Regards
> 
> Eric
> 
> This series can be found at:
> https://github.com/eauger/qemu/tree/v5.0.0-virtio-iommu-msi-bypass-v5
> 
> History:
> 
> v4 -> v5:
> - Take into account some additional comments from Markus:
>   - reserved region type becomes an unsigned + some comment/desc
>     rewording
>   - assert if the type is not RESERVED or MSI
> 
> v3 -> v4:
> - collected Jean and markus's R-bs
> - tool into account all Markus' comments in [1/5] (except removal of
>   goto)
> - use ':' as delimitor instead of commas
> - add example in 4/5 commit message as suggested by Markus
> 
> v2 -> v3:
> - Introduce VIRT_MSI_CTRL_NONE in VirtMSIControllerType
> - do not fill the remainder of the probe buffer
> 
> v1 -> v2:
> - check which MSI controller is in use and advertise the
>   corresponding MSI doorbell
> - managed for both ITS and GICv2M
> - various fixes spotted by Peter and Jean-Philippe, see
>   individual logs
> 
> v1: Most of those patches were respinned from
>   [PATCH for-5.0 v11 00/20] VIRTIO-IOMMU device
>   except the last one which is new
> 
> 
> Eric Auger (5):
>   qdev: Introduce DEFINE_PROP_RESERVED_REGION
>   virtio-iommu: Implement RESV_MEM probe request
>   virtio-iommu: Handle reserved regions in the translation process
>   virtio-iommu-pci: Add array of Interval properties
>   hw/arm/virt: Let the virtio-iommu bypass MSIs
> 
>  include/exec/memory.h            |   6 ++
>  include/hw/arm/virt.h            |   7 ++
>  include/hw/qdev-properties.h     |   3 +
>  include/hw/virtio/virtio-iommu.h |   2 +
>  include/qemu/typedefs.h          |   1 +
>  hw/arm/virt.c                    |  18 +++++
>  hw/core/qdev-properties.c        |  89 ++++++++++++++++++++++++
>  hw/virtio/virtio-iommu-pci.c     |   3 +
>  hw/virtio/virtio-iommu.c         | 112 +++++++++++++++++++++++++++++--
>  hw/virtio/trace-events           |   1 +
>  10 files changed, 238 insertions(+), 4 deletions(-)
> 
> -- 
> 2.20.1


