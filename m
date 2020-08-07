Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BBDC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 14:43:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAF87221E2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 14:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxuMd8uk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAF87221E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k43aO-0004Gn-Ty
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 10:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1k43Zq-0003pj-1J
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 10:42:34 -0400
Received: from mail-oo1-xc43.google.com ([2607:f8b0:4864:20::c43]:38935)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1k43Zo-0006o6-9x
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 10:42:33 -0400
Received: by mail-oo1-xc43.google.com with SMTP id x1so463419oox.6
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 07:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:reply-to:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=5XGDUZRBlQY5lpNdCDzrsPYxQla7Z96aDfQeFUfG0Hg=;
 b=YxuMd8ukaUUbGgt/ImNnV94qm0syYK71Q4tdz3bLBJ8H1vaFjapacG9//DZeNBg463
 wUJ5Vkdr6OTiMxdLhkVqCrBy7P4IlQHC5a4+Tsje75YSCUacRrr46F20a/Y8On+sbkIe
 Ch3mQa+PrSq9L22o5zrPyfDdrpduCyEFBk5yftgNoIT7h7mq9YlqLYAQqc/AKDpG4Xbs
 i0yGYM68GMUTv1UG30/PQ7jpCowTJcutvDokktLheU3gUzmrWvgFNcG/XsmonXg+QDQ+
 MVqHWwRaiWYrV2/QqTEPBABlHcZyvYRZ6TOKLQWbnS87eUFUif2TphjUNysREN8Xl9tL
 lYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :reply-to:references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=5XGDUZRBlQY5lpNdCDzrsPYxQla7Z96aDfQeFUfG0Hg=;
 b=AKdVnau91zCTn023SCcAD0biLRRT8TANHvyruixIpOng5N1ABeVYg1mGjQIFgQq6fp
 GBil91EWmFPwjr1dzf0nRYZPwBmXp1serAgICNAruUQaPqvM5MoMp7W3Vh5HIGIFtf3V
 kKUsI7TNtCJ/SZMemyI7SdTG6RUKW6wmVMFNVsAAy4KLo7hvNeNsREdMGUTRSuwNp458
 ZrvW5sW4e683PfPQk2X/fktAZb8OvrXJqLjh7ielprUpKa2kutKeDiH5XhWMuM2BChnn
 AbVKlRj88ElKnY9I65QvDw7PUl4zRXP32k9IwWi7JV3z2Hg0tMHYELJBg9P+x4ULCCdf
 v1PA==
X-Gm-Message-State: AOAM5330lvpNOAp0LyQoEYP91ykJiU+9CAd3Tkdch3lQH1G03x7+HaZm
 OZTbjxJxQDuQtb0bF/MxjgjDLa4=
X-Google-Smtp-Source: ABdhPJwwiWZ3vEqVPAwQ2S/cZ5oW5gVJt08emIuE4HHXIbsub0TLF3bVXr56zeb1V0n/eT0ZQr0bnA==
X-Received: by 2002:a4a:ce93:: with SMTP id f19mr13042176oos.15.1596811350164; 
 Fri, 07 Aug 2020 07:42:30 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
 by smtp.gmail.com with ESMTPSA id x143sm1819892oia.12.2020.08.07.07.42.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2020 07:42:29 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:c8ac:a9c:4367:4c28])
 by serve.minyard.net (Postfix) with ESMTPSA id 286ED18055B;
 Fri,  7 Aug 2020 14:42:28 +0000 (UTC)
Date: Fri, 7 Aug 2020 09:42:27 -0500
From: Corey Minyard <minyard@acm.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 106/143] meson: convert hw/ipmi
Message-ID: <20200807144227.GK2842@minyard.net>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <1596741379-12902-107-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1596741379-12902-107-git-send-email-pbonzini@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=2607:f8b0:4864:20::c43;
 envelope-from=tcminyard@gmail.com; helo=mail-oo1-xc43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Reply-To: minyard@acm.org
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 06, 2020 at 09:15:42PM +0200, Paolo Bonzini wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

I looked at all the configure names and files and everything
looks correct.

