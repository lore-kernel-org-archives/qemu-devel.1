Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46272C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 09:29:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AAF32083E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 09:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yPwhWFfg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AAF32083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56375 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hE9XS-0000r9-4r
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 05:29:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hE9WY-0000Rs-Tp
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 05:28:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hE9WX-00026k-3K
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 05:28:06 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:41905)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hE9WU-000226-T9
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 05:28:03 -0400
Received: by mail-oi1-x241.google.com with SMTP id v7so1155527oie.8
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 02:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=/tG0y3vVY/SWRlpNZfUF3z94PacdSU10RSQoJxdIRz4=;
	b=yPwhWFfg/Y+hRNY3PkGXRSt1emGrKCOtDCwVKdrhcJ873nc8YZJX0So57/1yGzkT0j
	BzjjeoneL/fvd6cWGMw3SP5CAlxaR4dMQw3npcs5tb8enuyUGg3hanSaBskN7Zw0cHby
	VD7O57XHpbElZ4ZPU1fekL1CFUk+SyOHdNWs2dckHtFP6tS5CQshbMraV4VxJiqij4g8
	fciiRpXq48kIoDT8EKlIPXC+doa/N08b7384Qlx2pO36n3igFxc+dnh9yuxhi9KgUiAE
	DQdzuVxtNyQYBnO9EcXMR9tWUqAzv+4uRcGpxkXyrPREV3EsAMwtFuQ3htZYIE4z2BN6
	ik5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=/tG0y3vVY/SWRlpNZfUF3z94PacdSU10RSQoJxdIRz4=;
	b=JpPy9TAZIygVa73Uv9I/EAcExgK2LF4Hx899AbP40HI+08q0OK0sPNc3eR4eewIGtP
	nXEqpSFRwmCBuQ0YkG/nTRf2SCL9X28TM4l2q7GwE2uh9bMEC5WMzoN4Rj40Sb1TmrFO
	c62tengWzyKXJ8fMdFOVliDM8UBD1kmEkO6LsM4CiYKQFISzIsIjZviwCTyYmnZ3tMP2
	sy7b2rv1x+wecUUG0cxH0bDlVDNjETHx2BQTB3EUsQU2Vj2GshDLZCIs3Yn4ZR5yN9XZ
	HcbojFIkH63Snh0rrNkUSIEH8Dd6Ga1eBWaPE1Z0gUBD5GPAvyIKLlMjuwKmpduLEpWU
	TuYg==
X-Gm-Message-State: APjAAAVwe3SBETgwiYW9jJDXsQo1/9MWIQoJMURkeKrrNXEMK4Xc1QEA
	1l7p/CNEUYh0Hl79kqwyA76jGz004+zxMWHGdQVLRw==
X-Google-Smtp-Source: APXvYqwa4PLNyf+fKthxKbC1OfonMNV6jAIQBPLvpDVMSO7fFgmIpfb5wAGWYiyiFDjOSCRJiYhBh/PP7gYFMvGZe1M=
X-Received: by 2002:aca:e84c:: with SMTP id f73mr1844271oih.163.1554888480907; 
	Wed, 10 Apr 2019 02:28:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190409235401.12671-1-alistair.francis@wdc.com>
In-Reply-To: <20190409235401.12671-1-alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 10 Apr 2019 10:27:49 +0100
Message-ID:
 <CAFEAcA9UxJv4qLz9syMiSgZ5h3zwFUsdPH72DDXV6JhtqriG_A@mail.gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PULL 0/1] device-tree queue
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
Cc: "alistair23@gmail.com" <alistair23@gmail.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410092749.ZcocayJK1mc1TovQz7zxL_rEhipCi3K83EvhwQHOVZc@z>

On Wed, 10 Apr 2019 at 00:55, Alistair Francis <Alistair.Francis@wdc.com> wrote:
>
> The following changes since commit f151f8aca5cf5da24f6eb743a55a2233091ae532:
>
>   migration/ram.c: Fix use-after-free in multifd_recv_unfill_packet() (2019-04-09 20:46:34 +0100)
>
> are available in the Git repository at:
>
>   git@github.com:alistair23/qemu.git tags/pull-device-tree-20190409-1
>
> for you to fetch changes up to 065e6298a75164b4347682b63381dbe752c2b156:
>
>   device_tree: Fix integer overflowing in load_device_tree() (2019-04-09 16:35:40 -0700)
>
> ----------------------------------------------------------------
> Single device tree fix for 4.0
>
> A single patch to avoid an overflow when loading device trees.
>
> ----------------------------------------------------------------
> Markus Armbruster (1):
>       device_tree: Fix integer overflowing in load_device_tree()

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM

