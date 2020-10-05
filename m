Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BC5C46466
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 19:12:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C12C2074F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 19:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=loon.com header.i=@loon.com header.b="SFe+bch7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C12C2074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=loon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPVud-0003dk-KZ
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 15:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ek@google.com>) id 1kPVqR-0007W7-9y
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 15:08:23 -0400
Received: from mail-vs1-xe43.google.com ([2607:f8b0:4864:20::e43]:45109)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ek@google.com>) id 1kPVqN-0001X7-RM
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 15:08:22 -0400
Received: by mail-vs1-xe43.google.com with SMTP id a16so4827434vsp.12
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 12:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=loon.com; s=google;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc:content-transfer-encoding;
 bh=Wf51CpU9+1eJB1CrgklE4uA+p8oCMvP2jx5nECecrtY=;
 b=SFe+bch7f8UQffb8NKWYtYpQsiBb5AG2sC011ROvuj4EkTTnx9lpNSTnoqjhOrmpkM
 FgQ6ybrU2o1piM6f9lPtkTYomL3QH5xp6/Bp2dK1n1/yxqup5YR6fZp71v+Q32j4owu4
 Gg7KQuky6ArN/On8kphDe4//MCQ9D6izsk6gY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc:content-transfer-encoding;
 bh=Wf51CpU9+1eJB1CrgklE4uA+p8oCMvP2jx5nECecrtY=;
 b=mw4OLNWXosER7PuLgYEAcgy1vUHUiH+Debj5CVkVD2Zj0CNpmeogUhf+fK5z8XIkWq
 pQF9/P1N5QojtNlMZG92jYC7mUVgtM+ljkIzzX1fOCwwl26u6k5tGaOTUo+wnA19mDAA
 9hUJLi6P4hNzgjawstSF5Hq6gEvSBYRtJnnRU/VHLHk9pUJ8HAi3Ap2GzNKTxwKvAg8Z
 Lrgj2cuHWxW78HvnzWh0BaJupZtl/6NVuYKG1N9YBOkRJ1w76qKCSv6+8xg4HFx+0qYU
 Ce+N/hx/U1673MUhFRr+dx/Y4ZQBM602g9whJgkW4b3ywT7+AVzUvqbVyd7b/BgckUKf
 RDIA==
X-Gm-Message-State: AOAM530yTmfdLTgQMvJ+Wtzi1BJ3oAtBDv4FIqI9KDGMjWMG8xG6M2dD
 lwVmmVXs+7s+uid7PodEv3nq29/ZnQ5M5dUc204Zlg==
X-Google-Smtp-Source: ABdhPJywZz0u5fQ521Ev1vyFY3cvsDqPKD8bsNO6k9IM110/zbkEZvBddkBQ1mqW8wLt96cJkHZiljiPwVpQC3T0tuk=
X-Received: by 2002:a67:f4c2:: with SMTP id s2mr1244621vsn.4.1601924897132;
 Mon, 05 Oct 2020 12:08:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201004180443.2035359-1-f4bug@amsat.org>
 <20201004180443.2035359-7-f4bug@amsat.org>
In-Reply-To: <20201004180443.2035359-7-f4bug@amsat.org>
From: Erik Kline <ek@loon.com>
Date: Mon, 5 Oct 2020 12:08:05 -0700
Message-ID: <CAAedzxrE9JVF_woHjxwU3=AHPsxtXxtXVjK+MQwK-gB9LSEfXA@mail.gmail.com>
Subject: Re: [RFC PATCH 06/21] contrib/gitdm: Add Google to the domain map
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e43;
 envelope-from=ek@google.com; helo=mail-vs1-xe43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -92
X-Spam_score: -9.3
X-Spam_bar: ---------
X-Spam_report: (-9.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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
Reply-To: ek@loon.com
Cc: Joe Richey <joerichey@google.com>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Josh Kunz <jkz@google.com>,
 Tao Wu <lepton@google.com>, Thomas Knych <thomaswk@google.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Havard Skinnemoen <hskinnemoen@google.com>, Ian McKellar <ianloic@google.com>,
 Andrew Oates <aoates@google.com>, Doug Kwan <dougkwan@google.com>,
 Matt Gingell <gingell@google.com>, Christian Svensson <bluecmd@google.com>,
 David 'Digit' Turner <digit@google.com>,
 Todd Eisenberger <teisenbe@google.com>, Doug Evans <dje@google.com>,
 Lingfeng Yang <lfy@google.com>, Peter Collingbourne <pcc@google.com>,
 Shu-Chun Weng <scw@google.com>, Catalin Patulea <catalinp@google.com>,
 Torbjorn Granlund <torbjorng@google.com>, Lirong Yuan <yuanzi@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

LGTM

Acked-by: Erik Kline <ek@google.com>


On Sun, Oct 4, 2020 at 11:04 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> There is a number of contributors from this domain,
> add its own entry to the gitdm domain map.
>
> Cc: Andrew Oates <aoates@google.com>
> Cc: Catalin Patulea <catalinp@google.com>
> Cc: Christian Svensson <bluecmd@google.com>
> Cc: David 'Digit' Turner <digit@google.com>
> Cc: Doug Evans <dje@google.com>
> Cc: Doug Kwan <dougkwan@google.com>
> Cc: Erik Kline <ek@google.com>
> Cc: Havard Skinnemoen <hskinnemoen@google.com>
> Cc: Ian McKellar <ianloic@google.com>
> Cc: Joe Richey <joerichey@google.com>
> Cc: Josh Kunz <jkz@google.com>
> Cc: Lingfeng Yang <lfy@google.com>
> Cc: Lirong Yuan <yuanzi@google.com>
> Cc: Matt Gingell <gingell@google.com>
> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> Cc: Peter Collingbourne <pcc@google.com>
> Cc: Shu-Chun Weng <scw@google.com>
> Cc: Tao Wu <lepton@google.com>
> Cc: Thomas Knych <thomaswk@google.com>
> Cc: Todd Eisenberger <teisenbe@google.com>
> Cc: Torbjorn Granlund <torbjorng@google.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> One Reviewed-by/Ack-by from someone from this domain
> should be sufficient to get this patch merged.
> ---
>  contrib/gitdm/domain-map | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
> index a27dca6b44..3e9602287a 100644
> --- a/contrib/gitdm/domain-map
> +++ b/contrib/gitdm/domain-map
> @@ -13,8 +13,9 @@ bytedance.com   ByteDance
>  cmss.chinamobile.com China Mobile
>  citrix.com      Citrix
>  daynix.com      Daynix
> -greensocs.com   GreenSocs
>  fujitsu.com     Fujitsu
> +google.com      Google
> +greensocs.com   GreenSocs
>  huawei.com      Huawei
>  ibm.com         IBM
>  igalia.com      Igalia
> --
> 2.26.2
>

