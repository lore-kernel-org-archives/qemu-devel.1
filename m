Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E353FC3A59D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 10:30:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9FDF206B7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 10:30:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9FDF206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0kMB-0007J9-9O
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 06:30:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36038)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i0kKp-0005kr-9C
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 06:28:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i0kKn-00057b-1h
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 06:28:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43566)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i0kKl-0004zN-6K
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 06:28:48 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 467A485539
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 10:28:41 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id m7so2972804wrw.22
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 03:28:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4MfO4wwvQsCCexQFrhxhOuZM/VP4L6uDupwMAnNIvjU=;
 b=eyO2qStOISi2+3U8QRbC2v6oFbwvr5aqIkaOfmkdT3p014xR81U29MJtZiJODwDHCa
 XIGOLeKAaNBt/CDbreImKYkoEyHahZZAD7pSSSW9vzeAxeJ6YSmM6jbEoRKCrQ85PH4w
 BZJwyWOHeIqhc8jJieyUpbeD0bxn8qmTS/lcNl6y/+F7ZzTWHKJeCHg+tG3uaLmIMgnw
 1zHZUyzdFYe5lL/SQwRsDAxILI+79DZ7yJ2VTCdSeZBnsMpROubPXR2AxINRrILAP7dJ
 dsWaFTs3ViN8B2WCW3NKqgEkIhtfh/TkMYppajbw1+dDo6Px6b2kwSVuhcP9zeGnjygS
 WQ/A==
X-Gm-Message-State: APjAAAU108QBNQ3b2li5+qnbEpwRZQbVcnWQ5okH4FiehoDUGGrU1Xme
 kDj0kYxKGyZkZwfVcpgtN6dh5DSEsEu4nF3tYeMU/qczhK2zzRWNUxe6qCaibge3T6U5YaCUsZb
 zg5pz8OkEK7uSm1U=
X-Received: by 2002:adf:fe85:: with SMTP id l5mr43711676wrr.5.1566469719944;
 Thu, 22 Aug 2019 03:28:39 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzcchmnd2d+Q6n3bl7nL/gok1KRpj0qcau6QT0Jbp5sxK2tyfYxaGdUFQWwvZSt7nt5WzCiag==
X-Received: by 2002:adf:fe85:: with SMTP id l5mr43711646wrr.5.1566469719615;
 Thu, 22 Aug 2019 03:28:39 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:21b9:ff1f:a96c:9fb3?
 ([2001:b07:6468:f312:21b9:ff1f:a96c:9fb3])
 by smtp.gmail.com with ESMTPSA id o2sm3335221wmh.9.2019.08.22.03.28.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2019 03:28:39 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20190818225414.22590-1-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <9e7a5fa2-2bf7-f3fe-57d9-680498166bf9@redhat.com>
Date: Thu, 22 Aug 2019 12:28:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190818225414.22590-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 00/15] hw/i386/pc: Do not restrict the
 fw_cfg functions to the PC machine
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
Cc: Yang Zhong <yang.zhong@intel.com>, Samuel Ortiz <sameo@linux.intel.com>,
 Rob Bradford <robert.bradford@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 kvm@vger.kernel.org, Christophe de Dinechin <dinechin@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/08/19 00:53, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi,
