Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC49C33CA1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 09:34:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3778220661
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 09:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DMWp8D6h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3778220661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izH4y-0002EN-C5
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 04:34:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49617)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1izH3R-0000Qb-Qu
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 04:33:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1izH3P-0002l3-In
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 04:33:05 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:44048)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1izH3P-0002Tz-7D
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 04:33:03 -0500
Received: by mail-wr1-x42b.google.com with SMTP id m16so1731613wrx.11
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 01:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=qwytGk+ZSsuITZ8tNsJtuqanOSDpOT81BMNdwjo8NV4=;
 b=DMWp8D6hSMxHzggelKy7WtdppNIaaI+VlW61WozRnvt8o5iVJDYgyZ2d/Sxw3sCQ2p
 REiHpEC4l0f4oYFEsCw2W0KCLth9aQQUlsK0uydM61b1nGNVf0yYA4hVMGt5rrEDE76W
 8KZ5VulcTc385aM/+zdAYB2Vnldm5nxlD3SvtwQYCRY3Yc37t2OuJqGWhMWZS+rEJUuL
 Rx4AJo/ieSVjbT3LcDptt3iX2SA7Be45BwjhsXemeuZEC3femvS9ooghz1+jmZGwbgHO
 ktXaGe5BKh7Yep4beYagbLaMAlJMwICLpMFmAm0HFhfWlMZd0vme8+dj12WXgomtAGjb
 Ri7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qwytGk+ZSsuITZ8tNsJtuqanOSDpOT81BMNdwjo8NV4=;
 b=DgmZZXxAXny4MAuPYdvu6mXBirEnKMDv5CcK/a9ZXIc36XjYWcjNDnijUxnQdyW8Am
 k09Sk4jIiqa9dskU6A4KnYpMbNajCPtMnkS/wXl9SnjJpJ1nDipHHqRvLaqhJQMwte+Y
 b542HGtyIy1Nh4YRdWqIg+A+xfAJvzf/f4wB/wjCkUsrf6NMFrPAhQ2+p5Wmy5MSRszC
 K8P+7Yg190rNt4xO/xXWyfnln3WAggCC0wtXJgrzINfsFjcg5QB7xk4+COjyNbZPYS5v
 QD6bwdWbiDDUdZQcLHj/dR6Zg5EfoEd/c0/DOfYPEIZeDu6JvyuyPH1R8A+OBrOQ74dY
 ljew==
X-Gm-Message-State: APjAAAXC3v0e05EjTtDAApoT+eLV451tRAvZpMKl3dLXHXXTC6AZJStf
 wYAy2/dq4Urcodj6qKX6yibfAGpq6Cjy/g==
X-Google-Smtp-Source: APXvYqzduiw8hitWqBaMDBl3CCVhjoSV0IVlKperD1+6a5icKA98j7V6WlYiu1X/vJYsiFZdoVhfMw==
X-Received: by 2002:a5d:55c1:: with SMTP id i1mr30019444wrw.347.1580895181321; 
 Wed, 05 Feb 2020 01:33:01 -0800 (PST)
Received: from [172.27.250.65] ([212.187.182.166])
 by smtp.gmail.com with ESMTPSA id r14sm30769067wrj.26.2020.02.05.01.33.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Feb 2020 01:33:00 -0800 (PST)
Subject: Re: Need help understanding assertion fail.
To: Wayne Li <waynli329@gmail.com>, qemu-devel@nongnu.org
References: <CAM2K0nr7+6NRW6CRYRdejS_BPjizV5yX7ykfctEFTyPzh=kSVA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4d538062-238d-1e50-26b1-e00419d72410@linaro.org>
Date: Wed, 5 Feb 2020 09:32:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAM2K0nr7+6NRW6CRYRdejS_BPjizV5yX7ykfctEFTyPzh=kSVA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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

On 2/3/20 4:37 PM, Wayne Li wrote:
> Anyway that's the background.  The specific problem I'm having right now is I
> get the following assertion error during some of the setup stuff our OS does
> post boot-up (the OS is also custom-made):
> 
> qemu_programs/qemu/tcg/ppc/tcg-target.inc.c:224: reloc_pc14_val: Assertion
> `disp == (int16_t) disp' failed.

As Peter has already explained this has to do with *generating* ppc output for
the host, and nothing to do with little vs big endian.

There is only one place from which this ought to be reachable: an extremely
large backward branch, explicitly generated within your tcg ops.

Out of range forward branches are handled gracefully, as they generally occur
due to an internal branch to out-of-line code to handle the slow path of a
memory operation.  Generally this will be "fixed" by restarting generation of
the TB with fewer guest instructions.  E.g.


	insn1
	  memory op, conditional branch to m1
 i2:
	insn2
	insn3
	insn4
	branch to next tb with insn5
 m1:
	slow path for insn1
	goto i2

can be split into

	insn1
	  memory op, conditional branch to m1
  i2:
	insn2
	branch to next tb with insn3
  m1:
	slow path for insn1
	goto i2


However, these forward branches are implicit, part of the expansion of the
INDEX_op_qemu_ld/st tcg opcodes.

Backward branches are are *only* generated by explicit tcg ops, generated by
your target/ code.  Since you should not be generating backward branches
*between* insns, there is no expectation that splitting the TB in half will
have any effect.

I can only suggest that there is some insn for which you are generating inline
code which includes a loop.  This insn should probably be implemented with an
out-of-line helper instead.  But since I have no visibility into the actual
architecture being emulated, I cannot be sure.


r~

