Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB2FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 12:01:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9FCC20737
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 12:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oGit0OQ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9FCC20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqxtu-00052l-8N
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 08:01:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mwoodpatrick@gmail.com>)
 id 1jqxsk-0004BL-6n
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 07:59:58 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c]:44446)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mwoodpatrick@gmail.com>)
 id 1jqxsi-0001fq-Ld
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 07:59:57 -0400
Received: by mail-pf1-x42c.google.com with SMTP id t11so7593075pfq.11
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 04:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:references:in-reply-to:subject:date:message-id:mime-version
 :content-transfer-encoding:thread-index:content-language;
 bh=golg96dEpXJfAgzCstEFxGpWdvx8DIRvbEfz0uUuoIU=;
 b=oGit0OQ+v3MOMKe1sjN5JJFJHX6WQY7mFvxNExN8CetcH7tNuqfvFXx8xrgytbCx1v
 xLtm/bi3ADJHG1G2a9jzXTuvyrimP9fbCY6hLWfpd8lVsSwK5tUj25Gxcx0vle0wxX2n
 RJrCk8ll3IIvoh/V7E27oex+NQaRzRZCLGWyx/x+CDtUu95K/xAHQ3kl2sORwb86tHIR
 s41EyHnWiFUbh9XhkrG5/c6t7dRCPmI0tNs/rCLw4s5Vke/9zj7WpBKRs48PzoVt2q+Y
 nH6805Vc86t3KTclSgHYW/i4eyi4zTm7+RRElBLtHGC+50lJCop5A6iPZ98+svsRa++V
 PEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:references:in-reply-to:subject:date
 :message-id:mime-version:content-transfer-encoding:thread-index
 :content-language;
 bh=golg96dEpXJfAgzCstEFxGpWdvx8DIRvbEfz0uUuoIU=;
 b=XocZgxAw8FcrUMKHBAnBvt0rimx9r5ErX2iCUB0QOUOlhbZ8A5HWhZMcBEfIzqzV8H
 nEidxTTVJ6rDB3Vg9mhfCzZQfN7RCjfU/BB2OhTs94Wo9+HGR2sxxp7oUSGDXdltLKWo
 Y1QBbyvQqxyq0OX2XuL/XqSaiS49OsDhkgNsxU6V3Vlt+6BIvBCFbiGy5O9jcSUkOFC1
 oNXaJ5tw07E7WGmPqqnV3aHVXKuTUMasi3PfFZN6QgC4MYM53dYoC13k2FLiZyykc+y9
 SOVCMIeN3S2F8Fw2ioTQfgsqbD66gR6RWkEYz6c78Gqv5Qw31JmaokMLHDC6ZJTsMeOG
 tXUQ==
X-Gm-Message-State: AOAM531rbpk4raTbbRaMs5Fu9wEk/NrRt3/0bKAEOgw5P+kKUnFDpy/O
 2yHdSFANB7uIJNBlju5xh48=
X-Google-Smtp-Source: ABdhPJzeW+/LIxZSNpAChZc6gtpeX6JkIp1xVfJP/brUku5AfqF+RkZPUr1J3aB9WTJWG/QSTgzUsg==
X-Received: by 2002:aa7:84ce:: with SMTP id x14mr23430650pfn.220.1593691194969; 
 Thu, 02 Jul 2020 04:59:54 -0700 (PDT)
Received: from MarksSpectreX360 ([216.228.117.191])
 by smtp.gmail.com with ESMTPSA id z5sm8449133pfn.117.2020.07.02.04.59.53
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 02 Jul 2020 04:59:54 -0700 (PDT)
From: <mwoodpatrick@gmail.com>
To: <qemu-devel@nongnu.org>,
	<kvm@vger.kernel.org>
References: <MN2PR12MB41758B8F79B8F3BBBAF6C314A06C0@MN2PR12MB4175.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB41758B8F79B8F3BBBAF6C314A06C0@MN2PR12MB4175.namprd12.prod.outlook.com>
Subject: Seeing a problem in multi cpu runs where memory mapped pcie device
 register reads are returning incorrect values
Date: Thu, 2 Jul 2020 04:59:52 -0700
Message-ID: <05f901d65068$4c23be00$e46b3a00$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdZP0xwDhu8cf1EMQLyhyg6esmh9lQAkw8Jg
Content-Language: en-us
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=mwoodpatrick@gmail.com; helo=mail-pf1-x42c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Background
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I have a test environment which runs QEMU 4.2 with a plugin that runs =
two
copies of a PCIE device simulator on a CentOS 7.5 host with an Ubuntu =
18.04
guest. When running with a single QEMU CPU using:

=A0=A0=A0=A0 -cpu kvm64,+lahf_lm -M q35,kernel-irqchip=3Doff -device
intel-iommu,intremap=3Don

Our tests run fine.=20

But when running with multiple cpu=92s:

=A0=A0=A0 -cpu kvm64,+lahf_lm -M q35,kernel-irqchip=3Doff -device
intel-iommu,intremap=3Don -smp 2,sockets=3D1,cores=3D2

Some mmio reads to the simulated devices BAR 0 registers by our device
driver running on the guest are returning are returning incorrect =
values.=20

Running QEMU under gdb I see that the read request is reaching our =
simulated
device correctly and that the correct result is being returned by the
simulator. Using gdb I have tracked the return value all the way back up =
the
call stack and the correct value is arriving in KVM_EXIT_MMIO
in=A0kvm_cpu_exec (qemu-4.2.0/accel/kvm/kvm-all.c:2365)=A0 but the value
returned to the device driver which initiated the read is 0.

Question
=3D=3D=3D=3D=3D=3D=3D=3D

Is anyone else running QEMU 4.2 in multi cpu mode? Is anyone getting
incorrect reads from memory mapped device registers =A0when running in =
this
mode? I would appreciate any pointers on how best to debug the flow from
KVM_EXIT_MMIO back to the device driver running on the guest
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20


