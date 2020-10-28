Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94709C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 21:18:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D742724838
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 21:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0y3+ShvR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D742724838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXsqD-0004JJ-Nf
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 17:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1kXspI-0003pd-1f
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 17:17:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:40388)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1kXspF-0007II-Rk
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 17:17:47 -0400
Received: from sstabellini-ThinkPad-T480s (c-24-130-65-46.hsd1.ca.comcast.net
 [24.130.65.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1C4002475E;
 Wed, 28 Oct 2020 21:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603919862;
 bh=Ph8XcSSlJE5u0Y736qvOrXbypgMNew09pxLwuxA4xHw=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=0y3+ShvRVvEGTexjrR0J3KR3tP6CIxCP+fR75LVZNzBedro+iprfmQvtYaVKThdgQ
 pH8OqGZJiMQgwmiLwd7UxI+41Qkjlhi22JpEhxk/tY03BBTPFGIOuHpkqJ6Ur/Jmzp
 Z3MmXYsi6RxL3kQK6u7g/vFq6+2ypmaW9N7Rh3Pg=
Date: Wed, 28 Oct 2020 14:17:41 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] meson.build: fix building of Xen support for aarch64
In-Reply-To: <20201028174406.23424-1-alex.bennee@linaro.org>
Message-ID: <alpine.DEB.2.21.2010281406080.12247@sstabellini-ThinkPad-T480s>
References: <20201028174406.23424-1-alex.bennee@linaro.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-857674193-1603919862=:12247"
Received-SPF: pass client-ip=198.145.29.99;
 envelope-from=sstabellini@kernel.org; helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 17:17:42
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>, Paul Durrant <paul@xen.org>,
 qemu-devel@nongnu.org, Anthony Perard <anthony.perard@citrix.com>,
 xen-devel@lists.xenproject.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-857674193-1603919862=:12247
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 28 Oct 2020, Alex Bennée wrote:
> Xen is supported on aarch64 although weirdly using the i386-softmmu
> model. Checking based on the host CPU meant we never enabled Xen
> support. It would be nice to enable CONFIG_XEN for aarch64-softmmu to
> make it not seem weird but that will require further build surgery.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Masami Hiramatsu <masami.hiramatsu@linaro.org>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: Paul Durrant <paul@xen.org>
> Fixes: 8a19980e3f ("configure: move accelerator logic to meson")
> ---
>  meson.build | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/meson.build b/meson.build
> index 835424999d..f1fcbfed4c 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -81,6 +81,8 @@ if cpu in ['x86', 'x86_64']
>      'CONFIG_HVF': ['x86_64-softmmu'],
>      'CONFIG_WHPX': ['i386-softmmu', 'x86_64-softmmu'],
>    }
> +elif cpu in [ 'arm', 'aarch64' ]
> +  accelerator_targets += { 'CONFIG_XEN': ['i386-softmmu'] }
>  endif

This looks very reasonable -- the patch makes sense.


However I have two questions, mostly for my own understanding. I tried
to repro the aarch64 build problem but it works at my end, even without
this patch. I wonder why. I suspect it works thanks to these lines in
meson.build:

  if not get_option('xen').disabled() and 'CONFIG_XEN_BACKEND' in config_host
    accelerators += 'CONFIG_XEN'
    have_xen_pci_passthrough = not get_option('xen_pci_passthrough').disabled() and targetos == 'linux'
  else
    have_xen_pci_passthrough = false
  endif

But I am not entirely sure who is adding CONFIG_XEN_BACKEND to
config_host.


The other question is: does it make sense to print the value of
CONFIG_XEN as part of the summary? Something like:

diff --git a/meson.build b/meson.build
index 47e32e1fcb..c6e7832dc9 100644
--- a/meson.build
+++ b/meson.build
@@ -2070,6 +2070,7 @@ summary_info += {'KVM support':       config_all.has_key('CONFIG_KVM')}
 summary_info += {'HAX support':       config_all.has_key('CONFIG_HAX')}
 summary_info += {'HVF support':       config_all.has_key('CONFIG_HVF')}
 summary_info += {'WHPX support':      config_all.has_key('CONFIG_WHPX')}
+summary_info += {'XEN support':      config_all.has_key('CONFIG_XEN')}
 summary_info += {'TCG support':       config_all.has_key('CONFIG_TCG')}
 if config_all.has_key('CONFIG_TCG')
   summary_info += {'TCG debug enabled': config_host.has_key('CONFIG_DEBUG_TCG')}


But I realize there is already:

summary_info += {'xen support':       config_host.has_key('CONFIG_XEN_BACKEND')}

so it would be a bit of a duplicate
--8323329-857674193-1603919862=:12247--

