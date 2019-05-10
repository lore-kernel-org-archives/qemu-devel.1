Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31ECEC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 21:23:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2FD7217F5
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 21:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTaBVWTy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2FD7217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50184 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPCz8-0000Kl-7A
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 17:23:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1hPCyB-0008Np-Ts
	for qemu-devel@nongnu.org; Fri, 10 May 2019 17:22:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1hPCy9-0000Vm-NN
	for qemu-devel@nongnu.org; Fri, 10 May 2019 17:22:19 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:33019)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
	id 1hPCy8-0000U0-Cn; Fri, 10 May 2019 17:22:17 -0400
Received: by mail-ed1-x543.google.com with SMTP id n17so6943639edb.0;
	Fri, 10 May 2019 14:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=pO692Vr35EFtke8/sxOhlgDHZvkq3DDBZKK4hO0zEv0=;
	b=JTaBVWTy1H1uvZbe3OJrG5G8U2Yt4ZSOMKoNP18yJHDboSay9b6Wa66yAE/+gJuy9n
	5j6DL5+5chFR7rXEkqITtWa6Do14FWqPl8nlfcDInhEbp7Gvmj8yDmDgcQGTb6dXegmC
	NnzbsXaJn1jBshM8EBrqMhWR5HEd0fDIBoTUiHkr0mAiIXr1cIh/d9tPnCqQHgx6oCgT
	Jn2+tZbjLkCU7FsGpm6u96kZPib3XE3yDRqYwHB2rpibO7plBTHZRMXdawM+9Gh6cbw/
	gM2DkAV8rQRXi+BgHSPwK3D5uso7lIzp8Gj7+v4xfo7Mt4L3Iq4LRas0RIRvI8UcA25B
	jHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
	:references:mime-version:content-disposition:in-reply-to:user-agent;
	bh=pO692Vr35EFtke8/sxOhlgDHZvkq3DDBZKK4hO0zEv0=;
	b=oLTzB+mVQg3LpFkogngftkJFCXhKkPYHQAb27NOryM/jNMPKbmor60fGfV/fJtSlIy
	vv0gbx2nvCSt2J7+g6LQS6VsQidjRszCPxqAK1cj4SHAJLd3+1izxwroVg3onDPyza2v
	FQeAMHVBOKImXaBUg2k/2e+u2D1O2nnJLm9STQWPXILAueB0YahSWIaJw1aDptCqoVtf
	AJZvvgcG3s4RGw1UP2oG+tTqvTLWFjd2kfvCEiDR2nDvWWgq7hL0Ca3ZkMY7U97a2Jv0
	LLrGpDVzxZfvZtSAaOD8+Ir/J3vN9i/j8gVXf9l9WRdN4F6GDYSdafhOoAmr9Frt9DRb
	YPow==
X-Gm-Message-State: APjAAAUCVptl1LcGZHVQ2dAM4ZQzQhodaIx631KnSKWMRbznnJGkfJyY
	DHiWw0RmVOV4hFg9CL77pB4=
X-Google-Smtp-Source: APXvYqyvY9mkodCKiS5ueCtq70Q1ZsdYQZ+9XUSoFcOCH+Qimj7s3+f0rdG6As5zRg9HmhtoQ3uEVA==
X-Received: by 2002:a50:b343:: with SMTP id r3mr13870142edd.53.1557523333887; 
	Fri, 10 May 2019 14:22:13 -0700 (PDT)
Received: from localhost ([185.92.221.13])
	by smtp.gmail.com with ESMTPSA id 96sm300260edq.68.2019.05.10.14.22.10
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 10 May 2019 14:22:10 -0700 (PDT)
Date: Fri, 10 May 2019 21:22:10 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190510212210.4ao2zoikky7jivwc@master>
References: <20190419003053.8260-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190419003053.8260-1-richardw.yang@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::543
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
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, mst@redhat.com,
	qemu-devel@nongnu.org, shannon.zhaosl@gmail.com,
	qemu-arm@nongnu.org, imammedo@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Igor

You would take this one? Or what should I do next?

On Fri, Apr 19, 2019 at 08:30:47AM +0800, Wei Yang wrote:
>This patch set tries to generalize MCFG table build process. And it is
>based on one un-merged patch from Igor, which is included in this serials.
>
>v3->v4:
>    * adjust comment to give more information about MCFG table
>
>v2->v3:
>    * Includes the un-merged patch from Igor
>    * use build_append_foo() API to construct MCFG
>
>Igor Mammedov (1):
>  q35: acpi: do not create dummy MCFG table
>
>Wei Yang (5):
>  hw/arm/virt-acpi-build: remove unnecessary variable mcfg_start
>  i386, acpi: remove mcfg_ prefix in AcpiMcfgInfo members
>  hw/arm/virt-acpi-build: pass AcpiMcfgInfo to build_mcfg()
>  hw/acpi: Consolidate build_mcfg to pci.c
>  acpi: pci: use build_append_foo() API to construct MCFG
>
> default-configs/arm-softmmu.mak  |  1 +
> default-configs/i386-softmmu.mak |  1 +
> hw/acpi/Kconfig                  |  4 +++
> hw/acpi/Makefile.objs            |  1 +
> hw/acpi/pci.c                    | 55 ++++++++++++++++++++++++++++++++
> hw/arm/virt-acpi-build.c         | 31 +++++-------------
> hw/i386/acpi-build.c             | 44 ++++---------------------
> include/hw/acpi/acpi-defs.h      | 18 -----------
> include/hw/acpi/pci.h            | 34 ++++++++++++++++++++
> 9 files changed, 111 insertions(+), 78 deletions(-)
> create mode 100644 hw/acpi/pci.c
> create mode 100644 include/hw/acpi/pci.h
>
>-- 
>2.19.1
>

-- 
Wei Yang
Help you, Help me

