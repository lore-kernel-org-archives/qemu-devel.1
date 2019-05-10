Return-Path: <SRS0=nJ0+=TL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D2EC04A6B
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2019 00:00:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61C392146F
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2019 00:00:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61C392146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51725 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPFRf-0005Jd-OS
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 20:00:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hPFQa-0004p2-UE
	for qemu-devel@nongnu.org; Fri, 10 May 2019 19:59:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hPFQZ-0004RQ-L0
	for qemu-devel@nongnu.org; Fri, 10 May 2019 19:59:48 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38329)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hPFQZ-0004R1-Gm
	for qemu-devel@nongnu.org; Fri, 10 May 2019 19:59:47 -0400
Received: by mail-qk1-f195.google.com with SMTP id a64so4771688qkg.5
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 16:59:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=g3iOqTGZfIcnm2nw2p/h7X+7c2kZhBQMIdV3gu8sFlo=;
	b=fBaHtR8D+JVMJ0FitBtPct4C4Zqdfl6Au1c1b5uO1FGbBdou2A4dfkk+S44diD1z7T
	SqeQfV7eQ8/ZELVATDQLAQPgHuiO0Jah5+Vk2suWREHhVH3M23+X5LeKzVe+fwtVahTH
	4z9lnPqgJTmp90D4+oX28GS0w7DEGG9pQjgz1w0VuyVxzboilDn+m5ljmS25pmTAgiWa
	xGQRR7LolDIan2IxI/wsYS0TiCUiR+pJ/DSF6gLSEd4Rw4HlrioS6iZdH+/kY4nBmq7R
	l4IFuORRh0rwMa1D/nB8uFLdiIdH7MDBhwXYXabjTeoTUtTaifNbxW/t62YPDwG0ex8P
	FM7Q==
X-Gm-Message-State: APjAAAW9NTsrdhKAYVvrIxZ5r3zer1k+zn0/Sp6Ss+7YyxcSiP0q07K0
	biYgWeR/3NJT1LA/MsU7G5Pi1w==
X-Google-Smtp-Source: APXvYqyk/sg0wAlzg3T+TMD5zSaUw3cj1K0tzmPBaau3s2KwIK7/BFz6EE+wUC1c5Dgh5txBpJJIfw==
X-Received: by 2002:a37:a24b:: with SMTP id l72mr11124467qke.166.1557532786923;
	Fri, 10 May 2019 16:59:46 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71]) by smtp.gmail.com with ESMTPSA id
	n22sm4269244qtb.56.2019.05.10.16.59.44
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 10 May 2019 16:59:45 -0700 (PDT)
Date: Fri, 10 May 2019 19:59:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Wei Yang <richard.weiyang@gmail.com>
Message-ID: <20190510195932-mutt-send-email-mst@kernel.org>
References: <20190419003053.8260-1-richardw.yang@linux.intel.com>
	<20190510212210.4ao2zoikky7jivwc@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510212210.4ao2zoikky7jivwc@master>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.222.195
Subject: Re: [Qemu-devel] [PATCH v4 0/6] Extract build_mcfg
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
	shannon.zhaosl@gmail.com, qemu-arm@nongnu.org,
	Wei Yang <richardw.yang@linux.intel.com>, imammedo@redhat.com,
	philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I merged this will send pull request soon.

On Fri, May 10, 2019 at 09:22:10PM +0000, Wei Yang wrote:
> Hi, Igor
> 
> You would take this one? Or what should I do next?
> 
> On Fri, Apr 19, 2019 at 08:30:47AM +0800, Wei Yang wrote:
> >This patch set tries to generalize MCFG table build process. And it is
> >based on one un-merged patch from Igor, which is included in this serials.
> >
> >v3->v4:
> >    * adjust comment to give more information about MCFG table
> >
> >v2->v3:
> >    * Includes the un-merged patch from Igor
> >    * use build_append_foo() API to construct MCFG
> >
> >Igor Mammedov (1):
> >  q35: acpi: do not create dummy MCFG table
> >
> >Wei Yang (5):
> >  hw/arm/virt-acpi-build: remove unnecessary variable mcfg_start
> >  i386, acpi: remove mcfg_ prefix in AcpiMcfgInfo members
> >  hw/arm/virt-acpi-build: pass AcpiMcfgInfo to build_mcfg()
> >  hw/acpi: Consolidate build_mcfg to pci.c
> >  acpi: pci: use build_append_foo() API to construct MCFG
> >
> > default-configs/arm-softmmu.mak  |  1 +
> > default-configs/i386-softmmu.mak |  1 +
> > hw/acpi/Kconfig                  |  4 +++
> > hw/acpi/Makefile.objs            |  1 +
> > hw/acpi/pci.c                    | 55 ++++++++++++++++++++++++++++++++
> > hw/arm/virt-acpi-build.c         | 31 +++++-------------
> > hw/i386/acpi-build.c             | 44 ++++---------------------
> > include/hw/acpi/acpi-defs.h      | 18 -----------
> > include/hw/acpi/pci.h            | 34 ++++++++++++++++++++
> > 9 files changed, 111 insertions(+), 78 deletions(-)
> > create mode 100644 hw/acpi/pci.c
> > create mode 100644 include/hw/acpi/pci.h
> >
> >-- 
> >2.19.1
> >
> 
> -- 
> Wei Yang
> Help you, Help me

