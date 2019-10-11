Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D158AECE58D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 19:31:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A15AE21835
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 19:31:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A15AE21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJ0dK-0000zT-A3
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 15:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38376)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iJ0Ud-0007Oo-2E
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 15:22:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iJ0Ua-0007Ce-V1
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 15:22:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50004)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iJ0Ua-0007C4-PO
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 15:22:24 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3E5B4757C5
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 19:22:23 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id b6so4821051wrw.2
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 12:22:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:cc:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ELMRBxvKSoWHhLzmpAUJbHUQr00+9jvSfjvYT/qSEAg=;
 b=uW7xvFrRXpUVcQ/kUimXesxqK303u1vU9kgEtrhJaBSjyDwhEUsZQJvViDklgIkqkd
 e68SokqfP2WfGDkKkNFlo0xM5l3q3pL8oUtFNWdMqRFY6tKiPBKUmPPTM/EWiWpLdU1S
 ezn9b5hEVB9Bgq4UD8NnP74PFlcgK74eiJCq1QN/tlfEZqMm04OdrhjfX1zjkzH4j3gD
 4wNhXGNd7QRhia30KSoIPf5WTHkp4hTvZSqKRQKmNw3/5Oj696H+P6e1LJIx7fGX12hV
 z8swTB1a5P687VTV3qKgokJ8zqI8XUq7ZPEyIdvlsnpfwNN1sC/1yUCLDxDaQ7r8s1Dy
 AFJA==
X-Gm-Message-State: APjAAAXA9hq5MplEd3XkkVSTYWFM7z9MRC94VCeWGt1IUqj9TPT+LsL9
 SbtSSGNqQVlgBy9F6oMabjTFP+OtVbe7IzslSxU+/MBAawDclPifi714LYBAOc6B4rkMrph56G6
 1cGmz+9GsNG0IoUc=
X-Received: by 2002:adf:fecd:: with SMTP id q13mr13730841wrs.224.1570821741945; 
 Fri, 11 Oct 2019 12:22:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwpL/ENBRAo+d12syMQPfSG/634EhJdHdYOwomzuH8c8Bw1Xb+gq/bly/yxn6chwl43K0oifQ==
X-Received: by 2002:adf:fecd:: with SMTP id q13mr13730830wrs.224.1570821741756; 
 Fri, 11 Oct 2019 12:22:21 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id n26sm6966676wmd.42.2019.10.11.12.22.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Oct 2019 12:22:21 -0700 (PDT)
Subject: Re: ACPI table modifications
To: Gautam Bhat <mindentropy@gmail.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>
References: <CAM2a4uzF-mtTEYwQE3+MvvDiQrfC_KQMwX4vqCg_dY9ytjZrjA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8a3d99b5-d9d3-28a7-2de0-e8a0a17356c1@redhat.com>
Date: Fri, 11 Oct 2019 21:22:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAM2a4uzF-mtTEYwQE3+MvvDiQrfC_KQMwX4vqCg_dY9ytjZrjA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Gautam,

On 10/11/19 8:47 PM, Gautam Bhat wrote:
> Hi,
>=20
> I want to add some I2C based temperature sensors to the -M Q35 machine.=
=20
> I want to update the ACPI tables to add this device information. How ca=
n=20
> I go about=C2=A0 doing this?

QEMU provides a MAINTAINERS file with persons to contact sorted by=20
topics (I Cc'ed in this reply).

This is the relevant ACPI section, it also lists the files you might=20
look at:

ACPI/SMBIOS
M: Michael S. Tsirkin
M: Igor Mammedov
S: Supported
F: include/hw/acpi/*
F: include/hw/firmware/smbios.h
F: hw/mem/*
F: hw/acpi/*
F: hw/smbios/*
F: hw/i386/acpi-build.[hc]
F: hw/arm/virt-acpi-build.c
F: tests/bios-tables-test.c
F: tests/acpi-utils.[hc]
F: tests/data/acpi/

Eventually the bios-tables-test.c file is a good starting point.

Regards,

Phil.

