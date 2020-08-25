Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B9EC433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 15:19:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53B1220786
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 15:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="urgY6okH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53B1220786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAajB-0007Nq-LV
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 11:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAaiS-0006pd-CP
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 11:18:28 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:45962)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAaiP-0005Nw-U0
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 11:18:27 -0400
Received: by mail-ed1-x541.google.com with SMTP id di22so11558885edb.12
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 08:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=GD8vABY/m9QvuX/7MfAI9rjpW0f+q+G1T72CQzvCM8o=;
 b=urgY6okHsz2cfxzlbzzCT+Bw93aKTAZ0X3EBVvqULrDq1WiqGUCwzbBoyaaYPE+dLG
 FU5vMaxEaHYrPyum2wrOm82SMpl3+3wlvw0UI1SOuWbVhG2nE5zQOcSmeAcTNjn1Rn6n
 hwoqjKnVuP7bRJ0K0RxXBXFG40sEJFcYkSQaniwNX67+mHXuldztVeCAXNL7BiUzToTU
 HxIdlgseSurPztsWr1lvQpl8HBmPFy3Yx8NKLsESIKdk4FpYABCyO6Wxsi1bUo6nLnjR
 6OiyftW5SyhEtSvddDs/LBy+YNZeSXDRtflNKyVwtJs5OezWDXKbEhw1oIGHLV5NSfPA
 L4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=GD8vABY/m9QvuX/7MfAI9rjpW0f+q+G1T72CQzvCM8o=;
 b=spgpxXJDvxJ22O4aJAoGVD3w1UFBxd1rvnlLQfAQ3Jo9gR9aWY/eejEuAcvYSP1TPg
 YDnMFAAErOqqErgTDQUp3WbFPOULL/zGLQl+iX1FfTZ9ia0Iylm0yKn5ukD9CZFLElEx
 C+Ml0c+YYFmpy/SljlESO0vkgPW9P6v7eF03AatnL60GNusqko5fU4zJXd6ig+gcPPp7
 R68iDnj7sGNj/QsjkpU1aCuPWs1M/KwqgDtkzf0/oCMzvi/ntE9h6HF21oJWCkVT4N/V
 Uu42TRH/GBEocVlxGDlZ76WAYGtrn1udNf3Y+yUHj4ImH9F6YIiQuf/RA3HSnPwrWwwZ
 vfgw==
X-Gm-Message-State: AOAM532zWHQbEQMg/IST5WMVGyfp+CYUcKlZwI4Clk+0NnfUPQMs0Wdj
 eqN7lhDpdIF5DgIXuKS/ka06z1OXBZnS5/d3gf2SAg==
X-Google-Smtp-Source: ABdhPJyPuPeysCp5Aqf2265KN/87DiXoj8GetMQdRf9U2J/CYukzyYmUyC9zFLZzOgqmac0qwkB8id/8wfMrAWz4Di4=
X-Received: by 2002:a50:8f45:: with SMTP id 63mr11051082edy.52.1598368704299; 
 Tue, 25 Aug 2020 08:18:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200819100956.2216690-1-clg@kaod.org>
 <20200819100956.2216690-6-clg@kaod.org>
 <CAFEAcA_GwY5qqLFYcttobLRnt_b=HoMNHMXEZrDHyRZJ4mjGug@mail.gmail.com>
 <CA+MHfou4eE3wYCMv4ojLSnnUeffKy73V6FhpaBC551bsfkqa+A@mail.gmail.com>
In-Reply-To: <CA+MHfou4eE3wYCMv4ojLSnnUeffKy73V6FhpaBC551bsfkqa+A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Aug 2020 16:18:13 +0100
Message-ID: <CAFEAcA9e=wbzXD8-Fim7JE4etNc0kmB5_Uuh7=q3tUa0vmk__w@mail.gmail.com>
Subject: Re: [PATCH v2 05/21] hw/arm/aspeed: Add board model for Supermicro
 X11 BMC
To: Erik Smit <erik.lucas.smit@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
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
Cc: Andrew Jeffery <andrew@aj.id.au>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Aug 2020 at 15:37, Erik Smit <erik.lucas.smit@gmail.com> wrote:
> On Tue, Aug 25, 2020, 4:33 PM Peter Maydell <peter.maydell@linaro.org> wr=
ote:
>>
>> On Wed, 19 Aug 2020 at 11:10, C=C3=A9dric Le Goater <clg@kaod.org> wrote=
:
>> >
>> > From: erik-smit <erik.lucas.smit@gmail.com>
>> >
>> > The BMC Firmware can be downloaded from :
>> >
>> >   https://www.supermicro.com/en/products/motherboard/X11SSL-F
>> >
>> > Signed-off-by: erik-smit <erik.lucas.smit@gmail.com>
>>
>> Should the name in the From and Signed-off-by: here be
>> "Erik Smit" rather than "erik-smit" ?
>
> I don't know if it matters. I'm fine with either.

It's supposed to be "your real name" (ie not a pseudonym,
email address or username); obviously for some people that
really is a single word or all-lower-case, but I usually
check because separate-words-with-caps is the more common.

thanks
-- PMM

