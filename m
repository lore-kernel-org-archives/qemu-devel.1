Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31109C282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 16:09:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E517820673
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 16:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IsQ3G55U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E517820673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipwqW-0007SP-1J
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 11:09:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51712)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ipwpT-0006Ar-MF
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 11:08:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ipwpO-0001ql-Hz
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 11:08:07 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:40707)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ipwpO-0001oX-Bz
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 11:08:02 -0500
Received: by mail-oi1-x244.google.com with SMTP id c77so2267573oib.7
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 08:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=IvQwos5FDFt9Z0OrYRVuGvYfq4rH1Ls6qEZMaKdYOKs=;
 b=IsQ3G55UqLIa7Fr+8WrMgmBJ5CsfXaPecJ+tTa+K+b//h44LBMHeUMKaJo2wxzaLyA
 XNl1OF4L0CbZ6bwC64uGyfGrAb5y2cn4AREKA8Vv0gMOYVt/XozNeOkuutDD2YBG9/TP
 F7oDWA2ahPuKnvZsBxMVLfW9C0pI8E9qlz2kCltwgOe84lcVwJKCVNMiLtpK6jlkKjuS
 fvWcg0R+W16ezfa9aVmYLk2Gvj342FY90/atl/i1ASOFDrrugzqXM+9KPpxUOOLGrTkE
 CdUegM8pcFqKlIe8aelLZStBOcgbID9XYHK0IYOw1UWCp65ZApo6qlavzljXKU5pf7q/
 W8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=IvQwos5FDFt9Z0OrYRVuGvYfq4rH1Ls6qEZMaKdYOKs=;
 b=hM7U3rMV2cf88Z4hd4jBt430Q2oOJFC65GqxpsorUHzPV/E71vEZZscXlTzbTruSvF
 Fw6Yh94qoV8ioptqulpXOZyBqsFxHD61gogmEjcmytZoJOg3uXMSNzRMLImnRp3iQIUx
 6HaQYuL81MHnP5AcT/kMsx6xrGs7AIMmYxNsg3nFTG9xdzBhqkOBVAZJcLyUpZEHljZy
 iagEEAZ/02UUfNBF8WjB1tZoZLE8Ua/36/pTxWAMBf7tqF8zZcFRbRYDtXi6am2HTZq7
 fMLluMFRVoMRUW82RpRkSYaCvmzplWNfcmeHTZunNZmMHXoeuzB3oGuAuTAHhUMeekyv
 EXIg==
X-Gm-Message-State: APjAAAXRuraSE63RIxDqLu3lAEtjSj2039qp5cQvCsM1oEb39iVtrNK5
 PKrR0aJ45B3E86gZ0MBYuBuOzTOYR77ETpjBXYxrm2g/JCg=
X-Google-Smtp-Source: APXvYqyt6zlXus8NeEOf1Z+D6n+AmWJIPm3e7elWefETj95T/UU1nmosfNTDCFaYI7LEOutPvXS706YDZ0fNYgmF87E=
X-Received: by 2002:aca:d78b:: with SMTP id o133mr2837148oig.163.1578672481323; 
 Fri, 10 Jan 2020 08:08:01 -0800 (PST)
MIME-Version: 1.0
References: <20200108042338.9082-1-richard.henderson@linaro.org>
In-Reply-To: <20200108042338.9082-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jan 2020 16:07:50 +0000
Message-ID: <CAFEAcA-AYKxnTW6w1xnbP0sbk-_8pV3UdfOotPmSHqNmj_Kjkg@mail.gmail.com>
Subject: Re: [PULL 0/3] capstone update
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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

On Wed, 8 Jan 2020 at 04:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit 035eed4c0d257c905a556fa0f4865a0c077b4e=
7f:
>
>   Merge remote-tracking branch 'remotes/vivier/tags/q800-for-5.0-pull-req=
uest' into staging (2020-01-07 17:08:21 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-cap-20200108
>
> for you to fetch changes up to 7cc3836eac04a3e358b2496fbca704b3ee5197ae:
>
>   capstone: Add skipdata hook for s390x (2020-01-08 14:53:54 +1100)
>
> ----------------------------------------------------------------
> Update capstone to next
>
> ----------------------------------------------------------------
> Richard Henderson (3):
>       capstone: Update to next
>       capstone: Enable disassembly for s390x
>       capstone: Add skipdata hook for s390x

Build failures:

  CC      aarch64-linux-user/disas.o
In file included from
/home/ubuntu/qemu/capstone/include/capstone/capstone.h:302:0,
                 from /home/ubuntu/qemu/include/disas/capstone.h:6,
                 from /home/ubuntu/qemu/disas.c:9:
/home/ubuntu/qemu/capstone/include/capstone/riscv.h:16:10: fatal
error: capstone/platform.h: No such file or directory
 #include "capstone/platform.h"
          ^~~~~~~~~~~~~~~~~~~~~
compilation terminated.

(same on most hosts)

aarch64 host had this complaint instead:

/home/pm/qemu/disas.c:187:1: error: expected =E2=80=98=3D=E2=80=99, =E2=80=
=98,=E2=80=99, =E2=80=98;=E2=80=99, =E2=80=98asm=E2=80=99 or
=E2=80=98__attribute__=E2=80=99 before =E2=80=98cap_skipdata_s390x_cb=E2=80=
=99
 cap_skipdata_s390x_cb(const uint8_t *code, size_t code_size,
 ^~~~~~~~~~~~~~~~~~~~~
/home/pm/qemu/disas.c:211:17: error: =E2=80=98cap_skipdata_s390x_cb=E2=80=
=99
undeclared here (not in a function); did you mean
=E2=80=98cap_skipdata_s390x=E2=80=99?
     .callback =3D cap_skipdata_s390x_cb
                 ^~~~~~~~~~~~~~~~~~~~~
                 cap_skipdata_s390x

thanks
-- PMM

