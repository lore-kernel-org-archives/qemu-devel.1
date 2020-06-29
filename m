Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6531C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 15:22:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 810C2247FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 15:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hQfKyUOF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 810C2247FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpvcE-0005EJ-Qi
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 11:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jpvbD-0004dM-HT
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 11:21:35 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39168
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jpvbB-0001Fx-GL
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 11:21:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593444092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4CMx1GO55ZFw157UDV5+gyoOgLVUEJkhnBwC/sFV9oc=;
 b=hQfKyUOF7iv/G0IFAuZBm7JjYmqu09AqiYCV9ncfNEohKvg9W6NRkHmw3vfZrgoAcfSi00
 EuiLlqTz7ef2Pc0rq1bEYXEfrB/WsHE4PComoDZiyj6s5RspwIojwBuOcOIEVdWDZo2Bbz
 S/jjcqNgn8u2Vv7A7Kr5D3HYb7EDvSw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-zHn1Snj2OD6RP069ULNhbA-1; Mon, 29 Jun 2020 11:21:30 -0400
X-MC-Unique: zHn1Snj2OD6RP069ULNhbA-1
Received: by mail-wr1-f69.google.com with SMTP id e11so16748812wrs.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 08:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4CMx1GO55ZFw157UDV5+gyoOgLVUEJkhnBwC/sFV9oc=;
 b=uRIZA7K8fzu8XhYy/1Oewp5AtbPP9/IlqaB4dujJpZTtFc7GzSntApKqnp+S024J0N
 5kIYeJeAmm/uGINeWT6cYZ1ho6gu2MNvsJUw1wWiDaR/mvPo0FtkqRSr2YhoNjVfrXqV
 CIV9vTMihP4z3Nit7V3MDA/fdqbBlh/QYAgOnpgNmPxhnBg5Dr7VKpKZQevGTvjG/hf+
 l2A4sPbr+QiBsIc7EPL96u9xTvecg0gmms11UbUEoDTZIU/1rv2oXLFt4TiOCAtSALdV
 1jSt/h91Q4pqLww4UneUc8MxoW8jUdKepLdzwU1TI57+93QVT8X4PHlLJoLRpXdm6/XK
 OiLw==
X-Gm-Message-State: AOAM532vhL/88hm2HUtYK7QCCL9F5I1wrQWX228IJg4wEdLyPnxrpvUS
 9fuNvLLAdZmNOEgaGoQdaEomEeWLfCRqQtr9fusceZJAqAtWNqhdPUyRwqlhNivAsUPr2EoEIVn
 SbVrINrQqdbCvIlU=
X-Received: by 2002:a5d:6b08:: with SMTP id v8mr18258180wrw.2.1593444089321;
 Mon, 29 Jun 2020 08:21:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwUVmYeL7pZMSBHPjcchpXiueAXW4gqtb89hzXwXkNUnhkjdVaPHqkhBax1alLw+D9P3I2w3Q==
X-Received: by 2002:a5d:6b08:: with SMTP id v8mr18258167wrw.2.1593444089160;
 Mon, 29 Jun 2020 08:21:29 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 b184sm149153wmc.20.2020.06.29.08.21.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2020 08:21:28 -0700 (PDT)
Date: Mon, 29 Jun 2020 11:21:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH 0/4] hw/arm/virt-acpi-build: Only expose flash on older
 machine types
Message-ID: <20200629112056-mutt-send-email-mst@kernel.org>
References: <20200629140938.17566-1-drjones@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200629140938.17566-1-drjones@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:06:01
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
Cc: peter.maydell@linaro.org, eric.auger@redhat.com, philmd@redhat.com,
 qemu-devel@nongnu.org, shannon.zhaosl@gmail.com, qemu-arm@nongnu.org,
 ard.biesheuvel@arm.com, imammedo@redhat.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 29, 2020 at 04:09:34PM +0200, Andrew Jones wrote:
> The flash device is exclusively for the host-controlled firmware, so
> we should not expose it to the OS. Exposing it risks the OS messing
> with it, which could break firmware runtime services and surprise the
> OS when all its changes disappear after reboot.
> 
> This change was suggested by Ard and Laszlo.
> 
> Patch 3/4 is the meat. The other patches deal with updating qtest.


acpi things:

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>


> Thanks,
> drew
> 
> Andrew Jones (4):
>   tests/acpi: remove stale allowed tables
>   tests/acpi: virt: allow DSDT acpi table changes
>   hw/arm/virt-acpi-build: Only expose flash on older machine types
>   tests/acpi: virt: update golden masters for DSDT
> 
>  hw/arm/virt-acpi-build.c                    |   5 ++++-
>  hw/arm/virt.c                               |   3 +++
>  include/hw/arm/virt.h                       |   1 +
>  tests/data/acpi/virt/DSDT                   | Bin 5307 -> 5205 bytes
>  tests/data/acpi/virt/DSDT.memhp             | Bin 6668 -> 6566 bytes
>  tests/data/acpi/virt/DSDT.numamem           | Bin 5307 -> 5205 bytes
>  tests/qtest/bios-tables-test-allowed-diff.h |  18 ------------------
>  7 files changed, 8 insertions(+), 19 deletions(-)
> 
> -- 
> 2.25.4


