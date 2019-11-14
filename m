Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6448C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 21:05:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3EDC20709
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 21:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S0N/dNKb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3EDC20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVMJO-0007IM-Rs
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 16:05:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45150)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iVMIa-0006la-Sm
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 16:05:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iVMIZ-0006Fi-Jf
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 16:05:04 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:44263)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iVMIZ-0006FC-7H
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 16:05:03 -0500
Received: by mail-oi1-x243.google.com with SMTP id s71so6595343oih.11
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 13:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MrlfJgV1YzNY/Mum1y4mnjGWmktbU/EzuAc6NF4tCNY=;
 b=S0N/dNKbxVBtCDvEbTCS9OISJPb3VmXLTGp2RYdnuadxnRWdELKlMOsS4ZSrlVa5h/
 /2xWjAZDPyFwn4cio+XG1kuol0ps+6Jitn/4QdsM0L1wW5GzeDnYJ7wjvFVoxLLJ7Nzd
 GeSvCtiK/aEA33s5X/yRBQSdAOYw89TsE0Ms7mA4Nq23C0OcW0XeD6Wy/GCparwDldFl
 4kL+wvprFl9KeAuRA9UtT3qPWLfnuMEaodgUVZ5k4Kv0n8u0TRejOcAyvtCNFv2cJ5Vl
 ztNLiwqnGcHJFnOZyF3VWpP+8E9VDaUUeEPYMamKiyDCesqfkyeYlfT+j/OfFOcFhsnx
 CCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MrlfJgV1YzNY/Mum1y4mnjGWmktbU/EzuAc6NF4tCNY=;
 b=E5oFJq+wl6gnlZX/7kyyiy+JPf2wB8EjI28uoZ/h4hSEKWgb6cczdDB3W33WkDLtG4
 fFS3EQL1k5xVu4w6TCiVWoqXUXs/m7QpyTafYb5wNi8xuX4hReGuXc8UC3fePEU/9wzi
 cMNeupHXDskaHntRDpaaF1bvDW49jMiF0XcveKSqlZBWtYd1jgQ3B3uMCqgRQRFRvYq8
 u38eT4wFrbCxdETVjAdAuel0S67B7HIXwIF90tSnHXpE6V6zMkcApbhdICoWzV66klYe
 Ib6Lmw6Jod0YXwWovpIZdvkhF9aUEXpzcFGurYD5MIEq5qvZnhuhlB0cOcT5fAIel3XX
 /VpA==
X-Gm-Message-State: APjAAAWJwrmvLzxeMwK0g6vSp6UgJ4750IPaOZJJmH1u2IDAt6BpxVRf
 GtzdsMOapodyeV2M6U8UD1R22kTKZK1mwOrB8JPyFA==
X-Google-Smtp-Source: APXvYqwgs9sFGyKD+yMW0jKnBB91gRE1Kq7ljZoS5xEEQOxOzNXQdj/feye1LWMDPlvPNYZhrO74mLlkJgTjwxDqt8o=
X-Received: by 2002:aca:451:: with SMTP id 78mr5388549oie.170.1573765502253;
 Thu, 14 Nov 2019 13:05:02 -0800 (PST)
MIME-Version: 1.0
References: <89ada4b1-ee3d-a512-07c2-9bc1ba5806da@redhat.com>
 <20191024224622.12371-1-keithp@keithp.com> <8736fhm9tw.fsf@linaro.org>
 <87pnik4w9n.fsf@keithp.com>
 <CAFEAcA-g+RkvYjseDE=1Z=gnLum0Cjvn_7bqB3ti+cBq9UZ3Eg@mail.gmail.com>
 <87mudo4owu.fsf@keithp.com>
 <CAFEAcA-MRtr9WUpqqwJiX9kc+ybGdgfv7ZB5Tc6_q9xwHwebsQ@mail.gmail.com>
 <d4baa0c3-694a-293a-385a-b3eba7d52d0d@linaro.org>
 <CAFEAcA-yc9oBfsj1uvbYVCc8kivOE9k2QBGdKs8HZ-vj2iv-pw@mail.gmail.com>
 <79acf595-5cc3-b795-24c9-e4511071c6c8@linaro.org>
In-Reply-To: <79acf595-5cc3-b795-24c9-e4511071c6c8@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Nov 2019 21:04:51 +0000
Message-ID: <CAFEAcA-BFoi00BWmXjEHGyML5FGdYF3eQnUiWUZrqFNtbP34Xw@mail.gmail.com>
Subject: Re: [PATCH] Semihost SYS_READC implementation (v4)
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Keith Packard <keithp@keithp.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 14 Nov 2019 at 20:52, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Yet another reason why I prefer any semi-hosting call to use an encoding that
> is otherwise reserved illegal.
>
> For this, you have to make up your mind: is it important to execute the
> instructions as specified by the ISA, or as specified by the semi-hosting spec?
>
> In this case, semi-hosting defines an "entry nop" that begins the sequence, and
> I think that we are well within our rights to ignore the validity of "insn1
> insn2 || other-insn".

Perhaps. I think you get the same issue with
  insn1 || insn2
vs
  insn1 || some-other-insn

though. (And the spec has wording that explicitly wants the
latter to be handled with the normal "I'm a hint instruction"
behaviour of insn1.)

-- PMM

