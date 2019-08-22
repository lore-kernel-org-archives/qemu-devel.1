Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626EEC3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 16:58:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B87021743
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 16:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B6AwOhqI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B87021743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0qPf-0006QY-8o
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 12:58:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54300)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i0qOd-0004ov-MC
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 12:57:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i0qOb-0004Aq-5X
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 12:57:11 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:34169)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i0qOa-00049T-Sq
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 12:57:09 -0400
Received: by mail-oi1-x22c.google.com with SMTP id g128so4912773oib.1
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 09:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Di9oxKFhxaxncUQ2W/+cux8HAQbPeHs6aCsDdtQrV40=;
 b=B6AwOhqIh/Oxr42w6X2UaL+eyvyiS+vFtpwdLfz5VubMsWRqmyIZnDteC4onYbX2EN
 9QgQ1+2YBB1CU1pogPTjKnnmrfcJbu4oEZULXgrxJ5t2itaMKUUpoKgmx0SmHb4cifhK
 wFB+/YT1M9Hw9sN4juujdI8Eh6SIwxJM3aLweLkDwGl6smyQM30FOENRdc+0BVkhiSNO
 Inki3tY0EFr+PkfU6zbrj0+TeNlDt64nY4BWdT2C8jCvIBIeXhC8ketcabCdV11pyukh
 PiDLXdU2vpz0Q40gGvhNMtI/KIbrI9BT7gFqngG7WMFJsSwa1TJRGymQHHHZYvcdgyyD
 IUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Di9oxKFhxaxncUQ2W/+cux8HAQbPeHs6aCsDdtQrV40=;
 b=T7h2v54tr66kVYaxxvVC51/F+ia7F/gkFSYoxe1w3To1aJvOl8pDjmaPEyL7/+XkZS
 r0J9mm3aJ5fAZZ/EzFPgTSPZSZ+qYZ9GyTPUJW3l3/sGYaW6SbhKbIrMSkt0qyt1pame
 UcrgCQ4gnSC2c8W08yozJfXd8XLPZLfbhDWlnfgh8xKCF429J2ddifSgPrbNkLdgwAZS
 iHkhJHJQv0VRkUMZe9kzbtuvlltSkr5j4FJNH6GjEIBSMhGMjRLo+UrlVYwPH+Ohi9g0
 TNb4J/AJEEi6PE8XuhgdIgMB7uv7XfRBMqsD5fNyr2TQArL8kN3hEw8dhkwXVma4RUeb
 vpwA==
X-Gm-Message-State: APjAAAVfCx7ONarBG23kra0qEdYnESV3gK2vHWuDsDVR9GFKhVdAuvcr
 I61915kxBMJ4DTC6DF6ToreG6mMc+yHwxafQmDUoYmJl
X-Google-Smtp-Source: APXvYqxsZAQOmJaAmIipdsUEUPF4efzAN7lkmuSDUaZDl3GdLWQvpl5DehyE5nzUKTkd0J+FNGL2zJZQIhWMLMfqMSk=
X-Received: by 2002:aca:50cb:: with SMTP id e194mr108391oib.48.1566493027642; 
 Thu, 22 Aug 2019 09:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190822102046.8765-1-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20190822102046.8765-1-kbastian@mail.uni-paderborn.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Aug 2019 17:56:56 +0100
Message-ID: <CAFEAcA-L18-5PW17yMJKM8R3W_GP_fALCcmkq2bB29BPp=0Txw@mail.gmail.com>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22c
Subject: Re: [Qemu-devel] [PULL 0/5] tricore queue
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

On Thu, 22 Aug 2019 at 11:20, Bastian Koppelmann
<kbastian@mail.uni-paderborn.de> wrote:
>
> The following changes since commit fe066b4848bab4f9365a419f3c8ba59ccecf67c0:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/trivial-branch-pull-request' into staging (2019-08-21 16:59:22 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/bkoppelmann/qemu.git tags/pull-tricore-20190822-1
>
> for you to fetch changes up to d4881da9b39df183f976349f223231ac1d81087b:
>
>   target/tricore: Fix tricore_tr_translate_insn (2019-08-22 12:17:01 +0200)
>
> ----------------------------------------------------------------
> Converted target/tricore to translate_loop


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

