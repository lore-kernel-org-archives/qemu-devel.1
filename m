Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357FDC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:24:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 020BC20409
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bbwwfdvr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 020BC20409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDuPo-0003C6-73
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52523)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sstabellini@kernel.org>) id 1jDtBQ-00048Q-DS
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:05:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sstabellini@kernel.org>) id 1jDtBP-00067h-4Q
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:05:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:46172)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sstabellini@kernel.org>)
 id 1jDtBM-0005Ym-4h; Mon, 16 Mar 2020 13:05:40 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D1ECE2051A;
 Mon, 16 Mar 2020 17:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1584378338;
 bh=SBAgB4tnN5H5EqyYoewhaMY5csYHCmQVwSVf76yy/gs=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=BbwwfdvrJpLp/NaruIf9GnCrZSbOkn0rguWsZRP8XubJ0BcYb1I4HyZTcDujkziS0
 BHqsjjbo5+FN5/KvuxaBSKYIQReW/29r1van7t7IZ3ZjNWnkM2mJVIko32wAkDklr9
 Ak1FL3P/W7gO5l+lUODN2MDa2HvaVn/f5qowIYMg=
Date: Mon, 16 Mar 2020 10:05:37 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v3 18/19] hw/arm: Do not build to 'virt' machine on Xen
In-Reply-To: <20200316160634.3386-19-philmd@redhat.com>
Message-ID: <alpine.DEB.2.21.2003161001510.1269@sstabellini-ThinkPad-T480s>
References: <20200316160634.3386-1-philmd@redhat.com>
 <20200316160634.3386-19-philmd@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1799168742-1584378221=:1269"
Content-ID: <alpine.DEB.2.21.2003161003470.1269@sstabellini-ThinkPad-T480s>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 198.145.29.99
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 kvm@vger.kernel.org, Paul Durrant <paul@xen.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, xen-devel@lists.xenproject.org,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1799168742-1584378221=:1269
Content-Type: text/plain; CHARSET=UTF-8
Content-ID: <alpine.DEB.2.21.2003161003471.1269@sstabellini-ThinkPad-T480s>
Content-Transfer-Encoding: quoted-printable

On Mon, 16 Mar 2020, Philippe Mathieu-Daud=C3=A9 wrote:
> Xen on ARM does not use QEMU machines [*]. Disable the 'virt'
> machine there to avoid odd errors such:
>=20
>     CC      i386-softmmu/hw/cpu/a15mpcore.o
>   hw/cpu/a15mpcore.c:28:10: fatal error: kvm_arm.h: No such file or dir=
ectory
>=20
> [*] https://wiki.xenproject.org/wiki/Xen_ARM_with_Virtualization_Extens=
ions#Use_of_qemu-system-i386_on_ARM


I confirm that what's written on that wikipage is correct: Xen on ARM
doesn't use QEMU for emulation, only as a PV backends provider. As such,
and also because the code is a bit entangled with the x86 platform, even
on ARM we are building and running qemu-system-i386 to get the PV disk
and PV framebuffer. Of course, no x86 emulation is actually done.

Ideally we would have a non-arch-specific machine type for the PV
backends, but that doesn't exist today.

In short, I think this patch is fine, at least until somebody comes
around and tries to add emulation to Xen on ARM.



> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: Paul Durrant <paul@xen.org>
> Cc: xen-devel@lists.xenproject.org
> ---
>  hw/arm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 8e801cd15f..69a8e30125 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -1,5 +1,6 @@
>  config ARM_VIRT
>      bool
> +    depends on !XEN
>      default y if KVM
>      imply PCI_DEVICES
>      imply TEST_DEVICES
> --=20
> 2.21.1
>=20
--8323329-1799168742-1584378221=:1269--

