Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BFBC43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 18:12:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E53F52075E
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 18:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F+/tat/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E53F52075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33348 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLAkw-0004R0-Tl
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 14:11:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLAkA-00048c-CO
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 14:11:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLAk9-0004bx-Bj
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 14:11:10 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b]:40610)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLAk9-0004ak-5A
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 14:11:09 -0400
Received: by mail-oi1-x22b.google.com with SMTP id y64so3544188oia.7
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 11:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to; 
	bh=wAs8yKbmb+WFcfWcQH4Zcd4+rxWAwxu2qHNOEffpdNY=;
	b=F+/tat/nHGUbmLhBU/GZ+p/srjClMMKPRBg0ucxabT1QL+/+IKadGkWQ4JP1Qfs+E9
	Zx/WPW8umknuxRcVsAgeLpT8h5yvmm4OqOj/dhNHsm3L0xSRF8ZhCOy5Dt3TPaIyvY+u
	r2CICss20da7n4Q4a9dx4R8J7gCOArNoL7MArSkohhcza48Hy5+foQ5ihMjbZlIDwtnY
	Bh3SY+helHCppyxw8leUkcz2+D2K+8wa15deJrub10DYNFA0AqPgIejJbyv55cdVyeX9
	UfKHpKSsUapO7vwQLxNzUSHCH1M5HWPzNMcxLHMk/I4G6CP3xbcg7O+e5AvwNC28p2Y8
	JUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to;
	bh=wAs8yKbmb+WFcfWcQH4Zcd4+rxWAwxu2qHNOEffpdNY=;
	b=Hv00rQvKeV+9BtEsCp2fP36kwWtR8ijQ0EJw/7x3l5KVwHBuHMxPrCj2hG/AjteDNr
	QReeAMtNOJsj5R2eoVpyROlpkCAaplIS+cVe8sPJkhLD2LAAWLFatCjEsA9RLkX/RwV1
	ujqQZKYTY1jHiJC3NSFs6ppblznLEe7y2JgrSMErBFUTpEVtEA3nj0i7x1yRp6MDhSHR
	oWrUgtCui7A8GMYbye29em+Oip/80GjM+7wuz19znIhCUHaSzveGoDBap2NkpELYr166
	7tLETu3YNuTcwzeLDmWF+J7p+6ITh58a/J4DuEc23VSEgbA9ILDonyBiYoFmc/6slgjM
	dqRg==
X-Gm-Message-State: APjAAAWkClePw8UdBJ1jmZNfTz0X8ASij5gCQNN45JBs+jyE3uHukDPr
	r4hjhmlQgrrXK3/KMIT1/t37ya5z3TX98Tm6HYFP1/jP2JI=
X-Google-Smtp-Source: APXvYqwdHRijWAvRsAOokYB1WiMvGoYn5tCeRqLKgD1E4vKePL6Y2K47VRog610gVYTZUvjqZQAatHJTyOYPMhGQZps=
X-Received: by 2002:aca:e054:: with SMTP id x81mr267534oig.146.1556561467744; 
	Mon, 29 Apr 2019 11:11:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190429170030.11323-1-peter.maydell@linaro.org>
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 19:10:56 +0100
Message-ID:
 <CAFEAcA_8mp6k+jQUjtcwKxKEFq3wcvqAFwiOpnLw8nRg+tQexQ@mail.gmail.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::22b
Subject: Re: [Qemu-devel] [PULL 00/42] target-arm queue
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429181056.bjUInrHu-YtF5vQeCR4oT7Orw_1LEaLJISiBGJ11PP8@z>

On Mon, 29 Apr 2019 at 18:00, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> First pullreq for arm of the 4.1 series, since I'm back from
> holiday now. This is mostly my M-profile FPU series and Philippe's
> devices.h cleanup. I have a pile of other patchsets to work through
> in my to-review folder, but 42 patches is definitely quite
> big enough to send now...
>
> thanks
> -- PMM
>
> The following changes since commit 413a99a92c13ec408dcf2adaa87918dc81e890c8:
>
>   Add Nios II semihosting support. (2019-04-29 16:09:51 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20190429
>
> for you to fetch changes up to 437cc27ddfded3bbab6afd5ac1761e0e195edba7:
>
>   hw/devices: Move SMSC 91C111 declaration into a new header (2019-04-29 17:57:21 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * remove "bag of random stuff" hw/devices.h header
>  * implement FPU for Cortex-M and enable it for Cortex-M4 and -M33
>  * hw/dma: Compile the bcm2835_dma device as common object
>  * configure: Remove --source-path option
>  * hw/ssi/xilinx_spips: Avoid variable length array
>  * hw/arm/smmuv3: Remove SMMUNotifierNode
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

