Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6220CC4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 16:38:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CDC820709
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 16:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cyxBK69H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CDC820709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFKeo-0006c1-9l
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 12:38:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48556)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jFKeC-0006Bj-Tv
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:37:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jFKeB-00089w-Df
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:37:24 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:45308)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jFKeB-00089c-4P
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:37:23 -0400
Received: by mail-oi1-x242.google.com with SMTP id 9so7089920oiq.12
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 09:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=LUFRmI6R+6ubG2fliEXhER/CA3Z3k4ii+8Q5NWd9EDI=;
 b=cyxBK69HMY50BVvZBNppw0Wosd4V/FOWV0rPhoMEIOguZLmCo2poX12on3KvGvwM9x
 9ye0BZX2p1nmAIC0e0kzbxCmG6bdxPZX/h+D9UhXGrSYXcjqQOn4jL1um1kLYJwNyA8w
 ZQvaKmGz1oEdBnhEZNLDTNT/Zt/5tLefWOhJga54y5/SrNBPu1pTn0b7jxxSfIdvF99E
 oV3KDkCRp35zxYbQeAlv0nimsi2aHxd4MxFTZrpfpPkuMKUWWC0xw3z90IVMAVpUDwS1
 KGNMnhtnoKCQcjb/adRPBuiNFPX6lTqIeIcDGaJKNDJzr2JSApAkFOKqGTY0Jx9P6EVJ
 EyMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LUFRmI6R+6ubG2fliEXhER/CA3Z3k4ii+8Q5NWd9EDI=;
 b=NhIhW/P856teAkSEdSK+oE6llrbqZSIjIZlCzDNYF7Aqd5j9ijAaqoYnoZP3TziLFp
 brJiNj5GJSscWghT62rGgSToSPOv57dAKP7kaLTw9kyveDCgJ6sDnLbiv1EYeOKGuCiw
 2Lovs4/mNfOrLyIr08Deycd/rrqFx3ZHU7GZDVWothYhBEdtfkx5loBccule8vgGkI5l
 ohzWuo25vN0EXG0y4bO9adC16Sf3b/1I/MhGxUhAQoM5+7WUPSchVy00s6NUmF0vmgLr
 9FQN/uanvZ0Ab+XjsoZMmQGbSXfvBRDh1c+yJ6Km9WJOQo0HQV/6j9IPqEbfKtCzlu0e
 YWNg==
X-Gm-Message-State: ANhLgQ2LlIY4IEkKjKX8GyEeEBmIdloKCenyEITfMiFrAZFCT1b1Krbo
 o3+hlkwqQhXx37bRlipdvhwKrbYUpZDxKWkJ5XWYIA==
X-Google-Smtp-Source: ADFU+vuDlYm+g3j3PER+Y4L2l23OAX4TGGmCR4mzpwAFZiAZPeQRY3P9fFx5ZTizgQg+nqmXwxDBQxsN8S9f5mGm9no=
X-Received: by 2002:aca:190f:: with SMTP id l15mr6933504oii.48.1584722242154; 
 Fri, 20 Mar 2020 09:37:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200320103551.29246-1-f4bug@amsat.org>
 <20200320103551.29246-2-f4bug@amsat.org>
 <c7cf4bab-b9ac-4387-0709-a02c04b24061@redhat.com>
 <e4bc22f6-128d-99e9-9359-3253f666c065@linaro.org>
 <CAFEAcA8RM6U1hKX1Wn5YmR71y=VrGimt46z_OR=+O1i9neahiw@mail.gmail.com>
 <70930618-a369-cb26-1b9b-aa7864deefc9@redhat.com>
In-Reply-To: <70930618-a369-cb26-1b9b-aa7864deefc9@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Mar 2020 16:37:10 +0000
Message-ID: <CAFEAcA_xRmiTfNfYHW7DLM9pCSvssNRXZWkqoQSggFLgEUPMRw@mail.gmail.com>
Subject: Re: [PULL v2 05/13] target/rx: CPU definitions
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 20 Mar 2020 at 16:32, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
> -fwrapv is here indeed.
>
> I use
> --extra-cflags=3D-fsanitize=3Daddress,alignment,array-bounds,bool,builtin=
,enum,float-cast-overflow,float-divide-by-zero,function,integer-divide-by-z=
ero,nonnull-attribute,null,pointer-overflow,return,returns-nonnull-attribut=
e,shift-base,shift-exponent,signed-integer-overflow,unreachable,vla-bound,v=
ptr

There was a bug in older clang versions where the shift-base
sanitizer didn't honour -fwrapv:
https://bugs.llvm.org/show_bug.cgi?id=3D25552

https://wiki.qemu.org/Testing#clang_UBSan
says you can work around the clang bug with -fno-sanitize=3Dshift-base.

The bug was fixed upstream back in 2016, though, so the
fix ought to be in clang 4, I think. Are you using an
old clang version, or has it regressed in newer clang?

thanks
-- PMM

