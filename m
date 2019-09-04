Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339A1C3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 09:22:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB91F22DBF
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 09:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mnQHayLN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB91F22DBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5RUz-0007Qn-4u
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 05:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41727)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i5ROS-0008Nm-GV
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 05:16:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i5ROR-0006lh-21
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 05:16:00 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:34453)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i5ROQ-0006lT-SJ
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 05:15:59 -0400
Received: by mail-ot1-x335.google.com with SMTP id c7so19935969otp.1
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 02:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5202wWqMhcjrZ2T5M46VXo9W3WUwT+15a5glYrw4PuQ=;
 b=mnQHayLNbTgXBAYa66DTA/rtXRL/zjYGBOz06dhDfdti4SMtzuW+URZQoHmpEAPTzs
 tduxj8kuRyYpz/GuBcKO2M7tV3o7uutKBaVZUsdaFhQsnqk08xhfM6cR4v9JeRzmEHLO
 1tVH3avglZ57tep1IitbXE2haKV37W3oF9RFXkIpJ1X2ozowJK/sz5/3eyYEUHZLW43z
 I/vjpAhAXTqyh8ohcdtvFbS4azvJYiVmVqSRs3MZswAcYFCsibsVKEd81IGI3KCSjq6W
 txmb/nIfsIPqSJOhiw+rIDI+Jf0AB+PIW8kcUZy93KVzmpC1+G2DXZ/P271BgNmCtZ6s
 YikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5202wWqMhcjrZ2T5M46VXo9W3WUwT+15a5glYrw4PuQ=;
 b=W8V99nm3ztKeuLfjN7gbIr0+HnJDV9SfcNI7d6PcZd9qIBZQfdY24KKXAzpNJzuJh/
 fPoUbwOVEW3mzC9TDFVCbyMvxysGGf63Docp1EyFHt+qDxnB5IVZonc4eqTx2yb9Z0/s
 RXs7sp+IH8h/7qfSTe9/w0JRZQ13g/NtLvR5LPgUWHDZMh6iYlhCbC8YssJDQFAlUDID
 QlcyGXgnPU115Kc6Om+8Z4q36FafpKfuTf6b+MdEYQ6ew+4nkIFVX6OlHdJ0T0utMAAx
 x6OPoLzZqo3MGbE12+DecyFRdW3KbRfgTDrgOA3/xtf/ZSAuLBeG0SFskC057b2Fv/Ed
 ZYhQ==
X-Gm-Message-State: APjAAAU2ApKU1lfDLz97Y71Nh2yqjknpOaVHiK68VutohkO/5iYyEs6v
 6p44PlBeasrSyTOxu7OH5UHnmgmhqrNFALQP6tTcig==
X-Google-Smtp-Source: APXvYqwaI54CzoRjm+FIbgo86vUR8lNe2/4LjTfsa273z6ax68NIluMpyU9z8ycMXLty7HIS1CFkUtU+kfKcpHQKeUk=
X-Received: by 2002:a9d:5e10:: with SMTP id d16mr32587182oti.91.1567588557854; 
 Wed, 04 Sep 2019 02:15:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190829071016.16589-1-kraxel@redhat.com>
In-Reply-To: <20190829071016.16589-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 4 Sep 2019 10:15:47 +0100
Message-ID: <CAFEAcA86UrdAt0hVVk_BHDDFK3EO_b04CCrGxYjOwpcNvr-8tw@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::335
Subject: Re: [Qemu-devel] [PULL 0/3] Usb 20190829 patches
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 29 Aug 2019 at 08:12, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 23919ddfd56135cad3cb468a8f54d5a595f024f4:
>
>   Merge remote-tracking branch 'remotes/aperard/tags/pull-xen-20190827' into staging (2019-08-27 15:52:36 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/usb-20190829-pull-request
>
> for you to fetch changes up to e4c1c64112565a9be50008e6f28dbc41b53da740:
>
>   usb-mtp: add sanity checks on rootdir (2019-08-29 07:31:12 +0200)
>
> ----------------------------------------------------------------
> usb: bugfixes for xhci and mtp.
>
> ----------------------------------------------------------------
>
> Bandan Das (1):
>   usb-mtp: add sanity checks on rootdir
>
> Ying Fang (1):
>   xhci: Fix memory leak in xhci_address_slot
>
> fangying (1):
>   xhci: Fix memory leak in xhci_kick_epctx


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

