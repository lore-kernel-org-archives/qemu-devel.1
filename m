Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A76C04AB3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 03:22:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BACB8205F4
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 03:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BACB8205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46310 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVpAj-00050e-Ui
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 23:22:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hVp9t-0004jf-H3
	for qemu-devel@nongnu.org; Tue, 28 May 2019 23:21:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hVp9s-0007s8-CJ
	for qemu-devel@nongnu.org; Tue, 28 May 2019 23:21:45 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35762)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hVp9s-0007rE-89
	for qemu-devel@nongnu.org; Tue, 28 May 2019 23:21:44 -0400
Received: by mail-qt1-f195.google.com with SMTP id w1so880247qts.2
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 20:21:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to;
	bh=+BLIyxyePTn2kZOn6YwF3uZjrbaiq6FJ5d3R61/OJaQ=;
	b=Cm7WcYLm/R/pQXPSHQzUNgmPfffZQDigepuRwk7/dAmh42DXgKFTZIzfXG3/3aO2qn
	Ib026S1MHDYNZUG7Yq1vChC5FMY7SaUDPrvMJmpehiiXDveF9eTyN67Cd2iQqV1ahIMI
	h1+picKlTebp2mfu7FfLX6DCxEVg/1DMCwG6kQFdJZVaocVBVSNLGm/mSePC3CUEbXtC
	9JTq/JJR3kv2J/VXSXHtLyIwlVKjn2sTTiIjVu4SyJ29eS9+n3k9QfMLeBZVikz9JNOh
	ptTlL/ZofPjLh0bfB9kvCbWf+Q38PTY91lCVI0b6N1IB7jzImzbsEMWldxR9RzR1xPhY
	Lqhg==
X-Gm-Message-State: APjAAAV1sMnDfhcpEbaP8nlI99Z6VmctL23dQhiKmA67FzQZrRqzE+no
	I3JWeMJPux4kyQreGrQoGP627A==
X-Google-Smtp-Source: APXvYqyMy/EH+S/Sutv4ILkIXpiq9K1NYpDaXBY82mLvAR61nXOYxQQUfOCOT1wcoTO3rvmM6gZSNg==
X-Received: by 2002:a0c:d13a:: with SMTP id a55mr55859802qvh.111.1559100103651;
	Tue, 28 May 2019 20:21:43 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
	[100.0.197.103]) by smtp.gmail.com with ESMTPSA id
	t17sm6533709qte.66.2019.05.28.20.21.41
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Tue, 28 May 2019 20:21:42 -0700 (PDT)
Date: Tue, 28 May 2019 23:21:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190528231739-mutt-send-email-mst@kernel.org>
References: <20190524063553.5339-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190524063553.5339-1-philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.195
Subject: Re: [Qemu-devel] [PATCH 00/20] hw/i386/pc: Do not restrict the
 fw_cfg functions to the PC machine
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
Cc: Yang Zhong <yang.zhong@intel.com>, Samuel Ortiz <sameo@linux.intel.com>,
	Rob Bradford <robert.bradford@intel.com>,
	Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 24, 2019 at 08:35:33AM +0200, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> This is my take at salvaging some NEMU good work.
> Samuel worked in adding the fw_cfg device to the x86-virt NEMU machine.
> This series is inspired by NEMU's commit 3cb92d080835 [*] and adapted
> to upstream style. The result makes the upstream codebase more
> modularizable.
> There are very little logical changes, this is mostly a cleanup
> refactor.
> 
> Regards,
> 
> Phil.

So I take issue with some of the renames.  When I see fw_cfg_XXXX I
expect the definition be in fw_cfg.c not in pc.c

Please use prefixes that match the file name -
avoids namespace conflicts and makes it easy to
find files.

This is not to say that the current system is perfect:
we have bochs_bios_init which isn't in bochs.c, should
be pc_bochs_bios_init or whatever.

Thanks!


> [*] https://github.com/intel/nemu/commit/3cb92d080835ac8d47c8b713156338afa33cff5c
> 
> Philippe Mathieu-Daudé (20):
>   hw/i386/pc: Use unsigned type to index arrays
>   hw/i386/pc: Use size_t type to hold/return a size of array
>   hw/i386/pc: Let e820_add_entry() return a ssize_t type
>   hw/i386/pc: Add the E820Type enum type
>   hw/i386/pc: Add documentation to the e820_*() functions
>   hw/i386/pc: Use e820_get_num_entries() to access e820_entries
>   hw/i386/pc: Extract e820 memory layout code
>   hw/i386/pc: Use address_space_memory in place
>   hw/i386/pc: Rename bochs_bios_init() more generic as
>     x86_create_fw_cfg()
>   hw/i386/pc: Pass the boot_cpus value by argument
>   hw/i386/pc: Pass the apic_id_limit value by argument
>   hw/i386/pc: Pass the CPUArchIdList array by argument
>   hw/i386/pc: Let fw_cfg_init() use the generic MachineState
>   hw/i386/pc: Let pc_build_smbios() take a FWCfgState argument
>   hw/i386/pc: Let pc_build_smbios() take a generic MachineState argument
>   hw/i386/pc: Rename pc_build_smbios() as generic fw_cfg_build_smbios()
>   hw/i386/pc: Let pc_build_feature_control() take a FWCfgState argument
>   hw/i386/pc: Let pc_build_feature_control() take a MachineState
>     argument
>   hw/i386/pc: Rename pc_build_feature_control() as generic
>     fw_cfg_build_*
>   hw/i386/pc: Extract the x86 generic fw_cfg code
> 
>  hw/i386/Makefile.objs        |   2 +-
>  hw/i386/e820_memory_layout.c |  62 +++++++++++
>  hw/i386/e820_memory_layout.h |  76 +++++++++++++
>  hw/i386/fw_cfg.c             | 135 +++++++++++++++++++++++
>  hw/i386/fw_cfg.h             |   6 ++
>  hw/i386/pc.c                 | 201 ++---------------------------------
>  include/hw/i386/pc.h         |  11 --
>  target/i386/kvm.c            |   1 +
>  8 files changed, 289 insertions(+), 205 deletions(-)
>  create mode 100644 hw/i386/e820_memory_layout.c
>  create mode 100644 hw/i386/e820_memory_layout.h
> 
> -- 
> 2.20.1

