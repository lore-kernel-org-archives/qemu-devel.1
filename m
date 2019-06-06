Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E9CC04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 22:26:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A2D720673
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 22:26:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A2D720673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44668 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZ0pl-0003Ol-Dt
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 18:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33898)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hZ0o0-0002kV-67
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 18:24:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hZ0nx-0003En-LV
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 18:24:18 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38894)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hZ0nx-0003Da-Fs
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 18:24:17 -0400
Received: by mail-wm1-f67.google.com with SMTP id t5so72741wmh.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 15:24:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4W8s0UUSsbia5JFej7oLovkxHqkCDia84BRDyGy5jVw=;
 b=ewyJJp7R+OCfwgBlF2JIAoH/gRLaQhLIKSzumUG+pckDPD5xdNsq0XOHz6D+KHYEBZ
 yvyLOhyh8cAA4vBGS+9twCbq7ZH6rQHA0RkZ5rcyMXOwvtHpjussb2IAD3HCsg9kNh8I
 803Hu7+IO/aPb+1RxYeydf1aVh3czNfjNT7l0rwLiubaxt8sIpFMNtp/8ZOMtZ28T3/p
 M26Kei9+ZjBBzk+5i0M0LRmvijAUrSC5WHXRnRnWcsyZmwRCVSiITv8qQ6Fhapq4HeWQ
 6S8HAwbFp5zurhciSrzLEWVixGSPZBE0S+/nMJF08nnYKdLeZVcbL3Ar8Np6YbQFTM2k
 N+CA==
X-Gm-Message-State: APjAAAWlunbvWSPNsuPvUNCmFzvNIV3Pt+2Ys/K6BIENQks/mXAb/8Lp
 SxDmcQpgRaurY8AcSs0tos3dnw==
X-Google-Smtp-Source: APXvYqxEecmnvfcSYmyt1MFgy5lX/RPm+b1obqITPjjbPWxnVV2fDR5oqLNCtpM4rpE/yby2EUgBXA==
X-Received: by 2002:a7b:c933:: with SMTP id h19mr1511060wml.52.1559859855902; 
 Thu, 06 Jun 2019 15:24:15 -0700 (PDT)
Received: from [192.168.0.156] ([78.192.181.46])
 by smtp.gmail.com with ESMTPSA id n4sm148668wmk.41.2019.06.06.15.24.15
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Jun 2019 15:24:15 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190606172408.18399-1-armbru@redhat.com>
 <20190606172408.18399-4-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <a164a196-ad0b-63c2-dd60-1db28a328a01@redhat.com>
Date: Fri, 7 Jun 2019 00:24:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190606172408.18399-4-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH v2 3/3] MAINTAINERS: Polish headline
 decorations
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
Cc: aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/6/19 7:24 PM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  MAINTAINERS | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bdc82c5735..6dc5b5cb67 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -65,7 +65,7 @@ F: *
>  F: */
>  
>  Responsible Disclosure, Reporting Security Issues
> -------------------------------
> +-------------------------------------------------
>  W: https://wiki.qemu.org/SecurityProcess
>  M: Michael S. Tsirkin <mst@redhat.com>
>  L: secalert@redhat.com
> @@ -106,8 +106,8 @@ K: ^Subject:.*(?i)s390x?
>  T: git https://github.com/cohuck/qemu.git s390-next
>  L: qemu-s390x@nongnu.org
>  
> -Guest CPU cores (TCG):
> -----------------------
> +Guest CPU cores (TCG)
> +---------------------
>  Overall TCG CPUs
>  M: Richard Henderson <rth@twiddle.net>
>  R: Paolo Bonzini <pbonzini@redhat.com>
> @@ -342,9 +342,8 @@ M: Alex Bennée <alex.bennee@linaro.org>
>  S: Maintained
>  F: tests/tcg/multiarch/
>  
> -Guest CPU Cores (KVM):
> -----------------------
> -
> +Guest CPU Cores (KVM)
> +---------------------
>  Overall KVM CPUs
>  M: Paolo Bonzini <pbonzini@redhat.com>
>  L: kvm@vger.kernel.org
> @@ -400,9 +399,8 @@ S: Supported
>  F: target/i386/kvm.c
>  F: scripts/kvm/vmxcap
>  
> -Guest CPU Cores (Xen):
> -----------------------
> -
> +Guest CPU Cores (Xen)
> +---------------------
>  X86 Xen CPUs
>  M: Stefano Stabellini <sstabellini@kernel.org>
>  M: Anthony Perard <anthony.perard@citrix.com>
> @@ -423,9 +421,8 @@ F: include/hw/block/dataplane/xen*
>  F: include/hw/xen/
>  F: include/sysemu/xen-mapcache.h
>  
> -Hosts:
> -------
> -
> +Hosts
> +-----
>  LINUX
>  M: Michael S. Tsirkin <mst@redhat.com>
>  M: Cornelia Huck <cohuck@redhat.com>
> @@ -462,6 +459,7 @@ X: qga/*win32*
>  F: qemu.nsi
>  
>  Alpha Machines
> +--------------
>  M: Richard Henderson <rth@twiddle.net>
>  S: Maintained
>  F: hw/alpha/
> @@ -1196,7 +1194,7 @@ F: hw/s390x/s390-pci*
>  L: qemu-s390x@nongnu.org
>  
>  UniCore32 Machines
> --------------
> +------------------
>  PKUnity-3 SoC initramfs-with-busybox
>  M: Guan Xuetao <gxt@mprc.pku.edu.cn>
>  S: Maintained
> 

Next step is to teach ./scripts/get_maintainer.pl how to process YAML...

FWIW:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


