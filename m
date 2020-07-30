Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DF3C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 08:45:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D4ED2068F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 08:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i/ekReEC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D4ED2068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k14Bp-0007IW-99
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 04:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k14B8-0006jh-6Y
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 04:44:42 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:42676)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k14B6-0008RR-A3
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 04:44:41 -0400
Received: by mail-oi1-x242.google.com with SMTP id j7so6741782oij.9
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 01:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Mk3XdEBa9UC5cwSV0q0gojpp0/4NYI0IrnvAqfNaKDQ=;
 b=i/ekReECz4IKe77bsIi7croPi+I6TLyVBu7nG3Kil+mfu8vmAMVvzCO0w87pwQpdLs
 87+YpU+r6kmHHFVpUhoPhkC/WSeiIn6gr10dmSBk/cz3KtiwDqzS0RVnaqKxyP7uASbG
 T8ZkcRg6ALzS/QGzsKgmUdHLHcDxUs9SMC4c+oS0d/lt3bdJnwv6hT8sQMOtF1Wz61z6
 mNdP7ovN1bDwAQkCA3s3cv/cXZCKGN95Ml8nDIlY8tc87NtU/xagOwNL+X2kfm2E+ut+
 b8vRbNgsvs63kSCWRCSdJ4snz/Qla2x/fa/gWR8PMK793jvQDT+TyR1VvZfv0j450v2J
 wBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Mk3XdEBa9UC5cwSV0q0gojpp0/4NYI0IrnvAqfNaKDQ=;
 b=hLvf1mwr7MpAzJbnT7CNywitHbCcjy6BUUnIuNB5U/bgS9nU4dBF6NH07Nmb+q5K9x
 BNFAUjoqY9uGmIAUCYgE70bMLaTp23qQ6nnL283axM7+bhovx3jsaUv8Lu13knzDFkoY
 bBfiCAWuk6BjLT3MqJQZgLv35WdTZiOHdpLOUm7FYr/I55vpcNtguuAuXdc2wJy0GGqt
 1cht33Mv9u+IcFKBaQUeCwIGtp6L5pyq7PKNDg5gNoyD+4m4wrngdWP2n6rllbmiVJn9
 ZKN8xPDbJkg3YeeVrq+Vl5HYYUIkoZWBT8l2KKiD+fyFO8Kx/AruZ/IwK6xgybSvpAB4
 i+RA==
X-Gm-Message-State: AOAM530RWVaJDgM5gDHHK3kKmUP29yaY2v7QIkOtp9cCYXo8sHZ7UUis
 aUEyUwjoxs2FUQZAXEe6ebh+fh2BdUl7Ept/skkkWg==
X-Google-Smtp-Source: ABdhPJwM088CbzF32neZKGwLiKCxtijE1HGnd7y9rSGwfdKXP682yWwVhu000x/Iq0/r3fA4imT7A4IqJ3WLTYq5Xf0=
X-Received: by 2002:aca:48d8:: with SMTP id v207mr3869003oia.48.1596098678301; 
 Thu, 30 Jul 2020 01:44:38 -0700 (PDT)
MIME-Version: 1.0
References: <1596074182-4920-1-git-send-email-likaige@loongson.cn>
 <1596074182-4920-2-git-send-email-likaige@loongson.cn>
In-Reply-To: <1596074182-4920-2-git-send-email-likaige@loongson.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Jul 2020 09:44:27 +0100
Message-ID: <CAFEAcA_ZgrkcpwYZD-stZGDDjhTgMOSLx--9KHPnxfbKz58s7g@mail.gmail.com>
Subject: Re: [PATCH 2/2] target/arm: Fix compile error.
To: Kaige Li <likaige@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 30 Jul 2020 at 02:56, Kaige Li <likaige@loongson.cn> wrote:
>
> When I compile qemu with such as:
>
> git clone https://git.qemu.org/git/qemu.git
> cd qemu
> git submodule init
> git submodule update --recursive
> ./configure
> make
>
> There is error log:
>
> /home/LiKaige/qemu/target/arm/translate-a64.c: In function =E2=80=98disas=
_ldst=E2=80=99:
> /home/LiKaige/qemu/target/arm/translate-a64.c:3392:5: error: =E2=80=98fn=
=E2=80=99 may be used uninitialized in this function [-Werror=3Dmaybe-unini=
tialized]
>      fn(cpu_reg(s, rt), clean_addr, tcg_rs, get_mem_index(s),
>      ^
> /home/LiKaige/qemu/target/arm/translate-a64.c:3318:22: note: =E2=80=98fn=
=E2=80=99 was declared here
>      AtomicThreeOpFn *fn;
>                       ^
> cc1: all warnings being treated as errors
>
> So, add an initiallization value for fn to fix this.
>
> Signed-off-by: Kaige Li <likaige@loongson.cn>

What compiler version is this ?

> ---
>  target/arm/translate-a64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 8c07649..910a91f 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -3315,7 +3315,7 @@ static void disas_ldst_atomic(DisasContext *s, uint=
32_t insn,
>      bool r =3D extract32(insn, 22, 1);
>      bool a =3D extract32(insn, 23, 1);
>      TCGv_i64 tcg_rs, clean_addr;
> -    AtomicThreeOpFn *fn;
> +    AtomicThreeOpFn *fn =3D tcg_gen_atomic_fetch_add_i64;

NULL would be a better choice for a "this is never actually used"
initialiser.

thanks
-- PMM

