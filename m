Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76DFCA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 21:46:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAA9421479
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 21:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xb/K1Vdf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAA9421479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPCq3-0005Xw-Fv
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 17:46:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45630)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iPCoJ-0003x4-A2
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 17:44:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iPCmZ-0000cC-TL
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 17:42:36 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:45730)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iPCmZ-0000by-NU
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 17:42:35 -0400
Received: by mail-ot1-x331.google.com with SMTP id 41so7960084oti.12
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 14:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=V2QgTJr483weyOkQKLL7mmZW8bZhXF+1OEJIP2UDq8g=;
 b=xb/K1Vdfhwh85oag5DJQmOn5gqktU8kdMCtBYxfFzWIUjwP5VERkowsm39mL5wzlrG
 2JEAX4C3EpGiNwQMvWEVreg4gZ4MqKJ+NCrCurz6xD2weCneccPYP9bMNSrrg/LcTxZJ
 FmMVqFzX2TKgA2i6l9MPki5ymWEKQNgxU23b8s07ORoRTCkBdFJYab8TtwHz45qsd0ZK
 TnRQ4eKYWo+6jd/64VD+NEuj7PkbPdI/ZFfThPD6z18FG4BQJxqE9dnyAclC2gkdq4RM
 QsWfnleiK/XCHo0WM07JaGeW1cQYmQYgBsNtBNmI7W6KpJaq6nPUZDufoYHL7hF9P8qS
 wIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=V2QgTJr483weyOkQKLL7mmZW8bZhXF+1OEJIP2UDq8g=;
 b=Fb3JIInPoNbMD7t8brgSzwXyMA7J4L+p8ypyu1MFxedapUWq1VvtERKlJ73e5aTgag
 4KnCsz0utqoncuPSTeD8em2JctuCnsYp6vJ6RmGFXwbD6CeI8qm77WUGp9WhbP2ImcIl
 4nq8QdfAWKyEsXuh8oe089HHUHu+OjIP4zqErjSy5P/P2C38Ikfh9bJAs+Y1b+BZGwDu
 23yAezg3DqG5XeAAgNLt4A50L41cOEOBk0SZP7GDKs9QUmR+Nu9cfepTF54c5YFk/9zs
 PXTOHTl3xzplkmy7PWtE7APgQ/D8i9vmZB+f+8mR7qXs9u1a0K0o2CYtdy75orjwqMqI
 vGBQ==
X-Gm-Message-State: APjAAAVvn83irAivvYFIPPKrsf6KhrJrpUalhB4bbc7aSUyniorJxMVu
 YZmhFc/hDw66EqiRCKGaX4nXzkFgCrWKWQuhhTVizg==
X-Google-Smtp-Source: APXvYqx2MGFB3NNKhdVnlQ2N5MCdsWVaGM6QTc7oV8GJwro+jlMN/QZFKpxTDxgXzD4BbwXGFIhX1zY+MvPmO/NH+1g=
X-Received: by 2002:a9d:7385:: with SMTP id j5mr5303958otk.135.1572298954689; 
 Mon, 28 Oct 2019 14:42:34 -0700 (PDT)
MIME-Version: 1.0
References: <1572244520-14737-1-git-send-email-jasowang@redhat.com>
In-Reply-To: <1572244520-14737-1-git-send-email-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Oct 2019 21:42:36 +0000
Message-ID: <CAFEAcA8c2zCDgP=zbzXs7s=4xT_oB8c7ndgn-qacXzepATuo0A@mail.gmail.com>
Subject: Re: [PULL 0/4] Net patches
To: Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::331
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
Cc: Sven Schnelle <svens@stackframe.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 28 Oct 2019 at 06:35, Jason Wang <jasowang@redhat.com> wrote:
>
> The following changes since commit 187f35512106501fe9a11057f4d8705431e002=
6d:
>
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-next-25=
1019-3' into staging (2019-10-26 10:13:48 +0100)
>
> are available in the git repository at:
>
>   https://github.com/jasowang/qemu.git tags/net-pull-request
>
> for you to fetch changes up to 5af982a47cf6b6cd9beb872e5a9b940e43df5bf9:
>
>   COLO-compare: Fix incorrect `if` logic (2019-10-28 14:28:31 +0800)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------

Hi -- I get this compile failure on some hosts (s390, aarch64,
aarch32, ppc):

/home/pm215/qemu/hw/net/tulip.c: In function =E2=80=98tulip_idblock_crc=E2=
=80=99:
/home/pm215/qemu/hw/net/tulip.c:859:9: error: comparison is always
true due to limited range of data type [-Werror=3Dtype-limits]
         for (bit =3D 15; bit >=3D 0; bit--) {
         ^

'bit' here is of type char, which can be either signed
or unsigned depending on the host. If it's unsigned
(as is the case on the above architectures), then the
loop will never terminate because "bit >=3D 0" is always true.
Plain old 'int' is probably a better choice anyway.

thanks
-- PMM

