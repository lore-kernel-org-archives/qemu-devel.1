Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154A6C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 14:47:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1FDB20787
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 14:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JfZEEIQW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1FDB20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIvhf-0007on-2H
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 10:47:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60349)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jIvgk-0007L4-I1
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 10:46:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jIvgj-0001bm-Jm
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 10:46:54 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:26006)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jIvgj-0001ai-G7
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 10:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585579613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vP2cKtinFs+lAQbb7BBjTB8lAFgZM4t9uQiiQWM7h44=;
 b=JfZEEIQWDlVK4wKMHLDg5DOHT+O2jvxQxlOpUH07bIiv7v8rNw2eVrVn24o++xYVwrooHs
 RWo3c+Bx37Gj0jKN1NZCvFLe47s40iQ0YBYr1uLW2OCF6EtBJ31MAD9w3wbBR8RUMiwyff
 GFSJsAHxRgiHYoTSm1Hma66Tjwktrqg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-9hK7_o31Mo2CnOmifTAa_g-1; Mon, 30 Mar 2020 10:46:49 -0400
X-MC-Unique: 9hK7_o31Mo2CnOmifTAa_g-1
Received: by mail-wr1-f72.google.com with SMTP id f8so11382962wrp.1
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 07:46:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FPOODXZeqHak8yNUsaPvPmUoEMONp5wZGn66sHTps20=;
 b=GwDWv8Jf9tUr90F0411k/iY1Z1WU9lAdeHdQoiHgEAHll6ai+gk4GM0P86L/D7al76
 oVXBi71yO3w8PHTfj1aN5mqJ5nRKMztDnbMrRDqdJVKhZaHt5H1aj9EwUWZqE4jbNYSB
 ex+8z3SgMRo0sche/6oquHZlWJ13TtlzX4ZAfKd8kW10Inw042etVwxGAjClndBnxAld
 mDX6pV1MMAjaHPF6W1T+2bQ8pqzvNad0LRviWDioXlLA02IMlh6o/R0ovUt8DgKltjUW
 RMxy9NR5O4cCH4O182MGT8Z7MXTspJ4v2HLa3i+oFRCouTqgliufEq/GYeBc14xA0vz/
 ZnaA==
X-Gm-Message-State: ANhLgQ0eYYBdlbyKw+vCcfIGM2CXjw6V7i2lkqnlxw+ecXAEGKzEdT3H
 VZfhb2A/OSogn5q1FUt9C6ug1Y/ErZZLycoqdxf28FlZjMF9PKQZwIfiwsnHYNpKPFpgnTu/EzK
 77kntjAPKI2iKLcg=
X-Received: by 2002:a1c:4645:: with SMTP id t66mr13970589wma.6.1585579608038; 
 Mon, 30 Mar 2020 07:46:48 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vu11Bf/4QJ0PMAXy7op2XTLz+TvVZsEHoWaya5YO1UeYVBfTuMaKjTcgmjpUGV7NkTe5j/1dA==
X-Received: by 2002:a1c:4645:: with SMTP id t66mr13970564wma.6.1585579607779; 
 Mon, 30 Mar 2020 07:46:47 -0700 (PDT)
Received: from xz-x1 (CPEf81d0fb19163-CMf81d0fb19160.cpe.net.fido.ca.
 [72.137.123.47])
 by smtp.gmail.com with ESMTPSA id w7sm22220373wrr.60.2020.03.30.07.46.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2020 07:46:46 -0700 (PDT)
Date: Mon, 30 Mar 2020 10:46:40 -0400
From: Peter Xu <peterx@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v2 00/22] intel_iommu: expose Shared Virtual Addressing
 to VMs
Message-ID: <20200330144640.GC522868@xz-x1>
References: <1585542301-84087-1-git-send-email-yi.l.liu@intel.com>
 <e709e36f-dc50-2e70-3a1e-62f08533e454@redhat.com>
MIME-Version: 1.0
In-Reply-To: <e709e36f-dc50-2e70-3a1e-62f08533e454@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: jean-philippe@linaro.org, kevin.tian@intel.com,
 Liu Yi L <yi.l.liu@intel.com>, kvm@vger.kernel.org, mst@redhat.com,
 jun.j.tian@intel.com, qemu-devel@nongnu.org, alex.williamson@redhat.com,
 pbonzini@redhat.com, hao.wu@intel.com, yi.y.sun@intel.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 30, 2020 at 12:36:23PM +0200, Auger Eric wrote:
> I think in general, as long as the kernel dependencies are not resolved,
> the QEMU series is supposed to stay in RFC state.

Yeah I agree. I think the subject is not extremely important, but we
definitely should wait for the kernel part to be ready before merging
the series.

Side note: I offered quite a few r-bs for the series (and I still plan
to move on reading it this week since there's a new version, and try
to offer more r-bs when I still have some context in my brain-cache),
however they're mostly only for myself to avoid re-reading the whole
series again in the future especially because it's huge... :)

Thanks,

--=20
Peter Xu


