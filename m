Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525D0C47247
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:27:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D64B2073E
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="itJYXknH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D64B2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVaCB-0005Uz-5z
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:27:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVa2P-0003e7-Al
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:17:33 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:44698)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVa2O-0000X4-2K
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:17:32 -0400
Received: by mail-ot1-x330.google.com with SMTP id j4so8613730otr.11
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 05:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dGfKgcJj7oYnARI4vDwaTmVA0K9Rg0bpOoviI7+r8Eo=;
 b=itJYXknHOuo0DXxI59qJ/R48gh7xwh6FNKZZN4Ko35/fdxCyEXMVc8aD0GC6tj9A39
 0JbQzJoD4vI87dAsdQnNy8EMMbWY4nrlEPNZMCly6Es7AK6hGvsQ0tOBWbwWfRqntyZy
 UOXRRwg8HD0QGO9aZlAu7f8NgHt8Uzn39KNahzcxrJ8CWZur0fh0N9JYqzJuwz7JwCTv
 SyPep82SzCKhWOfdaBvKcgxmPRZt91NW60sdvXKvc5AD/QvOva8SSDDxgFYoZDU1Hgsu
 p9eQKM9hh2QrR8eWcHdD3w5OSkdl1WNCtaw3XsSGew0ZbaeNEl8IwlhAkWTrUy7hlQO3
 z6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dGfKgcJj7oYnARI4vDwaTmVA0K9Rg0bpOoviI7+r8Eo=;
 b=kVbCHz7V+NTBjYu14FfIuYLL+UQs3RbczaRX9oWRK8vc4bEbeGqCFTVGJ7MxTAirDG
 FYQ/mUPyc+hjWxq66PfLOlTpbsKGpNaAQUXmvZYop4YTdi5dEuUOJftoBcvoRo2XnaGD
 akIlnvq8JuVKK3PWTKYfRV5h1xdqKyXItl/a3OdWXPXZ1WbtcUX1nbnZZpzW64TACnGT
 NabDmhO07BGnfyY+rSiPercMlglm230XDxvsAZ58a7cqxV7Jyttj3OYX9bmQ0+QQXOCc
 qeiEqc5jrAl5eF35WwnYnkc5Q2O8uL6UEFVMDuTFTkoAVoWYNpvMsnTajneQc6TmZKz6
 ZEpQ==
X-Gm-Message-State: AGi0PubuS793MvvX4PTnXP3BJAc/KECt6fRdRNklP0tk4pmRQzPOmI7x
 Ww+qcnvHrmzKuX4soR1C7Di1Bedakg4zrJOLJSQeiwW4DQA=
X-Google-Smtp-Source: APiQypKFQA0VU5i4CDlmI79Z+wiJCff9wGF/nQ+FfvjN+wIs2zXSQoCsPxqbkzUerlnOhSWrg6Mp48DtDxf33ix4Uv8=
X-Received: by 2002:a05:6830:1e4e:: with SMTP id
 e14mr13756837otj.91.1588594650616; 
 Mon, 04 May 2020 05:17:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200504115758.283914-1-laurent@vivier.eu>
In-Reply-To: <20200504115758.283914-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 May 2020 13:17:19 +0100
Message-ID: <CAFEAcA_FDt+1+ezAyRE-fwdd=VuG5YNThkKiHHTUOYqtRHLoyg@mail.gmail.com>
Subject: Re: [PULL 00/20] Trivial branch for 5.1 patches
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x330.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 4 May 2020 at 13:05, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit 2ef486e76d64436be90f7359a3071fb2a56ce835:
>
>   Merge remote-tracking branch 'remotes/marcel/tags/rdma-pull-request' into s=
> taging (2020-05-03 14:12:56 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/trivial-branch-for-5.1-pull-request
>
> for you to fetch changes up to 4341a0106781043a708c061b676312e5bb5d4488:
>
>   hw/timer/pxa2xx_timer: Add assertion to silent static analyzer warning (202=
> 0-05-04 12:06:21 +0200)
>
> ----------------------------------------------------------------
> trivial patches (20200504)
>
> Silent static analyzer warning
> Remove dead assignments
> Support -chardev serial on macOS
> Update MAINTAINERS
> Some cosmetic changes


Compile failure, OSX:
/Users/pm215/src/qemu-for-merges/block/file-posix.c:1620:9: error:
unused variable 'ret' [-Werror,-Wunused-variable]
    int ret;
        ^

Compile failure, aarch32 (but probably the result of whatever
crypto options/dependent libraries are on that setup):

In file included from /home/peter.maydell/qemu/crypto/cipher.c:157:0:
/home/peter.maydell/qemu/crypto/cipher-builtin.c: In function
'qcrypto_cipher_aes_xts_encrypt':
/home/peter.maydell/qemu/crypto/cipher-builtin.c:136:36: error:
passing argument 1 of 'qcrypto_cipher_aes_ecb_encrypt' discards
'const' qualifier from pointer target type
[-Werror=discarded-qualifiers]
     qcrypto_cipher_aes_ecb_encrypt(&aesctx->enc, src, dst, length);
                                    ^
/home/peter.maydell/qemu/crypto/cipher-builtin.c:77:13: note: expected
'AES_KEY * {aka struct aes_key_st *}' but argument is of type 'const
AES_KEY * {aka const struct aes_key_st *}'
 static void qcrypto_cipher_aes_ecb_encrypt(AES_KEY *key,
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/home/peter.maydell/qemu/crypto/cipher-builtin.c: In function
'qcrypto_cipher_aes_xts_decrypt':
/home/peter.maydell/qemu/crypto/cipher-builtin.c:147:36: error:
passing argument 1 of 'qcrypto_cipher_aes_ecb_decrypt' discards
'const' qualifier from pointer target type
[-Werror=discarded-qualifiers]
     qcrypto_cipher_aes_ecb_decrypt(&aesctx->dec, src, dst, length);
                                    ^
/home/peter.maydell/qemu/crypto/cipher-builtin.c:103:13: note:
expected 'AES_KEY * {aka struct aes_key_st *}' but argument is of type
'const AES_KEY * {aka const struct aes_key_st *}'
 static void qcrypto_cipher_aes_ecb_decrypt(AES_KEY *key,
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

thanks
-- PMM

