Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C1AC38A30
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 01:23:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD4322070B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 01:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD4322070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQhd2-0006nu-Ud
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 21:23:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58562)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <colin.xu@intel.com>) id 1jQhcL-00065f-4M
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 21:22:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <colin.xu@intel.com>) id 1jQhcK-0000Fs-NL
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 21:22:28 -0400
Received: from mga02.intel.com ([134.134.136.20]:25842)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <colin.xu@intel.com>)
 id 1jQhcI-0008Pi-62; Mon, 20 Apr 2020 21:22:26 -0400
IronPort-SDR: EQ/cFIJ9igSoq1PataU4vOtpUSTqBOSv6i90qZveAWLSpYOqm242sTnzf0UqP+T6WRGp4+6MHh
 d/jMQGYDoINw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2020 18:22:18 -0700
IronPort-SDR: QQDVJ7mWGKkyOcx1XjoyfCL/7v+jGEFyO87TssAmhUoMmTgdDJlu5YpwU2LNMXn8z/8yaeYIDM
 /jry2KPXL9pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,408,1580803200"; d="scan'208";a="455898509"
Received: from unknown (HELO coxu-arch-shz) ([10.239.160.21])
 by fmsmga005.fm.intel.com with ESMTP; 20 Apr 2020 18:22:15 -0700
Date: Tue, 21 Apr 2020 09:22:15 +0800 (CST)
From: Colin Xu <colin.xu@intel.com>
X-X-Sender: coxu_arch@coxu-arch-shz
To: BEric Blake <eblake@redhat.com>
Subject: Re: [PATCH 1/2] hax: Fix setting of FD_CLOEXEC
In-Reply-To: <20200420175309.75894-2-eblake@redhat.com>
Message-ID: <alpine.LNX.2.22.419.2004210921520.25064@coxu-arch-shz>
References: <20200420175309.75894-1-eblake@redhat.com>
 <20200420175309.75894-2-eblake@redhat.com>
User-Agent: Alpine 2.22 (LNX 419 2020-04-12)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=134.134.136.20; envelope-from=colin.xu@intel.com;
 helo=mga02.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/20 21:22:18
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 134.134.136.20
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
Cc: peter.maydell@linaro.org, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 "open list:X86 HAXM CPUs" <haxm-team@intel.com>, Colin Xu <colin.xu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Wenchao Wang <wenchao.wang@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Looks good to me.

Reviewed-by: Colin Xu <colin.xu@intel.com>

--
Best Regards,
Colin Xu

On Tue, 21 Apr 2020, Eric Blake wrote:

> Blindly setting FD_CLOEXEC without a read-modify-write will
> inadvertently clear any other intentionally-set bits, such as a
> proposed new bit for designating a fd that must behave in 32-bit mode.
> Use our wrapper function instead of an incorrect hand-rolled version.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> target/i386/hax-posix.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/target/i386/hax-posix.c b/target/i386/hax-posix.c
> index 3bad89f13337..5f9d1b803dec 100644
> --- a/target/i386/hax-posix.c
> +++ b/target/i386/hax-posix.c
> @@ -23,7 +23,7 @@ hax_fd hax_mod_open(void)
>         fprintf(stderr, "Failed to open the hax module\n");
>     }
>
> -    fcntl(fd, F_SETFD, FD_CLOEXEC);
> +    qemu_set_cloexec(fd);
>
>     return fd;
> }
> @@ -147,7 +147,7 @@ hax_fd hax_host_open_vm(struct hax_state *hax, int vm_id)
>     fd = open(vm_name, O_RDWR);
>     g_free(vm_name);
>
> -    fcntl(fd, F_SETFD, FD_CLOEXEC);
> +    qemu_set_cloexec(fd);
>
>     return fd;
> }
> @@ -200,7 +200,7 @@ hax_fd hax_host_open_vcpu(int vmid, int vcpuid)
>     if (fd < 0) {
>         fprintf(stderr, "Failed to open the vcpu devfs\n");
>     }
> -    fcntl(fd, F_SETFD, FD_CLOEXEC);
> +    qemu_set_cloexec(fd);
>     return fd;
> }
>
> -- 
> 2.26.1
>
>

