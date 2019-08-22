Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12231C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 14:19:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE38A21743
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 14:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XaQ2MYdt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE38A21743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0nvj-0005Tc-Np
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 10:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52058)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i0nnh-0005DL-FP
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 10:10:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i0nng-0001V4-1P
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 10:10:53 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46396)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i0nnf-0001UR-QT
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 10:10:51 -0400
Received: by mail-ot1-x341.google.com with SMTP id z17so5515212otk.13
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 07:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QeJQw4K3euzu5HhMiPjWu6YVohBTKbFjPTHQ94tefLA=;
 b=XaQ2MYdtZHY/slEa1DTJQSvCSjeWci1i/bJKIMMfoB+thTLriJPHXGMis4RGApQ/b/
 MHfBhfqxHqsTy2p18MAxKXLcn9I8vWTdh1JmL/h1HOVHVw2I5/3DblQfaPEyxF/6gotv
 Xym4QJEca+CPK8gVU5UA3ALyAvRIonni8RSBPC5Hp/FUYZKhH7H4AKPoCKy0EA8cJg4Y
 CPSlgkFhk2rPxJ0ucZQVwNVn+mLYZb0HT/NgqXp2dJ849g0BequezP/jTZ03YYdTOEsI
 RTq06BLz37bpNGMl270HLfAJXpRmzZ0J4hfIx6LtuRSrchDQeZ/ygfTo6G+Mn40+PxDk
 rTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QeJQw4K3euzu5HhMiPjWu6YVohBTKbFjPTHQ94tefLA=;
 b=mtj44KwsFOi5Y2wM1RP2Q3aqjI0tt/TuOAG7ye+AFq5+ys6WZ+LWuF+pPhb4K0Ho+x
 TbPc28byAwnu0GDJZyOsIkWUfdGeNn3G2Bg79Yrooj5uH/q0uwp0rYinJQ0B0P6XojaL
 lWT6sL5EmAB0qGWmhJhSgy0zMAKPBDFy9MhvF/kLHFSaWiS6fI9y7cXVt+F7rBh96OAd
 4lIPH2QXwDYJZV8pEZ6mm7GXTo041ORrTjp6RgxhAJLZM/kFWkzWsc9eJ33DweU0x8PG
 XvkhGtc0apt9i8PzmrbIfZAhOctGOpCuZFkHSZryvzkUZ6pBC+fHdSw49jznwRLvsEm2
 /7+Q==
X-Gm-Message-State: APjAAAUKmD5kstrB1JsEh6csBcXzqBxFZ7r+Fb0ZmijxHV9Dev5kTroR
 rYVzZsiRIvFRZ55rZ1cdvU1Eh2yR4+IV9lO5oSI92Q==
X-Google-Smtp-Source: APXvYqx8qMYvRXKUTNiKdqOD4hpCOnBZWokbiK4PrAc1yn6XXiCgFi1g7kUECd+EQsrk7UmGx2BoLQEB5rOBCv1PukM=
X-Received: by 2002:a9d:4817:: with SMTP id c23mr2170444otf.97.1566483050774; 
 Thu, 22 Aug 2019 07:10:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190822044218.9374-1-kraxel@redhat.com>
In-Reply-To: <20190822044218.9374-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Aug 2019 15:10:39 +0100
Message-ID: <CAFEAcA-nS5CFQL-mHPeG_kwGCUSED2DotNv=2ZUgWLBHkjOaqQ@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PULL 0/2] Ui 20190822 patches
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 22 Aug 2019 at 05:43, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 17dc57990320edaad52ac9ea808be9719c91cea6:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2019-08-20' into staging (2019-08-20 14:14:20 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/ui-20190822-pull-request
>
> for you to fetch changes up to a923b471fc59389e49575f38f4db3cd622619bf5:
>
>   input-linux: add shift+shift as a grab toggle (2019-08-21 12:25:46 +0200)
>
> ----------------------------------------------------------------
> curses: assert get_wch return value is okay
> input-linux: add shift+shift as a grab toggle
>
> ----------------------------------------------------------------
>
> Niklas Haas (1):
>   input-linux: add shift+shift as a grab toggle
>
> Paolo Bonzini (1):
>   curses: assert get_wch return value is okay
>
>  ui/curses.c      | 2 ++
>  ui/input-linux.c | 4 ++++
>  qapi/ui.json     | 3 ++-
>  3 files changed, 8 insertions(+), 1 deletion(-)
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

