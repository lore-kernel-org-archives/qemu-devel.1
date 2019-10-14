Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D30ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:52:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7063F20873
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="piX5jChy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7063F20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK4Vp-0004cJ-CF
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 13:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45614)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iK3kZ-000431-As
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 13:03:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iK3kW-0006MV-Va
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 13:03:14 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:38718)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iK3kU-0006Jx-P4
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 13:03:11 -0400
Received: by mail-pl1-x641.google.com with SMTP id w8so8264655plq.5
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 10:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=mdsrB3WJ/tk0ST4HvqFtC9xRaSlLd3WWsTQKXGGED9I=;
 b=piX5jChyat8A+Xml4c+vatVM1q3wWLn89FFsQbO9+iEmPt8fDcDV+uUhWUhm3orAhI
 6nznZFM1ttjTdXVXKWI4nFBOa8yh/CiSs3BO0dx4tRtDg6dcl/519zjunLAxCsMGNct9
 6MSKEl0buyjWOOFmMJvvM8sW6xA9AoIESfm++Bw5lJGsP4rWe/Vbvqn3mYFAuv9BfeZm
 IJWf+rK+du8vB8xZO3WlihvZhnPZRbRAzYY1OGnlBL31CHH34MpGnifd2pTdWYDSGaJa
 tHSlxvkq2aZqkAN55mC0gP1j0qWAKw6/R223FGKr5gdm2t6XNu+r9mcKzrk6x9VbrKOV
 V22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mdsrB3WJ/tk0ST4HvqFtC9xRaSlLd3WWsTQKXGGED9I=;
 b=jKozignyTkZLzx0xHlvBgasY9CGsgd1+IJSGxUE7sdMkOz2VBch3bLAicy1cbtvuEG
 4XvVoWs17D2pI6oVFQr/Pi+DNEt65hZqP+p59B0mdWDf+KMwFZ5YU3it8+o5g009Arjx
 1juo4uuRXEgupNm2TAbRCad8Vf80LgUsLEANKxUQVhuaguM2M1/YmmyHhusXc9r6vp2M
 H7kwIKYDxtZmk9ZokBisdewlbYSnFMNch1579sgr5cqhApt/kfwF8PnN6CAJRDGY3rjf
 x33/Vdld98+ljWkfjglkewliBngs13kEfNK+n8TceH/W+agTreAxbz9nX7FsTGFImNRm
 GSIA==
X-Gm-Message-State: APjAAAWmnobOJm+GjuuI3KNZP4t/X6RyRepB4fBawjUeF88NpeblfOKt
 AUe3cp4LgcPT4GfwXybABz818nBCfnY=
X-Google-Smtp-Source: APXvYqyk1B/v+3COmMzULjZKwvUqdQC8DvtczDgdgFL8arAoucEr7JqdiGmWXWj+MhekUxGij3Qb7A==
X-Received: by 2002:a17:902:9a85:: with SMTP id
 w5mr29779494plp.316.1571072589491; 
 Mon, 14 Oct 2019 10:03:09 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id v133sm14313800pgb.28.2019.10.14.10.03.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Oct 2019 10:03:08 -0700 (PDT)
Subject: Re: [PATCH v5 54/55] plugins: add qemu_plugin_outs and use it
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191014104948.4291-1-alex.bennee@linaro.org>
 <20191014104948.4291-55-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <354e0a45-cb8f-c09a-d368-aceadd3e3157@linaro.org>
Date: Mon, 14 Oct 2019 10:03:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191014104948.4291-55-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: robert.foley@futurewei.com, cota@braap.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 aaron@os.amperecomputing.com, peter.puhov@futurewei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/19 3:49 AM, Alex Bennée wrote:
> Having the plugins grab stdout and spew stuff there is a bit ugly and
> certainly makes the tests look ugly. Provide a hook back into QEMU
> which can be redirected as needed.
> 
> For the newer plugins that use GString already this falls out pretty
> naturally. For the older printf style plugins we convert to
> g_strdup_printf and pass that. While we are at it we can use
> g_autoptr/g_autofree to let the compiler worry about freeing things.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  include/qemu/log.h           |  1 +
>  include/qemu/qemu-plugin.h   |  6 ++++++
>  plugins/api.c                |  8 ++++++++
>  plugins/qemu-plugins.symbols |  1 +
>  tests/plugin/bb.c            | 12 +++++-------
>  tests/plugin/hotblocks.c     | 10 ++--------
>  tests/plugin/hotpages.c      | 12 +++---------
>  tests/plugin/howvec.c        | 15 ++-------------
>  tests/plugin/insn.c          | 10 ++++------
>  tests/plugin/mem.c           | 12 ++++++------
>  tests/tcg/Makefile.target    |  2 ++
>  util/log.c                   |  3 +++
>  12 files changed, 43 insertions(+), 49 deletions(-)

This also would be better sorted earlier, and the plugins done once.


r~

