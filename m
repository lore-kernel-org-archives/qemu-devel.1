Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C329C18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:30:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3230720674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gfzKk+Nl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3230720674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDuVa-0005Cq-BA
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:30:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35849)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jDuSk-0000ip-Jo
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:27:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jDuSj-0001DM-97
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:27:42 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:46479)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jDuSj-00017H-32
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:27:41 -0400
Received: by mail-ot1-x342.google.com with SMTP id 111so18830725oth.13
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 11:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=HoFnRy9roedPxz55B+3k96w9hR7fgmKlmGGI8u+V/Mg=;
 b=gfzKk+Nlk3vNbJII3LFGAwJqvKBxBKNpj3ZcWNQq0Po6zLYKGaSb7bbX+DGgn7U5g6
 cGCbpXRE4eWlKXA7C7temqGSONteu/wL6SnGvvbgG9Z6N9zzwq9zJ8Uc8z2RwS+gyWvl
 grzQws62zM/AiYueO4wrL7HhejGUqnXb7LB2razZETZgwyLMB7mvaGYIHSwWGL796M/V
 eD3VBGFl6YkYR7YM3/gF0CpZB/xezCxNnm1iX8j3QbYNTTDcDrX2G1FFGv9pE+WrSyq/
 BHCcvv0zfNlAWP/kj7+iRkbAYSW+a21wCF1i0Acjp7MLR53T909wFanDVhlhjsgKMJAY
 7p0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=HoFnRy9roedPxz55B+3k96w9hR7fgmKlmGGI8u+V/Mg=;
 b=bJQTKoawlmakaANzRx5OHO5dFyNEAlWMo8gNuVMNTygTAoypToIzu8aMVMhvCjgn9x
 YS9Wfr4f8MH/XKj45kcJB0/plA4thDMyYHQ/2sRYpG8Y00PE8MMhq/WduL0WWAW1oBfC
 ql7SyS0YTgwbYdOk6vekEWMLPGA1tKxmZ+oSjswKS9Pnuxr27iD+U3/KmGCA5k9J29RT
 wcP5eo4ot4suw4B0DEGg/jWDeWkOpBDtP1QLdJbn1p3Y+SZ/qO1WHI625bgZ0iwRaZ84
 vOgWG61Fu54avSnyEX9kVxW6obCABGvwfxJgva6lzmTy8RNchiOO/Epcjhh4uV9kpYmG
 HdAQ==
X-Gm-Message-State: ANhLgQ06QOlf5mG2ow1z65BEH8Ss5G+G34F72EdRYcCRYCaTLV5O02tQ
 npjY9sy+SDN+8SQwM75Zep7V145BsuWBUfFCgOiXUw==
X-Google-Smtp-Source: ADFU+vs7ixmWJKiAozAXRbEwBZDJ4GTmwwBPmYDbS0EQbenfiPhFUN7uMrNq0aBTlIR/KWhriAbRtY/7WN1GPl5WDk0=
X-Received: by 2002:a9d:1920:: with SMTP id j32mr421424ota.221.1584383259723; 
 Mon, 16 Mar 2020 11:27:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200316172155.971-1-alex.bennee@linaro.org>
 <20200316172155.971-22-alex.bennee@linaro.org>
In-Reply-To: <20200316172155.971-22-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Mar 2020 18:27:28 +0000
Message-ID: <CAFEAcA-x5L8=csd5tYYEwTaE2wb-8d9qcbaF3A9G2bC0vOOhhg@mail.gmail.com>
Subject: Re: [PATCH v1 21/28] configure: allow user to specify what gdb to use
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 16 Mar 2020 at 18:22, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> This is useful, especially when testing relatively new gdbstub
> features that might not be in distro packages yet.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  configure | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/configure b/configure
> index eb49bb6680c..6724158fde1 100755
> --- a/configure
> +++ b/configure
> @@ -303,6 +303,7 @@ libs_qga=3D""
>  debug_info=3D"yes"
>  stack_protector=3D""
>  use_containers=3D"yes"
> +gdb_bin=3D$(command -v "gdb")
>
>  if test -e "$source_path/.git"
>  then
> @@ -1588,6 +1589,8 @@ for opt do
>    ;;
>    --disable-fuzzing) fuzzing=3Dno
>    ;;
> +  --with-gdb=3D*) gdb_bin=3D"$optarg"
> +  ;;
>    *)
>        echo "ERROR: unknown option $opt"
>        echo "Try '$0 --help' for more information"
> @@ -1773,6 +1776,7 @@ Advanced options (experts only):
>    --enable-plugins
>                             enable plugins via shared library loading
>    --disable-containers     don't use containers for cross-building
> +  --with-gdb=3DGBB-path      gdb to use for gdbstub tests [$gdb_bin]

s/GBB/GDB/. (Also, the only other program we pass to configure
with "--with-foo=3D" is git; for make, install, python, sphinx-build,
smbd, iasl, cc, gcov we just use "--foo=3D".)

thanks
-- PMM

