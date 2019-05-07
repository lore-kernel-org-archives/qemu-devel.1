Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4EBC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 16:17:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E953D2054F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 16:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sK5Kt+dM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E953D2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49585 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO2mv-0003Yx-7g
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 12:17:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hO2lC-0002e0-J4
	for qemu-devel@nongnu.org; Tue, 07 May 2019 12:16:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hO2lA-0001FC-Ha
	for qemu-devel@nongnu.org; Tue, 07 May 2019 12:16:06 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:43552)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hO2l8-0001C7-Hx
	for qemu-devel@nongnu.org; Tue, 07 May 2019 12:16:04 -0400
Received: by mail-oi1-x243.google.com with SMTP id j9so12069562oie.10
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 09:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=1qOu4NnuKmCZdmutocx0nHz6+tgShBICvUB7VzoTKP0=;
	b=sK5Kt+dM9iniXDAbvovy60gGoINVzb3ME/ZbiMQmk5xXDhFR4XjDew+CJ1lwwQ+Mk9
	MukJubFp2JZaKBCWO6NBq+TbnFARLIGuy3vMqkE2XQ0dn37K88MqnVcDsLl83jJS0q18
	hThjMKDGN5EIlDlms415jvYyBeaH/FdRktXDW92neyVs0ny51ClhQ0Ckgq6UDufklIH6
	TDMKH0qoQhhM4WhPnO/rvKWKKMvOpn/4X75ItWqImIk1WXR0L6UvGq3CTfjgcsQBYHfv
	NYsi9jDmwxprXC1OIHzx1KoWPHWoOdTopVZAXGqWEzY0TvXEEQDy84RpLYDOWcq6doMG
	2WbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=1qOu4NnuKmCZdmutocx0nHz6+tgShBICvUB7VzoTKP0=;
	b=Zb3X/sSvE4Y/az6z8Ira++hNAZ8tYuuTNhsDmd7lUAKPFLC3x/81+buNCg/elm0nM1
	ZBJ1VWQd+ZT0kzeurnYFIDxXJAG+4fCRKl3/EdV6d/YZ+K4xj4z2XFNebkV1J6hpFiSf
	2YQ0mOvmnSLDaiNjzOIiT2ur146ke9o5avi/OHnEEGtYjSqjWUuuRq8zvOPuCbGnlnfw
	bZ2UHoujkZjFkmoBEAtmgOi52d5m3nlClUnl735svzbvrlyWJ4r2Sgtminv1YU3n1B5+
	2IkraN6W2pCLgj33WCxT4+UnVfFmQPjJgrOaO3wJ1a/goNDXWn4Wbbayvs/Pqx7ODG0o
	TaYQ==
X-Gm-Message-State: APjAAAXubqe+pvo0/D3FMKg09mAarhrg9MA6K73Nkd9ZTX++GQwoY6RM
	/WWxDFC7HSwDoEprsyUa8Vn9rupgLQpGEv+frLo/qQ==
X-Google-Smtp-Source: APXvYqylcytvWIiYZ4FXF1cw5v5E1q6RB8ZlzNR2J2eKCO8LCpggp067E/8p8IoztCtv0/h4334TDArehMBCwY5lyuo=
X-Received: by 2002:aca:110f:: with SMTP id 15mr685255oir.163.1557245758962;
	Tue, 07 May 2019 09:15:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190504134529.4755-1-marcel.apfelbaum@gmail.com>
In-Reply-To: <20190504134529.4755-1-marcel.apfelbaum@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 May 2019 17:15:47 +0100
Message-ID: <CAFEAcA-FOPxBFW7E_xyJDrcjeu28nuB54Vv5nXLV5C-rAxqksg@mail.gmail.com>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH PULL 0/4] RDMA queue
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
Cc: kamal heib <kamalheib1@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
	Yuval Shaia <yuval.shaia@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 4 May 2019 at 14:45, Marcel Apfelbaum
<marcel.apfelbaum@gmail.com> wrote:
>
> The following changes since commit a6ae23831b05a11880b40f7d58e332c45a6b04f7:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/python-next-pull-request' into staging (2019-05-03 15:26:09 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/marcel-apf/qemu tags/rdma-pull-request
>
> for you to fetch changes up to 355b7cf356b7f506ca1b716647cc0cf19d312fd2:
>
>   hw/pvrdma: Add support for SRQ (2019-05-04 15:55:56 +0300)
>
> ----------------------------------------------------------------
> RDMA queue
>
> * pvrdma: Add support for SRQ
>
> ----------------------------------------------------------------
> Kamal Heib (4):
>       hw/rdma: Add SRQ support to backend layer
>       hw/rdma: Add support for managing SRQ resource
>       hw/rdma: Modify create/destroy QP to support SRQ
>       hw/pvrdma: Add support for SRQ


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

