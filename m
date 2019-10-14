Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0D0ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:25:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5765A20663
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VaAMdL3x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5765A20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK45q-0006OM-5U
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 13:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44920)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK3dy-0003O0-SH
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:56:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK3dx-0004Hs-K5
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:56:26 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39276)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK3dx-0004HF-EP
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:56:25 -0400
Received: by mail-ot1-x343.google.com with SMTP id s22so14375786otr.6
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=6Dkz4ccsuMO4YafX7n8ER4ev2rKY1yy9iqCtaDhgm9M=;
 b=VaAMdL3xteL0jTyixSKq0gKZH6R88Q7mj1isT+EFL1WuHdoJr/aauN70Bpqbw87iB0
 ekP2jeoXN1cV+xiVev+A3NK3WayHReu25UUXYs69HnM9Mxj1g/FWB7+74veCULFEerYn
 d5u7fT7reAdCNijPDv/U117jsfekFlZ14OUV3Mu8q0dv2oCREH3drL8A/26WVxU358Hs
 DjZ9U7Jz4owHj/oichmz9FI7zRnrpZ37bGcQjyFgmUfzT5KrUeMbNb/dTY3kKGx7juRU
 94Wxy61u6jjhLxGCltUE3SjRRnWUpbsNxX456i4bEqkNsf6RsXPEs4EX2EzQT8SZIzKq
 TcpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6Dkz4ccsuMO4YafX7n8ER4ev2rKY1yy9iqCtaDhgm9M=;
 b=E6LJkOeO9CMhq+O9vqZ/m2GXNO7cAkfpMvnW171+tMyMs1GRZki8WtzTMlyOsQwFQp
 t23KFxEW8vnySjg5hYcHuJmXsZfG0OnbbW/Y8xORz5ulkGjncqYiZMUChC2zpf0VtdD0
 5nbIMaKjXJUwVj4ZdSW1o/mMqOREyAhGnY0NKzKGsC2QaT6dKjWo2FLbhuRGSWBxjNEO
 eRHyv43ewhX4tTyVMGb2cYSNn/LL4cwLu64OxbYufSLTOg/o/+gaC5pvUjMbQT5vy6XO
 Ja87G5skhvTMM1/kc1gc8k82qYpbvoFcKaEw9o/yFK1+vIYoxQ9Zs9o8fe/KOnL4HLli
 Mh8w==
X-Gm-Message-State: APjAAAXgBXnjv9S5b0f2URO7TKqpuQnNDR/37e79y/1zBxHRP3gdEfEv
 jAtG1veM08wAcCd+GEh4TRAq8ud6PdSwEvswa4DiWU7j1JE=
X-Google-Smtp-Source: APXvYqz8PeSIvX0SjhrNObMU9M3JSrfWw6zv44K08fU18dZCUHj9w0qZme3pxAaKn0W24jC23y/gwuzNmn6RAejDdVk=
X-Received: by 2002:a9d:708e:: with SMTP id l14mr25481059otj.135.1571072183419; 
 Mon, 14 Oct 2019 09:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <20191014104948.4291-1-alex.bennee@linaro.org>
 <20191014104948.4291-18-alex.bennee@linaro.org>
 <CAFEAcA8u3Srp_Lsucxh0-EaXW5UbETLOPA_KdpzONCaTob0GVA@mail.gmail.com>
 <87lftnmgkg.fsf@linaro.org>
In-Reply-To: <87lftnmgkg.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Oct 2019 17:56:11 +0100
Message-ID: <CAFEAcA9aCyxJU60wbYd3DXamGQkuuWFM9sVAq9hjmAAQKUNeAA@mail.gmail.com>
Subject: Re: [PATCH v5 17/55] plugins: implement helpers for resolving hwaddr
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: robert.foley@futurewei.com, QEMU Developers <qemu-devel@nongnu.org>,
 peter.puhov@futurewei.com, Aaron Lindsay <aaron@os.amperecomputing.com>,
 "Emilio G. Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 14 Oct 2019 at 17:34, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> Peter Maydell <peter.maydell@linaro.org> writes:
> > Apologies for dropping into the middle of this patchset, but
> > this API looks a bit odd. A hwaddr alone isn't a complete
> > definition of an access -- you need an (AddressSpace, hwaddr)
> > tuple for that. So this API looks like it doesn't really cope
> > with things like TrustZone ?
>
> Aren't hwaddr's unique across the bus? Or is this because you would have
> two address buses (secure and non-secure) with different address lines to
> different chips?

Architecturally, there are two completely separate physical
address spaces for Secure and NonSecure.
In actual Arm hardware, what you get is a bus/interconnect
where effectively the 'S/NS' line is an extra address bit.
The interconnect can set things up however it likes, but the
most common setup is "most devices mapped at the same address
in both S and NS", aka "most decode ignores the S/NS signal",
with some "this device is only present in S". There's no inherent
reason you couldn't have "address A is device X in S and device
Y in NS", though.

> But surely we have all the information we need because we've hooked the
> two things that QEMU's softmmu code knows. The mmu_idx and the vaddr
> with which the slow path can figure out what it needs.

I think the slowpath uses the MemTxAttrs rather than the mmu_idx:
iotlb_to_section() calls cpu_asidx_from_attrs() and then pulls the
AddressSpace out of cpu->cpu_ases[].

From the point of view of a plugin, it probably wants
the (hwaddr, MemTxAttrs) for the access.

> > This looks odd to see in the plugin API -- ramaddrs should
> > be a QEMU internal concept, shouldn't they?
>
> Hmm maybe.. I guess it's a special case of device offset. Do you want to
> drop this part for now?

I'd need to go and look at the overall plugin-facing API to
be sure, but in general my expectation would be that the
whole API should be in terms of guest-architectural concepts,
with no QEMU-isms like ramaddrs leaking through.

thanks
-- PMM

