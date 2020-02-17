Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5BBC34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:23:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97A3120836
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SowJWKg0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97A3120836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3l3D-0008Rq-RL
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 13:23:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42649)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1j3kmE-0001Kh-Go
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:05:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1j3kmC-0004GX-LA
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:05:50 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:40683)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1j3kmC-0004GA-Em; Mon, 17 Feb 2020 13:05:48 -0500
Received: by mail-pg1-x541.google.com with SMTP id z7so9596551pgk.7;
 Mon, 17 Feb 2020 10:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qC0Tm4A4DCzVRrulrvyNljaPVbcSaSsDoLMT3nU8GAI=;
 b=SowJWKg0GkjJl2xqFetcPBcdOXLSqoIMWuncPoBxv4OeZhEdBj1cYWo9g9Lv6s7Xsq
 plu509/vkS5nvmxx7zefN17Oude4QrsvnrxvaxD+MMRvVYHnXuREpOG1oF/048qI6tIN
 cZ88DHFHz8Dp9XIBjSzqGVFOymLPH2cZyppGtHagUa5zZomtUxtzIFfMZJ+GroCwneMr
 pmW7yYEEoAeQrBbwSLR/aJXwxYke6XpkdTuNUsiA1LulTEVBibsmLOui83AtVUYq+irq
 yvLRVyMa4DWr4iLBF96ykUvifQ0sY6s76j/tGxRGmcePBvSFobQMeNwxnYVye0Mis9Ja
 Yq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qC0Tm4A4DCzVRrulrvyNljaPVbcSaSsDoLMT3nU8GAI=;
 b=mO5uKzLGKg9qobpdkWJgpuoF1i0GSWAca7v5kgHHeqBUgnX2DFDwo8hw7G1AyLVAfk
 Pt5U6CE2TayGKosC8zKdY/pelkXQPwIw0dNjyvsY5cHZWVcOkRgIgJU1V4Ed3+u9+aIR
 fwcolxHYJEyi6FKsuXakiC9OuImcstIbr19SM/MzDr3nf9Eazg0ZidiBIdwBymlymsVp
 s2Yq2Aw/mpYMAapkl6aMs9taeBBLTCg9+CqeO4J+pp0RFanT0azlJMIhjlZgtAjqSDuI
 jDYgXITk2bliUHJCfvo0JqaVxWPeL1j+Civ8tXzBmhxTN5icArQBruQtGNon9DnTSiSV
 4bVQ==
X-Gm-Message-State: APjAAAXuTzsal94iuqwxrKB6vGUIHVQHLtDUUTPxPEjgFxBCjsVhWBix
 H4gbhqLPu6OeX3CFtQbKtb9xcUbu
X-Google-Smtp-Source: APXvYqzT1xlcbFsc3la4C/tyHf38Mi8znFR1tCy6T1umNGw7CrQgEfaXE+kiVt68n1PTdePraIZyUQ==
X-Received: by 2002:a62:c583:: with SMTP id j125mr18475652pfg.27.1581962746955; 
 Mon, 17 Feb 2020 10:05:46 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 n15sm1111246pfq.168.2020.02.17.10.05.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 10:05:46 -0800 (PST)
Subject: Re: [PATCH v2 3/3] arm: allwinner: Wire up USB ports
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200215001248.2642-1-linux@roeck-us.net>
 <20200215001248.2642-4-linux@roeck-us.net>
 <CAFEAcA8Su5SfM9f9BpwaEK2yq0NPwjbtUSwQ1n=G1a=8W881JA@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5bc0d418-c717-be48-2dd4-346d193674c7@roeck-us.net>
Date: Mon, 17 Feb 2020 10:05:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8Su5SfM9f9BpwaEK2yq0NPwjbtUSwQ1n=G1a=8W881JA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 2:13 AM, Peter Maydell wrote:
> On Sat, 15 Feb 2020 at 00:12, Guenter Roeck <linux@roeck-us.net> wrote:
>>
[ ... ]

> Hi; I tried to apply this patchset, but it doesn't apply to master.
> In particular, master doesn't have a #define for AW_A10_CCM_REG_BASE.
>  > Is this patchset supposed to be based on some other patchset
> you've already sent that's got lost in my mailbox?
> 

It is not supposed to be based on anything, but in practice it is because
I also carry a patch adding basic CCM support (which I completely forgot
and which I didn't send upstream because it is hackish).

Sorry for that. I'll rebase to master and resend.

Guenter