Reviewed-by: Corey Minyard <cminyard@mvista.com>

> ---
>  hw/Makefile.objs      |  1 -
>  hw/ipmi/Makefile.objs |  8 --------
>  hw/ipmi/meson.build   | 11 +++++++++++
>  hw/meson.build        |  1 +
>  4 files changed, 12 insertions(+), 9 deletions(-)
>  delete mode 100644 hw/ipmi/Makefile.objs
>  create mode 100644 hw/ipmi/meson.build
> 
> diff --git a/hw/Makefile.objs b/hw/Makefile.objs
> index a28e211..f136377 100644
> --- a/hw/Makefile.objs
> +++ b/hw/Makefile.objs
> @@ -15,7 +15,6 @@ devices-dirs-y += ide/
>  devices-dirs-y += input/
>  devices-dirs-y += intc/
>  devices-dirs-$(CONFIG_IPACK) += ipack/
> -devices-dirs-$(CONFIG_IPMI) += ipmi/
>  endif
>  
>  common-obj-y += $(devices-dirs-y)
> diff --git a/hw/ipmi/Makefile.objs b/hw/ipmi/Makefile.objs
> deleted file mode 100644
> index 3cca10b..0000000
> --- a/hw/ipmi/Makefile.objs
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -common-obj-$(CONFIG_IPMI) += ipmi.o ipmi_kcs.o ipmi_bt.o
> -common-obj-$(CONFIG_IPMI_LOCAL) += ipmi_bmc_sim.o
> -common-obj-$(CONFIG_IPMI_EXTERN) += ipmi_bmc_extern.o
> -common-obj-$(CONFIG_ISA_IPMI_KCS) += isa_ipmi_kcs.o
> -common-obj-$(CONFIG_PCI_IPMI_KCS) += pci_ipmi_kcs.o
> -common-obj-$(CONFIG_ISA_IPMI_BT) += isa_ipmi_bt.o
> -common-obj-$(CONFIG_PCI_IPMI_BT) += pci_ipmi_bt.o
> -common-obj-$(CONFIG_IPMI_SSIF) += smbus_ipmi.o
> diff --git a/hw/ipmi/meson.build b/hw/ipmi/meson.build
> new file mode 100644
> index 0000000..9622ea2
> --- /dev/null
> +++ b/hw/ipmi/meson.build
> @@ -0,0 +1,11 @@
> +ipmi_ss = ss.source_set()
> +ipmi_ss.add(when: 'CONFIG_IPMI', if_true: files('ipmi.c', 'ipmi_kcs.c', 'ipmi_bt.c'))
> +ipmi_ss.add(when: 'CONFIG_IPMI_LOCAL', if_true: files('ipmi_bmc_sim.c'))
> +ipmi_ss.add(when: 'CONFIG_IPMI_EXTERN', if_true: files('ipmi_bmc_extern.c'))
> +ipmi_ss.add(when: 'CONFIG_ISA_IPMI_KCS', if_true: files('isa_ipmi_kcs.c'))
> +ipmi_ss.add(when: 'CONFIG_PCI_IPMI_KCS', if_true: files('pci_ipmi_kcs.c'))
> +ipmi_ss.add(when: 'CONFIG_ISA_IPMI_BT', if_true: files('isa_ipmi_bt.c'))
> +ipmi_ss.add(when: 'CONFIG_PCI_IPMI_BT', if_true: files('pci_ipmi_bt.c'))
> +ipmi_ss.add(when: 'CONFIG_IPMI_SSIF', if_true: files('smbus_ipmi.c'))
> +
> +softmmu_ss.add_all(when: 'CONFIG_IPMI', if_true: ipmi_ss)
> diff --git a/hw/meson.build b/hw/meson.build
> index 8659854..9796f95 100644
> --- a/hw/meson.build
> +++ b/hw/meson.build
> @@ -1,4 +1,5 @@
>  subdir('core')
> +subdir('ipmi')
>  subdir('isa')
>  subdir('mem')
>  subdir('misc')
> -- 
> 1.8.3.1
> 
> 
> 

