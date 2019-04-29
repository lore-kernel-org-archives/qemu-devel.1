Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA13C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 18:18:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9348A215EA
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 18:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q4Rv5CMC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9348A215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33413 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLArW-000666-Nt
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 14:18:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLAqN-0005l8-2u
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 14:17:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLAqM-0008UU-5V
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 14:17:35 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:42118)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLAqL-0008UO-Uy
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 14:17:34 -0400
Received: by mail-oi1-x243.google.com with SMTP id k9so6076002oig.9
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 11:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=V/dfdmr1zai6GxTGpwqqi2vcy70wnP5fwf7FK/6FQGY=;
	b=q4Rv5CMC98nVoRBjyOMAiWm9SDiYXbmS/4U2HSlGXOjbF0CxePUElqyxuAaNUMNeyg
	S9p304JTuEgLW5ewOfs5+jgx4BIBPizjwPmeqGCLPEsdohxkE3770VSENzIc8nG36V4y
	IvlZDGLanlmpEjY04kwLNEL8yk89U4O1psvEOOiSrdTlefKel8m7T+rCy/5zbMK8dauk
	GROhNV2yM2naY/wchkLXxuNhAwgl5hG9gF4jWRdQkPNFoYa2Wc7b+4gnrhY/Jv81/moT
	azJUKIR9+MevFjfvydTtZApUQdrVcTNbLRebHFIf6xKNsvatk7xmZXPhrPQjJig848gS
	rvnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=V/dfdmr1zai6GxTGpwqqi2vcy70wnP5fwf7FK/6FQGY=;
	b=qU8XgCEOZnjo9h7Gvq6OzMCXaZlm+DKHJ0gjlLM0Q7LMhSJO7YBtWI0g+621avyi3O
	U1yHRLGGzrO++WyO8BxJV3CHiWoxbWWF5hTom1zf5zrvaQcRd0cAdTvRIE0dLXE6vpcJ
	A2ftscvuWfefZT2rm0ImiDVN9EdVOsP1bXYOBU42gCiVJOxIYfiS0EFM8smH+iyqWbnn
	BQZ3b4ZizoOtGU8w4FbU7FXE/Tn15YbGHwNHDSW9eLUpmfmMi605/GMnw8mirN4mXFIt
	XsGlgpMhHBVVI7MnF2bhNyrdRKL5XUddwLSfvVXm585JwRXTWTHE4lg4IPMgR5Krqefu
	g2/w==
X-Gm-Message-State: APjAAAU8hT7rIMbuELx48kIplrkw/V8rxJTCroGGRo4vrRwmsJT8r0y+
	FjgAuE6EAjm221nKNRbELUDUgTrgv/3fUKSL/SwPFYBXE3s=
X-Google-Smtp-Source: APXvYqzSjr82e7GYF0dIEVppqzSQYn7BT1/0Yx6ArvUOw0fOHKiN/xMDtdoadz7B2D9mw2pBdkjOlvrjhQ8z8d72xGk=
X-Received: by 2002:aca:4b04:: with SMTP id y4mr81974oia.170.1556561852905;
	Mon, 29 Apr 2019 11:17:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190318134019.23729-1-peter.maydell@linaro.org>
	<41b21196-5401-898d-4afc-6fffa71d09dd@collabora.com>
	<498af98a-5be0-a589-c7b5-246c4d0ee7ef@collabora.com>
In-Reply-To: <498af98a-5be0-a589-c7b5-246c4d0ee7ef@collabora.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 19:17:21 +0100
Message-ID:
 <CAFEAcA-fzPzZFV_orPL84syTdTqrseHUiwuba9vzrNgz95BHGA@mail.gmail.com>
To: Antonio Ospite <antonio.ospite@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH] configure: Remove --source-path option
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
	"patches@linaro.org" <patches@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429181721.HY4GOUuNKz_nDDlxrhuk-VQ_K8USbErrrjEVvsfpCDQ@z>

On Thu, 25 Apr 2019 at 17:42, Antonio Ospite
<antonio.ospite@collabora.com> wrote:
> Now that 4.0 has been released, maybe we can move on with this minor change.
>
> I will send a fix for https://bugs.launchpad.net/qemu/+bug/1817345 after
> this patch lands.

This patch has just gone in to master, so that should be ok
for you to rebase your patch on now.

thanks
-- PMM

