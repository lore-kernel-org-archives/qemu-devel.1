Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33B2C35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 14:27:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3014208C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 14:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nh33IvWz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3014208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j59HI-0000zX-0L
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 09:27:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47855)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j59GS-0008TT-FJ
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 09:26:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j59GR-000666-Ii
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 09:26:48 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:39496)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j59GR-00065X-E8
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 09:26:47 -0500
Received: by mail-ot1-x341.google.com with SMTP id 77so2127272oty.6
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 06:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/2fCPIpVt94NvvPO4CigqPV2g3CIeYezuT4KDYa1ew4=;
 b=Nh33IvWzD1cGAius/dAaiBVbeejIvxJ9uS1+A1EdpV+fJZ38EO9k/WPySxsLIstvxO
 U4wgRIfFQSbF1ZA2Pf1zsNq9hNYFo3sJ3gdLKgKGUs99BBPgiG84BURx6junSNENq6lG
 g5LR7C12CWST+ipLJNQ0OqjRHym0JfH1JsQr+1ufCtgjZ2TVdhIdbhfP5IZssr2UYi8+
 11WwGEBSL9aLiSdlVSZIsDvxlPMyCaYdJXC1wM+a9GbaBwdL9kGSxcGiypFEinIg7ZHe
 1fNWZ9acj1sGqFf55EzsBCodGmK1BR52vJmhGV9ukkTKXAlogTV8NBJBEFhBantOlBaI
 XS4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/2fCPIpVt94NvvPO4CigqPV2g3CIeYezuT4KDYa1ew4=;
 b=mJ96dtMvc/4hoJy25HRJItXN2AQXCviORHHQZUocm2PfZmlkfxrfvik46bzf7nz7YE
 +XdX30xvK4I1Ve7re482M9U2OPa3EzKAwJPjgy3R5/CsQU8tEeKa31prc8NoqZGn+v9k
 fe4D2HcahqThIDeLKqZJ+ZEc+LSp9Vb4f6ZslgzeW8F6RjIUWWrPcf1qotTHxa8QDrgE
 3hXMT9bLptXL7R+A4l4d8VS3XNaHSnYDD1/BU1D7JELdWkAc9DI343cFzoDS2x12sbzE
 ObqXEdnd1hmJBZmrNkWbstZ7s9qp65xcAxd4/RImXWyK/MPGROTBsheiD5VQLbCq6RzV
 8+dA==
X-Gm-Message-State: APjAAAXIzwlm9yvy2n7vE7aoOvNJTKI0TjmlphOB6crHOH/ZRNCUTWV7
 LcpwHTr+BCjxJtO00wp0g/DEAlqhUgic29b8BbPtjw==
X-Google-Smtp-Source: APXvYqx+GovfvBgYdYeQ1jj5sQVgNxefHMuCY9QBjRxRN+COHKwHIacGn7W8vpL2LYayLliwcaDREnASteBxgUAt/mw=
X-Received: by 2002:a9d:68d9:: with SMTP id i25mr16283516oto.135.1582295206690; 
 Fri, 21 Feb 2020 06:26:46 -0800 (PST)
MIME-Version: 1.0
References: <20200214132745.23392-1-eric.auger@redhat.com>
 <20200214132745.23392-11-eric.auger@redhat.com>
In-Reply-To: <20200214132745.23392-11-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Feb 2020 14:26:35 +0000
Message-ID: <CAFEAcA9HFAV+gPOkNWaixNqEKmsWUAAYjNcet8-tNJXvUyOrOg@mail.gmail.com>
Subject: Re: [PATCH v16 10/10] MAINTAINERS: add virtio-iommu related files
To: Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, tnowicki@marvell.com,
 Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, bharatb.linux@gmail.com,
 qemu-arm <qemu-arm@nongnu.org>, Eric Auger <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 14 Feb 2020 at 13:29, Eric Auger <eric.auger@redhat.com> wrote:
>
> Add a new "virtio-iommu" section with the new files
> related to this device.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c7717df720..b7a7a18737 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1623,6 +1623,12 @@ F: hw/input/virtio-input*.c
>  F: include/hw/virtio/virtio-input.h
>  F: contrib/vhost-user-input/*
>
> +virtio-iommu
> +M: Eric Auger <eric.auger@redhat.com>
> +S: Maintained
> +F: hw/virtio/virtio-iommu*.c
> +F: include/hw/virtio/virtio-iommu.h
> +
>  virtio-serial
>  M: Laurent Vivier <lvivier@redhat.com>
>  R: Amit Shah <amit@kernel.org>
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

