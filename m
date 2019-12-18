Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A07C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 23:28:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D664421582
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 23:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vt7d/Wjx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D664421582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihikT-0003hH-VY
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 18:28:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35555)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ihihM-0007j7-NU
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 18:25:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ihihL-0003lz-DW
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 18:25:44 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:36595)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ihihL-0003kd-6w
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 18:25:43 -0500
Received: by mail-pg1-x542.google.com with SMTP id k3so2094069pgc.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 15:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Eren9MLX7bzFjzWNgpuKzO0ZxiULws5PT2XeNzaV3mk=;
 b=vt7d/WjxHgqZ4rfBM2Boqfjy0fqwZRtQnv6QVXOQfkKRb1RVQ7OBoYYrBA0e0zHO/v
 F1ILRgO982EiuNMkkflR3gIjfnQNIIwRsu1nihJEqaNxN+VDYmVRictlAlttajZ0sNUD
 l4HMhVBYYvsO72WcTiFOc3cT1Jxx9Xg3gygVPk98QkVgwWOC2h9RSPk59WpB5NNZwsv0
 hR6vVQUgafApwPiemnZcW7fXDdxN3yVRbyGNgy9yokLoaZpdBdnNkonhDnE1uF0hFYJf
 idRyj/eBBTmxHkdJdrmUfReOxcZwOpz8Sr+rQgPfoxR+h68En5+xIi9zutCxtpKuYufS
 yQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Eren9MLX7bzFjzWNgpuKzO0ZxiULws5PT2XeNzaV3mk=;
 b=Z4plq+Zv9jkDLXYaop54ulyxwqwYGRadBJ4lz9Ami1HFsz0PBRoCoUK96nxXWqPZiE
 n37DnnHJGs93qKvTT/dCgodoo//94ugohOdau8M02NssbeXkW0PYMZk73+BerItx8sAy
 2muxjrgdil89TYF9tnHgnHaCOhEsYXPnuivYJeLjhknrfy9KkGLIo3Wx9PPU4pLaBVRY
 pjjkL3lPYaNvPh1eI5B3sr22qemzxXvjnJG9qtocCQmyC1GdMVHI+qB0CC4aEkn0Or3F
 QNJOU1gZTm4YYj+HpMum5rxerbDaCmG2VUaFGR3VaR3mckctdeGd9dNxCamcN+EKaMW/
 oI0w==
X-Gm-Message-State: APjAAAUYoLX94zoxrXn5luE8g8vBZXOU/EK4pYsgsKZXe9BsQD+DEll1
 pTimfjr7xNqteH471ch+PtTUXeOQgx4=
X-Google-Smtp-Source: APXvYqzPfxbrhkosH1bAF1xjw5Fd+MK03TPU/srZz7hsp7GX1cRPwkh6K3QYcL6gBoQFSEzjVUpZ0Q==
X-Received: by 2002:a63:d00f:: with SMTP id z15mr5779169pgf.143.1576711541896; 
 Wed, 18 Dec 2019 15:25:41 -0800 (PST)
Received: from ?IPv6:2605:e000:c74f:dc00:6838:d2b2:17e2:8445?
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id i127sm5108224pfe.54.2019.12.18.15.25.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2019 15:25:41 -0800 (PST)
Subject: Re: [PATCH v2 06/10] arm/arm-powerctl: rebuild hflags after setting
 CP15 bits in arm_set_cpu_on()
To: Niek Linnenbank <nieklinnenbank@gmail.com>
References: <20191216233519.29030-1-nieklinnenbank@gmail.com>
 <20191216233519.29030-7-nieklinnenbank@gmail.com>
 <CAPan3WpW1Q3zpnqgk=MWRWe99=MQ4XoW2kw8L3tioFxfEBXd+Q@mail.gmail.com>
 <CAFEAcA8Viii4Em_bf4Y=AG0jU+EFFFTX6dO-52qd=RT4uHbCVw@mail.gmail.com>
 <19e4f2ac-6067-f61f-f340-108545fb0f02@linaro.org>
 <CAPan3WrcvE_43=3+b4Ybn==TEQcKj+F_VWjJRBJ6MyXNrcpUbw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6ec61650-30e1-4377-6b22-5b6ef827e69c@linaro.org>
Date: Wed, 18 Dec 2019 13:25:37 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAPan3WrcvE_43=3+b4Ybn==TEQcKj+F_VWjJRBJ6MyXNrcpUbw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/18/19 11:01 AM, Niek Linnenbank wrote:
> Hello Richard,
> 
> On Tue, Dec 17, 2019 at 5:41 PM Richard Henderson <richard.henderson@linaro.org
> <mailto:richard.henderson@linaro.org>> wrote:
> 
>     On 12/17/19 6:12 AM, Peter Maydell wrote:
>     > Cc'ing Richard : this is one for you I think... (surely we
>     > need to rebuild the hflags from scratch when we power up
>     > a CPU anyway?)
> 
>     We do compute hflags from scratch in reset.
> 
>     It has also turned out that there were a few board models that poked at the
>     contents of the cpu and needed special help.  Some of that I would imagine
>     would be fixed properly with the multi-phase reset patches, where we could
>     rebuild hflags when *leaving* reset.
> 
>     In arm_set_cpu_on_async_work, we start by resetting the cpu and then start
>     poking at the contents of some system registers.  So, yes, we do need to
>     rebuild after doing that.  Also, I'm not sure how this function should fit into
>     the multi-phase reset future.
> 
> 
> Great, thanks a lot for confirming and clarifying this!
> You mention the multi-phase reset feature, is that going to replace the
> arm_set_cpu_on() functionality?

I don't think so, but I'm not sure.  As I said above, I don't immediately see
how arm_set_cpu_on() will integrate.

In any case, multi-phase reset is still pending, though I believe it is high on
Peter's priority queue for the 5.0 development cycle.


r~

