Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B35BC433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 18:29:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE34320663
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 18:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Plgfs0ea"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE34320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvm9s-0004qB-1z
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 14:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jvm8r-0004Ov-4M
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 14:28:29 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44014
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jvm8o-0004Ol-JW
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 14:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594837704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1gsuIKwLPMHt0qKlfp2sauu/XCPu3dQyhlXH+Zl387U=;
 b=Plgfs0eaiMM2ykM9UGL582SYp/Og9GLVJ5iGVCm1atBvDER1Ey1NF0nRzudzFTgupBP3Uq
 82e2Pl9LatUril2+Al8QpZxIi6L8TIuILF3FaTZfxtD20w9EfAuLpQwc2h3Hbxnk0M3KMX
 CSfxuWZWyJja0LSvrVNpYl+/qUKeXkM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-uIdXdgbeP_imuQLmDEPsEg-1; Wed, 15 Jul 2020 14:28:22 -0400
X-MC-Unique: uIdXdgbeP_imuQLmDEPsEg-1
Received: by mail-qv1-f71.google.com with SMTP id j4so1816408qvt.20
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 11:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=1gsuIKwLPMHt0qKlfp2sauu/XCPu3dQyhlXH+Zl387U=;
 b=lr7jBYaOOH8Td7JD3yMLCU0mKr8nXS/yH90LYbnh/+yC1TX3K8KuiVLlZ5RZshGqAL
 HoNfNGgL+5xOhWaLOGdgC7V+z2h3zdIciF7nW0ZspvbgnveMNYg2sWleFVrjy34C8+Jh
 PjGF6oyyXCBF+PmZ+CIPFzJ2UIhyR/lJEn8tTAq/6+VW4wFTI9554EQ2FiKwTotmV+Wf
 fCKx8/s5e3xDV0L5g9UkSa5QXqwmba3Sjl2ftSnknYNkPc015XELa4tf2V3Alc+YFYew
 Ze9Cu5YT44IwvD/1y3GMlFDqHL4FDP3gLa2ck8TGnIgF0Pi485k02GNE35LWkzlrTk+c
 97mA==
X-Gm-Message-State: AOAM533hBZIORmesTMNQGyi3PLKtfz5nKLUyHlWTslviHOr9VKRFDH5Z
 uWZALKbD922pH7c/bsvtuFpLMVZ6v5Xf7vVWJP7iimoVeNXu84CNG0uMPxshVXbDtV9YVfmjVbn
 JW/iZuAUWJKFBG/8=
X-Received: by 2002:a0c:e903:: with SMTP id a3mr667192qvo.144.1594837702219;
 Wed, 15 Jul 2020 11:28:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQwbaX8XMfP0vHfSfK/ne6EB1yJkzGNSm7sK2Lqf9e1PRwIZ/9aWA6vcO18lGFN9Fck2dQGg==
X-Received: by 2002:a0c:e903:: with SMTP id a3mr667173qvo.144.1594837701965;
 Wed, 15 Jul 2020 11:28:21 -0700 (PDT)
Received: from xz-x1.hitronhub.home ([2607:9880:19c8:6f::1f4f])
 by smtp.gmail.com with ESMTPSA id n143sm3389599qkn.94.2020.07.15.11.28.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2020 11:28:21 -0700 (PDT)
Date: Wed, 15 Jul 2020 14:28:19 -0400
From: Peter Xu <peterx@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: unable to boot windows with 256 cpus
Message-ID: <20200715182819.GF502441@xz-x1.hitronhub.home>
References: <20200715194513.5b19ca27@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200715194513.5b19ca27@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 02:37:03
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, alex.williamson@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 15, 2020 at 07:45:13PM +0200, Igor Mammedov wrote:
> While testing ACPI cpu hotplug changes I stumbled on BSOD in case
> QEMU is configured with 256 CPUs, Windows Server 2012R2x64 fails to boot
> with bugcheck 5C
> 
> 
> qemu-system-x86_64 -m 4G -smp 2,sockets=64,cores=4,maxcpus=256 -M q35,kernel-irqchip=split  -enable-kvm -device intel-iommu,intremap=on,eim=on ws2012r2x64DCchk.qcow2
> 
> Looking at stacktrace, it seems that is fails when trying to initialize iommu
> 
> hal_interrupt_remapping_setup_failure_nt!initbootprocessor
> 
> Any idea what to try to figure out what QEMU is missing wrt intremap?
> 
> PS:
> WS2016 boots eventually, but CPU hotplug doesn't work, symptoms (unconfirmed yet) like SCI isn't being delivered.
> With RHEL76 the same config works fine.

Igor,

Could you try this again but with vtd tracepoints enabled?

  -trace enable="vtd_*"

I think we don't need to capture all the trace outputs, but only until when the
HAL error message triggered should work.

Thanks,

-- 
Peter Xu


