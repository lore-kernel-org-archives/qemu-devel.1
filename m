Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9A3C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 16:05:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 667DB20815
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 16:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MoxEbmrU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 667DB20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60600 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRItF-0005Zt-HY
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 12:05:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRIsJ-00054X-OD
	for qemu-devel@nongnu.org; Thu, 16 May 2019 12:04:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRIsI-0008Jp-SL
	for qemu-devel@nongnu.org; Thu, 16 May 2019 12:04:55 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:39095)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hRIsI-0008H1-K2
	for qemu-devel@nongnu.org; Thu, 16 May 2019 12:04:54 -0400
Received: by mail-oi1-x235.google.com with SMTP id v2so2924182oie.6
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 09:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=OFEgS7JhQ7rzDZLcbKHLukzwFmZpJhmaLtTqXck6oQo=;
	b=MoxEbmrUeir7Oba+cOYXGOudjAUMsQs3bJp6DOubdJOsFAhNoCrZrWJ5kKVxQcV1qM
	PgJiTcBZWm3ALdH9iTMIak5fuDj+l9QK8GF1UDiftJdansSPDGq3TN5aOYmgNS3GQXOm
	Ywgba6gv1WImOv0EVvH58e+1MQf44Ugv+/5DrBw9r68eewuGim3FGjIGr9jF2M1I/U8G
	3cvpy59Lf98hGdE/UY+CZaB0BmCIoDopN+0x/4piSqeC5AEC5qtjEpD9sbCCQBy73tCh
	j/LxXCGzj9O9eTMK3q9060lS4QnaaIMr17YPDnJLk48SmolJJwamdkQtSDMRZzffmD0q
	1GKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=OFEgS7JhQ7rzDZLcbKHLukzwFmZpJhmaLtTqXck6oQo=;
	b=Y8bBxsttY0qSIjNnK/9TezSFlGqQKcZuA52arXpXwknyPOBz/hzEufDYkQ6W63b2dn
	NO7ecrLupcQXVXfi4hjpvupx5IkFi0pFg0ajUhrOugBiAlvX1jo655XgIWf0/PuiMoMs
	hEOhIJJ4XByg1CNBIevqKpeUvnsJBcpNpR4fXKCw95HWB7jUihkCDF1VKBlU0Sswg5tf
	qydliO4ZoqANn3DSWvbGcmPLC5smwNVpLJ83yOeo+0ZxeyijY3SQppTvykureAfyyI4l
	fKlimLt+ountsTIz6t90DLYXMcbqpUdjoRGzAOW0aSweqTstV7DlmoscQYWqIrBZT1At
	8vWA==
X-Gm-Message-State: APjAAAVIHY6uFLbM+NhM1YzKhjgIj88Y+hDk+ApoOO0axOqielNjlnUC
	aaEifIlM2ubGqIv1upkeHHs3E+hw7LTeLogmsQnV0g==
X-Google-Smtp-Source: APXvYqwbIr2JSP/BIfaZ+7cvz3Mio65u8c37O2tAljjgNvlLUdqNIPGTCnJvJt2y8kEyKtg1EwZ7zKahumgVFIawAGo=
X-Received: by 2002:aca:b1c1:: with SMTP id a184mr11614283oif.98.1558022693434;
	Thu, 16 May 2019 09:04:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190515121146.7248-1-mst@redhat.com>
In-Reply-To: <20190515121146.7248-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 May 2019 17:04:42 +0100
Message-ID: <CAFEAcA95Uh=j+vGCT08+ztAc5Yk8RWGzApDZrrt5DS7XudGQhQ@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::235
Subject: Re: [Qemu-devel] [PULL 00/37] pci, pc, virtio: features, fixes
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 May 2019 at 13:17, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> The following changes since commit efb4f3b62c69383a7308d7b739a3193e7c0ccae8:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-05-10 14:49:36 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 0534d255dae78450d90d59db0f3a9a46b32ebd73:
>
>   tests: acpi: print error unable to dump ACPI table during rebuild (2019-05-14 21:19:14 -0400)
>
> ----------------------------------------------------------------
> pci, pc, virtio: features, fixes
>
> reconnect for vhost blk
> tests for UEFI
> misc other stuff
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ----------------------------------------------------------------

Hi -- this pullreq has a conflict in default-configs/arm-softmmu.mak
because the conversion of arm to Kconfig has landed in master.
Could you rebase and fix up to use whatever the Kconfig
equivalent of these changes is, please?

thanks
-- PMM