>=20
> This is my take at salvaging some NEMU good work.
> Samuel worked in adding the fw_cfg device to the x86-virt NEMU machine.
> This series is inspired by NEMU's commit 3cb92d080835 [0] and adapted
> to upstream style. The result makes the upstream codebase more
> modularizable.
> There are very little logical changes, this is mostly a cleanup
> refactor.
>=20
> Since v3 [3]:
> - Addressed Christophe suggestion (patch #8)
> - Rebased patch #15 since Eduardo merged Like Xu's work between.
>=20
> Since v2 [2]:
> - Addressed MST comments from v2 (only patch #2 modified)
>   - do not use unsigned for enum
>   - do not add unuseful documentation
>=20
> Since v1 [1]:
> - Addressed Li and MST comments
>=20
> $ git backport-diff -u v3
> Key:
> [----] : patches are identical
> [####] : number of functional differences between upstream/downstream p=
atch
> [down] : patch is downstream-only
> The flags [FC] indicate (F)unctional and (C)ontextual differences, resp=
ectively
>=20
> 001/15:[----] [--] 'hw/i386/pc: Use e820_get_num_entries() to access e8=
20_entries'
> 002/15:[----] [-C] 'hw/i386/pc: Extract e820 memory layout code'
> 003/15:[----] [--] 'hw/i386/pc: Use address_space_memory in place'
> 004/15:[----] [-C] 'hw/i386/pc: Rename bochs_bios_init as more generic =
fw_cfg_arch_create'
> 005/15:[----] [--] 'hw/i386/pc: Pass the boot_cpus value by argument'
> 006/15:[----] [--] 'hw/i386/pc: Pass the apic_id_limit value by argumen=
t'
> 007/15:[0002] [FC] 'hw/i386/pc: Pass the CPUArchIdList array by argumen=
t'
> 008/15:[down] 'hw/i386/pc: Remove unused PCMachineState argument in fw_=
cfg_arch_create'
> 009/15:[----] [-C] 'hw/i386/pc: Let pc_build_smbios() take a FWCfgState=
 argument'
> 010/15:[----] [-C] 'hw/i386/pc: Let pc_build_smbios() take a generic Ma=
chineState argument'
> 011/15:[----] [-C] 'hw/i386/pc: Rename pc_build_smbios() as generic fw_=
cfg_build_smbios()'
> 012/15:[----] [--] 'hw/i386/pc: Let pc_build_feature_control() take a F=
WCfgState argument'
> 013/15:[----] [--] 'hw/i386/pc: Let pc_build_feature_control() take a M=
achineState argument'
> 014/15:[----] [--] 'hw/i386/pc: Rename pc_build_feature_control() as ge=
neric fw_cfg_build_*'
> 015/15:[0017] [FC] 'hw/i386/pc: Extract the x86 generic fw_cfg code'
>=20
> Regards,
>=20
> Phil.
>=20
> [0] https://github.com/intel/nemu/commit/3cb92d080835ac8d47c8b713156338=
afa33cff5c
> [1] https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg05759.html
> [2] https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg02786.html
> [3] https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg00193.html
>=20
> Philippe Mathieu-Daud=C3=A9 (15):
>   hw/i386/pc: Use e820_get_num_entries() to access e820_entries
>   hw/i386/pc: Extract e820 memory layout code
>   hw/i386/pc: Use address_space_memory in place
>   hw/i386/pc: Rename bochs_bios_init as more generic fw_cfg_arch_create
>   hw/i386/pc: Pass the boot_cpus value by argument
>   hw/i386/pc: Pass the apic_id_limit value by argument
>   hw/i386/pc: Pass the CPUArchIdList array by argument
>   hw/i386/pc: Remove unused PCMachineState argument in
>     fw_cfg_arch_create
>   hw/i386/pc: Let pc_build_smbios() take a FWCfgState argument
>   hw/i386/pc: Let pc_build_smbios() take a generic MachineState argumen=
t
>   hw/i386/pc: Rename pc_build_smbios() as generic fw_cfg_build_smbios()
>   hw/i386/pc: Let pc_build_feature_control() take a FWCfgState argument
>   hw/i386/pc: Let pc_build_feature_control() take a MachineState
>     argument
>   hw/i386/pc: Rename pc_build_feature_control() as generic
>     fw_cfg_build_*
>   hw/i386/pc: Extract the x86 generic fw_cfg code
>=20
>  hw/i386/Makefile.objs        |   2 +-
>  hw/i386/e820_memory_layout.c |  59 ++++++++++
>  hw/i386/e820_memory_layout.h |  42 ++++++++
>  hw/i386/fw_cfg.c             | 136 +++++++++++++++++++++++
>  hw/i386/fw_cfg.h             |   7 ++
>  hw/i386/pc.c                 | 202 ++---------------------------------
>  include/hw/i386/pc.h         |  11 --
>  target/i386/kvm.c            |   1 +
>  8 files changed, 254 insertions(+), 206 deletions(-)
>  create mode 100644 hw/i386/e820_memory_layout.c
>  create mode 100644 hw/i386/e820_memory_layout.h
>=20

Queued, thanks.

Paolo

