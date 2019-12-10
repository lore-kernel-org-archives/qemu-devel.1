Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C26C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 16:34:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C135A2073B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 16:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k2qqHrXp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C135A2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieiT3-00013A-8Z
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 11:34:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56198)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jean-philippe@linaro.org>) id 1ieiRF-0007nl-FQ
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:32:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jean-philippe@linaro.org>) id 1ieiRD-0007zl-CF
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:32:41 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40140)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jean-philippe@linaro.org>)
 id 1ieiRD-0007zB-2M
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:32:39 -0500
Received: by mail-wm1-x341.google.com with SMTP id t14so3900870wmi.5
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 08:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=qgVznmekNB3MfWLf8bBgjLOIH1R7Lmqq4nQfM+upz3U=;
 b=k2qqHrXpr77w0dy+IsuoZDZBR/zO1WWMkmuM0lgyEBcYt9nGmQFMIP0tKz7vAakfPl
 mj6EEnUORMrkxg1qYTKoAazJMitEMrlle4erVE86cUl7DPGfuUAGqBiqdPNF1K/LfJF+
 P4dmS1Bv1PLgJ7bdMv7iZOeUU1/Ex90kE6EkFf6eSgkovI0HowIC/TGoqP+Uj/0Y2m+Z
 USuRSdzIWqMKIIf5IwAWRTGPFnHtH233VgOwvj8mkK9nv2jJq3vx5z4UIC3j9TrzSaIY
 9fWjHx8MXWKTQUc5DpkTy4jc81F1k8P+MHc+hHlOCT/bx4kgQkb0nvGN5vDPv1UnDiAL
 hstQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qgVznmekNB3MfWLf8bBgjLOIH1R7Lmqq4nQfM+upz3U=;
 b=rJFpTBh18iZby9IQ8VqjcMHKkb9hRPDjLxg2fVQMVQJ+s63k1gi2zN5jbgMaOPaLQs
 6fKW7vFtI5/cshXo7XWIt9DYs4x1TEb9YW2MEqU/CQ8FDcVBuBkuH9C6RdC4skGREzFT
 2U+htu7qw1elXv1YMyzkzTMvWTYeHXwTlKpBnZdtGTDKIbtHm3tpKzFkbUm1qcmvYfR8
 fFVyiFnxTFei7KxXHGbzio0nYbtUUGiR6VJP9Av23H2IWO+z1v2vzQsctkB6y8lxfru6
 iOBpwlamgI3GfqehLWSD2jhLF1/hCvHoqj8GJ6ihl3P4Q/CcMkld8DjwGWPFv14kA6j8
 a1RA==
X-Gm-Message-State: APjAAAVCboRUPCaAnvE1/ZK+/zQO60XZkJVxOAd0IfqFjeAFs2wEr3/c
 NGJbdc6x8kd+3njr1V0XAh7C0w==
X-Google-Smtp-Source: APXvYqyltAwOreZoQ/omCzEQQ5FjH/XyA8RdQZXB56rgqB5k2s5ytj78cTlWZV+vkONaZtKV/jQjag==
X-Received: by 2002:a05:600c:2301:: with SMTP id
 1mr6485530wmo.147.1575995557913; 
 Tue, 10 Dec 2019 08:32:37 -0800 (PST)
Received: from myrica (adsl-84-227-176-239.adslplus.ch. [84.227.176.239])
 by smtp.gmail.com with ESMTPSA id u10sm3615307wmd.1.2019.12.10.08.32.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2019 08:32:37 -0800 (PST)
Date: Tue, 10 Dec 2019 17:32:33 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH for-5.0 v11 03/20] virtio-iommu: Decode the command payload
Message-ID: <20191210163233.GB277340@myrica>
References: <20191122182943.4656-1-eric.auger@redhat.com>
 <20191122182943.4656-4-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122182943.4656-4-eric.auger@redhat.com>
X-TUID: ajVuZQQERWm/
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, kevin.tian@intel.com,
 tnowicki@marvell.com, mst@redhat.com, jean-philippe.brucker@arm.com,
 quintela@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 armbru@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 dgilbert@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 22, 2019 at 07:29:26PM +0100, Eric Auger wrote:
> This patch adds the command payload decoding and
> introduces the functions that will do the actual
> command handling. Those functions are not yet implemented.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Which isn't worth much since I don't have prior QEMU experience but I did
stare at this code for a while and work on future extensions.

Thanks,
Jean


