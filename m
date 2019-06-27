Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC462C48BD7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 17:13:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8413620659
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 17:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vbLuzaP7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8413620659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgXxe-00074b-Qd
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 13:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58836)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hgXu4-0003qG-0Y
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 13:09:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hgXu3-000282-44
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 13:09:43 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:38454)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hgXu2-000276-Tv
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 13:09:43 -0400
Received: by mail-wr1-x42c.google.com with SMTP id d18so3428162wrs.5
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 10:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=46MeDvXBUaG/PcmmcSF+9Y/HHHGQLru5vxkqP0y9VlQ=;
 b=vbLuzaP7UF2v9EXpakS/IuOndXnzZVKCf5PB4ZrMk4XQdjhKjcpeZxRgykZ4nq5VF9
 i6eazqm3lnzqvqvoF5utPPzu6JVbM2elaOJoFfYKneXo7XtOA3n11E1iKGxbjljxbb58
 HlSkf6Q3RLQMhNjY3r1I1jRGm7fO8LcZnqN20T+bKapnSjZK1gwIjnwW25CrzP49qTwT
 g1eSr2WDHJUM0KpVWWifXYlsR8L0bzOVpq7aYRFOW/FE0DiE4YIQ4jBBRPvAt6QzEFxE
 Lsy/kAvV1QNrWY0JUIfmQOd307ErAK6SR8qTr8LH3l5VIkeY7nNpwSFUWKjCSA0pJfPK
 xkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=46MeDvXBUaG/PcmmcSF+9Y/HHHGQLru5vxkqP0y9VlQ=;
 b=gPDzMNskghKJwKOuMFUFt1gUFI9Agn337Atk2BWIfoPmCOe8PMtuobCArAhsKRUnGW
 X95AavoRmKrXuPyfhSx+Vwokm46QZw6V2DWxd0zHSzblWLz61Q++CiV4JWbzRhvJ84rR
 DSHMenvXS4M+5/hr44e74wsBlNQoZnoYGGQchoICb/oY6gvh8soGcpTvRvcM/hCS1dej
 jP+1DH8YPZIO0xY5EZwuJeysSymtrlQIST6eeXx1WPYmV40GI/SJ6XqUb340ZC7zndJw
 wE2yP0IxLxdiy6+GBAc9RWS6GBc0bkoJTGXLcNVK6hSNM4t6qOcx+OxM3Q8auAy1f8U8
 L8DA==
X-Gm-Message-State: APjAAAWpBdDyCZZuCGfwDNWf77r9IhZHtsjDBxf6tR+2DEuw9v0b1P6t
 mWlcbnj7a1GX2VA/p97jByxjWg==
X-Google-Smtp-Source: APXvYqz7Mk0UJTCK23cacSux81VN7pXJhUzBkHYFkhXUBVFMKC65Xt9Q2SnF7OiXDG8VYt6HqaTtxA==
X-Received: by 2002:adf:c614:: with SMTP id n20mr4346866wrg.17.1561655381528; 
 Thu, 27 Jun 2019 10:09:41 -0700 (PDT)
Received: from [192.168.2.137] (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id w7sm3640302wmc.46.2019.06.27.10.09.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 Jun 2019 10:09:40 -0700 (PDT)
To: Lucien Anti-Spam <lucienmp_antispam@yahoo.com>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
References: <2136180936.260219.1561641583358.ref@mail.yahoo.com>
 <2136180936.260219.1561641583358@mail.yahoo.com>
 <1079763171.281101.1561641752988@mail.yahoo.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <e4c1fbc4-3e43-5df4-a17c-527d98d9763c@linaro.org>
Date: Thu, 27 Jun 2019 19:09:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1079763171.281101.1561641752988@mail.yahoo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
Subject: Re: [Qemu-devel] RFC: Why does target/m68k RTE insn. use
 gen_exception
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/27/19 3:22 PM, Lucien Anti-Spam wrote:
> Hi Laurent / Richard,
> (resent email )
> 
> Does anyone have any knowledge why
>     gen_exception(s, s->base.pc_next, EXCP_RTE);
> 
> is generated for "RTE" instruction, where as the "RTS" goes a gen_jmp?
> ( note see target/m68k/translate.c in functions DISAS_INSN(rte) and DISAS_INSN(rts)

History, it would seem.  Paul Brook implemented it that way in 2007.

I think that it should not be implemented as an exception.  It should be a call
to one of two different helpers (cf and m68k), followed by either a normal exit
to main loop (to recognize the new interrupt state) or a debug exception.

This sort of modification should be fairly easy to perform, if you have the time.


r~

