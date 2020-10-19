Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13517C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 21:40:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 702D82231B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 21:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SDk3VsAP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 702D82231B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUctF-0006D4-6Y
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 17:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kUcpe-0003YJ-MQ
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 17:36:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32570)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kUcpZ-0003gP-5L
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 17:36:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603143393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/L6GGspEQuZhQDKjsRSCAeqayEQOCjwXf2Z5iOtI9ew=;
 b=SDk3VsAPoxs8L3TGCu24X7UB1U9E9AHYFyiS0u28LCmXRjB8eBZ5096Zgc+bd5gkuJKPO8
 3VRnw5QC8DpxRFmM3YkRoyffiWcfiX8ECDx0Xz/VBNmHDeNvA5TKA+GEJPnVIOI9ihxl12
 Dot0h45pOW/s1SCjEOfq1P5emj7a8oY=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-cAazFLbjOqGs7kXGjryoAA-1; Mon, 19 Oct 2020 17:36:31 -0400
X-MC-Unique: cAazFLbjOqGs7kXGjryoAA-1
Received: by mail-io1-f70.google.com with SMTP id x13so1175027iom.10
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 14:36:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/L6GGspEQuZhQDKjsRSCAeqayEQOCjwXf2Z5iOtI9ew=;
 b=Gtt2hgE8vs6qD+kdEPcz80jCyYSHaM9cMX9Z8S8x7lIgdZYfUxAb/+H12i9aJcKZv3
 ZS5koPeJHrME3Ahg9/WhQMn6+L3dlXOVRcO4Ce4nInOOGUhcHZ7FFTDJc/fdSPsHLMK3
 VQIoR3p5qovVJu1Mq7TkgYeujYUhAs+auIDMb55vGPczTZRnSyOGbOI01lbBgtHd8HrV
 OJpHySC/WkK1L7JNsjzUp2mjgxAZS01MVOkb18ifej9JsZFV/Htar2jEOL/0c2hvz71Y
 I//MFYOWPzFRP6ouj4MyMhWzOCVwlNI75JR/nWasX2qovuEqr9k/8TGlnkCo56ZiorPj
 Bhug==
X-Gm-Message-State: AOAM530WAauAB+mpKgSC9TRa0jc07/2rgy/unSlFeJ4JsUjfFMjqCY7V
 KijnnN1TZSLZhzuCsFksYM6oXFKCUyvuI/cDH9T+ibrgSXBoa7FLW15xqYYpAno4USA2iKs1pCm
 DowgfnM45bbwlCYE=
X-Received: by 2002:a05:6638:1508:: with SMTP id
 b8mr1662737jat.25.1603143391065; 
 Mon, 19 Oct 2020 14:36:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHRLzqa8S8+FigsSkx1Lz5QsMxAi244UrZ6jFfhloDuItHPm8b0/NtnUpgVwZ0MGQEyGI+xQ==
X-Received: by 2002:a05:6638:1508:: with SMTP id
 b8mr1662724jat.25.1603143390865; 
 Mon, 19 Oct 2020 14:36:30 -0700 (PDT)
Received: from xz-x1 (toroon474qw-lp140-04-174-95-215-133.dsl.bell.ca.
 [174.95.215.133])
 by smtp.gmail.com with ESMTPSA id z19sm1066570ioz.4.2020.10.19.14.36.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2020 14:36:30 -0700 (PDT)
Date: Mon, 19 Oct 2020 17:36:28 -0400
From: Peter Xu <peterx@redhat.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v10 07/10] memory: Add interface to set iommu page size
 mask
Message-ID: <20201019213628.GE3203@xz-x1>
References: <20201008171558.410886-1-jean-philippe@linaro.org>
 <20201008171558.410886-8-jean-philippe@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20201008171558.410886-8-jean-philippe@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 15:28:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: mst@redhat.com, qemu-devel@nongnu.org, eric.auger@redhat.com,
 alex.williamson@redhat.com, pbonzini@redhat.com, bbhushan2@marvell.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 08, 2020 at 07:15:55PM +0200, Jean-Philippe Brucker wrote:
> From: Bharat Bhushan <bbhushan2@marvell.com>
> 
> Allow to set the page size mask supported by an iommu memory region.
> This enables a vIOMMU to communicate the page size granule supported by
> an assigned device, on hosts that use page sizes greater than 4kB.
> 
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


